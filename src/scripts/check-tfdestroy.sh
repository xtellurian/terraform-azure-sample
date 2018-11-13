
while getopts a:f: option
do
    case "${option}"
    in
    a) ALLOW_DESTROY=${OPTARG};;
    f) FILE_PATH=${OPTARG};;
    esac
done

if [ -z "$FILE_PATH" ]; then
    echo "-f is a required argument - path to plan summary file"
    exit 1
fi

# check if the summary file contains the word 'destroy'
file="$(cat $FILE_PATH)"
testseq="- destroy"
if [[ $file =~ $testseq ]];
then
    echo "There are destroy commands in the plan"
    
    if [ "$ALLOW_DESTROY" = "true" ] 
    then 
        echo "Destroy operations are allowed." 
    elif [ "$ALLOW_DESTROY" = "false" ] 
    then
        echo "Destroy operations are not allowed."
        exit 1
    else
        echo "Destoy operations may be allowed with the -a flag"
        exit 1
    fi
else
    echo "No destruction detected."
fi