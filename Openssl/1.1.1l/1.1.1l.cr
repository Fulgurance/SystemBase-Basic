class Target < ISM::Software
    
    def configure
        super
        @useChroot=true
        configureSource([   "--prefix=/usr",
                            "--openssldir=/etc/ssl",
                            "--libdir=lib",
                            "shared",
                            "zlib-dynamic"],
                            buildDirectoryPath)
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        @useChroot=false
        fileReplaceText("INSTALL_LIBS=libcrypto.a libssl.a","INSTALL_LIBS=")
        @useChroot=true
        makeSource([Ism.settings.makeOptions,"MANSUFFIX=ssl","DESTDIR=#{builtSoftwareDirectoryPath}","install"],buildDirectoryPath)
        @useChroot=false
        copyDirectory("#{Ism.settings.rootPath}/usr/share/doc/openssl","#{builtSoftwareDirectoryPath}/usr/share/doc/openssl-1.1.1l")
    end

    def clean
        super
        deleteDirectoryRecursively("#{Ism.settings.rootPath}/usr/share/doc/openssl")
    end

end
