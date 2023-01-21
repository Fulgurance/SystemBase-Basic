class Target < ISM::Software

    def prepare
        super
        fileReplaceText("#{buildDirectoryPath}/Makefile","ln -s -f $(PREFIX)/bin/","ln -s -f ")
        fileReplaceText("#{buildDirectoryPath}/Makefile","$(PREFIX)/man","$(PREFIX)/share/man")
        @useChroot=true
        makeSource([Ism.settings.makeOptions,"-f","Makefile-libbz2_so"],buildDirectoryPath)
        makeSource([Ism.settings.makeOptions,"clean"],buildDirectoryPath)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"PREFIX=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr","install"],buildDirectoryPath)
        @useChroot=false
        copyFile(Dir["#{buildDirectoryPath}/libbz2.so.*"],"#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/lib")
        copyFile("#{buildDirectoryPath}/bzip2-shared","#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/bin/bzip2")
    end

    def install
        super
        makeLink("libbz2.so.1.0.8","#{Ism.settings.rootPath}/usr/lib/libbz2.so",:symbolicLink)
        makeLink("bzip2","#{Ism.settings.rootPath}/usr/bin/bzcat",:symbolicLinkByOverwrite)
        makeLink("bzip2","#{Ism.settings.rootPath}/usr/bin/bunzip2",:symbolicLinkByOverwrite)
    end

    def clean
        super
        deleteFile("#{Ism.settings.rootPath}/usr/lib/libbz2.a")
    end

end
