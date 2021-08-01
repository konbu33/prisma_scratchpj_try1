
helm install pg02 --set postgresqlPassword="postgres" bitnami/postgresql
kubectl port-forward svc/pg02-postgresql 6543:5432 &
psql -h 127.0.0.1 -U postgres -p 6543 

cat ./db.sh | sed -e "s/pg02/pg04/g" | sed -e "s/6543/8765/g"

helm install mysql01 bitnami/mysql
kubectl port-forward svc/mysql01 13306:3306 &
echo Password : $(kubectl get secret --namespace default mysql01 -o jsonpath="{.data.mysql-root-password}" | base64 --decode)
mysql -h 127.0.0.1 -u root -p -P 13306

cat ./db.sh | sed -e "s/mysql01/mysql02/g" | sed -e "s/13306/23306/g"


