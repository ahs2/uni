class ImportStudentsWorker
  require "roo"

  include Sidekiq::Worker

  def perform(import_student_id, university_id)
    students = []
    users = []
    current_time = Time.now
    university = University.find(university_id)

    Apartment::Tenant.switch(university.slug) do
      import_student = ImportStudent.find(import_student_id)
      
      app_url = if Rails.env.production?
        "https://www.campusniger.com"
      else
        "http://localhost:3000"
      end

      xlsx = Roo::Spreadsheet.open("#{app_url}/#{import_student.file_url}")
  
      xlsx.each_with_pagename do |name, sheet|
        sheet.each_with_index do |hash, index|
          if index != 0
            matricule = hash[0]
            last_name = hash[1]
            first_name = hash[2]
            birth_date = hash[3]
            birth_place = hash[4]
            nationality = hash[5]
            gender = hash[6]
            phone = hash[7].to_i
            certificat_name = hash[8]
            certificat_year = hash[9]

            password = SecureRandom.hex(3)
            user = User.new(
              phone: phone, 
              email: "#{matricule}.#{university.slug}.campusniger.com",
              university_id: university_id,
              profile: 1,
              password: password,
              password_confirmation: password
            )
            user.save!(validate: false)

            students << {
              matricule: matricule,
              last_name: last_name,
              first_name: first_name,
              birth_date: birth_date,
              birth_place: birth_place,
              nationality: nationality,
              gender: gender,
              address: phone,
              user_id: user.id,
              certificat_name: certificat_name,
              certificat_year: certificat_year,
              created_at: current_time,
              updated_at: current_time
            }
          end
        end
      end

      ActiveRecord::Base.transaction do
        Student.insert_all!(students)
        # students = Student.all.order('matricule desc')
        # broadcast_prepend_to "students", partial: "students/student", locals: { student: students }, target: "students"
      end
    end
  end
end
