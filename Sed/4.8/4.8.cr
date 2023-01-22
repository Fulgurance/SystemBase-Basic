class Target < ISM::Software
    
    def configure
        super
        configureSource([   "--prefix=/usr"],
                            buildDirectoryPath)
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
        makeSource([Ism.settings.makeOptions,"html"],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        makeDirectory("#{builtSoftwareDirectoryPath(false)}/usr/share/doc/sed-4.8")
        copyFile("#{buildDirectoryPath(false)}/doc/sed.html","#{builtSoftwareDirectoryPath(false)}/usr/share/doc/sed-4.8/sed.html")
    end

end
