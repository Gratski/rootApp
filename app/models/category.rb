class Category < ActiveRecord::Base
  has_many :article_categories
  has_many :articles, through: :article_categories
  
  validates :name, presence:true, 
            uniqueness: {case_sentive: false},
            length: {minimum: 3, maximum: 15}
end