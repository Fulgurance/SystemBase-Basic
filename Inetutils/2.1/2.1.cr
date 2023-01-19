class Target < ISM::Software

    def configure
        super
        configureSource([   "--prefix=#{Ism.settings.rootPath}/usr",
                            "--bindir=#{Ism.settings.rootPath}/usr/bin",
                            "--localstatedir=#{Ism.settings.rootPath}/var",
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
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}","install"],buildDirectoryPath)
        copyFile("/usr/bin/ifconfig","#{builtSoftwareDirectoryPath}/usr/sbin/ifconfig")
    end

    def clear
        super
        deleteFile("/usr/bin/ifconfig")
    end

end
