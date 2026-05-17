#!/bin/bash
#
# P0lyn0m1c0n v2.6 — Target-aware password mutator
# New: CLI flags + help screen + English interface + clearer basedic prompt
#

set -euo pipefail

# ============================================================
# Banner
# ============================================================
print_banner() {
cat << 'BANNER'
██████╗  ██████╗ ██╗  ██╗   ██╗███╗   ██╗ ██████╗ ███╗   ███╗ ██╗ ██████╗ ██████╗ ███╗   ██╗
██╔══██╗██╔═████╗██║  ╚██╗ ██╔╝████╗  ██║██╔═████╗████╗ ████║███║██╔════╝██╔═████╗████╗  ██║
██████╔╝██║██╔██║██║   ╚████╔╝ ██╔██╗ ██║██║██╔██║██╔████╔██║╚██║██║     ██║██╔██║██╔██╗ ██║
██╔═══╝ ████╔╝██║██║    ╚██╔╝  ██║╚██╗██║████╔╝██║██║╚██╔╝██║ ██║██║     ████╔╝██║██║╚██╗██║
██║     ╚██████╔╝███████╗██║   ██║ ╚████║╚██████╔╝██║ ╚═╝ ██║ ██║╚██████╗╚██████╔╝██║ ╚████║
╚═╝      ╚═════╝ ╚══════╝╚═╝   ╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═╝ ╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝
                                                                              v2.6
BANNER
}

# ============================================================
# Help screen
# ============================================================
print_help() {
cat << 'HELP'
P0lyn0m1c0n v2.6 — Target-aware password wordlist generator

USAGE:
  P0lyn0m1c0n_v2.sh                    Interactive mode (wizard)
  P0lyn0m1c0n_v2.sh [OPTIONS]          Non-interactive mode (CLI flags)
  P0lyn0m1c0n_v2.sh -h | --help        Show this help

REQUIRED (CLI mode):
  -t, --target TARGET                  Target name (company / domain)

OPTIONS (CLI mode):
  -l, --lang {es|en|both}              Language focus (default: es)
                                       Affects months, names, common words, roles.

      --min N                          Minimum password length (default: 8)
      --max N                          Maximum password length (default: 16)

      --charset STRING                 Character set: any combo of
                                         L = lowercase  (a-z)
                                         U = uppercase  (A-Z)
                                         D = digits     (0-9)
                                         S = symbols    (!@#$%&*)
                                       Examples:
                                         --charset LUD     → letters + digits, no symbols
                                         --charset LUDS    → everything (default)
                                         --charset UD      → uppercase + digits only
                                         --charset D       → digits only

      --leet {off|basic|medium|full|all}
                                       Leet substitution level (default: medium)
                                         off    → no leet
                                         basic  → a→4 e→3 i→1 o→0
                                         medium → + s→5 t→7
                                         full   → + l→1 g→9 b→8 z→2
                                         all    → combines all + partial-first variant

      --years {recent|historic}        Year range (default: recent)
                                         recent   → previous / current / next year
                                         historic → 2005 to next year

  -e, --effort {fast|medium|full|all}  Output cap (default: medium)
                                         fast   → top 1,000
                                         medium → top 10,000
                                         full   → top 50,000
                                         all    → no cap

  -b, --basedic PATH                   Path to basedic file
                                       (default: ./basedic.txt, auto-generated)

      --no-prompt                      Skip the interactive basedic edit prompt
                                       (use as-is, don't pause)

  -o, --output PATH                    Output filename (default: P0lyn0m1c0n_<target>.txt)

  -y, --yes                            Skip the "Proceed?" confirmation

EXAMPLES:
  # Interactive mode (wizard asks everything step by step)
  ./P0lyn0m1c0n_v2.sh

  # Quick CLI run for company "acme", Spanish focus, top 10k
  ./P0lyn0m1c0n_v2.sh -t acme

  # Full CLI run for AD password spray (English)
  ./P0lyn0m1c0n_v2.sh -t globex -l en --min 8 --max 16 \
                      --charset LUDS --leet medium --effort medium -y --no-prompt

  # Maximum coverage for offline cracking
  ./P0lyn0m1c0n_v2.sh -t hooli -l both --charset LUDS \
                      --leet all --years historic --effort all -y --no-prompt

OUTPUT:
  Wordlist saved to ./P0lyn0m1c0n_<target>.txt
  Basedic saved to ./basedic.txt (overwritten on each run unless --basedic used)

HELP
}

# ============================================================
# Defaults (used by both CLI and interactive)
# ============================================================
TARGET=""
LANG_MODE="es"
MIN_LEN=8
MAX_LEN=16
USE_LOWER=1
USE_UPPER=1
USE_DIGITS=1
USE_SYMBOLS=0
LEET_MODE="medium"
YEAR_MODE="1"     # 1=recent, 2=historic
TOP_N=10000
EFFORT_NAME="Medium"
SKIP_PROMPT=0
SKIP_CONFIRM=0
INTERACTIVE=1
BASEDIC_PATH=""
OUTPUT_FILE=""

# ============================================================
# CLI flag parser
# ============================================================
parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h|--help)        print_help; exit 0 ;;
      -t|--target)      TARGET="$2"; INTERACTIVE=0; shift 2 ;;
      -l|--lang)
        case "$2" in
          es|en|both) LANG_MODE="$2" ;;
          *) echo "Error: --lang must be es|en|both" >&2; exit 1 ;;
        esac
        shift 2 ;;
      --min)            MIN_LEN="$2"; shift 2 ;;
      --max)            MAX_LEN="$2"; shift 2 ;;
      --charset)
        local cs="${2^^}"
        USE_LOWER=0; USE_UPPER=0; USE_DIGITS=0; USE_SYMBOLS=0
        [[ "$cs" == *L* ]] && USE_LOWER=1
        [[ "$cs" == *U* ]] && USE_UPPER=1
        [[ "$cs" == *D* ]] && USE_DIGITS=1
        [[ "$cs" == *S* ]] && USE_SYMBOLS=1
        shift 2 ;;
      --leet)
        case "$2" in
          off|basic|medium|full|all) LEET_MODE="$2" ;;
          *) echo "Error: --leet must be off|basic|medium|full|all" >&2; exit 1 ;;
        esac
        shift 2 ;;
      --years)
        case "$2" in
          recent)   YEAR_MODE="1" ;;
          historic) YEAR_MODE="2" ;;
          *) echo "Error: --years must be recent|historic" >&2; exit 1 ;;
        esac
        shift 2 ;;
      -e|--effort)
        case "$2" in
          fast)   TOP_N=1000;  EFFORT_NAME="Fast" ;;
          medium) TOP_N=10000; EFFORT_NAME="Medium" ;;
          full)   TOP_N=50000; EFFORT_NAME="Full" ;;
          all)    TOP_N=0;     EFFORT_NAME="Exhaustive" ;;
          *) echo "Error: --effort must be fast|medium|full|all" >&2; exit 1 ;;
        esac
        shift 2 ;;
      -b|--basedic)     BASEDIC_PATH="$2"; shift 2 ;;
      --no-prompt)      SKIP_PROMPT=1; shift ;;
      -o|--output)      OUTPUT_FILE="$2"; shift 2 ;;
      -y|--yes)         SKIP_CONFIRM=1; shift ;;
      *) echo "Unknown option: $1 (use -h for help)" >&2; exit 1 ;;
    esac
  done

  # Validate
  if (( INTERACTIVE == 0 )); then
    [[ -z "$TARGET" ]] && { echo "Error: --target is required in CLI mode" >&2; exit 1; }
    (( MIN_LEN > MAX_LEN )) && { echo "Error: --min > --max" >&2; exit 1; }
    if (( USE_LOWER + USE_UPPER + USE_DIGITS + USE_SYMBOLS == 0 )); then
      echo "Error: --charset must include at least one of L/U/D/S" >&2
      exit 1
    fi
  fi
}

# ============================================================
# Prompts
# ============================================================
ask() {
  local prompt="$1" default="${2:-}" answer
  if [[ -n "$default" ]]; then
    read -rp "$prompt [$default]: " answer
    echo "${answer:-$default}"
  else
    read -rp "$prompt: " answer
    echo "$answer"
  fi
}

ask_yn() {
  local prompt="$1" default="${2:-n}" answer
  while true; do
    read -rp "$prompt (y/n) [$default]: " answer
    answer="${answer:-$default}"
    case "$answer" in
      [Yy]*) return 0 ;;
      [Nn]*) return 1 ;;
      *) echo "Please answer y or n." ;;
    esac
  done
}

ask_int() {
  local prompt="$1" default="$2" answer
  while true; do
    read -rp "$prompt [$default]: " answer
    answer="${answer:-$default}"
    [[ "$answer" =~ ^[0-9]+$ ]] && { echo "$answer"; return; }
    echo "Integers only."
  done
}

# ============================================================
# Data: months
# ============================================================
MONTHS_EN_FULL=(january february march april may june july august september october november december)
MONTHS_EN_SHORT=(jan feb mar apr may jun jul aug sep oct nov dec)
MONTHS_ES_FULL=(enero febrero marzo abril mayo junio julio agosto septiembre octubre noviembre diciembre)
MONTHS_ES_SHORT=(ene feb mar abr may jun jul ago sep oct nov dic)
MONTHS_NUM=(01 02 03 04 05 06 07 08 09 10 11 12)

# ============================================================
# Data: roles / departments / services (by language)
# ============================================================
ROLES_EN=(admin administrator user guest test demo dev developer
  root sysadmin support help helpdesk manager director boss
  owner staff team employee intern operator engineer analyst
  consultant lead chief vp ceo cto cfo cio ciso architect)

ROLES_ES=(administrador usuario invitado prueba desarrollador
  soporte ayuda gerente director jefe propietario duenio
  personal equipo empleado becario operador ingeniero analista
  consultor lider jefatura presidente vicepresidente
  contralor tesorero supervisor coordinador)

DEPTS_EN=(it infosec security marketing sales finance hr legal
  compliance qa ops operations devops helpdesk support
  servicedesk accounting engineering research)

DEPTS_ES=(sistemas seguridad ventas finanzas contabilidad
  recursos rrhh humanos marketing legal cumplimiento
  operaciones soporte mesadeayuda contraloria
  ingenieria desarrollo investigacion)

SERVICES=(ftp sql mysql postgres oracle web mail smtp pop imap
  ldap dns vpn rdp ssh backup db database api wifi wireless
  network printer scanner camera server fileserver dc)

# Common passwords
COMMON_EN=(password passw0rd pass passwd
  qwerty qwer asdf asdfgh 123456 abc123 letmein welcome
  monkey dragon master shadow sunshine princess love
  iloveyou freedom whatever trust hello
  admin adm root toor user changeme default temp temporary test1234
  summer winter spring autumn fall
  football baseball basketball soccer hockey
  computer internet email phone mobile
  company corp business work office family home house
  hunter trustno1 superman batman
  spider tiger eagle wolf lion bear)

NAMES_EN=(michael chris john david james robert mary
  jennifer linda patricia jessica ashley emily
  daniel matthew anthony joshua andrew kevin
  brian thomas paul mark steven kenneth
  george edward donald)

COMMON_ES=(contrasena clave password
  qwerty asdf hola hola123 holamundo
  bienvenido bienvenida bienvenidos
  amor amorcito vida cielo princesa
  perro gato perrito gatito mascota
  futbol pelota equipo
  computadora computador laptop telefono
  empresa trabajo oficina casa familia
  verano invierno primavera otono
  navidad pascua cumpleanos cumple aniversario
  mexico colombia chile argentina peru espana
  guadalupe carmen consuelo)

NAMES_ES=(jose juan luis carlos miguel angel
  pedro pablo francisco antonio manuel
  jorge raul alejandro roberto fernando
  ricardo eduardo sergio enrique javier
  diego andres mario marco rodrigo
  alberto rafael oscar arturo
  maria guadalupe carmen ana laura sofia
  fernanda alejandra patricia teresa monica
  rosa luz claudia daniela paola)

COMMON_UNIVERSAL=(abc abc123 abcdef qwerty asdfgh
  test demo dev develop development
  prod production staging sandbox
  vpn rdp ssh ftp web admin root
  guest temp temporary changeme default)

# ============================================================
# Leet
# ============================================================
leet_basic()  { echo "$1" | tr 'aeioAEIO' '43104310'; }
leet_medium() { echo "$1" | tr 'aeiostAEIOST' '431057431057'; }
leet_full()   { echo "$1" | tr 'aeiostlgbzAEIOSTLGBZ' '43105719824310571982'; }
leet_partial_first() {
  local w="$1"; local first="${w:0:1}"; local rest="${w:1}"
  echo "${first^}$(leet_basic "$rest")"
}

# ============================================================
# Interactive wizard
# ============================================================
configure_interactive() {
  echo
  echo "=== Configuration ==="

  TARGET=$(ask "Target (company / domain name)")
  while [[ -z "$TARGET" ]]; do
    echo "Target cannot be empty."
    TARGET=$(ask "Target")
  done

  echo
  echo "Language focus (affects months, names, common words, roles):"
  echo "  1) Spanish"
  echo "  2) English"
  echo "  3) Both (most exhaustive)"
  local lang
  while true; do
    read -rp "Choose [1]: " lang
    lang="${lang:-1}"
    case "$lang" in
      1) LANG_MODE="es"; break ;;
      2) LANG_MODE="en"; break ;;
      3) LANG_MODE="both"; break ;;
      *) echo "Only 1, 2, or 3." ;;
    esac
  done

  MIN_LEN=$(ask_int "Minimum password length" 8)
  MAX_LEN=$(ask_int "Maximum password length" 16)
  (( MIN_LEN > MAX_LEN )) && { echo "Error: min > max"; exit 1; }

  echo
  echo "Character set (combine as needed):"
  USE_LOWER=$(ask_yn  "  Include lowercase (a-z)?" "y" && echo 1 || echo 0)
  USE_UPPER=$(ask_yn  "  Include uppercase (A-Z)?" "y" && echo 1 || echo 0)
  USE_DIGITS=$(ask_yn "  Include digits (0-9)?"    "y" && echo 1 || echo 0)
  USE_SYMBOLS=$(ask_yn "  Include symbols (!@#\$%&*)?" "n" && echo 1 || echo 0)

  if (( USE_LOWER + USE_UPPER + USE_DIGITS + USE_SYMBOLS == 0 )); then
    echo "Error: choose at least one character class."
    exit 1
  fi

  echo
  echo "Leet substitution level (letter-to-digit replacement):"
  echo "  1) Off       — no leet"
  echo "  2) Basic     — a→4, e→3, i→1, o→0          (e.g., acme → 4cm3)"
  echo "  3) Medium    — + s→5, t→7                  (e.g., sales → 54l35)"
  echo "  4) Full      — + l→1, g→9, b→8, z→2        (e.g., manager → m4n493r)"
  echo "  5) All       — combines all three          (more variants)"
  local lt
  while true; do
    read -rp "Choose [3]: " lt
    lt="${lt:-3}"
    case "$lt" in
      1) LEET_MODE="off"; break ;;
      2) LEET_MODE="basic"; break ;;
      3) LEET_MODE="medium"; break ;;
      4) LEET_MODE="full"; break ;;
      5) LEET_MODE="all"; break ;;
      *) echo "Only 1-5." ;;
    esac
  done

  echo
  echo "Year range mode:"
  echo "  1) Recent (previous, current, next — 3 years)"
  echo "  2) Historic (2005 to next year — all years)"
  local ym
  while true; do
    read -rp "Choose [1]: " ym
    ym="${ym:-1}"
    [[ "$ym" == "1" || "$ym" == "2" ]] && break
    echo "Only 1 or 2."
  done
  YEAR_MODE="$ym"

  echo
  echo "Effort level (maximum number of passwords in output):"
  echo "  1) Fast       — top 1,000"
  echo "  2) Medium     — top 10,000"
  echo "  3) Full       — top 50,000"
  echo "  4) Exhaustive — no cap"
  local effort
  while true; do
    read -rp "Choose [2]: " effort
    effort="${effort:-2}"
    case "$effort" in
      1) TOP_N=1000;  EFFORT_NAME="Fast"; break ;;
      2) TOP_N=10000; EFFORT_NAME="Medium"; break ;;
      3) TOP_N=50000; EFFORT_NAME="Full"; break ;;
      4) TOP_N=0;     EFFORT_NAME="Exhaustive"; break ;;
      *) echo "Only 1-4." ;;
    esac
  done
}

# ============================================================
# Build the shared basedic
# ============================================================
build_basedic() {
  local outfile="$1"
  {
    printf '%s\n' "${COMMON_UNIVERSAL[@]}"
    printf '%s\n' "${SERVICES[@]}"

    case "$LANG_MODE" in
      es)
        printf '%s\n' "${COMMON_ES[@]}"
        printf '%s\n' "${NAMES_ES[@]}"
        printf '%s\n' "${ROLES_ES[@]}"
        printf '%s\n' "${DEPTS_ES[@]}"
        printf '%s\n' admin root user dev test demo support helpdesk
        ;;
      en)
        printf '%s\n' "${COMMON_EN[@]}"
        printf '%s\n' "${NAMES_EN[@]}"
        printf '%s\n' "${ROLES_EN[@]}"
        printf '%s\n' "${DEPTS_EN[@]}"
        ;;
      both)
        printf '%s\n' "${COMMON_ES[@]}" "${COMMON_EN[@]}"
        printf '%s\n' "${NAMES_ES[@]}"  "${NAMES_EN[@]}"
        printf '%s\n' "${ROLES_ES[@]}"  "${ROLES_EN[@]}"
        printf '%s\n' "${DEPTS_ES[@]}"  "${DEPTS_EN[@]}"
        ;;
    esac
  } | awk '!seen[$0]++' > "$outfile"
}

# ============================================================
# Basedic setup with edit invitation
# ============================================================
setup_basedic() {
  build_basedic "$BASEDIC_PATH"
  local count
  count=$(wc -l < "$BASEDIC_PATH")

  echo
  echo "═════════════════════════════════════════════════"
  echo "  BASE DICTIONARY"
  echo "═════════════════════════════════════════════════"
  echo
  echo "  The base dictionary $BASEDIC_PATH will be used."
  echo "  ($count words included, language: $LANG_MODE)"
  echo
  echo "  It contains: common passwords, typical first names,"
  echo "  corporate roles (admin, manager, ceo, etc.),"
  echo "  departments (it, sales, hr, etc.) and technical"
  echo "  services (ftp, sql, vpn, ssh, etc.)."
  echo

  if (( SKIP_PROMPT )); then
    echo "  --no-prompt set: skipping edit pause, using as-is."
    echo "═════════════════════════════════════════════════"
    return
  fi

  echo "  If you want to add more words, do it now (edit the"
  echo "  file in another terminal), then type 'y' when you"
  echo "  are ready to continue:"
  echo
  echo "      nano $BASEDIC_PATH"
  echo "      vim  $BASEDIC_PATH"
  echo
  echo "═════════════════════════════════════════════════"
  echo
  while true; do
    read -rp "Type 'y' when you are ready to continue: " response
    case "$response" in
      [Yy]*) break ;;
      *) echo "  (Waiting for 'y' to continue...)" ;;
    esac
  done

  local new_count
  new_count=$(wc -l < "$BASEDIC_PATH")
  if (( new_count > count )); then
    echo "  ✓ Detected $((new_count - count)) new words. Total: $new_count"
  else
    echo "  ✓ Using basedic with $count words."
  fi
}

# ============================================================
# Helpers
# ============================================================
expand_leet() {
  local w="$1"
  case "$LEET_MODE" in
    off)    return 0 ;;
    basic)  leet_basic   "$w" ;;
    medium) leet_medium  "$w" ;;
    full)   leet_full    "$w" ;;
    all)
      local b m f p
      b=$(leet_basic "$w")
      m=$(leet_medium "$w")
      f=$(leet_full "$w")
      p=$(leet_partial_first "$w")
      printf '%s\n%s\n%s\n%s\n' "$b" "$m" "$f" "$p"
      ;;
  esac
}

adapt_to_charset() {
  awk -v lower="$USE_LOWER" -v upper="$USE_UPPER" \
      -v digits="$USE_DIGITS" -v symbols="$USE_SYMBOLS" '
  {
    line = $0
    if (!lower && upper)   { line = toupper(line) }
    if (!upper && lower)   { line = tolower(line) }
    if (!lower && !upper)  { gsub(/[a-zA-Z]/, "", line) }
    if (!digits)           { gsub(/[0-9]/, "", line) }
    if (!symbols)          { gsub(/[^a-zA-Z0-9]/, "", line) }
    if (length(line) > 0) print line
  }'
}

filter_length() {
  awk -v min="$MIN_LEN" -v max="$MAX_LEN" 'length($0) >= min && length($0) <= max'
}

get_months_full() {
  case "$LANG_MODE" in
    es)   printf '%s\n' "${MONTHS_ES_FULL[@]}" ;;
    en)   printf '%s\n' "${MONTHS_EN_FULL[@]}" ;;
    both) printf '%s\n' "${MONTHS_ES_FULL[@]}" "${MONTHS_EN_FULL[@]}" ;;
  esac
}

get_months_short() {
  case "$LANG_MODE" in
    es)   printf '%s\n' "${MONTHS_ES_SHORT[@]}" ;;
    en)   printf '%s\n' "${MONTHS_EN_SHORT[@]}" ;;
    both) printf '%s\n' "${MONTHS_ES_SHORT[@]}" "${MONTHS_EN_SHORT[@]}" ;;
  esac
}

# ============================================================
# Generators
# ============================================================
gen_year_variations() {
  local word="$1" y1="$2" y2="$3" i
  for ((i = y1; i <= y2; i++)); do
    printf '%s\n' \
      "${word}${i}" "${i}${word}" \
      "${word}.${i}" "${i}.${word}" \
      "${word}_${i}" "${i}_${word}" \
      "${word}-${i}" "${i}-${word}" \
      "${word}${i}!" "${word}${i}#" "${word}${i}@" \
      "${word}@${i}" "${word}#${i}"
  done
}

gen_month_variations() {
  local word="$1" m
  local months_full months_short
  mapfile -t months_full  < <(get_months_full)
  mapfile -t months_short < <(get_months_short)

  for m in "${months_full[@]}"; do
    echo "${word}${m}"; echo "${m}${word}"
    echo "${word}.${m}"; echo "${m}.${word}"
    echo "${word}_${m}"; echo "${m}_${word}"
    echo "${word}${m^}"; echo "${m^}${word}"
  done
  for m in "${months_short[@]}"; do
    echo "${word}${m}"; echo "${m}${word}"
    echo "${word}${m^}"; echo "${m^}${word}"
  done
}

gen_month_year_variations() {
  local word="$1" y1="$2" y2="$3" y m
  local months_short
  mapfile -t months_short < <(get_months_short)

  for ((y = y1; y <= y2; y++)); do
    for m in "${months_short[@]}"; do
      echo "${word}${m}${y}"
      echo "${word}${m^}${y}"
      echo "${m}${y}${word}"
      echo "${m^}${y}${word}"
      echo "${m}${word}${y}"
    done
    for m in "${MONTHS_NUM[@]}"; do
      echo "${word}${m}${y}"
      echo "${m}${y}${word}"
      echo "${word}${m}-${y}"
      echo "${word}.${m}.${y}"
    done
  done
}

gen_common_suffixes() {
  local word="$1" suf
  for suf in 1 12 123 1234 12345 123456 "!" "@" "#" "\$" "!@#" 01 00 007 "!1" "1!" "2024" "2025" "2026"; do
    echo "${word}${suf}"
  done
}

capitalize() { echo "${1^}"; }

# ============================================================
# Main pipeline
# ============================================================
generate_passwords() {
  local target_lc="${TARGET,,}"
  local target_uc="${TARGET^^}"
  local target_cap; target_cap="$(capitalize "$target_lc")"

  local current_year y_start y_end
  current_year=$(date +%Y)
  if [[ "$YEAR_MODE" == "1" ]]; then
    y_start=$((current_year - 1)); y_end=$((current_year + 1))
  else
    y_start=2005; y_end=$((current_year + 1))
  fi

  # TIER 1
  {
    echo "$target_lc"; echo "$target_uc"; echo "$target_cap"

    if [[ "$LEET_MODE" != "off" ]]; then
      while read -r leet_var; do
        [[ -z "$leet_var" ]] && continue
        echo "$leet_var"
        echo "${leet_var}${current_year}"
        echo "${current_year}${leet_var}"
        gen_year_variations "$leet_var" "$y_start" "$y_end"
        gen_common_suffixes "$leet_var"
      done < <(expand_leet "$target_lc" | awk '!seen[$0]++')
    fi

    gen_year_variations "$target_lc"   "$y_start" "$y_end"
    gen_year_variations "$target_uc"   "$y_start" "$y_end"
    gen_year_variations "$target_cap"  "$y_start" "$y_end"
    gen_common_suffixes "$target_lc"
    gen_common_suffixes "$target_uc"
    gen_common_suffixes "$target_cap"
  } > "$TMP_TIER1"

  # TIER 2
  {
    gen_month_variations "$target_lc"
    gen_month_variations "$target_cap"
    gen_month_variations "$target_uc"
    gen_month_year_variations "$target_lc"  "$y_start" "$y_end"
    gen_month_year_variations "$target_cap" "$y_start" "$y_end"
    gen_month_year_variations "$target_uc"  "$y_start" "$y_end"

    if [[ "$LEET_MODE" != "off" ]]; then
      local m m_leet
      while read -r m; do
        [[ -z "$m" ]] && continue
        m_leet=$(leet_basic "$m")
        echo "${target_lc}${m_leet}"
        echo "${target_lc}${m_leet}${current_year}"
      done < <(get_months_short)
    fi

    local y m
    while read -r m; do
      [[ -z "$m" ]] && continue
      for ((y = y_start; y <= y_end; y++)); do
        echo "${m}${y}"; echo "${y}${m}"
        echo "${m^}${y}"; echo "${y}${m^}"
      done
    done < <(get_months_short)

    echo "${target_lc}${target_lc}"
    echo "${target_lc}.${target_lc}"
    echo "${target_cap}${target_cap}"
  } > "$TMP_TIER2"

  # TIER 3
  {
    local word w_lc w_uc w_cap
    while IFS= read -r word; do
      [[ -z "$word" || "$word" =~ ^# ]] && continue
      w_lc="${word,,}"
      w_uc="${word^^}"
      w_cap="$(capitalize "$w_lc")"

      echo "$w_lc"; echo "$w_uc"; echo "$w_cap"

      if [[ "$LEET_MODE" != "off" ]]; then
        while read -r wleet; do
          [[ -z "$wleet" ]] && continue
          echo "$wleet"
          echo "${wleet}${current_year}"
          gen_common_suffixes "$wleet"
        done < <(expand_leet "$w_lc" | awk '!seen[$0]++')
      fi

      gen_year_variations "$w_lc"  "$y_start" "$y_end"
      gen_year_variations "$w_cap" "$y_start" "$y_end"
      gen_month_variations "$w_lc"

      echo "${w_lc}${target_lc}"; echo "${target_lc}${w_lc}"
      echo "${w_cap}${target_cap}"; echo "${target_cap}${w_cap}"
      echo "${w_lc}.${target_lc}"; echo "${target_lc}.${w_lc}"
      echo "${w_lc}_${target_lc}"; echo "${target_lc}_${w_lc}"
      echo "${w_lc}-${target_lc}"; echo "${target_lc}-${w_lc}"
      echo "${w_uc}${target_uc}"; echo "${target_uc}${w_uc}"
      echo "${w_uc}_${target_uc}"; echo "${target_uc}_${w_uc}"
      echo "${w_cap}${target_cap}${current_year}"
      echo "${target_cap}${w_cap}${current_year}"
      gen_common_suffixes "$w_lc"
      gen_common_suffixes "$w_cap"
    done < "$BASEDIC_PATH"
  } > "$TMP_TIER3"
}

postprocess() {
  cat "$1" | adapt_to_charset | filter_length | awk '!seen[$0]++' > "$2"
}

# ============================================================
# Final report
# ============================================================
report_results() {
  local total="$1" requested="$2" effort_name="$3" file="$4"

  echo
  echo "═════════════════════════════════════════════════"
  echo "  RESULT"
  echo "═════════════════════════════════════════════════"
  echo "  Output file:           $file"
  echo "  Passwords generated:   $total"
  echo "  Effort level:          $effort_name"

  if (( requested == 0 )); then
    echo "  Cap requested:         none"
    echo
    echo "  ✓ All generated passwords included."
  elif (( total < requested )); then
    echo "  Cap requested:         $requested"
    echo
    echo "  ⚠  NOTICE: Only $total passwords were generated (below the cap of $requested)."
    echo
    echo "  This is usually caused by combined restrictions:"
    [[ "$MAX_LEN" -lt 10 ]] && echo "    • Max length is short ($MAX_LEN), discards many variants"
    [[ "$MIN_LEN" -gt 10 ]] && echo "    • Min length is high ($MIN_LEN), filters short variants"
    (( USE_SYMBOLS == 0 )) && echo "    • Symbols disabled — losing typical suffixes (!, @, #, !@#)"
    (( USE_DIGITS == 0 )) && echo "    • Digits disabled — losing years and numeric suffixes"
    [[ "$LEET_MODE" == "off" ]] && echo "    • Leet disabled — losing variants like acme→4cm3"
    [[ "$LANG_MODE" != "both" ]] && echo "    • Single language ($LANG_MODE) — 'both' doubles the basedic"
    [[ "$YEAR_MODE" == "1" ]] && echo "    • Recent year mode — only 3 years of variations"
    echo
    echo "  Suggestions to broaden:"
    echo "    • Edit $BASEDIC_PATH and add target-specific words"
    echo "    • Widen the length range"
    echo "    • Enable symbols and/or digits"
    echo "    • Enable leet (mode 'all' is the most generous)"
    echo "    • Switch language to 'both'"
    echo "    • Switch to historic year mode"
  else
    echo "  Cap requested:         $requested"
    echo
    echo "  ✓ Trimmed to cap. More passwords were generated than requested."
  fi
  echo "═════════════════════════════════════════════════"
}

# ============================================================
# Summary + confirmation
# ============================================================
print_summary_and_confirm() {
  echo
  echo "=== Summary ==="
  echo "  Target:    $TARGET"
  echo "  Language:  $LANG_MODE"
  echo "  Length:    $MIN_LEN - $MAX_LEN"
  echo "  Charset:   lower=$USE_LOWER upper=$USE_UPPER digits=$USE_DIGITS symbols=$USE_SYMBOLS"
  echo "  Leet:      $LEET_MODE"
  echo "  Basedic:   $BASEDIC_PATH"
  echo "  Years:     $([ "$YEAR_MODE" = "1" ] && echo "recent (3 years)" || echo "historic (2005+)")"
  echo "  Effort:    $EFFORT_NAME ($([ "$TOP_N" = "0" ] && echo "no cap" || echo "cap $TOP_N"))"
  echo "  Output:    ${OUTPUT_FILE:-P0lyn0m1c0n_${TARGET,,}.txt}"
  echo
  if (( SKIP_CONFIRM == 0 )); then
    ask_yn "Proceed?" "y" || exit 0
  fi
}

# ============================================================
# Main
# ============================================================
parse_args "$@"
print_banner

if (( INTERACTIVE )); then
  configure_interactive
fi

# Default basedic path if not given
[[ -z "$BASEDIC_PATH" ]] && BASEDIC_PATH="${PWD}/basedic.txt"
[[ -z "$OUTPUT_FILE" ]]  && OUTPUT_FILE="P0lyn0m1c0n_${TARGET,,}.txt"

print_summary_and_confirm
setup_basedic

TMPDIR_RUN=$(mktemp -d)
trap 'rm -rf "$TMPDIR_RUN"' EXIT
TMP_TIER1="$TMPDIR_RUN/tier1.txt"
TMP_TIER2="$TMPDIR_RUN/tier2.txt"
TMP_TIER3="$TMPDIR_RUN/tier3.txt"
TMP_T1_F="$TMPDIR_RUN/tier1.flt.txt"
TMP_T2_F="$TMPDIR_RUN/tier2.flt.txt"
TMP_T3_F="$TMPDIR_RUN/tier3.flt.txt"

echo
echo "[+] Generating variations (years, months, leet, basedic combinations)..."
generate_passwords

echo "[+] Filtering by charset and length..."
postprocess "$TMP_TIER1" "$TMP_T1_F"
postprocess "$TMP_TIER2" "$TMP_T2_F"
postprocess "$TMP_TIER3" "$TMP_T3_F"

cat "$TMP_T1_F" "$TMP_T2_F" "$TMP_T3_F" | awk '!seen[$0]++' > "$OUTPUT_FILE.full"

total=$(wc -l < "$OUTPUT_FILE.full")
if (( TOP_N > 0 && total > TOP_N )); then
  head -n "$TOP_N" "$OUTPUT_FILE.full" > "$OUTPUT_FILE"
  final_total="$TOP_N"
  rm "$OUTPUT_FILE.full"
else
  mv "$OUTPUT_FILE.full" "$OUTPUT_FILE"
  final_total="$total"
fi

report_results "$final_total" "$TOP_N" "$EFFORT_NAME" "$OUTPUT_FILE"

echo
echo "Preview (first 30):"
head -n 30 "$OUTPUT_FILE" | sed 's/^/  /'
