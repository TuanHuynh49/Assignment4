package murach.data;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import murach.business.User;

public class UserIO {

    public static synchronized boolean add(User user, String filepath) {
        if (user == null || filepath == null || filepath.isEmpty()) {
            return false;
        }

        File file = new File(filepath);
        if (file.getParentFile() != null && !file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }

        // Check if user already exists, update or skip duplicate
        List<User> existingUsers = getUsers(filepath);
        boolean exists = false;
        for (User u : existingUsers) {
            if (u.getEmail().equalsIgnoreCase(user.getEmail())) {
                u.setFirstName(user.getFirstName());
                u.setLastName(user.getLastName());
                exists = true;
                break;
            }
        }

        if (exists) {
            // Rewrite all users
            try (PrintWriter out = new PrintWriter(new FileWriter(file, false))) {
                for (User u : existingUsers) {
                    out.println(u.getEmail() + "|" + u.getFirstName() + "|" + u.getLastName());
                }
                return true;
            } catch (IOException e) {
                System.err.println("UserIO Error rewriting file: " + e.getMessage());
                return false;
            }
        } else {
            // Append new user
            try (PrintWriter out = new PrintWriter(new FileWriter(file, true))) {
                out.println(user.getEmail() + "|" + user.getFirstName() + "|" + user.getLastName());
                return true;
            } catch (IOException e) {
                System.err.println("UserIO Error writing user: " + e.getMessage());
                return false;
            }
        }
    }

    public static synchronized User getUser(String email, String filepath) {
        if (email == null || email.trim().isEmpty() || filepath == null) {
            return null;
        }

        File file = new File(filepath);
        if (!file.exists()) {
            return null;
        }

        try (BufferedReader in = new BufferedReader(new FileReader(file))) {
            String line = in.readLine();
            while (line != null) {
                line = line.trim();
                if (!line.isEmpty()) {
                    String[] tokens = line.split("\\|");
                    if (tokens.length >= 3) {
                        String userEmail = tokens[0].trim();
                        String firstName = tokens[1].trim();
                        String lastName = tokens[2].trim();
                        if (email.equalsIgnoreCase(userEmail)) {
                            return new User(firstName, lastName, userEmail);
                        }
                    } else if (tokens.length == 1) {
                        // In case format is just email
                        if (email.equalsIgnoreCase(tokens[0].trim())) {
                            return new User("", "", tokens[0].trim());
                        }
                    }
                }
                line = in.readLine();
            }
        } catch (IOException e) {
            System.err.println("UserIO Error reading user: " + e.getMessage());
        }
        return null;
    }

    public static synchronized List<User> getUsers(String filepath) {
        List<User> users = new ArrayList<>();
        if (filepath == null) {
            return users;
        }

        File file = new File(filepath);
        if (!file.exists()) {
            return users;
        }

        try (BufferedReader in = new BufferedReader(new FileReader(file))) {
            String line = in.readLine();
            while (line != null) {
                line = line.trim();
                if (!line.isEmpty()) {
                    String[] tokens = line.split("\\|");
                    if (tokens.length >= 3) {
                        users.add(new User(tokens[1].trim(), tokens[2].trim(), tokens[0].trim()));
                    } else if (tokens.length == 2) {
                        users.add(new User(tokens[1].trim(), "", tokens[0].trim()));
                    } else if (tokens.length == 1) {
                        users.add(new User("", "", tokens[0].trim()));
                    }
                }
                line = in.readLine();
            }
        } catch (IOException e) {
            System.err.println("UserIO Error reading all users: " + e.getMessage());
        }
        return users;
    }
}
