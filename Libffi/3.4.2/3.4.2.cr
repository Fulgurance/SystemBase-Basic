class Target < ISM::Software

    def configure
        super
        @useChroot=true
        configureSource([   "--prefix=/usr",
                            "--disable-static",
                            "--with-gcc-arch=native",
                            "--disable-exec-static-tramp"],
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
