class Target < ISM::Software
    
    def prepare
        super
        makePerlSource(buildDirectoryPath)
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"install"],buildDirectoryPath)
    end

end
