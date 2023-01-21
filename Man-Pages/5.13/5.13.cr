class Target < ISM::Software
    
    def prepareInstallation
        super
        @useChroot=true
        makeSource([Ism.settings.makeOptions,"prefix=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr","install"],buildDirectoryPath)
        @useChroot=false
    end

end
