filename="$(basename $1)"
name="${filename%.*}"

scp -q $1 imada:assembly/$filename
ssh -T imada << HERE
    as --gstabs assembly/${filename} -o assembly/objects/${name}.o
    ld assembly/objects/${name}.o -o assembly/output/${name}
    ./assembly/output/${name} $2
HERE