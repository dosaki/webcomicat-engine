package net.dosaki.webcomicat

import java.sql.Date as SQLDate

class ComicPage {
    String author
    String title
    SQLDate releaseDate = new SQLDate(new java.util.Date().getTime())
    String chapter
    String description
    String image

    static constraints = {
        author nullable:false
        title nullable: true
        releaseDate nullable: false
        chapter nullable: true
        description nullable: true
        image nullable: false
    }
}
