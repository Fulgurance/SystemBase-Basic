class Target < ISM::Software
    
    def configure
        super
        @useChroot=true
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
        @useChroot=false
        makeDirectory("#{builtSoftwareDirectoryPath}/usr/share/doc/sed-4.8")
        copyFile("#{buildDirectoryPath}/doc/sed.html","#{builtSoftwareDirectoryPath}/usr/share/doc/sed-4.8/sed.html")
    end

end
