# ⚜️ FinchCore

Разработки для работы с core компонентами.

## 🛠 Установка

Встраивается в проект приложения как submodule

[Как добавить submodule в проект](https://www.notion.so/finchmoscow/submodule-98e7f8b8ed0542949d4c793590ffcc25)

## ⚡️ Список компонентов

### InternetConnectionReachability сервис

[InternetConnectionReachability сервис](https://git.finch.fm/frameworks/finchcore/-/tree/master/FinchCore/Core/InternetConnectionReachability) - сервис для отслеживания статуса подключения к сети интернет. Состоит из:

#### InternetConnectionReachability

[InternetConnectionReachability](https://git.finch.fm/frameworks/finchcore/-/blob/master/FinchCore/Core/InternetConnectionReachability/InternetConnectionReachability.swift) - сущность, которая следит за reachability flags и в случае их изменения рассылает notification со значением статуса подключения к сети интернет через NotificationCenter по специальному имени уведомления. (Используется [InternetConnectionReachabilityCenter](https://git.finch.fm/frameworks/finchcore/-/blob/master/FinchCore/Core/InternetConnectionReachability/InternetConnectionReachabilityCenter.swift)'ом).

#### InternetConnectionReachabilityCenter

[InternetConnectionReachabilityCenter](https://git.finch.fm/frameworks/finchcore/-/blob/master/FinchCore/Core/InternetConnectionReachability/InternetConnectionReachabilityCenter.swift) - singleton, который отвечает за создание внутри себя единственного соединения [InternetConnectionReachability](https://git.finch.fm/frameworks/finchcore/-/blob/master/FinchCore/Core/InternetConnectionReachability/InternetConnectionReachability.swift) по 'всегда' доступному адресу www.google.com. Для запуска тестирования соединения и рассылки уведомлений, необходимо при старте приложения в AppDelegate в методе didFinishLaunchingWithOptions вызвать InternetConnectionReachabilityCenter.shared.startTrackingInternetConnectionReachability().

#### InternetConnectionReachabilityHandler

[InternetConnectionReachabilityHandler](https://git.finch.fm/frameworks/finchcore/-/blob/master/FinchCore/Core/InternetConnectionReachability/InternetConnectionReachabilityHandler.swift) - обработчик уведомлений [InternetConnectionReachability](https://git.finch.fm/frameworks/finchcore/-/blob/master/FinchCore/Core/InternetConnectionReachability/InternetConnectionReachability.swift) о смене статуса подключения к сети интернет. Необходимо нужный controller подписать под протокол InternetConnectionReachabilityHandlerDelegate и создать InternetConnectionReachabilityHandler отдав в делегата controller.

### GraphQLClient

Позволяет быстро втянуть GraphQL в проект, для этого вам надо: 

1) прописать скрипт в  Build Phases

        SCRIPT_PATH="${PODS_ROOT}/Apollo/scripts"
         cd "${SRCROOT}/${TARGET_NAME}"
            "${SCRIPT_PATH}"/run-bundled-codegen.sh codegen:generate --target=swift --includes=./**/*.graphql --passthroughCustomScalars --localSchemaFile="$SRCROOT/Stoloto/API/GraphQL/Core/Schema/schema.json"  $SRCROOT/Stoloto/API/GraphQL/Core/API.swift
            
    #### --localSchemaFile= если схема загружена явно, указываем путь к ней
    
    если схему надо грузить по определенному запросу 
        
        SCRIPT_PATH="${PODS_ROOT}/Apollo/scripts"
        cd "${SRCROOT}/${TARGET_NAME}"
        "${SCRIPT_PATH}"/run-bundled-codegen.sh schema:download --endpoint=https://sberzvuk-app.dev.finch.fm/api/v1/gateway/graphql ${SRCROOT}/SberSound/Core/GraphQL/Core/Schema/schema.json
        "${SCRIPT_PATH}"/run-bundled-codegen.sh codegen:generate --target=swift --includes=./**/*.graphql --passthroughCustomScalars --localSchemaFile="$SRCROOT/SberSound/Core/GraphQL/Core/Schema/schema.json"  $SRCROOT/SberSound/Core/GraphQL/Core/API.swift

    #### --endpoint= путь к вашей схеме
    #### --localSchemaFile= должен быть такой же путь куда сохраняли при загрузке

2) Добавляем с .gitignore  файлы API.swift - он автогенерируется и schema.json  если она доступна по запросу

3) Добавляем необходимые Query их надо просить у бека

4) создаем модельку и реализуем Decodable 

5) получаем в completionHandler'e вашу модельку или ошибку. 

6) нежелательно использовать GraphQLClient  в своем проекте напрямую. 

7) [Документация по GraphQL](https://graphql.org/learn/) 

