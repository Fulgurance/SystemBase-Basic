class Target < ISM::Software
    
    def configure
        super
        configureSource([   "--prefix=#{Ism.settings.rootPath}/usr",
                            "--docdir=#{Ism.settings.rootPath}/usr/share/doc/bison-3.7.6"],
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
