class Target < ISM::Software
    
    def configure
        super
        configureSource([   "FORCE_UNSAFE_CONFIGURE=1",
                            "--prefix=#{Ism.settings.rootPath}/usr"],
                            buildDirectoryPath)
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}","install"],buildDirectoryPath)
        makeSource([Ism.settings.makeOptions,"-C","doc","DESTDIR=#{builtSoftwareDirectoryPath}","install-html","docdir=#{Ism.settings.rootPath}/usr/share/doc/tar-1.34"],buildDirectoryPath)
    end

end