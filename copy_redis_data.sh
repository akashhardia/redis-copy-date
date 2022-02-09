# source_host=redis://localhost:6379/2
# target_host=redis://localhost:6379/3
r=`tput setaf 1`
g=`tput setaf 2`
reset=`tput sgr0`

while getopts s:t: flag
do
    case "${flag}" in
        s) source_host=${OPTARG};;
        t) target_host=${OPTARG};;
    esac
done

echo "Source HOST: ${g} $source_host ${reset}"
echo "Target HOST: ${g} $target_host ${r}"

#copy all keys without preserving ttl!
redis-cli -c -u $source_host keys '*' | while read key; do
    echo "${g} ===== Copying =====  ${reset} $key \n"
    redis-cli --raw -c -u $source_host DUMP "$key" \
        | head -c -1 \
        | redis-cli -x -c -u $target_host RESTORE "$key" 0
done
