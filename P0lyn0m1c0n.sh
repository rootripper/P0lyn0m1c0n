#!/bin/bash

echo '
██████╗  ██████╗ ██╗  ██╗   ██╗███╗   ██╗ ██████╗ ███╗   ███╗ ██╗ ██████╗ ██████╗ ███╗   ██╗
██╔══██╗██╔═████╗██║  ╚██╗ ██╔╝████╗  ██║██╔═████╗████╗ ████║███║██╔════╝██╔═████╗████╗  ██║
██████╔╝██║██╔██║██║   ╚████╔╝ ██╔██╗ ██║██║██╔██║██╔████╔██║╚██║██║     ██║██╔██║██╔██╗ ██║
██╔═══╝ ████╔╝██║██║    ╚██╔╝  ██║╚██╗██║████╔╝██║██║╚██╔╝██║ ██║██║     ████╔╝██║██║╚██╗██║
██║     ╚██████╔╝███████╗██║   ██║ ╚████║╚██████╔╝██║ ╚═╝ ██║ ██║╚██████╗╚██████╔╝██║ ╚████║
╚═╝      ╚═════╝ ╚══════╝╚═╝   ╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═╝ ╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝'
echo -e '
                           _________________________________
                         %::::::::::::::::::::::::::::::::##
                       %::::::::::::::::::::::::::::::::##..
                     %::::::::::::::::::::::::::::::::##....
                   %:::::::::7777777777:::::::::::::##......
                 %:::::::::77777777777::::::::::::##.......#
               %::::::::::7. .77..777:::::::::::##.......#
             %:::::::::::77777777777::::::::::##.......#
           %:::::::::::::777.77777::::::::::##.......#
         %::::::::::::::777.777:::::::::::##.......#
       %::::::::::::::::77.77:::::::::::##.......#
     %:::::::::::::::::77777::::::::::##.......#
   %::::::::::::::::::::::::::::::::##.......#
   ##################################**....#
   !!................................**..#
   !!................................**#
   ###################################
'
# Check if target name is supplied
if [ -z "$1" ]; then
  echo "Target name not supplied!!!"
  exit 1
fi

# Check if sponge command is available
if ! command -v sponge &> /dev/null; then
  echo 'Error: sponge is not installed. Please install moreutils package.'
  exit 1
fi

# Function to generate permutations and substitutions
generate_variations() {
  local word="$1"
  local prefix="$2"
  local year="$3"

  for ((i = 2005; i <= year; i++)); do
    echo "${prefix}${word}${i}"
    echo "${i}${word}${prefix}"
    echo "${i}.${word}"
    echo "${word}.${i}"
    echo "${i}_${word}"
    echo "${word}_${i}"
    echo "${i}-${word}"
    echo "${word}-${i}"
    echo "${word}${i}."
    echo "${i}${word}."
  done
}

# Function to perform substitutions
perform_substitutions() {
  local word="$1"
  local substitutions="$2"

  for substitution in "${substitutions[@]}"; do
    echo "${word}${substitution}"
    echo "${substitution}${word}"
  done
}

# Function to generate variations with substitutions
generate_variations_with_substitutions() {
  local word="$1"
  local substitutions=("${@:2}")

  for substitution in "${substitutions[@]}"; do
    generate_variations "$word$substitution" "$substitution"
  done
}

# Main script

# Set target and year
target="$1"
year=$(date +"%Y")+1

# Convert target to lowercase, uppercase, leet speak, and leet speak uppercase
target_lc="${target,,}"
target_uc="${target^^}"
target_leet="$(echo "$target_lc" | tr 'aeio' '4310')"
target_leet_uc="$(echo "$target_uc" | tr 'AEIO' '4310')"

# Create file name
filename="P0lyn0m1c0n_${target_lc}.txt"

# Read words from basedic.txt in the current directory
basedic_file="basedic.txt"
if [ ! -f "$basedic_file" ]; then
  echo "Error: $basedic_file not found in the current directory."
  exit 1
fi

# Read words from basedic.txt into an array
mapfile -t basedic < "$basedic_file"

# Append variations and substitutions to the file
generate_variations "$target_lc" "" "$year" | sponge "$filename"
generate_variations "$target_leet" "" "$year" | sponge -a "$filename"
generate_variations "$target_uc" "" "$year" | sponge -a "$filename"
generate_variations_with_substitutions "$target_uc" 'a' 'e' 'i' 'o' | sponge -a "$filename"
generate_variations "$target_leet_uc" "" "$year" | sponge -a "$filename"
generate_variations_with_substitutions "$target_leet_uc" 'a' 'e' 'i' 'o' | sponge -a "$filename"

# Append base dictionary variations to the file
for word in "${basedic[@]}"; do
  generate_variations "$word" "" "$year" | sponge -a "$filename"
  perform_substitutions "$word" 'A' 'E' 'I' 'O' | sponge -a "$filename"
done

# Append target with base dictionary variations to the file
for word in "${basedic[@]}"; do
  word_uc="${word^}"
  word_uc_leet="$(echo "$word_uc" | tr 'AEIO' '4310')"
  
  perform_substitutions "$word" "$target_lc" "$target_uc" "$target_leet" "$target_leet_uc" | sponge -a "$filename"
  perform_substitutions "$word_uc" "$target_lc" "$target_uc" "$target_leet" "$target_leet_uc" | sponge -a "$filename"
  perform_substitutions "$word_uc_leet" "$target_lc" "$target_uc" "$target_leet" "$target_leet_uc" | sponge -a "$filename"
done

echo "Variations and substitutions have been saved to $filename"
