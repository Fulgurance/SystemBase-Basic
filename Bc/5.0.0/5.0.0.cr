class Target < ISM::Software

    def configure
        super
        configureSource([   "CC=gcc",
                            "--prefix=#{Ism.settings.rootPath}/usr",
                            "-G",
                            "-O3"],
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