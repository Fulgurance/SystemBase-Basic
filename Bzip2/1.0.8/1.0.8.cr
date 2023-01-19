class Target < ISM::Software

    def prepare
        super
        fileReplaceText("#{buildDirectoryPath}/Makefile","ln -s -f $(PREFIX)/bin/","ln -s -f ")
        fileReplaceText("#{buildDirectoryPath}/Makefile","$(PREFIX)/man","$(PREFIX)/share/man")
        makeSource([Ism.settings.makeOptions,"-f","Makefile-libbz2_so"],buildDirectoryPath)
        makeSource([Ism.settings.makeOptions,"clean"],buildDirectoryPath)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"PREFIX=/usr","DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        copyFile("#{buildDirectoryPath}/libbz2.so.*","#{builtSoftwareDirectoryPath}/usr/lib")
        copyFile("#{buildDirectoryPath}/bzip2-shared","#{builtSoftwareDirectoryPath}/usr/bin/bzip2")
    end

    def install
        super
        makeLink("libbz2.so.1.0.8","#{Ism.settings.rootPath}/usr/lib/libbz2.so",:symbolicLink)
        makeLink("bzip2","#{Ism.settings.rootPath}/usr/bin/bzcat",:symbolicLinkByOverwrite)
        makeLink("bzip2","#{Ism.settings.rootPath}/usr/bin/bunzip2",:symbolicLinkByOverwrite)
    end

    def clean
        super
        removeFile("#{Ism.settings.rootPath}/usr/lib/libbz2.a")
    end

end
