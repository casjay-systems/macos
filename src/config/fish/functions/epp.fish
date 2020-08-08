function epp -d "Edit personal .plan"
    switch (hostname)
    case alephnull
        cd ~/.personal-plan
    case '*'
        cd ~/.plan
    end

    hg pull -u
    vim README.markdown
    hg ci -m 'Update'
    hg pa
    cd -
end
