class Target < ISM::Software

    def prepare
        super
        fileReplaceText("#{buildDirectoryPath}/gnulib/lib/malloc/dynarray-skeleton.c","__attribute_nonnull__","__nonnull")
    end
    
    def configure
        super
        @useChroot=true
        configureSource([   "--prefix=#{Ism.settings.rootPath}/usr"],
                            buildDirectoryPath)
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}","install"],buildDirectoryPath)
        @useChroot=false
    end

end
