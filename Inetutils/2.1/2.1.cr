class Target < ISM::Software

    def configure
        super
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
        copyFile("/usr/bin/ifconfig","#{builtSoftwareDirectoryPath(false)}/usr/sbin/ifconfig")
    end

    def clear
        super
        deleteFile("#{Ism.settings.rootPath}/usr/bin/ifconfig")
    end

end
