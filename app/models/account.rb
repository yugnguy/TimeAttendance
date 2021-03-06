class Account < ApplicationRecord
    has_many :tasks
    belongs_to :factory
    
    def self.get_free_worker(date, word)
        filter_by_word(word, get_worker_by_date(date))
    end

    def self.get_worker_by_date(date)
        busy_acc = Task.get_accId_by_date(date)
        return Account.where.not(:id => busy_acc).where.not(:role => ["Manager", "Admin"])
    end
    
    def self.filter_by_word(word, acc_list)
        tmp = []
        if word != ""
            acc_list.each do |w|
                if w.name.match("^#{word}") || String(w.id).match("^#{word}")
                    tmp << w
                end
            end
            return tmp
        else
            return acc_list
        end
    end
    
    def self.get_name(acc_id)
        return Account.find_by(:id => acc_id).name
    end
    
    def self.add_task(accId, task)
            acc = Account.find_by(:id => accId)
            acc.tasks << task
            acc.save!
    end
    
    def self.get_worker_by_id(id)
        return Account.find_by_id(id)
    end
    def get_tel
        begin
            return self.detail["telephone"]
        rescue
            return ""
        end
    end
end
