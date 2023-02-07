class Target < ISM::Software
    
    def prepareInstallation
        super
        makeDirectory("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/etc")
        moveFile("#{mainWorkDirectoryPath(false)}/services", "#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/etc/services")
        moveFile("#{mainWorkDirectoryPath(false)}/protocols", "#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/etc/protocols")
    end

end
