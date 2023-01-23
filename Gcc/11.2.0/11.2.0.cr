class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
        fileDeleteLine("#{mainWorkDirectoryPath(false)}/libsanitizer/sanitizer_common/sanitizer_posix_libcdep.cpp",170)
        fileReplaceTextAtLineNumber("#{mainWorkDirectoryPath(false)}/libsanitizer/sanitizer_common/sanitizer_posix_libcdep.cpp","return kAltStackSize;","return SIGSTKSZ * 4;",170)
        fileReplaceText(mainWorkDirectoryPath(false) +
                        "/gcc/config/i386/t-linux64",
                        "m64=../lib64",
                        "m64=../lib")
    end
    
    def configure
        super
        configureSource([   "--prefix=/usr",
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
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
        makeDirectory("#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/share/gdb/auto-load/usr/lib")
        copyFile("#{Ism.settings.rootPath}/usr/lib/*gdb.py","#{builtSoftwareDirectoryPath(false)}/#{Ism.settings.rootPath}/usr/share/gdb/auto-load/usr/lib")
    end

    def install
        super
        makeLink("/usr/bin/cpp","#{Ism.settings.rootPath}/usr/lib",:symbolicLink)
        makeLink("../../libexec/gcc/$(gcc -dumpmachine)/11.2.0/liblto_plugin.so","#{Ism.settings.rootPath}/usr/lib/bfd-plugins/",:symbolicLinkByOverwrite)
    end

    def clean
        super
        deleteDirectoryRecursively("#{Ism.settings.rootPath}/usr/lib/gcc/$(gcc -dumpmachine)/11.2.0/include-fixed/bits/")
        deleteFile(Dir["#{Ism.settings.rootPath}/usr/lib/*gdb.py"])
    end

end
