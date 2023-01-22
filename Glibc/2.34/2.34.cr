class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
        fileReplaceText("#{mainWorkDirectoryPath(false)}/sysdeps/unix/sysv/linux/mq_notify.c","NOTIFY_REMOVED)","NOTIFY_REMOVED && data.attr != NULL)")
    end

    def configure
        super
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
    end

    def prepareInstallation
        super
        makeDirectory("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/etc")
        makeDirectory("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/var/cache/nscd")
        makeDirectory("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/lib/locale")
        generateEmptyFile("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/etc/ld.so.conf")
        fileReplaceText("#{mainWorkDirectoryPath(false)}/Makefile","$(PERL)","echo not running")
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        copyFile("#{mainWorkDirectoryPath(false)}/nscd/nscd.conf","#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/etc/nscd.conf")
    end

end
