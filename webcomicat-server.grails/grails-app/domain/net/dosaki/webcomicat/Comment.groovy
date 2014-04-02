package net.dosaki.webcomicat

import java.sql.Date as SQLDate

class Comment {
    String author="Anonymous"
    SQLDate datePosted = new SQLDate(new java.util.Date().getTime())
    String email
    String text
    ComicPage comicPage

    static constraints = {
        author nullable: false
        //datePosted nullable: false
        email nullable: true
        text nullable: false
        comicPage nullable: false
    }
}
