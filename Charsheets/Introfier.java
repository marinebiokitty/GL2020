import java.io.IOException;
import java.nio.file.*;
import java.util.*;
import java.util.regex.*;

public class Introfier {
    private static final Pattern CHARACTER_REFERENCE = Pattern.compile(
        "(?<!\\{)\\\\c([A-Z][A-Za-z]*)\\{(\\\\[A-Za-z]+)?\\}"
    );

    public static void main(String[] args) throws IOException {
        for (String file : args) {
            Path path = Paths.get(file);
            String contents = Files.readString(path);
            Set<String> seenCharacters = new HashSet<>();
            Matcher matcher = CHARACTER_REFERENCE.matcher(contents);
            String result = matcher.replaceAll(matchResult -> {
                String charCommand = matchResult.group(1);
                if (!seenCharacters.add(charCommand)) {
                    return "$0"; // we've already seen this character; don't replace anything
                } else {
                    return "\\\\c$1{\\\\intro}";
                }
            });
            Files.writeString(path, result);
        }
    }
}