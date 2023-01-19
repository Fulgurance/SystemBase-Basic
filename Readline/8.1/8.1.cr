class Target < ISM::Software

    def prepare
        super
        fileReplaceText("#{buildDirectoryPath}/Makefile.in","-$(MV)","")
        fileReplaceLineContaining("#{buildDirectoryPath}/support/shlib-install","{OLDSUFF}",":")
    end

    def configure
        super
        configureSource([   "--prefix=#{Ism.settings.rootPath}/usr",
                            "--disable-static",
                            "--with-curses",
                            "--docdir=#{Ism.settings.rootPath}/usr/share/doc/readline-8.1"],
                            buildDirectoryPath)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions,"SHLIB_LIBS=\"-lncursesw\""],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"SHLIB_LIBS=\"-lncursesw\"","DESTDIR=#{builtSoftwareDirectoryPath}","install"],buildDirectoryPath)
    end

end