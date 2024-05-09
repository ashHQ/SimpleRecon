#!/bin/bash
PATH_TO_DIRSEARCH="/home/user00/dirsearch/dirsearch"
TODAY=$(date)
echo "This scan was created on $TODAY"
DOMAIN=$1
DIRECTORY=${DOMAIN}_recon
echo "Creating directory $DIRECTORY."
mkdir $DIRECTORY
nmap_scan()
{
    nmap $DOMAIN > $DIRECTORY/nmap
    echo "The results of dirsearch scan are stored in $DIRECTORY/dirsearch."
}
dirsearch_scan()
{
    $PATH_TO_DIRSEARCH/dirsearch.py -u $DOMAIN -e php > $DIRECTORY/dirsearch
    echo "The results of dirsearch scan are stored in $DIRECTORY/dirsearch."

}
crt_scan()
{
    curl "https://crt.sh/?q=$DOMAIN&output=json" -o $DIRECTORY/crt
    echo "The results of cert parsing is stored in $DIRECTORY/crt"
}
case $2 in 
nmap-only)
    nmap_scan
    ;;
dirsearch-only)
    dirsearch_scan
    ;;
crt_only)
    crt_scan
    ;;
*)
    nmap_scan
    dirsearch_scan
    crt_scan
    ;;
esac

