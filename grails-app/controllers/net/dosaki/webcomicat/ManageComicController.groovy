package net.dosaki.webcomicat

import grails.converters.JSON
import groovy.json.JsonSlurper

import grails.plugin.springsecurity.annotation.Secured


@Secured(['ROLE_ADMIN'])
class ManageComicController {
    def wcSecurityService
    def comicPageService
    def chapterService

    def index() {
        render view:"index"
    }

    def users() {
        render view:"users"
    }

    def settings() {
        render view:"settings"
    }

    def getSettings() {
        def settings = Settings.get(1)
        render settings as JSON
    }

    def saveSettings() {
        def settings = Settings.get(1)
        settings.properties = request.JSON
        settings.aboutComic = request.JSON.aboutComic
        settings.aboutAuthor = request.JSON.aboutAuthor
        settings.save(flush:true)

        render "All is good"
    }

    def newChapter() {
        def chapter = new Chapter();

        chapter.sequence = request.JSON.sequence.toInteger();
        chapter.title = request.JSON.title

        if(chapter.validate()){
            chapter.save()
            render chapter as JSON
        }
        else{
            response.sendError(500, chapter.errors as JSON);
        }
    }
    def newComicPage() {
        def file = request.getFile('file')
        def comic = new JsonSlurper().parseText(params.data)
        def sequence = ComicPage.getAll().size()
        def chapter = Chapter.findBySequence(comic.chapter.sequence)

        def newComicPage = new ComicPage()
        newComicPage.title = comic.title ?: "Page" + sequence
        newComicPage.chapter = chapter
        newComicPage.sequence = sequence
        newComicPage.author = wcSecurityService.getCurrentUser()
        newComicPage.description = comic.description ?: null
        newComicPage.image = file.bytes
        newComicPage.imageType = file.getContentType()

        if(newComicPage.validate()){
            newComicPage.save()
            render newComicPage as JSON
        }
        else{
            response.sendError(500, newComicPage.errors as JSON);
        }
    }

    def deleteComicPage() {
        def comicPage = ComicPage.get(request.JSON.id)
        comicPage.delete(flush:true)

        if(!ComicPage.get(request.JSON.id)){
            render request.JSON.id
        }
        else{
            response.sendError(500, "Couldn't delete comic!");
        }

    }

    def image() {
        def comic = ComicPage.findBySequenceAndChapter(
            params.sequence.toInteger(),
            Chapter.findBySequence(params.chapter.toInteger())
        )
        response.contentType = comic.imageType
        response.contentLength = comic.image.size()
        OutputStream out = response.outputStream
        out.write(comic.image)
        out.close()
    }

    def getAllComicPages() {
        render comicPageService.getAllComicPages() as JSON
    }

    def getAllChapters() {
        render chapterService.getAllChapters() as JSON
    }

    def getAllUsers(){
        render User.getAll() as JSON
    }
}
