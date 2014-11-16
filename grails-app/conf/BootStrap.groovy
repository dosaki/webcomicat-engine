import net.dosaki.webcomicat.*

class BootStrap {
    def init = { servletContext ->
        def adminRole = Role.findByAuthority('ROLE_ADMIN') ?: new Role(authority: 'ROLE_ADMIN').save(flush: true)
        def userRole = Role.findByAuthority('ROLE_USER') ?: new Role(authority: 'ROLE_USER').save(flush: true)

        if(!User.findByUsername('admin')){
            println "creating..."
            def adminUser = new User(username: 'admin', password: 'password')
            adminUser.save(flush: true)

            UserRole.create adminUser, adminRole, true
        }

    }

    def destroy = {
    }
}
