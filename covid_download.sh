#!/bin/bash

date=$(date -d "yesterday" '+%Y-%m-%d')
filename=$(printf 'cord-19_%s.tar.gz' "$date")
url=$(printf 'https://ai2-semanticscholar-cord-19.s3-us-west-2.amazonaws.com/historical_releases/%s' "$filename")

echo "*******************"
echo "COVID-19 Text Data"
echo ""
echo "Pulling data as of:"
echo $date
echo "*******************"

wget $url

echo "Untarring..."
tar -xzf $filename
rm $filename

echo "Untarring nested tars..."
cd $date
tar -xzf document_parses.tar.gz 
echo "document_parses....done"
tar -xzf cord_19_embeddings.tar.gz
echo "cord_19_embeddings....done"

echo "Cleaning Up"
rm document_parses.tar.gz
rm cord_19_embeddings.tar.gz

echo "Done!"