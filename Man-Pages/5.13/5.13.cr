class Target < ISM::Software
    
    def prepareInstallation
        super
        @useChroot=true
        makeSource([Ism.settings.makeOptions,"prefix=#{builtSoftwareDirectoryPath}/usr","install"],buildDirectoryPath)
        @useChroot=false
    end

end
