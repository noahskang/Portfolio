require_relative 'employee'

class Manager < Employee
  attr_reader :employees
  def initialize(name, title, salary, boss, employees)
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    total_salary = @employees.inject(0) do |accum, employee|
      accum += employee.salary
    end
    total_salary * multiplier
  end


end

shawna = Employee.new("shawna", "ta", 12000, "darren")
david = Employee.new("david", "ta", 10000, "darren")
darren = Manager.new("darren", "ta manager", 78000, "ned", [shawna, david])
ned = Manager.new("ned", "founder", 1000000, nil, [darren, shawna, david])

p ned.employees
p ned.bonus(5)
p darren.bonus(4)
p david.bonus(3)
