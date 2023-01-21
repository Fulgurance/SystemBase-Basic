class Target < ISM::Software
    
    def configure
        super
        @useChroot=true
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
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}","install"],buildDirectoryPath)
        @useChroot=false
    end

end
