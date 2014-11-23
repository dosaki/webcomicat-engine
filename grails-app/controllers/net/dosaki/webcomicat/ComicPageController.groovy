package net.dosaki.webcomicat

import grails.converters.JSON
import org.hibernate.criterion.CriteriaSpecification

import grails.plugin.springsecurity.annotation.Secured


@Secured(['permitAll'])
class ComicPageController {
    def comicPageService

    def index(){
        render view:"index",
                model:[
                    "current": "home"
                ]
    }

    def image(){
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
        render comicPageService.getAllReleasedComicPages() as JSON
    }
}
