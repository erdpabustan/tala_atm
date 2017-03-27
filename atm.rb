require 'inquirer'


class ATM
  
  def initialize_defaults()
    @starting_balance = 150000
    @max_daily_deposit = 150000
    @max_deposit_per_transaction = 40000
    @max_deposit_frequency = 4 
    @current_balance = @starting_balance
    @total_deposits_per_day = 0
    @total_amount_deposited = 0
    @max_daily_withdrawal = 50000
    @max_withdrawal_per_transaction = 20000
    @max_withdrawal_frequency = 3
    @total_withdrawals_per_day = 0
    @total_amount_withdrawn = 0
  end

  def show_menu()
    puts "*************************************************************************************************************"
    puts "1. Balance"
    puts "2. Deposit"
    puts "3. Withdrawal"
    puts "4. Quit"
    puts "\n\nEnter Menu Option"
  end
  
  def show_prompt()
    return Ask.input(">")
  end
  
  def show_balance()
    puts "*************************************************************************************************************"
    puts "BALANCE"
    puts "%.2f" % @current_balance
    puts "\n"
    return @current_balance
  end
  
  def deposit(local_atm)
    puts "Enter amount to deposit and press enter (or type menu and press enter to go back to main menu)"
    user_input = local_atm.show_prompt()
    
    if(user_input == "menu")
      local_atm.show_menu()
    elsif(@total_deposits_per_day.to_f() >= 4)
      puts "Error: Max allowed number of deposits of 4 exceeded."
    elsif(user_input.to_f() > 40000)
      puts "Error: Deposit amount exceeds allowed amount. Allowed amount is up to $40,000.00"
    elsif(user_input.to_f() <= 40000 && user_input.to_f() > 0)
      #check whether the amount exceeds max deposit allowed for the day
      temp_max_deposit = @total_amount_deposited + user_input.to_f()
      if(temp_max_deposit > @max_daily_deposit.to_f())
        puts "Error: Deposit amount of #{user_input} + total amount deposited of #{@total_amount_deposited} will exceed max deposit allowed amount of #{@max_daily_deposit} "
      else
        @current_balance = @current_balance + user_input.to_f()
        @total_deposits_per_day = @total_deposits_per_day + 1
        @total_amount_deposited = @total_amount_deposited.to_f() + user_input.to_f()
        local_atm.show_balance()
      end
      
    elsif(user_input.to_f() <= 0)
      puts "Error: Deposit amount is not valid. Please deposit between 1 to 40k."  
    end
  end
  
  def withdraw(local_atm)
    puts "Enter amount to withdraw and press enter (or type menu and press enter to go back to main menu)"
    user_input = local_atm.show_prompt()
    
    if(user_input == "menu")
      local_atm.show_menu()
    elsif(@total_withdrawals_per_day.to_f() >= 3)
      puts "Error: Max allowed number of withdrawals of 3 exceeded."
    elsif(user_input.to_f() > 20000)
      puts "Error: Withdrawal amount exceeds allowed amount. Allowed amount is up to $20,000.00"
    elsif(user_input.to_f() > @current_balance)
      puts "Error: Not enough funds to cover the withdrawal. #{user_input} is greater than #{@current_balance}"
    elsif(user_input.to_f() <= 20000 && user_input.to_f() > 0)
      temp_max_withdrawn = @total_amount_withdrawn + user_input.to_f()
      if(temp_max_withdrawn > @max_daily_withdrawal)
        puts "Error: Withdrawal amount of #{user_input} + total amount withdrawn of #{@total_amount_withdrawn} will exceed max withdrawal allowed amount of #{@max_daily_withdrawal} "
      else
        @current_balance = @current_balance - user_input.to_f()
        @total_withdrawals_per_day = @total_withdrawals_per_day + 1
        @total_amount_withdrawn = @total_amount_withdrawn + user_input.to_f()
        local_atm.show_balance()
      end
    end
  end
  
  def show_transactions()
    puts "Current balance: #{@current_balance}"
    puts "Total deposits today: #{@total_deposits_per_day}"
    puts "Total amount deposited: #{@total_amount_deposited}"
    puts "Max daily deposits allowed: #{@max_daily_deposit}"
    puts "Total withdrawals today: #{@total_withdrawals_per_day}"
    puts "Total amount withdrawn: #{@total_amount_withdrawn}"
    puts "Max daily withdrawals allowed: #{@max_daily_withdrawal}"
  end
  
end

tala_atm = ATM.new()
tala_atm.initialize_defaults()
user_is_banking = true
tala_atm.show_menu()

while(user_is_banking) 
  
  menu_option = tala_atm.show_prompt()
  
  case menu_option.upcase
  when "QUIT", "Q"
    response = Ask.input("Are you sure you want to quit? (yes or no)?")
      if(response.upcase == "YES")
        user_is_banking = false
      else
        tala_atm.show_menu()
      end
    when "BALANCE", "B"
      tala_atm.show_balance()
    when "DEPOSIT", "D", "+"
      tala_atm.deposit(tala_atm)
    when "WITHDRAWAL", "W", "-"
      tala_atm.withdraw(tala_atm)
    when "MENU", "M"
      tala_atm.show_menu()  
    when "STATUS", "S"
      tala_atm.show_transactions()
    else
      puts "Invalid menu entry. Type 'menu' to see valid options"
      user_is_banking = true
  end
 
end
  

