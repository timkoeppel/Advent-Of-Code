package main.kotlin.days

import main.kotlin.utils.*
import kotlin.system.measureTimeMillis

abstract class Day(private val day: Int) {
	abstract fun part1(input: List<String>): String
	abstract fun part2(input: List<String>): String

	init {
		// calc
		var partSolution1 ="";
		val timePart1 = measureTimeMillis {
			partSolution1 = this.part1(getDefaultInput())
		}
		var partSolution2 ="";
		val timePart2 = measureTimeMillis {
			partSolution2 = this.part2(getDefaultInput())
		}

		// print
		"Day ${getVerboseDay()}:".println()
		getSolveString(1, timePart1.format(), partSolution1).println()
		getSolveString(2, timePart2.format(), partSolution2).println()
		"".println()
	}
	
	private fun getDefaultInput(): List<String>{
		return readInput(this.javaClass.simpleName)
	}

	private fun getSolveString(part: Int, time: String, solution: String): String{
		val timeString = "[$time ms]".grey()
		return "$timeString Part $part: ${solution.green()}"
	}

	private fun getVerboseDay(): String {
		return if (day < 10) "0$day" else "$day"
	}
}