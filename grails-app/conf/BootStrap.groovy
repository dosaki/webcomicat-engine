import net.dosaki.webcomicat.*
import net.dosaki.webcomicat.marshallers.*

class BootStrap {
    def init = { servletContext ->
        def adminRole = Role.findByAuthority('ROLE_ADMIN') ?: new Role(authority: 'ROLE_ADMIN').save(flush: true)
        def userRole = Role.findByAuthority('ROLE_USER') ?: new Role(authority: 'ROLE_USER').save(flush: true)

        if(!User.findByUsername('admin')){
            println "Creating admin..."
            def adminUser = new User(username: 'admin', password: 'password')
            adminUser.save(flush: true)

            UserRole.create adminUser, adminRole, true
        }


        /**
         * Generate settings if they are not there
         */
        def settings = Settings.get(1)
        if(!settings){
            settings = new Settings();
            settings.aboutAuthor = [
                "I'm just the developer.",
                "If you're seeing this, the actual author probably forgot to configure something."
            ]
            settings.aboutComic = [
                "Manage and host your own webcomic!",
                "If you're seeing this, the actual author probably forgot to configure something."
            ]
            settings.save(flush:true)
        }

        /**
         * Register JSON marshallers
         */
        def comicPageMarshaller = new ComicPageMarshaller()
        comicPageMarshaller.register()
        def userMarshaller = new UserMarshaller()
        userMarshaller.register()
        def chapterMarshaller = new ChapterMarshaller()
        chapterMarshaller.register()
        def settingsMarshaller = new SettingsMarshaller()
        settingsMarshaller.register()
    }

    def destroy = {
    }
}
