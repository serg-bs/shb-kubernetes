# helm Chart for SHB project

## Пререквизты
1. Установить minikube для запуска kubernetes локально
2. `sudo snap install helm --classic` - установить helm
3. `helm init` - для утановки клиента и сервера helm


## Полезные команды
1. `helm install ./chart-shb/` - установка чартов
2. `helm upgrade --install test ./chart-shb/` - обновление либо установка чарта с именем test 
3. `helm install --set shb-back.image.tag=KUBE-1.0.0.19 ./chart-shb/` пример передачи параметра
