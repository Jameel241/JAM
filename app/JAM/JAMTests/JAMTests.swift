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
    // MARK: - Relevance Scorer
    
    @Test
    func relevanceScorerReturnsZeroForEmptyQuery() {
        
        let scorer = RelevanceScorer()
        
        let suggestion = makeSuggestion(
            kind: .application,
            displayText: "Safari"
        )
        
        let score = scorer.score(
            suggestion: suggestion,
            query: ""
        )
        
        #expect(score == 0)
    }
    
    @Test
    func relevanceScorerPrefersExactMatchOverPrefixMatch() {
        
        let scorer = RelevanceScorer()
        
        let exactMatch = makeSuggestion(
            kind: .application,
            displayText: "Safari"
        )
        
        let prefixMatch = makeSuggestion(
            kind: .application,
            displayText: "Safari Technology Preview"
        )
        
        let exactScore = scorer.score(
            suggestion: exactMatch,
            query: "Safari"
        )
        
        let prefixScore = scorer.score(
            suggestion: prefixMatch,
            query: "Safari"
        )
        
        #expect(exactScore > prefixScore)
    }
    
    @Test
    func relevanceScorerPrefersApplicationFinalWordMatch() {
        
        let scorer = RelevanceScorer()
        
        let finalWordMatch = makeSuggestion(
            kind: .application,
            displayText: "Google Chrome"
        )
        
        let exactMatch = makeSuggestion(
            kind: .application,
            displayText: "Chrome"
        )
        
        let finalWordScore = scorer.score(
            suggestion: finalWordMatch,
            query: "Chrome"
        )
        
        let exactScore = scorer.score(
            suggestion: exactMatch,
            query: "Chrome"
        )
        
        #expect(finalWordScore > exactScore)
    }
    
    
    @Test
    func relevanceScorerPrefersExactWordOverWordPrefixMatch() {
        
        let scorer = RelevanceScorer()
        
        let exactWordMatch = makeSuggestion(
            kind: .setting,
            displayText: "Open Privacy Settings"
        )
        
        let wordPrefixMatch = makeSuggestion(
            kind: .setting,
            displayText: "Open PrivacyCenter Settings"
        )
        
        let exactWordScore = scorer.score(
            suggestion: exactWordMatch,
            query: "Privacy"
        )
        
        let wordPrefixScore = scorer.score(
            suggestion: wordPrefixMatch,
            query: "Privacy"
        )
        
        #expect(exactWordScore > wordPrefixScore)
    }
    
    @Test
    func relevanceScorerPrefersWordPrefixOverSubstringMatch() {
        
        let scorer = RelevanceScorer()
        
        let wordPrefixMatch = makeSuggestion(
            kind: .file,
            displayText: "My Documents"
        )
        
        let substringMatch = makeSuggestion(
            kind: .file,
            displayText: "Undocumented"
        )
        
        let wordPrefixScore = scorer.score(
            suggestion: wordPrefixMatch,
            query: "Doc"
        )
        
        let substringScore = scorer.score(
            suggestion: substringMatch,
            query: "Doc"
        )
        
        #expect(wordPrefixScore > substringScore)
    }
    
    @Test
    func relevanceScorerBoostsCommandsForCommandIntent() {
        
        let scorer = RelevanceScorer()
        
        let commandSuggestion = makeSuggestion(
            kind: .command,
            displayText: "Quit Safari"
        )
        
        let applicationSuggestion = makeSuggestion(
            kind: .application,
            displayText: "Quit Safari"
        )
        
        let commandScore = scorer.score(
            suggestion: commandSuggestion,
            query: "quit Safari"
        )
        
        let applicationScore = scorer.score(
            suggestion: applicationSuggestion,
            query: "quit Safari"
        )
        
        #expect(commandScore > applicationScore)
    }
    
    @Test
    func relevanceScorerUsesSuggestionConfidence() {
        
        let scorer = RelevanceScorer()
        
        let highConfidence = makeSuggestion(
            kind: .file,
            displayText: "Document",
            confidence: 1.0
        )
        
        let lowConfidence = makeSuggestion(
            kind: .file,
            displayText: "Document",
            confidence: 0.0
        )
        
        let highScore = scorer.score(
            suggestion: highConfidence,
            query: "Document"
        )
        
        let lowScore = scorer.score(
            suggestion: lowConfidence,
            query: "Document"
        )
        
        #expect(highScore > lowScore)
    }
    
    @Test
    func suggestionClampsConfidenceAboveMaximum() {
        
        let suggestion = makeSuggestion(
            kind: .application,
            displayText: "Safari",
            confidence: 2.0
        )
        
        #expect(suggestion.confidence == 1.0)
    }
    
    @Test
    func suggestionClampsConfidenceBelowMinimum() {
        
        let suggestion = makeSuggestion(
            kind: .application,
            displayText: "Safari",
            confidence: -1.0
        )
        
        #expect(suggestion.confidence == 0.0)
    }
    
    // MARK: - Test Helpers
    
    private func makeSuggestion(
        kind: SuggestionKind,
        displayText: String,
        confidence: Double = 0.5
    ) -> Suggestion {
        
        Suggestion(
            kind: kind,
            displayText: displayText,
            completion: displayText,
            confidence: confidence,
            url: nil,
            subtitle: "Test"
        )
    }
    
    // MARK: - Command Parser

    @Test
    func commandParserParsesOpenCommand() {

        let parser = CommandParser()

        let command = parser.parse("open Safari")

        #expect(command.verb == .open)
        #expect(command.object == "Safari")
        #expect(command.originalText == "open Safari")
    }

    @Test
    func commandParserParsesQuitCommand() {

        let parser = CommandParser()

        let command = parser.parse("quit Google Chrome")

        #expect(command.verb == .quit)
        #expect(command.object == "Google Chrome")
    }

    @Test
    func commandParserParsesCloseCommand() {

        let parser = CommandParser()

        let command = parser.parse("close Xcode")

        #expect(command.verb == .close)
        #expect(command.object == "Xcode")
    }

    @Test
    func commandParserIsCaseInsensitiveForVerb() {

        let parser = CommandParser()

        let command = parser.parse("OPEN Safari")

        #expect(command.verb == .open)
        #expect(command.object == "Safari")
    }

    @Test
    func commandParserHandlesMultipleWordObject() {

        let parser = CommandParser()

        let command = parser.parse(
            "open System Settings"
        )

        #expect(command.verb == .open)
        #expect(command.object == "System Settings")
    }

    @Test
    func commandParserHandlesVerbWithoutObject() {

        let parser = CommandParser()

        let command = parser.parse("open")

        #expect(command.verb == .open)
        #expect(command.object.isEmpty)
    }

    @Test
    func commandParserReturnsUnknownForUnsupportedVerb() {

        let parser = CommandParser()

        let command = parser.parse("dance Safari")

        #expect(command.verb == .unknown)
        #expect(command.object == "Safari")
    }

    @Test
    func commandParserHandlesEmptyInput() {

        let parser = CommandParser()

        let command = parser.parse("")

        #expect(command.verb == .unknown)
        #expect(command.object.isEmpty)
    }
    
}

