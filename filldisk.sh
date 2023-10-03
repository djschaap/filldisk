#!/bin/ash
set -u

if [ -z "${TEMP_FILE:-}" ] ; then
	TEMP_FILE=$(mktemp)
fi

echo filldisk.sh
echo
echo "START_SIZE=${START_SIZE:=1} MiB"
echo "MAX_ITER=${MAX_ITER:=2}"
echo "INCREMENT=${INCREMENT:=1} MiB"
echo "TEMP_FILE=${TEMP_FILE}"
echo
echo id
id
echo
echo df
df
echo
echo df -h
df -h
echo

# fix block size at 1 MiB for reasonable performance
RAW_BS=1048576

echo "write first ${START_SIZE} MiB"
dd status=none if=/dev/zero of=$TEMP_FILE bs=$RAW_BS count=$START_SIZE

for I in $(seq $MAX_ITER); do
	echo "i=${I} target_size=$((START_SIZE+I*INCREMENT)) MiB"
	if ! dd status=none if=/dev/zero bs=$RAW_BS count=$INCREMENT \
			>> $TEMP_FILE ; then
		echo "error encountered; aborting loop"
		break
	fi
done

echo
echo ls -l $TEMP_FILE
ls -l $TEMP_FILE
echo
echo ls -lh $TEMP_FILE
ls -lh $TEMP_FILE
echo
echo df
df
echo
echo df -h
df -h
