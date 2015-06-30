app_frontend() { cd "$APP_FRONTEND_HOME"; }
app_frontend_baixar() { baixar-app_frontend; }
app_frontend_remote_add_upstream() { 
    (app_frontend && git remote add upstream http://github.com/pensandoodireito/sislegis-app-frontend)
}

# vim: set ts=4 sw=4 expandtab:
