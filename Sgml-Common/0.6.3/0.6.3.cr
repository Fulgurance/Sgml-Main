class Target < ISM::Software

    def prepare
        super

        runAutoreconfCommand(["-f","-i"],buildDirectoryPath)
    end
    
    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--sysconfdir=/etc"],
                            buildDirectoryPath)
    end
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","docdir=/usr/share/doc","install"],buildDirectoryPath)
    end

    def install
        super

        if File.exists?("#{Ism.settings.rootPath}etc/sgml/catalog")
            runInstallCatalogCommand([  "--remove",
                                        "/etc/sgml/sgml-ent.cat",
                                        "/usr/share/sgml/sgml-iso-entities-8879.1986/catalog"])
            runInstallCatalogCommand([  "--remove",
                                        "/etc/sgml/sgml-docbook.cat",
                                        "/etc/sgml/sgml-ent.cat"])
        end

        runInstallCatalogCommand([  "--add",
                                    "/etc/sgml/sgml-ent.cat",
                                    "/usr/share/sgml/sgml-iso-entities-8879.1986/catalog"])
        runInstallCatalogCommand([  "--add",
                                    "/etc/sgml/sgml-docbook.cat",
                                    "/etc/sgml/sgml-ent.cat"])
    end

end
