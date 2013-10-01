#!/bin/bash
filename="$1"
outfile="$2"

# clear outfile
rm -f $outfile
touch $outfile

# loop through lines and output if bad.
while read -r line
do
	readline=$line

	originalUrl=`echo $readline | cut -d \; -f 1`
	originalUrl="http://$originalUrl"

	expectedUrl=`echo $readline | cut -d \; -f 2`
	expectedUrl="http://$expectedUrl"

	redirectUrl=`curl -s -w %{redirect_url}  $originalUrl -o /dev/null`

	if [ "$expectedUrl" != "$redirectUrl" ]; then
		  echo "FAIL: $originalUrl maps to $redirectUrl not $expectedUrl" >> $outfile
	fi
done < $filename
echo Done.


	
