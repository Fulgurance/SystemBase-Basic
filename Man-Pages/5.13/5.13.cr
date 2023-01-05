class Target < ISM::Software
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"prefix=#{builtSoftwareDirectoryPath}/usr","install"],buildDirectoryPath)
    end

end
