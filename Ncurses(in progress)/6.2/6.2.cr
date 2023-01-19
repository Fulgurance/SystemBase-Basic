class Target < ISM::Software
    
    def configure
        super
        configureSource([   "--prefix=#{Ism.settings.rootPath}/usr",
                            "--mandir=#{Ism.settings.rootPath}/usr/share/man",
                            "--with-shared",
                            "--without-debug",
                            "--without-normal",
                            "--enable-pc-files",
                            "--enable-widec"],
                            buildDirectoryPath)
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}","install"],buildDirectoryPath)
        #fileAppendData("#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/lib/libncurses.so","INPUT(-lncursesw)")
    end

end
