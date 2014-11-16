package net.dosaki.webcomicat

import grails.converters.JSON
import grails.converters.deep.JSON as deepJSON
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

    def image(){
        def comic = ComicPage.findBySequenceAndChapter(params.sequence.toInteger(), Chapter.findBySequence(params.chapter.toInteger()))
        response.contentType = comic.imageType
        response.contentLength = comic.image.size()
        OutputStream out = response.outputStream
        out.write(comic.image.byte)
        out.close()
    }

    def getAllComicPages() {
        render comicPageService.getAllComicPages() as deepJSON
    }

    def getAllChapters() {
        render chapterService.getAllChapters() as JSON
    }
}
