class Target < ISM::Software

    def configure
        super
        configureSource([   "--prefix=#{Ism.settings.rootPath}/usr",
                            "--sysconfdir=#{Ism.settings.rootPath}/etc",
                            "--enable-utf8",
                            "--docdir=#{Ism.settings.rootPath}/usr/share/doc/nano-5.8"],
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
