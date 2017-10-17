NSS_WRAPPER_PASSWD=/var/lib/postgresql/passwd
NSS_WRAPPER_GROUP=/etc/group
LD_PRELOAD=${LD_PRELOAD:+$LD_PRELOAD:}/usr/local/lib/libnss_wrapper.so
