package net.dosaki.webcomicat

import java.sql.Date as SQLDate

class ComicPage {
    User author
    String title
    Integer sequence
    SQLDate releaseDate = new SQLDate(new java.util.Date().getTime())
    String description
    String image

    static belongsTo = [chapter: Chapter]

    static constraints = {
        author nullable:false
        title nullable: true
        releaseDate nullable: false
        chapter nullable: true
        description nullable: true
        image nullable: false
    }
}
