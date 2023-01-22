class Target < ISM::Software

    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--disable-static",
                            "--sysconfdir=/etc",
                            "--docdir=/usr/share/doc/attr-2.5.1"],
                            buildDirectoryPath)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

end
