class Target < ISM::Software
    
    def configure
        super
        configureSource([   "--prefix=/usr"],
                            buildDirectoryPath,
                            "",
                            {"FORCE_UNSAFE_CONFIGURE" => "1"})
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        makeSource([Ism.settings.makeOptions,"-C","doc","DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install-html","docdir=/usr/share/doc/tar-1.34"],buildDirectoryPath)
    end

end
