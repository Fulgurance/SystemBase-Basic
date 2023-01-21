class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super
        @useChroot=true
        configureSource([   "--prefix=/usr"],
                            buildDirectoryPath)
    end

    def prepareInstallation
        super
        @useChroot=false
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
        @useChroot=true
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}","install"],buildDirectoryPath)
        @useChroot=false
        makeDirectory("#{Ism.settings.rootPath}/usr/share/doc/dejagnu-1.6.3")
        moveFile("#{buildDirectoryPath}/doc/dejagnu.html","#{Ism.settings.rootPath}/usr/share/doc/dejagnu-1.6.3/dejagnu.html")
        moveFile("#{buildDirectoryPath}/doc/dejagnu.txt","#{Ism.settings.rootPath}/usr/share/doc/dejagnu-1.6.3/dejagnu.txt")
    end

end
