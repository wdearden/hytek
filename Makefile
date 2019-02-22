PACKAGE = hytek

package: check

docs:
	# Regenerate documentation with roxygen
	@Rscript -e "devtools::document(pkg = 'R/$(PACKAGE)')"

install: docs
	# Install gguptake R package
	@Rscript -e "devtools::install('R/$(PACKAGE)', repos = 'cran.rstudio.com')"

test: install
	@Rscript -e "devtools::test('R/$(PACKAGE)')"

build: docs
	R CMD build R/$(PACKAGE)

check: build
	VERSION=$$(cat R/$(PACKAGE)/DESCRIPTION | grep ^Version | awk '{print $$2}') && \
	PKG_TAR=R/$(PACKAGE)_$$VERSION.tar.gz && \
	R CMD check $$PKG_TAR && \
	rm $$PKG_TAR && \
	rm -rf $(PACKAGE).Rcheck

pkgdown: install
	Rscript -e "pkgdown::build_site('R/$(PACKAGE)', preview = TRUE)"