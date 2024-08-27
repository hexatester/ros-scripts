/queue type
add kind=fq-codel name=fq-codel-default
add cake-memlimit=32.0MiB kind=cake name=cake-default
add cake-diffserv=diffserv4 cake-flowmode=dual-dsthost cake-memlimit=32.0MiB cake-nat=yes kind=cake name=cake-download
add cake-diffserv=diffserv4 cake-flowmode=srchost cake-memlimit=32.0MiB cake-nat=yes kind=cake name=cake-upload
add kind=sfq name=sfq-default
add kind=red name=red-default