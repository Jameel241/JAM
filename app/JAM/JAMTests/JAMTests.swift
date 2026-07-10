import Testing
@testable import JAM

struct JAMTests {

    // MARK: - Search Query Normalizer

    @Test
    func normalizerTrimsWhitespace() {

        let normalizer = SearchQueryNormalizer()

        let result = normalizer.normalize(
            "   Safari   "
        )

        #expect(result == "Safari")
    }

    @Test
    func normalizerRemovesOpenPrefix() {

        let normalizer = SearchQueryNormalizer()

        let result = normalizer.normalize(
            "open Safari"
        )

        #expect(result == "Safari")
    }

    @Test
    func normalizerRemovesShowMePrefix() {

        let normalizer = SearchQueryNormalizer()

        let result = normalizer.normalize(
            "show me Downloads"
        )

        #expect(result == "Downloads")
    }

    @Test
    func normalizerRemovesGoToPrefix() {

        let normalizer = SearchQueryNormalizer()

        let result = normalizer.normalize(
            "go to Privacy"
        )

        #expect(result == "Privacy")
    }

    @Test
    func normalizerRemovesSearchForPrefix() {

        let normalizer = SearchQueryNormalizer()

        let result = normalizer.normalize(
            "search for Documents"
        )

        #expect(result == "Documents")
    }

    @Test
    func normalizerRemovesFindPrefix() {

        let normalizer = SearchQueryNormalizer()

        let result = normalizer.normalize(
            "find Downloads"
        )

        #expect(result == "Downloads")
    }

    @Test
    func normalizerRemovesLaunchPrefix() {

        let normalizer = SearchQueryNormalizer()

        let result = normalizer.normalize(
            "launch Xcode"
        )

        #expect(result == "Xcode")
    }

    @Test
    func normalizerMatchesPrefixesCaseInsensitively() {

        let normalizer = SearchQueryNormalizer()

        let result = normalizer.normalize(
            "OPEN Safari"
        )

        #expect(result == "Safari")
    }

    @Test
    func normalizerPreservesQueryWithoutPrefix() {

        let normalizer = SearchQueryNormalizer()

        let result = normalizer.normalize(
            "System Settings"
        )

        #expect(result == "System Settings")
    }

    @Test
    func normalizerHandlesEmptyQuery() {

        let normalizer = SearchQueryNormalizer()

        let result = normalizer.normalize("")

        #expect(result.isEmpty)
    }

    @Test
    func normalizerHandlesWhitespaceOnlyQuery() {

        let normalizer = SearchQueryNormalizer()

        let result = normalizer.normalize(
            "     "
        )

        #expect(result.isEmpty)
    }


    // MARK: - Query Intent Detector

    @Test
    func intentDetectorRecognizesQuitCommand() {

        let detector = QueryIntentDetector()

        let result = detector.detect(
            "quit Safari"
        )

        #expect(result == .command)
    }

    @Test
    func intentDetectorRecognizesCloseCommand() {

        let detector = QueryIntentDetector()

        let result = detector.detect(
            "close Xcode"
        )

        #expect(result == .command)
    }

    @Test
    func intentDetectorRecognizesHideCommand() {

        let detector = QueryIntentDetector()

        let result = detector.detect(
            "hide Finder"
        )

        #expect(result == .command)
    }

    @Test
    func intentDetectorRecognizesStandaloneCommand() {

        let detector = QueryIntentDetector()

        let result = detector.detect(
            "quit"
        )

        #expect(result == .command)
    }

    @Test
    func intentDetectorIsCaseInsensitive() {

        let detector = QueryIntentDetector()

        let result = detector.detect(
            "QUIT Safari"
        )

        #expect(result == .command)
    }

    @Test
    func intentDetectorTrimsWhitespace() {

        let detector = QueryIntentDetector()

        let result = detector.detect(
            "   hide Finder   "
        )

        #expect(result == .command)
    }

    @Test
    func intentDetectorDoesNotMatchPartialCommandWords() {

        let detector = QueryIntentDetector()

        let result = detector.detect(
            "quitting Safari"
        )

        #expect(result == .general)
    }

    @Test
    func intentDetectorReturnsGeneralForApplicationQuery() {

        let detector = QueryIntentDetector()

        let result = detector.detect(
            "Safari"
        )

        #expect(result == .general)
    }

    @Test
    func intentDetectorReturnsGeneralForEmptyQuery() {

        let detector = QueryIntentDetector()

        let result = detector.detect("")

        #expect(result == .general)
    }

    @Test
    func intentDetectorReturnsGeneralForWhitespaceOnlyQuery() {

        let detector = QueryIntentDetector()

        let result = detector.detect(
            "     "
        )

        #expect(result == .general)
    }
}
