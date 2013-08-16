namespace :mrbank do
  desc "Applies all allowances"
  task :allowances => :environment do
    Allowance.all.each do |allowance|
      transaction = Transaction.new do |t|
        t.operation = 'deposit'
        t.amount = allowance.amount
        t.description = "Allowance for #{Date.today.to_s(:long)}"
      end
      begin
        allowance.customer.record(transaction)
        puts "Deposited #{allowance.amount} into #{allowance.customer.name}'s account."
      rescue Exception => e
        puts "Error recording allowance for #{allowance.customer.name}:"
        puts e
      end
    end
  end
end