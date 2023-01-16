class Target < ISM::Software

    def configure
        super
        configureSource([   "--prefix=#{Ism.settings.rootPath}/usr",
                            "--with-tcl=#{Ism.settings.rootPath}/usr/lib",
                            "--enable-shared",
                            "--mandir=#{Ism.settings.rootPath}/usr/share/man",
                            "--with-tclinclude=#{Ism.settings.rootPath}/usr/include"],
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
        makeLink("expect5.45.4/libexpect5.45.4.so","#{Ism.settings.rootPath}/usr/lib",:symbolicLinkByOverwrite)
    end

end
