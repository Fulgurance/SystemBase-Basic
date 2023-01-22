class Target < ISM::Software

    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--disable-static",
                            "--docdir=/usr/share/doc/mpc-1.2.1"],
                            buildDirectoryPath)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
        makeSource([Ism.settings.makeOptions,"html"],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install-html"],buildDirectoryPath)
    end

end
