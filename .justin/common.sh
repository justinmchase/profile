# Run apt update / upgrade once per day
now=$(date --date=$(date --iso-8601) +%s 2>/dev/null)
last=$(date --date=$([ -f $HOME/.justin/.last ] && date --date=$(cat $HOME/.justin/.last) --iso-8601 || echo "2000-01-01") +%s 2>/dev/null)
delta=$(($now-$last))

if [ $delta -ne 0 ] && [ $(uname) == "Linux" ]
then
    sudo apt update
    sudo apt upgrade -y
    sudo apt autoremove -y
elif [ $delta -ne 0 ]
then
    echo "Unknown operating system $(uname), unable to automatically update."
fi
echo "$(date --iso-8601)" > $HOME/.justin/.last

if [ $(uname) == "Linux" ] && [ ! $(which xclip) ] || [ ! $(which xsel) ]
then
    echo "installing pbcopy..."
    sudo apt install -y xclip xsel 
fi