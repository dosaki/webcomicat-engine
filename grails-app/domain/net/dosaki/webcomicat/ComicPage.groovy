package net.dosaki.webcomicat

import java.sql.Date as SQLDate

class ComicPage {
    User author
    String title
    Integer sequence
    SQLDate releaseDate = new SQLDate(new java.util.Date().getTime())
    String description
    byte[] image
    String imageType

    static belongsTo = [chapter: Chapter]

    static constraints = {
        author nullable:false
        title nullable: false
        releaseDate nullable: false
        chapter nullable: false
        description nullable: true
        sequence nullable: false
        image nullable: false, maxSize:1073741824
        imageType nullable: false
    }
}
