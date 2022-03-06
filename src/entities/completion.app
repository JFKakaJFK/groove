module completion

imports src/entities

entity Completion {
	habit: Habit (not null)
	date: Date
}