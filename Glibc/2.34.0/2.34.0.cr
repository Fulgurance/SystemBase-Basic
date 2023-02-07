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

        nsswitchData = <<-CODE
        passwd: files
        group: files
        shadow: files

        hosts: files dns
        networks: files

        protocols: files
        services: files
        ethers: files
        rpc: files
        CODE
        fileWriteData("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}etc/nsswitch.conf",nsswitchData)

        ldsoData = <<-CODE
        /usr/local/lib
        /opt/lib
        include /etc/ld.so.conf.d/*.conf
        CODE
        fileWriteData("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}etc/ld.so.conf",ldsoData)
    end

end
