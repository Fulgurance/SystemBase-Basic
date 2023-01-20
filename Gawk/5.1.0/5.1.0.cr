class Target < ISM::Software
    
    def prepare
        super
        fileReplaceText("#{buildDirectoryPath}/Makefile.in","extras","")
    end

    def configure
        super
        configureSource([   "--prefix=#{Ism.settings.rootPath}/usr"],
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