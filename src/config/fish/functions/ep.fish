function ep -d "Edit .plan"
    switch (hostname)
    case alephnull
        cd ~/.plan
        nvim README.markdown
        make
        git cm 'Update' -a
        git push origin master
        cd -
    case '*'
        hg -R ~/.plan pull -u
        vim ~/.plan/README.markdown
        hg -R ~/.plan ci -m 'Update'
        hg -R ~/.plan push
        hg -R ~/.plan push git
    end
end
