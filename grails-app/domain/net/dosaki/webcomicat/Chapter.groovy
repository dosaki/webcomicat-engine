package net.dosaki.webcomicat

class Chapter {
    String title
    Integer sequence

    static constraints = {
        title nullable: true
        sequence nullable: true, unique: true
    }

    def getComics(){
        return Comic.findAllByChapter(this)
    }

    String toString(){
        return "" + this.sequence + ": " + this.title
    }
}
