#!/bin/bash
# task 4 answer script
# Usage: ./line_count.sh <dictionary> <ecrypted file>
# -----------------------------------------------------------------------------

# Link filedescriptor 10 with stdin
exec 10<&0
# stdin replaced with a file supplied as a first argument
exec < $1
# remember the name of the input file
dict=$1
cipher=$2
plaintext=""
password=""


# init
file="current_line.txt"
let count=0


while read LINE
do
    # for loop to create new file containing all possible passwords
    for i in {1..9}
    do
        echo $LINE$i >> possiblepasses.txt  #writes to new file
        echo $LINE$i >> possiblepasses2.txt
    done 
done

while read LINE #reads possible passes and decrypts 
do
    # for decrypt using all possible passes with padding

    if ! [[ -s decrypts.txt ]] #checks if decrypted file is empty
    then
        openssl enc -aes-128-cbc -d -in $cipher -out decrypts.txt -pass pass:$LINE
    else
        if grep -Fxq $LINE words.txt
            then
                $plaintext = $(head -n 1 decrypts.txg)
                $password = $LINE
            else
                echo "checking without padding...."
        fi

        echo "plain text: $(head -n 1 decrypts.txg)"
        echo "password: $password "
        exit
    fi

    
  
done < possiblepasses.txt



while read LINE #reads possible passes and decrypts 
do
    # for decrypt using all possible passes with padding

    if ! [[ -s decrypts.txt ]] #checks if decrypted file is empty
    then
        openssl enc -aes-128-cbc -d -in $cipher -out decrypts.txt -pass pass:$LINE --nopad
    else
        if grep -Fxq $LINE words.txt
            then
                echo "plainword: $line"
        fi

        echo "file is not empty "
        exit
    fi

    
  
done < possiblepasses2.txt




## Note: You can achieve the same by just using the tool wc like this
#echo "Expected number of lines: `wc -l $in`"

# restore stdin from filedescriptor 10
# and close filedescriptor 10
exec 0<&10 10<&-
