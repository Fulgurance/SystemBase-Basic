class Target < ISM::Software
    
    def configure
        super
        configureSource([   "--prefix=#{Ism.settings.rootPath}/usr",
                            "--disable-static",
                            "--docdir=#{Ism.settings.rootPath}/usr/share/doc/gettext-0.21"],
                            buildDirectoryPath)
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}","install"],buildDirectoryPath)
    end

end
