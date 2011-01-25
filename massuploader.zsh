#!/bin/zsh

LEVEL=9
TEMPORAL="/tmp/uploads/"
if  [ "$1" =  "" ]; then
DIRECTORY=`pwd`
USER=''
PASSWORD=''
/bin/echo "I have not detected any specified folder, i will upload automatically your files located on your current folder"
else;
DIRECTORY=$1
cd $DIRECTORY
fi
if [ -d "$TEMPORAL" ]; then
/bin/echo 'The temporal directory for uploads already exist.'
/bin/echo 'I will start zipping all your contents on: '
/bin/echo 'on the folder:'
/bin/echo $TEMPORAL
else
/bin/mkdir -p $TEMPORAL
/bin/touch /tmp/upload.txt
/bin/echo 'I have created a temporal directory on:'
/bin/echo $TEMPORAL
fi

echo 'Start zipping contents'
for file in $DIRECTORY/*; do
if [ -d "$file" ]; then
/bin/cp $HOME/Documentos/uploaded_for_free_culture.txt "$file/"
/bin/cp $HOME/Documentos/subido_para_la_cultura_libre.txt "$file/"
filemon=`echo $file|sed 's/\/home\/daniel\/Música\/Metallica\///'`
/bin/echo $filemon
/usr/bin/zip -rj$LEVEL "/tmp/uploads/$filemon.zip" "$file"
/usr/bin/plowup -v0 -a $USER:$PASSWORD -d "$filemon" "/tmp/uploads/$filemon.zip" megaupload >> /tmp/upload.txt
/bin/rm filemon
/bin/less /tmp/upload.txt
rm /tmp/upload.txt
fi
done