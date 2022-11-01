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

if [ -n "$1" ]; then
  echo "You supplied the target name"
else
  echo "Target name not supplied!!!"
  exit
fi

if ! [ -x "$(command -v spongito)" ]; then
  echo 'Error: sponge is not installed.' >&2
  echo 'try apt-get install moreutils'
  exit 1
fi

basedicString=$(cat  basedic.txt |tr "\n" " ")
basedic=($basedicString)
len=${#basedic[@]}

target=$1
year=$(date +"%Y")+1
target_l=${target,,}
target_fu=${target_l^}
target_u=${target_l^^}
target_lafn=$(echo $target_l | tr 'a' '4' | tr 'e' '3' | tr 'i' '1' | tr 'o' '0')
target_fuafn=$(echo $target_fu | tr 'a' '4' | tr 'e' '3' | tr 'i' '1' | tr 'o' '0' | tr 'A' '4' | tr 'E' '3' | tr 'I' '1' | tr 'O' '0')
target_uafn=$(echo $target_u | tr 'a' '4' | tr 'e' '3' | tr 'i' '1' | tr 'o' '0' | tr 'A' '4' | tr 'E' '3' | tr 'I' '1' | tr 'O' '0')


echo $target_l >> P0lyn0m1c0n_$target_l.txt
for ((i=2005; i<= $year; i++)); do
        echo $target_l$i >> P0lyn0m1c0n_$target_l.txt
        echo $i$target_l >> P0lyn0m1c0n_$target_l.txt
        echo $i"."$target_l >> P0lyn0m1c0n_$target_l.txt
        echo $target_l"."$i >> P0lyn0m1c0n_$target_l.txt
        echo $i"_"$target_l >> P0lyn0m1c0n_$target_l.txt
        echo $target_l"_"$i >> P0lyn0m1c0n_$target_l.txt
        echo $i"-"$target_l >> P0lyn0m1c0n_$target_l.txt
        echo $target_l"-"$i >> P0lyn0m1c0n_$target_l.txt
        echo $target_l$i"." >> P0lyn0m1c0n_$target_l.txt
        echo $i$target_l"." >> P0lyn0m1c0n_$target_l.txt
done

echo $target_lafn >> P0lyn0m1c0n_$target_l.txt
for ((i=2005; i<= $year; i++)); do
        echo $target_lafn$i >> P0lyn0m1c0n_$target_l.txt
        echo $i$target_lafn >> P0lyn0m1c0n_$target_l.txt
        echo $i"."$target_lafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_lafn"."$i >> P0lyn0m1c0n_$target_l.txt
        echo $i"_"$target_lafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_lafn"_"$i >> P0lyn0m1c0n_$target_l.txt
        echo $i"-"$target_lafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_lafn"-"$i >> P0lyn0m1c0n_$target_l.txt
        echo $target_lafn$i"." >> P0lyn0m1c0n_$target_l.txt
        echo $i$target_lafn"." >> P0lyn0m1c0n_$target_l.txt
done

echo $target_fu >> P0lyn0m1c0n_$target_l.txt
for ((i=2005; i<= $year; i++)); do
        echo $target_fu$i >> P0lyn0m1c0n_$target_l.txt
        echo $i$target_fu >> P0lyn0m1c0n_$target_l.txt
        echo $i"."$target_fu >> P0lyn0m1c0n_$target_l.txt
        echo $target_fu"."$i >> P0lyn0m1c0n_$target_l.txt
        echo $i"_"$target_fu >> P0lyn0m1c0n_$target_l.txt
        echo $target_fu"_"$i >> P0lyn0m1c0n_$target_l.txt
        echo $i"-"$target_fu >> P0lyn0m1c0n_$target_l.txt
        echo $target_fu"-"$i >> P0lyn0m1c0n_$target_l.txt
        echo $target_fu$i"." >> P0lyn0m1c0n_$target_l.txt
        echo $i$target_fu"." >> P0lyn0m1c0n_$target_l.txt
done

echo $target_fuafn >> P0lyn0m1c0n_$target_l.txt
for ((i=2005; i<= $year; i++)); do
        echo $target_fuafn$i >> P0lyn0m1c0n_$target_l.txt
        echo $i$target_fuafn >> P0lyn0m1c0n_$target_l.txt
        echo $i"."$target_fuafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_fuafn"."$i >> P0lyn0m1c0n_$target_l.txt
        echo $i"_"$target_fuafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_fuafn"_"$i >> P0lyn0m1c0n_$target_l.txt
        echo $i"-"$target_fuafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_fuafn"-"$i >> P0lyn0m1c0n_$target_l.txt
        echo $target_fuafn$i"." >> P0lyn0m1c0n_$target_l.txt
        echo $i$target_fuafn"." >> P0lyn0m1c0n_$target_l.txt
done

echo $target_u >> P0lyn0m1c0n_$target_l.txt
for ((i=2005; i<= $year; i++)); do
        echo $target_u$i >> P0lyn0m1c0n_$target_l.txt
        echo $i$target_u >> P0lyn0m1c0n_$target_l.txt
        echo $i"."$target_u >> P0lyn0m1c0n_$target_l.txt
        echo $target_u"."$i >> P0lyn0m1c0n_$target_l.txt
        echo $i"_"$target_u >> P0lyn0m1c0n_$target_l.txt
        echo $target_u"_"$i >> P0lyn0m1c0n_$target_l.txt
        echo $i"-"$target_u >> P0lyn0m1c0n_$target_l.txt
        echo $target_u"-"$i >> P0lyn0m1c0n_$target_l.txt
        echo $target_u$i"." >> P0lyn0m1c0n_$target_l.txt
        echo $i$target_u"." >> P0lyn0m1c0n_$target_l.txt
done

echo $target_uafn >> P0lyn0m1c0n_$target_l.txt
for ((i=2005; i<= $year; i++)); do
        echo $target_uafn$i >> P0lyn0m1c0n_$target_l.txt
        echo $i$target_uafn >> P0lyn0m1c0n_$target_l.txt
        echo $i"."$target_uafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_uafn"."$i >> P0lyn0m1c0n_$target_l.txt
        echo $i"_"$target_uafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_uafn"_"$i >> P0lyn0m1c0n_$target_l.txt
        echo $i"-"$target_uafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_uafn"-"$i >> P0lyn0m1c0n_$target_l.txt
        echo $target_uafn$i"." >> P0lyn0m1c0n_$target_l.txt
        echo $i$target_uafn"." >> P0lyn0m1c0n_$target_l.txt
done



for k in "${basedic[@]}"
do
        for ((j=2005; j<= $year; j++)); do
                echo $k$j >> P0lyn0m1c0n_$target_l.txt
                echo $j$k >> P0lyn0m1c0n_$target_l.txt
                echo $j"."$k >> P0lyn0m1c0n_$target_l.txt
                echo $k"."$j >> P0lyn0m1c0n_$target_l.txt
                echo $j"_"$k >> P0lyn0m1c0n_$target_l.txt
                echo $k"_"$j >> P0lyn0m1c0n_$target_l.txt
                echo $j"-"$k >> P0lyn0m1c0n_$target_l.txt
                echo $k"-"$j >> P0lyn0m1c0n_$target_l.txt
                echo $k$j"." >> P0lyn0m1c0n_$target_l.txt
                echo $j$k"." >> P0lyn0m1c0n_$target_l.txt
        done
done

for k in "${basedic[@]}"
do
        bdw=$k
        bdw=${bdw^}
        for ((j=2005; j<= $year; j++)); do
                echo $bdw$j >> P0lyn0m1c0n_$target_l.txt
                echo $j$bdw >> P0lyn0m1c0n_$target_l.txt
                echo $j"."$bdw >> P0lyn0m1c0n_$target_l.txt
                echo $k"."$j >> P0lyn0m1c0n_$target_l.txt
                echo $j"_"$bdw >> P0lyn0m1c0n_$target_l.txt
                echo $bdw"_"$j >> P0lyn0m1c0n_$target_l.txt
                echo $j"-"$bdw >> P0lyn0m1c0n_$target_l.txt
                echo $bdw"-"$j >> P0lyn0m1c0n_$target_l.txt
                echo $bdw$j"." >> P0lyn0m1c0n_$target_l.txt
                echo $j$bdw"." >> P0lyn0m1c0n_$target_l.txt
        done
done

for k in "${basedic[@]}"
do
        bdw=$k
        bdw=${bdw^^}
        for ((j=2005; j<= $year; j++)); do
                echo $bdw$j >> P0lyn0m1c0n_$target_l.txt
                echo $j$bdw >> P0lyn0m1c0n_$target_l.txt
                echo $j"."$bdw >> P0lyn0m1c0n_$target_l.txt
                echo $k"."$j >> P0lyn0m1c0n_$target_l.txt
                echo $j"_"$bdw >> P0lyn0m1c0n_$target_l.txt
                echo $bdw"_"$j >> P0lyn0m1c0n_$target_l.txt
                echo $j"-"$bdw >> P0lyn0m1c0n_$target_l.txt
                echo $bdw"-"$j >> P0lyn0m1c0n_$target_l.txt
                echo $bdw$j"." >> P0lyn0m1c0n_$target_l.txt
                echo $j$bdw"." >> P0lyn0m1c0n_$target_l.txt
        done
done

for k in "${basedic[@]}"
do
        bd_lafn=$(echo $k | tr 'a' '4' | tr 'e' '3' | tr 'i' '1' | tr 'o' '0')
        for ((j=2005; j<= $year; j++)); do
                echo $bd_lafn$j >> P0lyn0m1c0n_$target_l.txt
                echo $j$bd_lafn >> P0lyn0m1c0n_$target_l.txt
                echo $j"."$bd_lafn >> P0lyn0m1c0n_$target_l.txt
                echo $bd_lafn"."$j >> P0lyn0m1c0n_$target_l.txt
                echo $j"_"$bd_lafn >> P0lyn0m1c0n_$target_l.txt
                echo $bd_lafn"_"$j >> P0lyn0m1c0n_$target_l.txt
                echo $j"-"$bd_lafn >> P0lyn0m1c0n_$target_l.txt
                echo $bd_lafn"-"$j >> P0lyn0m1c0n_$target_l.txt
                echo $bd_lafn$j"." >> P0lyn0m1c0n_$target_l.txt
                echo $j$bd_lafn"." >> P0lyn0m1c0n_$target_l.txt
        done
done

for k in "${basedic[@]}"
do
        bdw=$k
        bdw=${bdw^}
        bd_fuafn=$(echo $bdw | tr 'a' '4' | tr 'e' '3' | tr 'i' '1' | tr 'o' '0' | tr 'A' '4' | tr 'E' '3' | tr 'I' '1' | tr 'O' '0')
        for ((j=2005; j<= $year; j++)); do
                echo $bd_fuafn$j >> P0lyn0m1c0n_$target_l.txt
                echo $j$bd_fuafn >> P0lyn0m1c0n_$target_l.txt
                echo $j"."$bd_fuafn >> P0lyn0m1c0n_$target_l.txt
                echo $bd_fuafn"."$j >> P0lyn0m1c0n_$target_l.txt
                echo $j"_"$bd_fuafn >> P0lyn0m1c0n_$target_l.txt
                echo $bd_fuafn"_"$j >> P0lyn0m1c0n_$target_l.txt
                echo $j"-"$bd_fuafn >> P0lyn0m1c0n_$target_l.txt
                echo $bd_fuafn"-"$j >> P0lyn0m1c0n_$target_l.txt
                echo $bd_fuafn$j"." >> P0lyn0m1c0n_$target_l.txt
                echo $j$bd_fuafn"." >> P0lyn0m1c0n_$target_l.txt
        done
done

for k in "${basedic[@]}"
do
        bdw=$k
        bdw=${bdw^^}
        bd_uafn=$(echo $bdw | tr 'a' '4' | tr 'e' '3' | tr 'i' '1' | tr 'o' '0' | tr 'A' '4' | tr 'E' '3' | tr 'I' '1' | tr 'O' '0')
        for ((j=2005; j<= $year; j++)); do
                echo $bd_uafn$j >> P0lyn0m1c0n_$target_l.txt
                echo $j$bd_uafn >> P0lyn0m1c0n_$target_l.txt
                echo $j"."$bd_uafn >> P0lyn0m1c0n_$target_l.txt
                echo $bd_uafn"."$j >> P0lyn0m1c0n_$target_l.txt
                echo $j"_"$bd_uafn >> P0lyn0m1c0n_$target_l.txt
                echo $bd_uafn"_"$j >> P0lyn0m1c0n_$target_l.txt
                echo $j"-"$bd_uafn >> P0lyn0m1c0n_$target_l.txt
                echo $bd_uafn"-"$j >> P0lyn0m1c0n_$target_l.txt
                echo $bd_uafn$j"." >> P0lyn0m1c0n_$target_l.txt
                echo $j$bd_uafn"." >> P0lyn0m1c0n_$target_l.txt
        done
done

for k in "${basedic[@]}"
do
        echo $k$target_l >> P0lyn0m1c0n_$target_l.txt
        echo $target_l$k >> P0lyn0m1c0n_$target_l.txt
        echo $target_l"."$k >> P0lyn0m1c0n_$target_l.txt
        echo $k"."$target_l >> P0lyn0m1c0n_$target_l.txt
        echo $target_l"_"$k >> P0lyn0m1c0n_$target_l.txt
        echo $k"_"$target_l >> P0lyn0m1c0n_$target_l.txt
        echo $target_l"-"$k >> P0lyn0m1c0n_$target_l.txt
        echo $k"-"$target_l >> P0lyn0m1c0n_$target_l.txt
        echo $k$target_l"." >> P0lyn0m1c0n_$target_l.txt
        echo $target_l$k"." >> P0lyn0m1c0n_$target_l.txt

        echo $k$target_fu >> P0lyn0m1c0n_$target_l.txt
        echo $target_fu$k >> P0lyn0m1c0n_$target_l.txt
        echo $target_fu"."$k >> P0lyn0m1c0n_$target_l.txt
        echo $k"."$target_fu >> P0lyn0m1c0n_$target_l.txt
        echo $target_fu"_"$k >> P0lyn0m1c0n_$target_l.txt
        echo $k"_"$target_fu >> P0lyn0m1c0n_$target_l.txt
        echo $target_fu"-"$k >> P0lyn0m1c0n_$target_l.txt
        echo $k"-"$target_fu >> P0lyn0m1c0n_$target_l.txt
        echo $k$target_fu"." >> P0lyn0m1c0n_$target_l.txt
        echo $target_fu$k"." >> P0lyn0m1c0n_$target_l.txt

        echo $k$target_u >> P0lyn0m1c0n_$target_l.txt
        echo $target_u$k >> P0lyn0m1c0n_$target_l.txt
        echo $target_u"."$k >> P0lyn0m1c0n_$target_l.txt
        echo $k"."$target_u >> P0lyn0m1c0n_$target_l.txt
        echo $target_u"_"$k >> P0lyn0m1c0n_$target_l.txt
        echo $k"_"$target_u >> P0lyn0m1c0n_$target_l.txt
        echo $target_u"-"$k >> P0lyn0m1c0n_$target_l.txt
        echo $k"-"$target_u >> P0lyn0m1c0n_$target_l.txt
        echo $k$target_u"." >> P0lyn0m1c0n_$target_l.txt
        echo $target_u$k"." >> P0lyn0m1c0n_$target_l.txt

        echo $k$target_lafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_lafn$k >> P0lyn0m1c0n_$target_l.txt
        echo $target_lafn"."$k >> P0lyn0m1c0n_$target_l.txt
        echo $k"."$target_lafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_lafn"_"$k >> P0lyn0m1c0n_$target_l.txt
        echo $k"_"$target_lafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_lafn"-"$k >> P0lyn0m1c0n_$target_l.txt
        echo $k"-"$target_lafn >> P0lyn0m1c0n_$target_l.txt
        echo $k$target_lafn"." >> P0lyn0m1c0n_$target_l.txt
        echo $target_lafn$k"." >> P0lyn0m1c0n_$target_l.txt

        echo $k$target_fuafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_fuafn$k >> P0lyn0m1c0n_$target_l.txt
        echo $target_fuafn"."$k >> P0lyn0m1c0n_$target_l.txt
        echo $k"."$target_fuafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_fuafn"_"$k >> P0lyn0m1c0n_$target_l.txt
        echo $k"_"$target_fuafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_fuafn"-"$k >> P0lyn0m1c0n_$target_l.txt
        echo $k"-"$target_fuafn >> P0lyn0m1c0n_$target_l.txt
        echo $k$target_fuafn"." >> P0lyn0m1c0n_$target_l.txt
        echo $target_fuafn$k"." >> P0lyn0m1c0n_$target_l.txt

        echo $k$target_uafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_uafn$k >> P0lyn0m1c0n_$target_l.txt
        echo $target_uafn"."$k >> P0lyn0m1c0n_$target_l.txt
        echo $k"."$target_uafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_uafn"_"$k >> P0lyn0m1c0n_$target_l.txt
        echo $k"_"$target_uafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_uafn"-"$k >> P0lyn0m1c0n_$target_l.txt
        echo $k"-"$target_uafn >> P0lyn0m1c0n_$target_l.txt
        echo $k$target_uafn"." >> P0lyn0m1c0n_$target_l.txt
        echo $target_uafn$k"." >> P0lyn0m1c0n_$target_l.txt
done

for k in "${basedic[@]}"
do
        bdw=$k
        bdw=${bdw^}
        echo $bdw$target_l >> P0lyn0m1c0n_$target_l.txt
        echo $target_l$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $target_l"."$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"."$target_l >> P0lyn0m1c0n_$target_l.txt
        echo $target_l"_"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"_"$target_l >> P0lyn0m1c0n_$target_l.txt
        echo $target_l"-"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"-"$target_l >> P0lyn0m1c0n_$target_l.txt
        echo $bdw$target_l"." >> P0lyn0m1c0n_$target_l.txt
        echo $target_l$bdw"." >> P0lyn0m1c0n_$target_l.txt

        echo $bdw$target_fu >> P0lyn0m1c0n_$target_l.txt
        echo $target_fu$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $target_fu"."$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"."$target_fu >> P0lyn0m1c0n_$target_l.txt
        echo $target_fu"_"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"_"$target_fu >> P0lyn0m1c0n_$target_l.txt
        echo $target_fu"-"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"-"$target_fu >> P0lyn0m1c0n_$target_l.txt
        echo $bdw$target_fu"." >> P0lyn0m1c0n_$target_l.txt
        echo $target_fu$bdw"." >> P0lyn0m1c0n_$target_l.txt

        echo $bdw$target_u >> P0lyn0m1c0n_$target_l.txt
        echo $target_u$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $target_u"."$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"."$target_u >> P0lyn0m1c0n_$target_l.txt
        echo $target_u"_"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"_"$target_u >> P0lyn0m1c0n_$target_l.txt
        echo $target_u"-"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"-"$target_u >> P0lyn0m1c0n_$target_l.txt
        echo $bdw$target_u"." >> P0lyn0m1c0n_$target_l.txt
        echo $target_u$bdw"." >> P0lyn0m1c0n_$target_l.txt

        echo $bdw$target_lafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_lafn$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $target_lafn"."$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"."$target_lafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_lafn"_"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"_"$target_lafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_lafn"-"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"-"$target_lafn >> P0lyn0m1c0n_$target_l.txt
        echo $bdw$target_lafn"." >> P0lyn0m1c0n_$target_l.txt
        echo $target_lafn$bdw"." >> P0lyn0m1c0n_$target_l.txt

        echo $bdw$target_fuafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_fuafn$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $target_fuafn"."$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"."$target_fuafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_fuafn"_"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"_"$target_fuafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_fuafn"-"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"-"$target_fuafn >> P0lyn0m1c0n_$target_l.txt
        echo $bdw$target_fuafn"." >> P0lyn0m1c0n_$target_l.txt
        echo $target_fuafn$bdw"." >> P0lyn0m1c0n_$target_l.txt

        echo $bdw$target_uafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_uafn$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $target_uafn"."$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"."$target_uafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_uafn"_"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"_"$target_uafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_uafn"-"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"-"$target_uafn >> P0lyn0m1c0n_$target_l.txt
        echo $bdw$target_uafn"." >> P0lyn0m1c0n_$target_l.txt
        echo $target_uafn$bdw"." >> P0lyn0m1c0n_$target_l.txt
done

for k in "${basedic[@]}"
do
        bdw=$k
        bdw=${bdw^^}
        echo $bdw$target_l >> P0lyn0m1c0n_$target_l.txt
        echo $target_l$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $target_l"."$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"."$target_l >> P0lyn0m1c0n_$target_l.txt
        echo $target_l"_"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"_"$target_l >> P0lyn0m1c0n_$target_l.txt
        echo $target_l"-"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"-"$target_l >> P0lyn0m1c0n_$target_l.txt
        echo $bdw$target_l"." >> P0lyn0m1c0n_$target_l.txt
        echo $target_l$bdw"." >> P0lyn0m1c0n_$target_l.txt

        echo $bdw$target_fu >> P0lyn0m1c0n_$target_l.txt
        echo $target_fu$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $target_fu"."$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"."$target_fu >> P0lyn0m1c0n_$target_l.txt
        echo $target_fu"_"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"_"$target_fu >> P0lyn0m1c0n_$target_l.txt
        echo $target_fu"-"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"-"$target_fu >> P0lyn0m1c0n_$target_l.txt
        echo $bdw$target_fu"." >> P0lyn0m1c0n_$target_l.txt
        echo $target_fu$bdw"." >> P0lyn0m1c0n_$target_l.txt

        echo $bdw$target_u >> P0lyn0m1c0n_$target_l.txt
        echo $target_u$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $target_u"."$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"."$target_u >> P0lyn0m1c0n_$target_l.txt
        echo $target_u"_"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"_"$target_u >> P0lyn0m1c0n_$target_l.txt
        echo $target_u"-"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"-"$target_u >> P0lyn0m1c0n_$target_l.txt
        echo $bdw$target_u"." >> P0lyn0m1c0n_$target_l.txt
        echo $target_u$bdw"." >> P0lyn0m1c0n_$target_l.txt

        echo $bdw$target_lafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_lafn$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $target_lafn"."$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"."$target_lafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_lafn"_"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"_"$target_lafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_lafn"-"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"-"$target_lafn >> P0lyn0m1c0n_$target_l.txt
        echo $bdw$target_lafn"." >> P0lyn0m1c0n_$target_l.txt
        echo $target_lafn$bdw"." >> P0lyn0m1c0n_$target_l.txt

        echo $bdw$target_fuafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_fuafn$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $target_fuafn"."$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"."$target_fuafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_fuafn"_"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"_"$target_fuafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_fuafn"-"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"-"$target_fuafn >> P0lyn0m1c0n_$target_l.txt
        echo $bdw$target_fuafn"." >> P0lyn0m1c0n_$target_l.txt
        echo $target_fuafn$bdw"." >> P0lyn0m1c0n_$target_l.txt

        echo $bdw$target_uafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_uafn$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $target_uafn"."$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"."$target_uafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_uafn"_"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"_"$target_uafn >> P0lyn0m1c0n_$target_l.txt
        echo $target_uafn"-"$bdw >> P0lyn0m1c0n_$target_l.txt
        echo $bdw"-"$target_uafn >> P0lyn0m1c0n_$target_l.txt
        echo $bdw$target_uafn"." >> P0lyn0m1c0n_$target_l.txt
        echo $target_uafn$bdw"." >> P0lyn0m1c0n_$target_l.txt
done

for k in "${basedic[@]}"
do
    bdw=$(echo $k | tr 'a' '4' | tr 'e' '3' | tr 'i' '1' | tr 'o' '0')
    echo $bdw$target_l >> P0lyn0m1c0n_$target_l.txt
    echo $target_l$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $target_l"."$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"."$target_l >> P0lyn0m1c0n_$target_l.txt
    echo $target_l"_"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"_"$target_l >> P0lyn0m1c0n_$target_l.txt
    echo $target_l"-"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"-"$target_l >> P0lyn0m1c0n_$target_l.txt
    echo $bdw$target_l"." >> P0lyn0m1c0n_$target_l.txt
    echo $target_l$bdw"." >> P0lyn0m1c0n_$target_l.txt

    echo $bdw$target_fu >> P0lyn0m1c0n_$target_l.txt
    echo $target_fu$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $target_fu"."$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"."$target_fu >> P0lyn0m1c0n_$target_l.txt
    echo $target_fu"_"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"_"$target_fu >> P0lyn0m1c0n_$target_l.txt
    echo $target_fu"-"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"-"$target_fu >> P0lyn0m1c0n_$target_l.txt
    echo $bdw$target_fu"." >> P0lyn0m1c0n_$target_l.txt
    echo $target_fu$bdw"." >> P0lyn0m1c0n_$target_l.txt

    echo $bdw$target_u >> P0lyn0m1c0n_$target_l.txt
    echo $target_u$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $target_u"."$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"."$target_u >> P0lyn0m1c0n_$target_l.txt
    echo $target_u"_"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"_"$target_u >> P0lyn0m1c0n_$target_l.txt
    echo $target_u"-"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"-"$target_u >> P0lyn0m1c0n_$target_l.txt
    echo $bdw$target_u"." >> P0lyn0m1c0n_$target_l.txt
    echo $target_u$bdw"." >> P0lyn0m1c0n_$target_l.txt

    echo $bdw$target_lafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_lafn$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $target_lafn"."$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"."$target_lafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_lafn"_"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"_"$target_lafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_lafn"-"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"-"$target_lafn >> P0lyn0m1c0n_$target_l.txt
    echo $bdw$target_lafn"." >> P0lyn0m1c0n_$target_l.txt
    echo $target_lafn$bdw"." >> P0lyn0m1c0n_$target_l.txt

    echo $bdw$target_fuafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_fuafn$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $target_fuafn"."$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"."$target_fuafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_fuafn"_"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"_"$target_fuafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_fuafn"-"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"-"$target_fuafn >> P0lyn0m1c0n_$target_l.txt
    echo $bdw$target_fuafn"." >> P0lyn0m1c0n_$target_l.txt
    echo $target_fuafn$bdw"." >> P0lyn0m1c0n_$target_l.txt

    echo $bdw$target_uafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_uafn$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $target_uafn"."$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"."$target_uafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_uafn"_"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"_"$target_uafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_uafn"-"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"-"$target_uafn >> P0lyn0m1c0n_$target_l.txt
    echo $bdw$target_uafn"." >> P0lyn0m1c0n_$target_l.txt
    echo $target_uafn$bdw"." >> P0lyn0m1c0n_$target_l.txt

done

for k in "${basedic[@]}"
do
    bdw=$k
    bdw=${bdw^}
        bdw=$(echo $bdw | tr 'a' '4' | tr 'e' '3' | tr 'i' '1' | tr 'o' '0' | tr 'A' '4' | tr 'E' '3' | tr 'I' '1' | tr 'O' '0')
    echo $bdw$target_l >> P0lyn0m1c0n_$target_l.txt
    echo $target_l$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $target_l"."$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"."$target_l >> P0lyn0m1c0n_$target_l.txt
    echo $target_l"_"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"_"$target_l >> P0lyn0m1c0n_$target_l.txt
    echo $target_l"-"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"-"$target_l >> P0lyn0m1c0n_$target_l.txt
    echo $bdw$target_l"." >> P0lyn0m1c0n_$target_l.txt
    echo $target_l$bdw"." >> P0lyn0m1c0n_$target_l.txt

    echo $bdw$target_fu >> P0lyn0m1c0n_$target_l.txt
    echo $target_fu$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $target_fu"."$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"."$target_fu >> P0lyn0m1c0n_$target_l.txt
    echo $target_fu"_"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"_"$target_fu >> P0lyn0m1c0n_$target_l.txt
    echo $target_fu"-"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"-"$target_fu >> P0lyn0m1c0n_$target_l.txt
    echo $bdw$target_fu"." >> P0lyn0m1c0n_$target_l.txt
    echo $target_fu$bdw"." >> P0lyn0m1c0n_$target_l.txt

    echo $bdw$target_u >> P0lyn0m1c0n_$target_l.txt
    echo $target_u$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $target_u"."$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"."$target_u >> P0lyn0m1c0n_$target_l.txt
    echo $target_u"_"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"_"$target_u >> P0lyn0m1c0n_$target_l.txt
    echo $target_u"-"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"-"$target_u >> P0lyn0m1c0n_$target_l.txt
    echo $bdw$target_u"." >> P0lyn0m1c0n_$target_l.txt
    echo $target_u$bdw"." >> P0lyn0m1c0n_$target_l.txt

    echo $bdw$target_lafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_lafn$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $target_lafn"."$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"."$target_lafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_lafn"_"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"_"$target_lafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_lafn"-"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"-"$target_lafn >> P0lyn0m1c0n_$target_l.txt
    echo $bdw$target_lafn"." >> P0lyn0m1c0n_$target_l.txt
    echo $target_lafn$bdw"." >> P0lyn0m1c0n_$target_l.txt

    echo $bdw$target_fuafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_fuafn$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $target_fuafn"."$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"."$target_fuafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_fuafn"_"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"_"$target_fuafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_fuafn"-"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"-"$target_fuafn >> P0lyn0m1c0n_$target_l.txt
    echo $bdw$target_fuafn"." >> P0lyn0m1c0n_$target_l.txt
    echo $target_fuafn$bdw"." >> P0lyn0m1c0n_$target_l.txt

    echo $bdw$target_uafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_uafn$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $target_uafn"."$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"."$target_uafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_uafn"_"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"_"$target_uafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_uafn"-"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"-"$target_uafn >> P0lyn0m1c0n_$target_l.txt
    echo $bdw$target_uafn"." >> P0lyn0m1c0n_$target_l.txt
    echo $target_uafn$bdw"." >> P0lyn0m1c0n_$target_l.txt

done

for k in "${basedic[@]}"
do
    bdw=$k
    bdw=${bdw^^}
    bdw=$(echo $bdw | tr 'a' '4' | tr 'e' '3' | tr 'i' '1' | tr 'o' '0' | tr 'A' '4' | tr 'E' '3' | tr 'I' '1' | tr 'O' '0')
    echo $bdw$target_l >> P0lyn0m1c0n_$target_l.txt
    echo $target_l$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $target_l"."$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"."$target_l >> P0lyn0m1c0n_$target_l.txt
    echo $target_l"_"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"_"$target_l >> P0lyn0m1c0n_$target_l.txt
    echo $target_l"-"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"-"$target_l >> P0lyn0m1c0n_$target_l.txt
    echo $bdw$target_l"." >> P0lyn0m1c0n_$target_l.txt
    echo $target_l$bdw"." >> P0lyn0m1c0n_$target_l.txt

    echo $bdw$target_fu >> P0lyn0m1c0n_$target_l.txt
    echo $target_fu$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $target_fu"."$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"."$target_fu >> P0lyn0m1c0n_$target_l.txt
    echo $target_fu"_"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"_"$target_fu >> P0lyn0m1c0n_$target_l.txt
    echo $target_fu"-"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"-"$target_fu >> P0lyn0m1c0n_$target_l.txt
    echo $bdw$target_fu"." >> P0lyn0m1c0n_$target_l.txt
    echo $target_fu$bdw"." >> P0lyn0m1c0n_$target_l.txt

    echo $bdw$target_u >> P0lyn0m1c0n_$target_l.txt
    echo $target_u$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $target_u"."$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"."$target_u >> P0lyn0m1c0n_$target_l.txt
    echo $target_u"_"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"_"$target_u >> P0lyn0m1c0n_$target_l.txt
    echo $target_u"-"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"-"$target_u >> P0lyn0m1c0n_$target_l.txt
    echo $bdw$target_u"." >> P0lyn0m1c0n_$target_l.txt
    echo $target_u$bdw"." >> P0lyn0m1c0n_$target_l.txt

    echo $bdw$target_lafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_lafn$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $target_lafn"."$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"."$target_lafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_lafn"_"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"_"$target_lafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_lafn"-"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"-"$target_lafn >> P0lyn0m1c0n_$target_l.txt
    echo $bdw$target_lafn"." >> P0lyn0m1c0n_$target_l.txt
    echo $target_lafn$bdw"." >> P0lyn0m1c0n_$target_l.txt

    echo $bdw$target_fuafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_fuafn$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $target_fuafn"."$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"."$target_fuafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_fuafn"_"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"_"$target_fuafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_fuafn"-"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"-"$target_fuafn >> P0lyn0m1c0n_$target_l.txt
    echo $bdw$target_fuafn"." >> P0lyn0m1c0n_$target_l.txt
    echo $target_fuafn$bdw"." >> P0lyn0m1c0n_$target_l.txt

    echo $bdw$target_uafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_uafn$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $target_uafn"."$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"."$target_uafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_uafn"_"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"_"$target_uafn >> P0lyn0m1c0n_$target_l.txt
    echo $target_uafn"-"$bdw >> P0lyn0m1c0n_$target_l.txt
    echo $bdw"-"$target_uafn >> P0lyn0m1c0n_$target_l.txt
    echo $bdw$target_uafn"." >> P0lyn0m1c0n_$target_l.txt
    echo $target_uafn$bdw"." >> P0lyn0m1c0n_$target_l.txt

done

sort P0lyn0m1c0n_$target_l.txt | uniq | sponge P0lyn0m1c0n_$target_l.txt
echo -e '\nP0lyn0m1c0n is ready!!\n'
