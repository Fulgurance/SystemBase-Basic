class Target < ISM::Software

    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--sysconfdir=/etc",
                            "--enable-utf8",
                            "--docdir=/usr/share/doc/nano-5.8"],
                            buildDirectoryPath)
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        copyFile("#{buildDirectoryPath(false)}doc/nano.html","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/doc/nano-5.8")
        copyFile("#{buildDirectoryPath(false)}doc/sample.nanorc","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/doc/nano-5.8")
    end

    def install
        super
        setPermissions("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/doc/nano-5.8/nano.html",0o644)
        setPermissions("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/doc/nano-5.8/sample.nanorc",0o644)
    end

end
