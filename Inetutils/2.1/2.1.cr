class Target < ISM::Software

    def configure
        super
        @useChroot=true
        configureSource([   "--prefix=/usr",
                            "--bindir=/usr/bin",
                            "--localstatedir=/var",
                            "--disable-logger",
                            "--disable-whois",
                            "--disable-rcp",
                            "--disable-rexec",
                            "--disable-rlogin",
                            "--disable-rsh",
                            "--disable-server"],
                            buildDirectoryPath)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        @useChroot=false
        copyFile("/usr/bin/ifconfig","#{builtSoftwareDirectoryPath}/usr/sbin/ifconfig")
    end

    def clear
        super
        deleteFile("/usr/bin/ifconfig")
    end

end
