class Target < ISM::Software
    
    def configure
        super
        configureSource([   "--prefix=/usr"],
                            buildDirectoryPath,
                            "",
                            {"PAGE" => "A4"})
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
