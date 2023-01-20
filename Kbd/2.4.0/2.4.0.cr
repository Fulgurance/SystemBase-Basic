class Target < ISM::Software

    def prepare
        super
        fileReplaceText("#{buildDirectoryPath}/configure","RESIZECONS_PROGS=yes","RESIZECONS_PROGS=no")
        fileReplaceText("#{buildDirectoryPath}/docs/man/man8/Makefile.in","resizecons.8 ","")
    end

    def configure
        super
        configureSource([   "--prefix=#{Ism.settings.rootPath}/usr",
                            "--disable-vlock"],
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
