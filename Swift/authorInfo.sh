mdate=`date +%Y/%m/%d`
year=${mdate%%/*}
projectName=$1
className=$2
info="//\n//    ${className}\n//  ${projectName}\n//\n//  Created by ${USER} on ${mdate}.\n// \n"
echo $info
