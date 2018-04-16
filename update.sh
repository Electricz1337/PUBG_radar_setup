#!/bin/bash
rm -r Gaydar

git clone https://github.com/Electricz1337/Gaydar

cd Gaydar

PS3="Which map do you want to use? "
options=("2k Map" "4k Map" "8k Map")
select opt in "${options[@]}"
do
    case $opt in
         "2k Map")
            echo "Using 2k Map"
              mv src/main/resources/maps/Erangel_2k.png src/main/resources/maps/Erangel8k.png
              mv src/main/resources/maps/Miramar_2k.png src/main/resources/maps/Miramar8k.png
            break
            ;;
        "4k Map")
            echo "Using 4k Map"
              mv src/main/resources/maps/Erangel_4k.png src/main/resources/maps/Erangel8k.png
              mv src/main/resources/maps/Miramar_4k.png src/main/resources/maps/Miramar8k.png
            break
            ;;
        "8k Map")
            echo "Using 8k Map"
              mv src/main/resources/maps/Erangel_8k.png src/main/resources/maps/Erangel8k.png
              mv src/main/resources/maps/Miramar_8k.png src/main/resources/maps/Miramar8k.png
            break
            ;;
        *) echo invalid option;;
    esac
done

mvn -T 1C clean verify install

cd ..

if [ -e run.sh ]
then
  echo "Keep previous run.sh [Y/N]? "
  read keep
  if [ "$keep" != "${keep#[Yy]}" ]
  then
    exit
  fi
fi

wget https://raw.githubusercontent.com/Electricz1337/PUBG_radar_setup/master/create_run.sh -O create_run.sh
chmod +x create_run.sh
./create_run.sh
