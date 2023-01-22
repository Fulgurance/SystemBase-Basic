class Target < ISM::Software
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"prefix=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr","install"],buildDirectoryPath)
    end

end
