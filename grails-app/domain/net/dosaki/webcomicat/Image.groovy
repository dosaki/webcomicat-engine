package net.dosaki.webcomicat

class Image {
    byte[] file
    String name
    String extension

    static constraints = {
        file nullable: false, maxSize:1073741824
        name nullable: false
        extension nullable: false
    }
}
