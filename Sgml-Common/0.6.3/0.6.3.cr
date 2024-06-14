class Target < ISM::Software

    def prepare
        super

        runAutoreconfCommand(   arguments:  "-f -i",
                                path:       buildDirectoryPath)
    end
    
    def configure
        super

        configureSource(arguments:  "--prefix=/usr  \
                                    --sysconfdir=/etc",
                        path:       buildDirectoryPath)
    end
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource( arguments:  "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} docdir=/usr/share/doc install",
                    path:       buildDirectoryPath)
    end

    def install
        super

        if File.exists?("#{Ism.settings.rootPath}etc/sgml/catalog")
            runInstallCatalogCommand(arguments: "--remove   \
                                                /etc/sgml/sgml-ent.cat  \
                                                /usr/share/sgml/sgml-iso-entities-8879.1986/catalog")

            runInstallCatalogCommand(arguments: "--remove                   \
                                                /etc/sgml/sgml-docbook.cat  \
                                                /etc/sgml/sgml-ent.cat")
        end

        runInstallCatalogCommand(arguments: "--add                  \
                                            /etc/sgml/sgml-ent.cat  \
                                            /usr/share/sgml/sgml-iso-entities-8879.1986/catalog")

        runInstallCatalogCommand(arguments: "--add                      \
                                            /etc/sgml/sgml-docbook.cat  \
                                            /etc/sgml/sgml-ent.cat")
    end

end
