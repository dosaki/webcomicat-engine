package net.dosaki.webcomicat

class Settings {
    String comicTitle = "Webcomicat"
    String mainAuthor = "Dosaki"
    String mainAuthorEmail = "tiago.f.a.correia@gmail.com"

    static hasMany = [paragraphs:Paragraph]

    def getAboutAuthor(){
        return Paragraph.findAllByName("aboutAuthor")*.text
    }

    def setAboutAuthor(ps){
        def deletePs = Paragraph.findAllByName("aboutAuthor")
        deletePs*.delete(flush:true)

        ps.each{
            new Paragraph(name:"aboutAuthor", text:it).save(flush:true)
        }

    }

    def getAboutComic(){
        return Paragraph.findAllByName("aboutComic")*.text
    }

    def setAboutComic(ps){
        def deletePs = Paragraph.findAllByName("aboutComic")
        deletePs*.delete(flush:true)

        ps.each{
            new Paragraph(name:"aboutComic", text:it).save(flush:true)
        }
    }

    def getProfileImage(){
        return Image.findByName("profileImage")
    }
    def getFavicon(){
        return Image.findByName("favicon")
    }
    def getProfileImageName(){
        return Image.findByName("profileImage")?.name
    }
    def getFaviconName(){
        return Image.findByName("favicon")?.name
    }

    static constraints = {
        profileImage nullable:true
        favicon nullable:true
    }
}
