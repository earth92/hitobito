# encoding: UTF-8
ch = Group.roots.first
srand(42)
def contacts
  { short_name: ('A'..'Z').to_a.sample(2).join,
    address: Faker::Address.street_address,
    zip_code: Faker::Address.zip,
    town: Faker::Address.city,
    country: 'Svizzera',
    email: Faker::Internet.safe_email
  } 
end
unless ch.address.present?
  ch.update_attributes(contacts)
  ch.default_children.each do |child_class|
    child_class.first.update_attributes(contacts)
  end
end

states = Group::State.seed(:name, :parent_id,
  {name: 'Kanton Bern',
   short_name: 'BE',
   address: "Klostergasse 3",
   zip_code: "3333",
   town: "Bern",
   country: "Svizzera",
   email: "bern@be.ch",
   parent_id: ch.id},

  {name: 'Kanton Zürich',
   short_name: 'ZH',
   address: "Tellgasse 3",
   zip_code: "8888",
   town: "Zürich",
   country: "Svizzera",
   email: "zuerich@zh.ch",
   parent_id: ch.id },
   
  {name: 'Kanton Nordost',
   short_name: 'NO',
   address: "Nordostgasse 3",
   zip_code: "9000",
   town: "Nordosthausen",
   country: "Svizzera",
   email: "nordost@nordost.ch",
   parent_id: ch.id },
)

states.each do |s|
  SocialAccount.seed(:contactable_id, :contactable_type, :name,
    { contactable_id:   s.id,
      contactable_type: 'Group',
      name:             'info@group.ch',
      label:            'Email',
      public:           true }
  )

  PhoneNumber.seed(:contactable_id, :contactable_type, :number,
    { contactable_id:   s.id,
      contactable_type: 'Group',
      number:           Faker::PhoneNumber.phone_number,
      label:            "Auskunft",
      public:           true }
  )
  ast = s.children.where(type: 'Group::StateAgency').first
  ast.update_attributes(contacts)
end

Group::ProfessionalGroup.seed(:name, :parent_id,
  {name: 'FG Sicherheit',
   parent_id: states[0].id },
   
  {name: 'FG Security',
   parent_id: states[2].id },
)

Group::WorkGroup.seed(:name, :parent_id,
  {name: 'AG Bundeslager',
   parent_id: ch.id },
   
  {name: 'AG Kantonslager',
   parent_id: states[0].id },
)

regions = Group::Region.seed(:name, :parent_id,
  {name: 'Region Stadt',
   parent_id: states[0].id }.merge(contacts),
   
  {name: 'Region Oberland',
   parent_id: states[0].id }.merge(contacts),
   
  {name: 'Region Jura',
   parent_id: states[0].id }.merge(contacts),
   
  {name: 'Region Stadt',
   parent_id: states[1].id }.merge(contacts),
   
  {name: 'Region Oberland',
   parent_id: states[1].id }.merge(contacts),
)

flocks = Group::Flock.seed(:name, :parent_id,
  {name: 'Schar Bern',
   parent_id: regions[0].id },
   
  {name: 'Schar Muri',
   parent_id: regions[0].id },
   
  {name: 'Schar Thun',
   parent_id: regions[1].id },
   
  {name: 'Schar Interlaken',
   parent_id: regions[1].id },
   
  {name: 'Schar Simmental',
   parent_id: regions[1].id },
   
  {name: 'Schar Biel',
   parent_id: regions[2].id },
   
  {name: 'Schar Chräis Chäib',
   parent_id: regions[3].id },
   
  {name: 'Schar Wiedikon',
   parent_id: regions[3].id },
   
  {name: 'Schar Innerroden',
   parent_id: states[2].id },
   
  {name: 'Schar Ausserroden',
   parent_id: states[2].id },
)

flocks.each do |s|
  SocialAccount.seed(:contactable_id, :contactable_type, :label,
    { contactable_id:   s.id,
      contactable_type: 'Group',
      name:             'info@flocks.ch',
      label:            'E-Mail',
      public:           true }
  )

  PhoneNumber.seed(:contactable_id, :contactable_type, :label,
    { contactable_id:   s.id,
      contactable_type: 'Group',
      number:           Faker::PhoneNumber.phone_number,
      label:            "Auskunft",
      public:           true },
  )
end

Group::ChildGroup.seed(:name, :parent_id,
  {name: 'Kindergruppe Asterix',
   parent_id: flocks[0].id },
   
  {name: 'Kindergruppe Obelix',
   parent_id: flocks[0].id },
   
  {name: 'Kindergruppe Idefix',
   parent_id: flocks[0].id },
   
  {name: 'Kindergruppe Mickey',
   parent_id: flocks[1].id },
   
  {name: 'Kindergruppe Minnie',
   parent_id: flocks[2].id },
   
  {name: 'Kindergruppe Goofy',
   parent_id: flocks[3].id },
   
  {name: 'Kindergruppe Donald',
   parent_id: flocks[4].id },
   
  {name: 'Kindergruppe Gaston',
   parent_id: flocks[5].id },
   
  {name: 'Kindergruppe Tim',
   parent_id: flocks[6].id },
   
  {name: 'Kindergruppe Hadock',
   parent_id: flocks[7].id },
   
  {name: 'Kindergruppe Batman',
   parent_id: flocks[8].id },
   
  {name: 'Kindergruppe Robin',
   parent_id: flocks[8].id },
   
  {name: 'Kindergruppe Spiderman',
   parent_id: flocks[9].id },
   
)

Group::SimpleGroup.seed(:name, :parent_id,
  {name: 'Einfache Gruppe Tschutter',
   parent_id: flocks[0].id },
   
  {name: 'Einfache Gruppe Angestellte',
   parent_id: states[0].id },
)
   
   
Group.rebuild!
