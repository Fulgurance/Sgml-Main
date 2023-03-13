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

        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","docdir=/usr/share/doc","install"],buildDirectoryPath)
    end

    def install
        super

        runInstallCatalogCommand([  "--remove",
                                    "/etc/sgml/sgml-ent.cat",
                                    "/usr/share/sgml/sgml-iso-entities-8879.1986/catalog"])
        runInstallCatalogCommand([  "--remove",
                                    "/etc/sgml/sgml-docbook.cat",
                                    "/etc/sgml/sgml-ent.cat"])
        runInstallCatalogCommand([  "--add",
                                    "/etc/sgml/sgml-ent.cat",
                                    "/usr/share/sgml/sgml-iso-entities-8879.1986/catalog"])
        runInstallCatalogCommand([  "--add",
                                    "/etc/sgml/sgml-docbook.cat",
                                    "/etc/sgml/sgml-ent.cat"])
    end

end
