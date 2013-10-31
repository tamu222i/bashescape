#!/bin/sh
ng='"trigger_key":trigger_key>>>"log[/tmp/hoge.txt,"not\[ic\]",,100,skip]"<<<trigger_key'
#ok='"trigger_key":"log[/tmp/hoge.txt,not\[i,,100,skip]"'

begin='trigger_key>>>"'
end='"<<<trigger_key'
var1=`echo ${ng} | awk --assign begin=$begin '{split($0,arr,begin);{print arr[2]}}'`
echo $var1
var2=`echo ${var1} | awk --assign end=$end '{split($0,arr,end);{print arr[1]}}'`
echo $var2
var3=`echo ${var2} | sed -e 's/\"/\\\"/g'`
echo $var3
var4=`echo "${begin}${var2}${end}" | sed -e 's/\\\\/\\\\\\\\/g' | sed -e 's/\//\\\\\//g' | sed -e 's/\[/\\\\\[/g' | sed -e 's/\]/\\\\\]/g'`
echo $var4
var5=`echo "${begin}${var3}${end}" | sed -e 's/\\\\/\\\\\\\\/g' | sed -e 's/\//\\\\\//g' | sed -e 's/\[/\\\\\[/g' | sed -e 's/\]/\\\\\]/g'`
echo $var5

echo $ng
echo ${ng} | sed -e 's/'$var4'/'$var5'/g'
echo ${ng} | perl -pe 's/'$var4'/'$var5'/g'

#var6=`echo ${ng} | perl -pe 's/'$var4'/'$var5'/g'`
#echo $var6
#
#echo '{' $ng '}'

