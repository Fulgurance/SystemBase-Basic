class Target < ISM::Software
    
    def configure
        super
        runScript("Configure",buildDirectoryPath,
                    [   "BUILD_ZLIB=False",
                        "BUILD_BZIP2=0",
                        "-des",
                        "-Dprefix=#{Ism.settings.rootPath}/usr",
                        "-Dvendorprefix=#{Ism.settings.rootPath}/usr",
                        "-Dprivlib=#{Ism.settings.rootPath}/usr/lib/perl5/5.34/core_perl",
                        "-Darchlib=#{Ism.settings.rootPath}/usr/lib/perl5/5.34/core_perl",
                        "-Dsitelib=#{Ism.settings.rootPath}/usr/lib/perl5/5.34/site_perl",
                        "-Dsitearch=#{Ism.settings.rootPath}/usr/lib/perl5/5.34/site_perl",
                        "-Dvendorlib=#{Ism.settings.rootPath}/usr/lib/perl5/5.34/vendor_perl",
                        "-Dvendorarch=#{Ism.settings.rootPath}/usr/lib/perl5/5.34/vendor_perl",
                        "-Dman1dir=#{Ism.settings.rootPath}/usr/share/man/man1",
                        "-Dman3dir=#{Ism.settings.rootPath}/usr/share/man/man3",
                        "-Dpager=\"#{Ism.settings.rootPath}/usr/bin/less -isR\"",
                        "-Duseshrplib",
                        "-Dusethreads"])
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions,"BUILD_ZLIB=False","BUILD_BZIP2=0"],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"BUILD_ZLIB=False","BUILD_BZIP2=0","DESTDIR=#{builtSoftwareDirectoryPath}","install"],buildDirectoryPath)
    end

end
