EXECUTABLE = swift-syntax-highlight
ARCHIVE = $(EXECUTABLE).tar.gz
PREFIX ?= /usr/local/bin
SOURCES = $(wildcard Sources/**/*.swift)
BUILD_PATH ?= ./.build

$(EXECUTABLE): $(BUILD_PATH)/release/$(EXECUTABLE)
	@mv $(BUILD_PATH)/release/$(EXECUTABLE) $(EXECUTABLE)

$(BUILD_PATH)/release/$(EXECUTABLE): $(SOURCES)
	swift build -c release --build-path $(BUILD_PATH)

.PHONY: install
install: $(EXECUTABLE)
	install $(EXECUTABLE) "$(PREFIX)"

.PHONY: archive
archive: $(EXECUTABLE)
	tar --create --preserve-permissions --gzip --file $(ARCHIVE) $(EXECUTABLE)
	@shasum -a 256 $(EXECUTABLE)
	@shasum -a 256 $(ARCHIVE)

.PHONY: clean
clean:
	rm -rf $(EXECUTABLE) $(ARCHIVE)

.PHONY: uninstall
uninstall:
	rm "$(PREFIX)/$(EXECUTABLE)"
