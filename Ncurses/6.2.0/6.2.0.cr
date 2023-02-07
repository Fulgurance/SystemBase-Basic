class Target < ISM::Software
    
    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--mandir=/usr/share/man",
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
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        fileAppendData("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/lib/libncurses.so","INPUT(-lncursesw)")
        fileAppendData("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/lib/libform.so","INPUT(-lformw)")
        fileAppendData("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/lib/libpanel.so","INPUT(-lpanelw)")
        fileAppendData("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/lib/libmenu.so","INPUT(-lmenuw)")
        fileAppendData("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/lib/libcursesw.so","INPUT(-lncursesw)")
    end

    def install
        super
        makeLink("ncursesw.pc","#{Ism.settings.rootPath}/usr/lib/pkgconfig/ncurses.pc",:symbolicLinkByOverwrite)
        makeLink("formw.pc","#{Ism.settings.rootPath}/usr/lib/pkgconfig/form.pc",:symbolicLinkByOverwrite)
        makeLink("panelw.pc","#{Ism.settings.rootPath}/usr/lib/pkgconfig/panel.pc",:symbolicLinkByOverwrite)
        makeLink("menuw.pc","#{Ism.settings.rootPath}/usr/lib/pkgconfig/menu.pc",:symbolicLinkByOverwrite)
        makeLink("libncurses.so","#{Ism.settings.rootPath}/usr/lib/libcurses.so",:symbolicLinkByOverwrite)
    end

    def clean
        super
        deleteFile("#{Ism.settings.rootPath}/usr/lib/libncurses++w.a")
    end

end
