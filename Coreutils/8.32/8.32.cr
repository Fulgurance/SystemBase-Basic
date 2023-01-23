class Target < ISM::Software
    
    def configure
        super
        runAutoreconfCommand(["-fiv"],buildDirectoryPath)
        configureSource([   "--prefix=/usr",
                            "--enable-no-install-program=kill,uptime"],
                            buildDirectoryPath,
                            {"FORCE_UNSAFE_CONFIGURE" => "1"})
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        makeDirectory("#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/sbin")
        moveFile("#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/bin/chroot","#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/sbin")
        makeDirectory("#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/share/man/man8/")
        moveFile("#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/share/man/man1/chroot.1","#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/share/man/man8/chroot.8")
        fileReplaceText("#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/share/man/man8/chroot.8","\"1\"","\"8\"")
    end

end
