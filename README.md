# duplicity-panic-extractor 😳😲😱
## Motivation
[Duplicity](http://duplicity.nongnu.org/) is an awesome software for doing incremental, secure backups. But sometimes things might fail. For example when you don't have enough room on your backup device and first full backup does not finish successfully. Then when you want to do restore, you might end with something like:

```
duplicity restore file:///my_backup /foo
Local and Remote metadata are synchronized, no sync needed.
Last full backup date: none
GnuPG passphrase:
Traceback (most recent call last):
  File "/usr/bin/duplicity", line 1494, in <module>
    with_tempdir(main)
  File "/usr/bin/duplicity", line 1488, in with_tempdir
    fn()
  File "/usr/bin/duplicity", line 1337, in main
    do_backup(action)
  File "/usr/bin/duplicity", line 1422, in do_backup
    restore(col_stats)
  File "/usr/bin/duplicity", line 697, in restore
    restore_get_patched_rop_iter(col_stats)):
  File "/usr/bin/duplicity", line 719, in restore_get_patched_rop_iter
    backup_chain = col_stats.get_backup_chain_at_time(time)
  File "/usr/lib/python2.7/dist-packages/duplicity/collections.py", line 952, in get_backup_chain_at_time
    raise CollectionsError("No backup chains found")
CollectionsError: No backup chains found
```

Duplicity is not really good at providing some help at this point. Luckily there still might be a chance for you. Internally it does not use anything complicated, just some gpg, tar, and file splitting. So you might try to recover the data manually.

This repository is here to help. Maybe you can just run the script and everything will magically work. Maybe it will just give you the idea what's happening and you can fix it yourself.

## HowTo use this

1. Clone this repo
```
git clone git@github.com:MichalBryxi/duplicity-panic-extractor.git
```

2. Run the script and cross your fingers
```
cd duplicity-panic-extractor
./duplicity-panic-extractor.sh ~/my-duplicity-directory
```

## Contributing
Pull requests welcome!

## Credits
- https://wiki.gnome.org/Apps/DejaDup/Help/Restore/WorstCase
