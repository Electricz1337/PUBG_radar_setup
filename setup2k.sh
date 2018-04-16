#!/bin/bash
apt-get update

mkdir Radar
cd Radar

mkdir /opt/Oracle_Java
wget ftp.osuosl.org/pub/funtoo/distfiles/oracle-java/jdk-8u152-linux-x64.tar.gz
tar -xzf jdk-8u152-linux-x64.tar.gz -C /opt/Oracle_Java/
rm jdk-8u152-linux-x64.tar.gz

update-alternatives --install /usr/bin/java java /opt/Oracle_Java/jdk1.8.0_152/bin/java 1
update-alternatives --install /usr/bin/javac javac /opt/Oracle_Java/jdk1.8.0_152/bin/javac 1
update-alternatives --install /usr/bin/javaws javaws /opt/Oracle_Java/jdk1.8.0_152/bin/javaws 1
update-alternatives --install /usr/bin/jar jar /opt/Oracle_Java/jdk1.8.0_152/bin/jar 1

update-alternatives --set java /opt/Oracle_Java/jdk1.8.0_152/bin/java
update-alternatives --set javac /opt/Oracle_Java/jdk1.8.0_152/bin/javac
update-alternatives --set javaws /opt/Oracle_Java/jdk1.8.0_152/bin/javaws
update-alternatives --set jar /opt/Oracle_Java/jdk1.8.0_152/bin/jar

sed -i 's/#crypto.policy=unlimited.*/crypto.policy=unlimited/' '/opt/Oracle_Java/jdk1.8.0_152/jre/lib/security/java.security'

apt-get -y install dsniff
apt-get -y install maven
apt-get -y install git

git clone https://github.com/Electricz1337/Gaydar

cd Gaydar

mv src/main/resources/maps/Erangel_2k.png src/main/resources/maps/Erangel8k.png
mv src/main/resources/maps/Miramar_2k.png src/main/resources/maps/Miramar8k.png

mvn -T 1C clean verify install

cd ..
cd ..

clear
echo "Ip Adresse des Game PC eingeben (192.168.??.??) und Enter druecken"
read game_ip

clear
echo "Ip Adresse des Router eingeben (192.168.??.??) und Enter druecken"
read router_ip

clear
echo "Ip Adresse des Radar PC eingeben (192.168.??.??) und Enter druecken"
read radar_ip

clear
echo "Gebe den name des zu nutzenden Interface ein"
ls /sys/class/net

echo ""
read interface

clear

cat >run.sh <<EOF
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
arpspoof -i $interface -t $game_ip $router_ip & >/dev/null
arpspoof -i $interface -t $router_ip $game_ip & >/dev/null
java -jar Radar/Gaydar/target/Gaydar-6.9-jar-with-dependencies.jar $radar_ip PortFilter $game_ip
EOF

chmod +x run.sh
