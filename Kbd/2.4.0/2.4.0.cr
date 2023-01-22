class Target < ISM::Software

    def prepare
        super
        fileReplaceText("#{buildDirectoryPath(false)}/configure","RESIZECONS_PROGS=yes","RESIZECONS_PROGS=no")
        fileReplaceText("#{buildDirectoryPath(false)}/docs/man/man8/Makefile.in","resizecons.8 ","")
    end

    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--disable-vlock"],
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

end
