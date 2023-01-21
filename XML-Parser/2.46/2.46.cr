class Target < ISM::Software
    
    def prepare
        super
        @useChroot=true
        makePerlSource(buildDirectoryPath)
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"install"],buildDirectoryPath)
        @useChroot=false
    end

end
