class Target < ISM::Software
    
    def prepareInstallation
        super
        copyDirectory("#{mainWorkDirectoryPath}/services", "#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/etc/")
        copyDirectory("#{mainWorkDirectoryPath}/protocols", "#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/etc/")
    end

end
