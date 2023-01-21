class Target < ISM::Software
    
    def configure
        super
        @useChroot=true
        configureSource([   "FORCE_UNSAFE_CONFIGURE=1",
                            "--prefix=/usr"],
                            buildDirectoryPath)
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        makeSource([Ism.settings.makeOptions,"-C","doc","DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install-html","docdir=#{Ism.settings.rootPath}/usr/share/doc/tar-1.34"],buildDirectoryPath)
        @useChroot=false
    end

end
