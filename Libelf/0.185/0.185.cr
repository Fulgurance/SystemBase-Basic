class Target < ISM::Software

    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--disable-debuginfod",
                            "--enable-libdebuginfod=dummy"],
                            buildDirectoryPath)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"-C","libelf","DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        makeDirectory("#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/lib/")
        copyFile("#{buildDirectoryPath(false)}/config/libelf.pc","#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/lib/pkgconfig")
    end

    def clean
        super
        deleteFile("#{Ism.settings.rootPath}/usr/lib/libelf.a")
    end

end
