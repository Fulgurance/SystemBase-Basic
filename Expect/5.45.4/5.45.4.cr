class Target < ISM::Software

    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--with-tcl=/usr/lib",
                            "--enable-shared",
                            "--mandir=/usr/share/man",
                            "--with-tclinclude=/usr/include"],
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

    def install
        super
        makeLink("expect5.45.4/libexpect5.45.4.so","#{Ism.settings.rootPath}/usr/lib",:symbolicLinkByOverwrite)
    end

end
