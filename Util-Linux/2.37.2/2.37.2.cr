class Target < ISM::Software

    def configure
        super
        configureSource([   "ADJTIME_PATH=#{Ism.settings.rootPath}/var/lib/hwclock/adjtime",
                            "--libdir=/usr/lib",
                            "--docdir=/usr/share/doc/util-linux-2.37.2",
                            "--disable-chfn-chsh",
                            "--disable-login",
                            "--disable-nologin",
                            "--disable-su",
                            "--disable-setpriv",
                            "--disable-runuser",
                            "--disable-pylibmount",
                            "--disable-static",
                            "--without-python",
                            "--without-systemd",
                            "--without-systemdsystemunitdir",
                            "runstatedir=#{Ism.settings.rootPath}/run"],
                            buildDirectoryPath)
    end

    def build
        super
        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end

    def prepareInstallation
        super
        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}","install"],buildDirectoryPath)
    end

end
