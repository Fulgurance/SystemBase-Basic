class Target < ISM::Software
    
    def configure
        super
        configureSource([   "--prefix=#{Ism.settings.rootPath}/usr",
                            "--disable-static"],
                            buildDirectoryPath)
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"docdir=#{Ism.settings.rootPath}/usr/share/doc/check-0.15.2","DESTDIR=#{builtSoftwareDirectoryPath}","install"],buildDirectoryPath)
    end

end