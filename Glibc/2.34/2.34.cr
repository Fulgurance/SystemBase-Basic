class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
        fileReplaceText("#{mainWorkDirectoryPath}/sysdeps/unix/sysv/linux/mq_notify.c","NOTIFY_REMOVED)","NOTIFY_REMOVED && data.attr != NULL)")
    end

    def configure
        super
        @useChroot=true
        configureSource([   "--prefix=/usr",
                            "--disable-werror",
                            "--enable-kernel=3.2",
                            "--enable-stack-protector=strong",
                            "--with-headers=/usr/include",
                            "libc_cv_slibdir=/usr/lib"],
                            buildDirectoryPath)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
        @useChroot=false
    end

    def prepareInstallation
        super
        makeDirectory("#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/etc")
        makeDirectory("#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/var/cache/nscd")
        makeDirectory("#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/lib/locale")
        generateEmptyFile("#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/etc/ld.so.conf")
        fileReplaceText("#{mainWorkDirectoryPath}/Makefile","$(PERL)","echo not running")
        @useChroot=true
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        @useChroot=false
        copyFile("#{mainWorkDirectoryPath}/nscd/nscd.conf","#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/etc/nscd.conf")
    end

end
