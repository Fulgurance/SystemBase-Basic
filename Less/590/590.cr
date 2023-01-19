class Target < ISM::Software

    def configure
        super
        configureSource([   "--prefix=#{Ism.settings.rootPath}/usr",
                            "--sysconfdir=#{Ism.settings.rootPath}/etc"],
                            buildDirectoryPath)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}","install"],buildDirectoryPath)
    end

end
