import java.io.IOException;
import java.nio.file.*;
import java.util.*;
import java.util.regex.*;

/**
 * Simple script that accepts a list of file names, and in those files, replaces the first reference 
 * to each character \cCharacter with \cCharacter{\intro}.
 */
public class Introfier {
    private static final Pattern CHARACTER_REFERENCE = Pattern.compile(
        "(?<!\\{)\\\\c([A-Z][A-Za-z]*)\\{(\\\\[A-Za-z]+)?\\}"
    ); // \cStartsWithUpperCase{\optionallyOneCommand}, *not* preceded by a {

    public static void main(String[] args) throws IOException {
        for (String file : args) {
            Path path = Paths.get(file);
            try {
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
                System.out.println("Processed file " + file + ".");
            } catch (Exception e) {
                new IOException("Error on file " + file + ".  Continued.", e).printStackTrace();
            }
        }
    }
}