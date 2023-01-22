class Target < ISM::Software

    def configure
        super
        configureSource([   "--prefix=/usr",
                            "--mandir=/usr/share/man",
                            "--enable-64bit"],
                            "#{buildDirectoryPath}/unix")
    end

    def build
        super
        makeSource([Ism.settings.makeOptions],"#{buildDirectoryPath}/unix")
    end

    def prepareInstallation
        super
        fileReplaceText("#{buildDirectoryPath}/unix/tclConfig.sh","#{buildDirectoryPath}/unix","/usr/lib")
        fileReplaceText("#{buildDirectoryPath}/unix/tclConfig.sh","#{buildDirectoryPath}","/usr/include")
        fileReplaceText("#{buildDirectoryPath}/unix/pkgs/tdbc1.1.2/tdbcConfig.sh","#{buildDirectoryPath}/unix/pkgs/tdbc1.1.2","/usr/lib/tdbc1.1.2")
        fileReplaceText("#{buildDirectoryPath}/unix/pkgs/tdbc1.1.2/tdbcConfig.sh","#{buildDirectoryPath}/pkgs/tdbc1.1.2/generic","/usr/include")
        fileReplaceText("#{buildDirectoryPath}/unix/pkgs/tdbc1.1.2/tdbcConfig.sh","#{buildDirectoryPath}/pkgs/tdbc1.1.2/library","/usr/lib/tcl8.6")
        fileReplaceText("#{buildDirectoryPath}/unix/pkgs/tdbc1.1.2/tdbcConfig.sh","#{buildDirectoryPath}/pkgs/tdbc1.1.2","/usr/include")
        fileReplaceText("#{buildDirectoryPath}/unix/pkgs/itcl4.2.1/itclConfig.sh","#{buildDirectoryPath}/unix/pkgs/itcl4.2.1","/usr/lib/itcl4.2.1")
        fileReplaceText("#{buildDirectoryPath}/unix/pkgs/itcl4.2.1/itclConfig.sh","#{buildDirectoryPath}/pkgs/itcl4.2.1/generic","/usr/include")
        fileReplaceText("#{buildDirectoryPath}/unix/pkgs/itcl4.2.1/itclConfig.sh","#{buildDirectoryPath}/pkgs/itcl4.2.1","/usr/include")
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],"#{buildDirectoryPath}/unix")
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install-private-headers"],"#{buildDirectoryPath}/unix")
        moveFile("#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/share/man/man3/Thread.3","#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}/usr/share/man/man3/Tcl_Thread.3")
    end

    def install
        super
        makeLink("tclsh8.6","#{Ism.settings.rootPath}/usr/bin/tclsh",:symbolicLinkByOverwrite)
    end

end
