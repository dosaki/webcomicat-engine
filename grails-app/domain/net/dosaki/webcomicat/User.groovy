package net.dosaki.webcomicat

class User {

	transient springSecurityService

	String username
	String password
	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	static transients = ['springSecurityService']

	static constraints = {
		username blank: false, unique: true
		password blank: false
	}

	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role }
	}

	Boolean hasRole(role) {
		return authorities.any { it.authority == role }
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		//if (isDirty('password')) { //commented because of dirty checking bug
			encodePassword()
		//}
	}

	protected void encodePassword() {
		password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
	}
}
