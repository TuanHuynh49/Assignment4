package murach.business;

import java.io.Serializable;

public class Song implements Serializable {

    private String title;
    private String filename;
    private String format;

    public Song() {
        this.title = "";
        this.filename = "";
        this.format = "MP3";
    }

    public Song(String title, String filename) {
        this.title = title;
        this.filename = filename;
        this.format = "MP3";
    }

    public Song(String title, String filename, String format) {
        this.title = title;
        this.filename = filename;
        this.format = format;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }
}
