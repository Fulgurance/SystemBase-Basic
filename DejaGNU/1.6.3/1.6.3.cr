class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super
        configureSource([   "--prefix=/usr"],
                            buildDirectoryPath)
    end

    def prepareInstallation
        super
        fileMakeinfo([  "--html",
                        "--no-split",
                        "-o",
                        "doc/dejagnu.html",
                        "../doc/dejagnu.texi"],
                        buildDirectoryPath)
        fileMakeinfo([  "--plaintext",
                        "-o",
                        "doc/dejagnu.txt",
                        "../doc/dejagnu.texi"],
                        buildDirectoryPath)
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        makeDirectory("#{Ism.settings.rootPath}/usr/share/doc/dejagnu-1.6.3")
        moveFile("#{buildDirectoryPath}/doc/dejagnu.html","#{Ism.settings.rootPath}/usr/share/doc/dejagnu-1.6.3/dejagnu.html")
        moveFile("#{buildDirectoryPath}/doc/dejagnu.txt","#{Ism.settings.rootPath}/usr/share/doc/dejagnu-1.6.3/dejagnu.txt")
    end

end
