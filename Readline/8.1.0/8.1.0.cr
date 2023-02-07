class Target < ISM::Software

    def prepare
        super
        fileReplaceText("#{buildDirectoryPath(false)}/Makefile.in","-$(MV)","")
        fileReplaceLineContaining("#{buildDirectoryPath(false)}/support/shlib-install","{OLDSUFF}",":")
    end

    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--disable-static",
                            "--with-curses",
                            "--docdir=/usr/share/doc/readline-8.1"],
                            buildDirectoryPath)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions,"SHLIB_LIBS=\"-lncursesw\""],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"SHLIB_LIBS=\"-lncursesw\"","DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

end
