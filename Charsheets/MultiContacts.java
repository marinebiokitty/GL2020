import java.io.IOException;
import java.nio.file.*;
import java.util.*;
import java.util.regex.*;

/**
 * Simple script that accepts a list of file names, and in those files, replaces the first reference 
 * to each character \cCharacter with \cCharacter{\intro}.
 */
public class MultiContacts {
    private static final Pattern CONTACTS = Pattern.compile(
        "\\\\begin\\{contacts\\}"
    ); // \cStartsWithUpperCase{\optionallyOneCommand}, *not* preceded by a {

    public static void main(String[] args) throws IOException {
        for (String file : args) {
            Path path = Paths.get(file);
            try {
                String contents = Files.readString(path);
                Set<String> seenCharacters = new HashSet<>();
                Matcher matcher = CONTACTS.matcher(contents);
                if (matcher.find() && matcher.find()) {
                    System.out.println(file);
                }
            } catch (Exception e) {
                new IOException("Error on file " + file + ".  Continued.", e).printStackTrace();
            }
        }
    }
}