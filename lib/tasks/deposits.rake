namespace :bod do
  desc 'Process deposits at term'
  task :deposits => :environment do
    puts 'Processing deposits...'
      Deposit.where(term: Date.today - 1.day).each do |deposit|
        transaction = Transaction.new do |t|
          t.operation = 'deposit'
          t.amount = deposit.amount * (1 + deposit.interest/100.0)
          t.description = 'Deposit maturity'
        end
        begin
          deposit.customer.record(transaction)
          deposit.destroy!
          puts "Deposited #{transaction.amount} #{transaction.customer.account.currency} into #{transaction.customer.name}'s account."
        rescue Exception => e
          puts e
          puts "Error recording interest for #{deposit.customer.name}:"
        end
      end    
  end
end