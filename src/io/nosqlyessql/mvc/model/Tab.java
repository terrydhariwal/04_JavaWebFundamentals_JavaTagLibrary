package io.nosqlyessql.mvc.model;

/**
 * Created by Terry on 31/12/14.
 */
public class Tab {

    private String name;
    private String url;

    public Tab(String name, String url) {
        this.name = name;
        this.url = url;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Override
    public String toString() {
        return "Tab {" +
                "name = '" + name + "'," +
                "url = '" + url + "'" +
                "}";
    }
}
