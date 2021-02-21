kbpods() {
	kubectl get pods -n $1
}
kbevents() {
	kubectl get events -n $1
}
kbservices() {
	kubectl get services -n $1
}
kblogs() {
	kubectl logs $(kubectl get pods -n $1 | grep $2 | cut -d " " -f 1) -n $1 -f
}
kbconn() {
	kubectl exec $(kubectl get pods -n $1 | grep $2 | cut -d " " -f 1) -it sh -n $1
}
