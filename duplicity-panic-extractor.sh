#!/bin/bash

SOURCE_DIR=${1}
RESTORE_DIR='restore'

if [ -z "${SOURCE_DIR}" ]; then
  echo "Usage: ${0} [diretory with duplicity-full.*.difftar.gpg files]"
  echo "Example: ${0} my_backup"
  exit 1
fi

echo "Preparing environment"
cd ${SOURCE_DIR}
mkdir -p ${RESTORE_DIR}
rm ${RESTORE_DIR}/*

echo "Extracting archives"
gpg --multifile --decrypt duplicity-full.*.difftar.gpg
for t in duplicity-full.*.difftar; do
  tar xf ${t};
done

echo "Restoring single volume snapshots"
mv snapshot/* ${RESTORE_DIR}

echo "Restoring multi volume snapshots"
cd multivol_snapshot
for f in `ls`; do
  for i in `ls ${f} | sort -n`; do
    cat ${f}/${i} >> ../${RESTORE_DIR}/${f}
  done
done

echo "Cleanup"
cd ..
rm duplicity-full.*.difftar
rm -rf snapshot
rm -rf multivol_snapshot

echo "Backups restored to ${SOURCE_DIR}/${RESTORE_DIR}:"
ls -lh ../${RESTORE_DIR}
