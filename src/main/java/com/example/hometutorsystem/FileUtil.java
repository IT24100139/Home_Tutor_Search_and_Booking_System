
package com.example.hometutorsystem;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileUtil {
    private static final String FILE_PATH = "users.txt";

    public static List<String> readLines() throws IOException {
        File file = new File(FILE_PATH);
        if (!file.exists()) file.createNewFile();

        List<String> lines = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) lines.add(line);
        }
        return lines;
    }

    public static void writeLines(List<String> lines) throws IOException {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (String line : lines) bw.write(line + "\n");
        }
    }
}
