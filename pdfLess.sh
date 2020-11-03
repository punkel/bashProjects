#!/bin/bash

PFADOUT=$(pwd) #~/Dokumente
PFADIN=$(pwd)
PARAMETERqualaty="default"
QUALATY=0

if hash gs 2>/dev/null;
  then
    echo "Willkommen zur PDF Verkleinerung"
  else
    echo -e "Programm GhostScript nicht gefunden. Bitte Installieren\nsudo apt-get install -yf ghostscript"
    exit
fi

if [ $# -ge 3 ]
  then
    echo -e "False Handling\n\nuse: hpdfLess file qualaty\nfor: file-small.pdf"
    exit
fi

# get file
if [ $# -eq 0 ]
  then
	  read -e -p "Bitte Ausgangs PDF angeben: " FILEIN
	else
	  FILEIN=$1
fi

# check file
if [ ! -f $FILEIN ]
  then
    echo "File not exist"
    exit
fi

# get qualaty
if [ $# -le 1 ]
  then
	  echo -e "Auf welches Format soll verkleinert werden?\n1 = screen 72dpi\n2 = ebook 150 dpi\n3 = printer 300 dpi\n4 = prepress 300 dpi Farbverbesserung\n5 = default"
	  read QUALATY
	else
	  QUALATY=$2
fi
# check qualaty
if [ $QUALATY -le 0 ] || [ $QUALATY -ge 6 ]
  then
    echo "False Qualaty use 1-5"
    exit
fi

case $QUALATY in
  1)
	  PARAMETERqualaty="screen"
	  ;;
  2)
	  PARAMETERqualaty="ebook"
	  ;;
  3)
	  PARAMETERqualaty="printer"
	  ;;
  4)
	  PARAMETERqualaty="prepress"
	  ;;
  5)
	  PARAMETERqualaty="default"
	  ;;
  default)
	  echo "Falscher Wert"
	  exit
	  ;;
esac

# name for the new file
FILEOUT=${FILEIN%\.pdf}-small.pdf

gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/$PARAMETERqualaty -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$PFADOUT/$FILEOUT $PFADIN/$FILEIN
echo -e "\nDie Datei $FILEOUT liegt im Ordner $PFADOUT\n"
