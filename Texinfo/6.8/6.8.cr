class Target < ISM::Software

    def prepare
        super
        fileReplaceText("#{buildDirectoryPath(false)}/gnulib/lib/malloc/dynarray-skeleton.c","__attribute_nonnull__","__nonnull")
    end
    
    def configure
        super
        configureSource([   "--prefix=/usr"],
                            buildDirectoryPath)
    end
    
    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}/#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

end
