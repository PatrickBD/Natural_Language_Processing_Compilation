require "csv"

### read in data
train_file = File.open("train.tsv")
test_file = File.open("test.tsv")

train_array = []
train_tags = []
train_file.each do |line|
    seperate = line.split("\t")
    train_array << seperate[1]
    train_tags << seperate[0]
end
test_array = []
test_file.each do |line|
  test_array << line
end
### accuracy checker
def targeted_accuracy_checker(target,correctarray=train_tags,myarray=answers_array,descriptions=train_array,returning = false)
    correct = 0
    overrep = 0
    underrep = 0
    missed_array = []
    myarray.each_with_index do |guess, i|
        if (guess.include?(target) && correctarray[i].include?(target)) || (guess.include?(target) == false && correctarray[i].include?(target) == false)
          correct += 1
        else
          if guess.include?(target) && correctarray[i].include?(target) == false
              overrep += 1
          else
            missed_array << descriptions[i]
              underrep += 1
          end
        end
    end
    puts "#{target} : (O:#{overrep} U:#{underrep}) #{correct}/#{correctarray.length} #{(100*(correct.to_f/correctarray.length)).round}%"
    if returning
      puts missed_array[150]
    end
end

def all_accuracy_checker(correctarray=train_tags,myarray=answers_array,descriptions=train_array)
    array = ["part-time-job","full-time-job","hourly-wage","salary","associate-needed","bs-degree-needed",
      "ms-or-phd-needed","licence-needed","1-year-experience-needed","2-4-years-experience-needed","5-plus-years-experience-needed","supervising-job"]
    array.each do |tag|
      targeted_accuracy_checker(tag,correctarray,myarray,descriptions)
    end
end

def overall_correct_lines(correctarray=train_tags,myarray=answers_array,descriptions=train_array)
    correct = 0
    myarray.each_with_index do |guess,i|
        comp_array = correctarray[i].split(" ").sort
        concated = guess.split(" ") & comp_array
        concated = concated.sort
        if concated == comp_array
          correct += 1
        end
    end
    puts "Overall : #{correct}/#{correctarray.length} #{(100*(correct.to_f/correctarray.length)).round}%"
end
### keyword checker
def keyword_checker(keywords, tline)
    lowestindex = tline.length
    keywords.each do |word|
      if tline.include?(word)
          if tline.index(word)< lowestindex
            lowestindex = tline.index(word)
          end
      end
    end
    return lowestindex
end
### money checker (for hourly vs salary)
def money_checker( tline)
    tline = tline.split(" ")
    tline.each_with_index do |word, i|
      if word.include?("$") && tline[i+1] != "million" && word.include?("million") == false
            money = word.split('-')[0].gsub(/[^0-9.]/, "").to_f
            money *= 1000 if word.include?("k")
            tline[i] = "hour_tag" if money < 100 && money != 0
            tline[i] = "sal_tag" if money > 20000
      end
    end
    return tline.join(" ")
end
### supervising checker (tested: not implemented)
def supervising_checker(keywords, tline)
    lowestindex = tline.length
    counter = 0
    keywords.each do |word|
      counter += tline.scan(/(?=#{word})/).count
      if counter > 2
        lowestindex = 1
      end
    end
    return lowestindex
end
### keywords arrays
part_time_words = ["part time","part-time","20 hours per week", "parttime", "hiring seasonal", "20 hours a week"]
full_time_words = ["full time","full-time","30+ hours per week", "a career", "work core hours", "4 day work week", "fulltime",
                    "32 hours per week", "40 hours per week", " 40-hr", "40/hr", "monday-friday", "monday - friday"]

hourly_wage_words = ["per hour","per hr", "hourly","/hr","hours/wk", "/hour", "an hour", "hour_tag"]
salary_words = ["starting salary", "salary of","competitive salary", "base salary", "salary requirements", "5k", "salary based", "salary",
                  "sal_tag", "salary expectations"]

associate_words = ["associate's degree", "associate’s degree", "associate degree", "associates or", "two-year degree", "two-year college",
                    "associates degree", "aa degree", "bachelors or associates degree"]
bs_words = ["ba required", "ba needed", "bachelor's degree","bachelor’s degree", "bachelor degree", "college degree",
            "bs/ba degree", " ba,", " ba ", "bachelors degree", "b.s.", "bachelor", " degree in", "four-year degree",
          "four-year college", "bs degree", "bs required", "masters preferred", "b.a."]
ms_phd_words = ["masters degree","master's degree","master’s degree","phd", "top academic credentials", "must have a master's"]
license_words = ["technical degree","licence needed","licence required"," license "," license.", "license,", "class a cdl", "ceritication",
                  "certification required", "cdl-a", "certification needed", "bar admission", "credentials", "registered nurse", "a rn", "licensed",
                "valid licensure", " bsn ", " bicsi ", "nurse practitioner", " cpc ", " ahima ", " cna "]

year_1_words = ["1 to 2 years", "1 year","1-2 years", "one year", "one or more years", "a year or more", "(1) year", "1+ year", " one to ", " 1 to "]
year_2_4_words = ["3 years","3+ years", "4 years","2 years", "2+ years", "-5 years", "to 5 years","two years", "three years", "four years", "3 yrs",
                  "(3) years", "(2) years", "(4) years", "4+ years", "two-years", "three-years", "four-years", "3 plus years", "2 plus years", "4 plus years",
                "4-6 years", "2 or more years", "- 5 years", "4-6 yrs", "2yrs", "three-plus years", "2-6+ years"]
year_5_words = ["5 years","5+ years","5 or more years","six plus years","10 years", "five years", "(5) years", "(8+) years", "6 years", "7 years",
                "10+ years", "five or more years", "7+ years", "6+ years", "8+ yrs.", "(8-10) years", "(10) years", "(6) years", "(7 years)",
              "5+ year", "8+ years"]

supervising_words = ["supervising","overseeing","oversees","strategic leadership", "directing", "strategize with", "property manager",
                    "marketing manager", "/project manager", "restaurant manager", "development manager", "staff supervision", "leadership",
                  "administer employee", "media manager", "marketing lead", "activity director", "manager"]

problematic_words = ["driver’s license","hourly pay rate or salary level","full or part-time", "part-time and full-time", "part or full-time",
                      "after 5 years","leadership skills","and hourly associates", "business for 10 years", "25 years old", "part time or full time",
                    "leadership abilities", "part and full time", "for more than 10 years", "violations in last two years", "driver's license",
                     "to one year", "driver license", "within the last 2-3 years", "12 years", "over the past 2 years", "in the past 2 years"]

### run through data
answers_array = []
answers_array << "tags"
test_array[1..-1].each_with_index do |line, i|
    current_tags = ""
    line = line.force_encoding 'utf-8'
    line = line.downcase
    ### remove problematic phrases
    problematic_words.each do |word|
      line.gsub!(word, '')
    end
    line = money_checker(line)

    #part time vs full time
    pti = keyword_checker(part_time_words, line)
    fti = keyword_checker(full_time_words, line)
    if pti < fti || pti != line.length
      current_tags += "part-time-job "
    elsif fti < pti
      current_tags += "full-time-job "
    end
    #hourly wage vs salary
    hwi = keyword_checker(hourly_wage_words, line)
    si = keyword_checker(salary_words, line)
    if hwi < si
      current_tags += "hourly-wage "
    elsif si < hwi
      current_tags += "salary "
    end
    #degree and license
    degree_comp_array = [keyword_checker(license_words, line),keyword_checker(associate_words, line),keyword_checker(bs_words, line),keyword_checker(ms_phd_words, line)]
    min = degree_comp_array.min
    if min != line.length
      i = degree_comp_array.index(min)
      if i == 0
          current_tags += "licence-needed "
      elsif i == 1
          current_tags += "associate-needed "
      elsif i == 2
          current_tags += "bs-degree-needed "
      elsif i == 3
          current_tags += "ms-or-phd-needed "
      end
    end
    #years experience needed
    years_comp_array = [keyword_checker(year_1_words, line),keyword_checker(year_2_4_words, line),keyword_checker(year_5_words, line)]
    min = years_comp_array.min
    if min != line.length
      i = years_comp_array.index(min)
      if i == 0
          current_tags += "1-year-experience-needed "
      elsif i == 1
          current_tags += "2-4-years-experience-needed "
      elsif i == 2
          current_tags += "5-plus-years-experience-needed "
      end
    end
    #supervising?
    supi = keyword_checker(supervising_words, line)
    if supi < line.length
      current_tags += "supervising-job "
    end
    #clean up
    if current_tags == ''
      current_tags = " "
    else
      current_tags.chop
    end
    answers_array << current_tags
end

### sample lines
# answers_array[40..60].each_with_index do |line,i|
#    puts "#{i+41}"+line
# end
### check accuracy
# all_accuracy_checker(train_tags,answers_array,train_array)
# overall_correct_lines(train_tags,answers_array,train_array)
# targeted_accuracy_checker("bs-degree-needed",train_tags,answers_array,train_array,true)

### write the CSV file
File.open("tags.tsv", "w") do |csv|
    csv.write(answers_array.join("\n"))
end






#
