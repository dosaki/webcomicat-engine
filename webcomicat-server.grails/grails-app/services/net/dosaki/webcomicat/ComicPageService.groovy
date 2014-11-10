package net.dosaki.webcomicat

import org.hibernate.criterion.CriteriaSpecification

class ComicPageService{
    def getAllComicPages() {
        def c = ComicPage.createCriteria()
        def comicPageList = c.list {
            resultTransformer(CriteriaSpecification.ALIAS_TO_ENTITY_MAP);

            lt("releaseDate", (new java.sql.Date((new java.util.Date() + 1).getTime())) )

            order("releaseDate", "desc")
        }

        return comicPageList
    }
}
