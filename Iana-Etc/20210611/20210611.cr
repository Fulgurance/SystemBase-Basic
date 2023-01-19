class Target < ISM::Software
    
    def prepareInstallation
        super
        makeDirectory("#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/etc")
        moveFile("#{mainWorkDirectoryPath}/services", "#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/etc/services")
        moveFile("#{mainWorkDirectoryPath}/protocols", "#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/etc/protocols")
    end

end
