class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
        fileDeleteLine("#{mainWorkDirectoryPath}",170)
        fileReplaceTextAtLineNumber("#{mainWorkDirectoryPath}","return kAltStackSize;","return SIGSTKSZ * 4;",170)
        fileReplaceText(mainWorkDirectoryPath +
                        "/gcc/config/i386/t-linux64",
                        "m64=../lib64",
                        "m64=../lib")
    end
    
    def configure
        super
        configureSource([   "--prefix=#{Ism.settings.rootPath}/usr",
                            "LD=ld",
                            "--enable-languages=c,c++",
                            "--disable-multilib",
                            "--disable-bootstrap",
                            "--with-system-zlib"],
                            buildDirectoryPath)
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}","install"],buildDirectoryPath)
        makeDirectory("#{builtSoftwareDirectoryPath}/usr/share/gdb/auto-load/usr/lib")
        copyFile("#{Ism.settings.rootPath}/usr/lib/*gdb.py","#{builtSoftwareDirectoryPath}/usr/share/gdb/auto-load/usr/lib")
    end

    def install
        super
        makeLink("/usr/bin/cpp","#{Ism.settings.rootPath}/usr/lib",:symbolicLink)
        makeLink("../../libexec/gcc/$(gcc -dumpmachine)/11.2.0/liblto_plugin.so","#{Ism.settings.rootPath}/usr/lib/bfd-plugins/",:symbolicLinkByOverwrite)
    end

    def clean
        super
        deleteDirectoryRecursively("#{Ism.settings.rootPath}/usr/lib/gcc/$(gcc -dumpmachine)/11.2.0/include-fixed/bits/")
        deleteFile("#{Ism.settings.rootPath}/usr/lib/*gdb.py")
    end

end
