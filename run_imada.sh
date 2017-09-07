filename="$(basename $1)"
name="${filename%.*}"

scp $1 imada:assembly/$filename
ssh imada << HERE
    as assembly/${filename} -o assembly/objects/${name}.o
    ld assembly/objects/${name}.o -o assembly/output/${name}
    ./assembly/output/${name} 
HERE