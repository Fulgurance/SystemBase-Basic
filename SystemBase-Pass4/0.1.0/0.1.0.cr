class Target < ISM::Software

    def download
    end

    def check
    end

    def extract
    end

    def patch
    end

    def prepare
    end
    
    def configure
    end
    
    def build
    end
    
    def prepareInstallation
        super
    end

    def install
    end

    def clean
    end

end
