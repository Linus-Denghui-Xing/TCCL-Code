#!/usr/bin/perl -w
#This script will convert the cp2k XYZ file into an xyz file for PSO.
#Time-stamp: <Last updated: Zhao,Yafan zhaoyafan@mail.thu.edu.cn 2013-11-29 16:43:12>
use strict;
my $line;
my @lines;
my $num_atoms;
my $energy_au;
my $energyline;
my $stepnum;
my @array;
my @point3D;
my @molecule;
my %map=();
use constant DEBUG=>0;
#Periodical table
%map=('H',1,'He',2,'Li',3,'Be',4,'B',5,'C',6,'N',7,'O',8,'F',9,'Ne',10,'Na',11,'Mg',12,'Al',13,'Si',14,'P',15,'S',16,'Cl',17,'Ar',18,'K',19,'Ca',20,'Sc',21,'Ti',22,'V',23,'Cr',24,'Mn',25,'Fe',26,'Co',27,'Ni',28,'Cu',29,'Zn',30,'Ga',31,'Ge',32,'As',33,'Se',34,'Br',35,'Kr',36,'Rb',37,'Sr',38,'Y',39,'Zr',40,'Nb',41,'Mo',42,'Tc',43,'Ru',44,'Rh',45,'Pd',46,'Ag',47,'Cd',48,'In',49,'Sn',50,'Sb',51,'Te',52,'I',53,'Xe',54,'Cs',55,'Ba',56,'La',57,'Ce',58,'Pr',59,'Nd',60,'Pm',61,'Sm',62,'Eu',63,'Gd',64,'Tb',65,'Dy',66,'Ho',67,'Er',68,'Tm',69,'Yb',70,'Lu',71,'Hf',72,'Ta',73,'W',74,'Re',75,'Os',76,'Ir',77,'Pt',78,'Au',79,'Hg',80,'Tl',81,'Pb',82,'Bi',83,'Po',84,'At',85,'Rn',86,'Fr',87,'Ra',88,'Ac',89,'Th',90,'Pa',91,'U',92,'Np',93,'Pu',94,'Am',95,'Cm',96,'Bk',97,'Cf',98,'Es',99,'Fm',100,'Md',101,'No',102,'Lr',103,'Rf',104,'Db',105,'Sg',106,'Bh',107,'Hs',108,'Mt',109,'Ds',110,'Rg',111,'Uub',112,'Uut',113,'Uuq',114,'Uup',115,'Uuh',116,'Uus',117,'Uuo',118);
if ( @ARGV< 2) {
    print "Usage: cp2kdimerlog2xyz.pl [cp2k-pos-1.xyz] [fe.dat] \n";
    exit(0);
}
$num_atoms=`head -n 1 $ARGV[0]`;
chomp ($num_atoms);
$num_atoms=~s/^\s+|\s+$//g;
my $num_lines=$num_atoms+2;
do {
    @lines=`tail -n $num_lines $ARGV[0]`;
    if(DEBUG){
        print "$lines[0]";
    }
#    sleep(1);
} while($lines[0]!~/^\s+\d+$/);
$lines[1]=~/i\s+=\s+(\d+),\s+E =\s+([-]?\d+\.?\d+)/;
#i =       53, E =      -126.1425005872
$stepnum = $1;
$energy_au = $2;
if ( 2 == @ARGV) {
     $energyline=`grep -P "^$stepnum\t" $ARGV[1]`;
     if ($energyline=~/^\d+\s+([+\-]?\d+\.?\d+)/){
         $energy_au = $1;
     }
}
print "$num_atoms\n";
print "$energy_au\n";
for my $i(2..$num_atoms+1){
    if ($lines[$i]=~/\s+(\w+)\s+([+\-]?\d+\.?\d+)\s+([+\-]?\d+\.?\d+)\s+([+\-]?\d+\.?\d+)/){
	#Mn         3.0116233302        2.7974459027        2.6886516190
        #print "$map{$1} $2 $3 $4\n";
        print "$1 $2 $3 $4\n";
    }
}
