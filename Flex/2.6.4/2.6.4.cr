class Target < ISM::Software

    def configure
        super
        configureSource([   "--prefix=#{Ism.settings.rootPath}/usr",
                            "--docdir=#{Ism.settings.rootPath}/usr/share/doc/flex-2.6.4",
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
    end

    def install
        super
        makeLink("flex","#{Ism.settings.rootPath}/usr/bin/lex",:symbolicLink)
    end

end
