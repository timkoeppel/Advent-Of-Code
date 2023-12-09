plugins {
	kotlin("jvm") version "1.9.21"
}

sourceSets {
	main {
		kotlin.srcDir("src")
	}
}

tasks {
	wrapper {
		gradleVersion = "8.5"
	}

	test {
		useJUnitPlatform()
	}
}

dependencies {
	testImplementation("org.junit.jupiter:junit-jupiter:5.9.2")
	testImplementation("org.jetbrains.kotlin:kotlin-test:1.8.10")
}
