namespace :mrbank do
  desc 'Pay account interests'
  task :interests => :environment do
    puts 'Processing accounts interests...'
    Account.where('interest > 0)'.each do |account|
      begin
        transaction = Transaction.new do |t|
          t.operation = 'deposit'
          t.amount = account.balance * account.interest / 100.0;
          t.description = "Monthly interest of #{account.interest}%"
        end
        account.customer.record(transaction)
        puts "Deposited #{transaction.amount} #{account.currency} into #{transaction.customer.name}'s account."
      rescue Exception => e
        puts "Error recording interest for #{account.customer.name}:"
        puts e.message
      end
    end    
  end
end