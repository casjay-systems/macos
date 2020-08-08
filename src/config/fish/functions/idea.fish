function idea -d "Record an idea"
    hg -R ~/.plan pull -u
    echo $argv >> ~/.plan/IDEAS.txt
    hg -R ~/.plan ci -m 'Update'
    hg -R ~/.plan push
    hg -R ~/.plan push git
end
