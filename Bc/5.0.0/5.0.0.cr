class Target < ISM::Software

    def configure
        super
        @useChroot=true
        configureSource([   "CC=gcc",
                            "--prefix=/usr",
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
        @useChroot=false
    end

end
