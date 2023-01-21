class Target < ISM::Software

    def configure
        super
        @useChroot=true
        configureSource([   "--prefix=/usr",
                            "--docdir=/usr/share/doc/flex-2.6.4",
                            "--disable-static"],
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

    def install
        super
        makeLink("flex","#{Ism.settings.rootPath}/usr/bin/lex",:symbolicLink)
    end

end
