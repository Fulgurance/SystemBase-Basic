class Target < ISM::Software
    
    def configure
        super
        runScript("config",["--prefix=/usr",
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
        fileReplaceText("#{buildDirectoryPath(false)}/Makefile","INSTALL_LIBS=libcrypto.a libssl.a","INSTALL_LIBS=")
        makeSource([Ism.settings.makeOptions,"MANSUFFIX=ssl","DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        moveFile("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/share/doc/openssl","#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/share/doc/openssl-1.1.1l")
    end

end
