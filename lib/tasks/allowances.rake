namespace :mrbank do
  desc 'Processes allowances'
  task :allowances => :environment do
    puts 'Processing allowances...'
    Allowance.where(wday: Date.today.wday).each do |allowance|
      begin
        transaction = Transaction.new do |t|
          t.operation = 'deposit'
          t.amount = allowance.amount
          t.description = "#{Date::DAYNAMES[Date.today.wday]}\' s allowance"
        end
        allowance.customer.record(transaction)
        puts "Deposited #{transaction.amount} #{allowance.customer.account.currency} into #{transaction.customer.name}'s account."
      rescue Exception => e
        puts "Error recording allowance for #{allowance.customer.name}:"
        puts e
      end
    end
  end
end