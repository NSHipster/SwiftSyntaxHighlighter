EXECUTABLE = swift-syntax-highlight
ARCHIVE = $(EXECUTABLE).tar.gz
PREFIX ?= /usr/local/bin
SOURCES = $(wildcard Sources/**/*.swift)
BUILD_PATH ?= ./.build

.PHONY: build
build: $(EXECUTABLE)

$(EXECUTABLE): $(BUILD_PATH)/release/$(EXECUTABLE)
	@cp $(BUILD_PATH)/release/$(EXECUTABLE) $(EXECUTABLE)

$(BUILD_PATH)/release/$(EXECUTABLE): $(SOURCES)
	swift build -c release --build-path $(BUILD_PATH)

.PHONY: install
install: $(EXECUTABLE)
	install $(EXECUTABLE) "$(PREFIX)"

.PHONY: archive
archive: $(ARCHIVE)
	@shasum -a 256 $(EXECUTABLE)
	@shasum -a 256 $(ARCHIVE)

$(ARCHIVE): $(EXECUTABLE)
	tar --create --preserve-permissions --gzip --file $(ARCHIVE) $(EXECUTABLE)

.PHONY: clean
clean:
	rm -rf $(BUILD_PATH) $(EXECUTABLE) $(ARCHIVE)

.PHONY: uninstall
uninstall:
	rm "$(PREFIX)/$(EXECUTABLE)"
