namespace :mrbank do
  desc 'Processes allowances and interests'
  task :daily => :environment do
    accounts
    deposits
    allowances
  end
end

def accounts
  puts 'Processing accounts'
  if Date.today.wday == 6
    puts 'Processing accounts interests'
    Account.where('interest > 0').each do |account|
      begin
        transaction = Transaction.new do |t|
          t.operation = 'deposit'
          t.amount = account.balance * account.interest / 100.0;
          t.description = "Interest of #{account.interest}% for #{Date.today.to_s(:long)}"
        end
        account.customer.record(transaction)
        puts "Deposited #{transaction.amount} #{account.currency} into #{transaction.customer.name}'s account."
      rescue Exception => e
        puts "Error recording interest for #{account.customer.name}:"
        puts e
      end
    end
  end
end

def deposits
  puts 'Processing deposits'
end

def allowances
  puts 'Processing allowances'
  Allowance.where(wday: Date.today.wday).each do |allowance|
    begin
      transaction = Transaction.new do |t|
        t.operation = 'deposit'
        t.amount = allowance.amount
        t.description = "Allowance for #{Date.today.to_s(:long)}"
      end
      allowance.customer.record(transaction)
      puts "Deposited #{transaction.amount} #{allowance.customer.account.currency} into #{transaction.customer.name}'s account."
    rescue Exception => e
      puts "Error recording allowance for #{allowance.customer.name}:"
      puts e
    end
  end
end