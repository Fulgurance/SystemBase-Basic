class Target < ISM::Software
    
    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--enable-shared",
                            "--with-system-expat",
                            "--with-system-ffi",
                            "--with-ensurepip=yes",
                            "--enable-optimizations"],
                            buildDirectoryPath)
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

end
