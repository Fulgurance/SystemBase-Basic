class Target < ISM::Software
    
    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--disable-static",
                            "--docdir=/usr/share/doc/gettext-0.21"],
                            buildDirectoryPath)
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        setPermissions("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/lib/preloadable_libintl.so",0o755)
    end

end
