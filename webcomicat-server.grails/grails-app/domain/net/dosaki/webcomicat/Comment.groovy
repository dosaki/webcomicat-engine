package net.dosaki.webcomicat

import java.sql.Date as SQLDate

class Comment {
    User author=null
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


    def getAuthorName(){
        return author ? author.username : "Annonymous"
    }

    def setAuthorName(username){
        author = User.findByUsername(username)
        return author?.username
    }
}
