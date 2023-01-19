class Target < ISM::Software
    
    def configure
        super
        configureSource([   "--prefix=#{Ism.settings.rootPath}/usr"],
                            buildDirectoryPath)
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
        makeSource([Ism.settings.makeOptions,"html"],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}","install"],buildDirectoryPath)
        makeDirectory("#{builtSoftwareDirectoryPath}/usr/share/doc/sed-4.8")
        copyFile("#{buildDirectoryPath}/doc/sed.html","#{builtSoftwareDirectoryPath}/usr/share/doc/sed-4.8/sed.html")
    end

end
