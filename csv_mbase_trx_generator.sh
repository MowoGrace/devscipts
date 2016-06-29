#!/bin/bash

fileName="mbase_trx_generator_output.xml"
rm -rf $fileName;
touch $fileName;


cat mbase_trx_generator_sample.csv| while read i 

do

startPosition=$(echo $i | cut -f1 -d\,);
endPosition=$(echo $i | cut -f2 -d\,);
fieldLength=$(echo $i | cut -f3 -d\,);
handlerType=$(echo $i | cut -f4 -d\,);
fieldName=$(echo $i | cut -f5 -d\,);

case $handlerType in
	S|s )
	Xml="<field start=\"$startPosition\" end=\"$endPosition\"><name>$fieldName</name><length>$fieldLength</length><handler type=\"com.profitera.services.system.dsp.handler.ZonedDecimalHandler\" /><value /></field>";
	;;
	A|a )
	Xml="<field start=\"$startPosition\" end=\"$endPosition\"><name>$fieldName</name><length>$fieldLength</length><handler type=\"com.profitera.services.system.dsp.handler.CharHandler\" /><value /></field>"
	;;
	*)
esac

echo $Xml >> $fileName;


done





