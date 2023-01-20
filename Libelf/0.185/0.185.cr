class Target < ISM::Software

    def configure
        super
        configureSource([   "--prefix=#{Ism.settings.rootPath}/usr",
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
        makeSource([Ism.settings.makeOptions,"-C","libelf","DESTDIR=#{builtSoftwareDirectoryPath}","install"],buildDirectoryPath)
        copyFile("#{buildDirectoryPath}/config/libelf.pc","#{builtSoftwareDirectoryPath}/usr/lib/pkgconfig")
    end

    def clean
        super
        deleteFile("/usr/lib/libelf.a")
    end

end