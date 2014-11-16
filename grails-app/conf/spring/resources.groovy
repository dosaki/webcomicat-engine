import grails.rest.render.json.JsonCollectionRenderer
import grails.rest.render.json.JsonRenderer

import net.dosaki.webcomicat.ComicPage
import net.dosaki.webcomicat.Chapter
import net.dosaki.webcomicat.User


// Place your Spring DSL code here
beans = {
    final comicPageExcludes = ['class', 'image', 'imageType']
    comicPageRenderer(JsonRenderer, ComicPage) {
        excludes = comicPageExcludes
    }
    comicPageRenderer(JsonCollectionRenderer, ComicPage) {
        excludes = comicPageExcludes
    }

    final chapterExcludes = ['class']
    chapterRenderer(JsonRenderer, Chapter) {
        excludes = chapterExcludes
    }
    chapterRenderer(JsonCollectionRenderer, Chapter) {
        excludes = chapterExcludes
    }

    final userExcludes = ['class','password']
    userRenderer(JsonRenderer, User) {
        excludes = userExcludes
    }
    userRenderer(JsonCollectionRenderer, User) {
        excludes = userExcludes
    }
}
