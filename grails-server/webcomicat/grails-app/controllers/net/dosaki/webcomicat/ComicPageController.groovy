package net.dosaki.webcomicat

import grails.converters.JSON
import org.hibernate.criterion.CriteriaSpecification


class ComicPageController {
    def newComicPage() {
        def newComicPage=new ComicPage()
        newComicPage.properties=request.JSON.comicPage
        newComicPage.save()
        if(!newComicPage.hasErrors())
            render newComicPage as JSON
        else
            render newComicPage.errors
    }

    def getAllComicPages() {
        def c = ComicPage.createCriteria()
        def comicPageList = c.list {
            resultTransformer(CriteriaSpecification.ALIAS_TO_ENTITY_MAP);

            lt("releaseDate", (new java.sql.Date((new java.util.Date() + 1).getTime())) )

            order("releaseDate", "desc")
        }

        render comicPageList as JSON
    }
}
