package net.dosaki.webcomicat

import grails.converters.JSON

import grails.plugin.springsecurity.annotation.Secured


@Secured(['ROLE_ADMIN'])
class ManageComicController {
    def wcSecurityService
    def comicPageService

    def index() {
        render view:"index"
    }

    def newChapter() {
        def chapter = new Chapter();

        chapter.sequence = params.chaptSequence.toInteger();
        chapter.title = params.title

        if(!chapter.hasErrors())
            render chapter as JSON
        else
            render chapter.errors
    }
    def newComicPage() {
        def file = request.getFile('comicImage')
        def title = params.title;
        def chapter = Chapter.findBySequence(params.chapter);
        def sequence = ComicPage.getAll().size()

        println params
        //file.transferTo(new File('/var/webcomicat/comics/'+chapter.sequence+'/'+sequence+title))
/*
        def newComicPage=new ComicPage()
        newComicPage.title = title;
        newComicPage.chapter = chapter;
        newComicPage.author = wcSecurityService.getCurrentUser()
        newComicPage.save()

        if(!newComicPage.hasErrors())
            render newComicPage as JSON
        else
            render newComicPage.errors*/
    }

    def getAllComicPages() {
        render comicPageService.getAllComicPages() as JSON
    }

    def getChapters() {
        render comicPageService.getAllComicPages() as JSON
    }
}
