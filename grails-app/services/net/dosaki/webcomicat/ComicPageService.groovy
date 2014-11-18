package net.dosaki.webcomicat

import org.hibernate.criterion.CriteriaSpecification
import java.sql.Date as SQLDate

class ComicPageService{
    def getAllComicPages(){
        return ComicPage.getAll()
    }

    def getAllReleasedComicPages() {
        def now = new SQLDate(new java.util.Date().getTime())
        def query = ComicPage.where{
            releaseDate <= now
        }

        return query.list(sort:"releaseDate", order:"asc")
    }
}
