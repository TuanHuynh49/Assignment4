package murach.business;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Product implements Serializable {

    private String code;
    private String description;
    private String artist;
    private String title;
    private List<Song> songs;

    public Product() {
        this.code = "";
        this.description = "";
        this.artist = "";
        this.title = "";
        this.songs = new ArrayList<>();
    }

    public Product(String code, String artist, String title) {
        this.code = code;
        this.artist = artist;
        this.title = title;
        this.description = artist + " - " + title;
        this.songs = new ArrayList<>();
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getArtist() {
        return artist;
    }

    public void setArtist(String artist) {
        this.artist = artist;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public List<Song> getSongs() {
        return songs;
    }

    public void setSongs(List<Song> songs) {
        this.songs = songs;
    }

    public void addSong(Song song) {
        if (this.songs == null) {
            this.songs = new ArrayList<>();
        }
        this.songs.add(song);
    }
}
