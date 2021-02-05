for f in *
do
    echo "Processing $f file..."
    # take action on each file. $f store current file name
    java -jar ./unluac.jar $f  > decompiled_$f
done
