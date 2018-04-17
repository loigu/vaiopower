XSLT := xsltproc --param man.charmap.use.subset "0" \
	--param make.year.ranges "1" \
	--param make.single.year.ranges "1"
STYLESHEET := /usr/share/xml/docbook/stylesheet/nwalsh/manpages/docbook.xsl
XMLLINT    := xmllint --valid --noout
MANPAGES   := vaiopower.8 vaiopower.conf.5

all: $(MANPAGES)
vaiopower.8: src/vaiopower.xml
	$(XSLT) $(STYLESHEET) $<
vaiopower.conf.5: src/vaiopower.conf.xml
	$(XSLT) $(STYLESHEET) $<
clean:
	rm $(MANPAGES)
valid:
	$(XMLLINT) src/*.xml
.PHONY: all clean valid
