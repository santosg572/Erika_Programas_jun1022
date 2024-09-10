nombres = list.files(pattern = 'data')

res = lapply(nombres, read.csv, header=F)

data = res[[1]]

n = length(nombres)

#for (i in 2:n){
	data = rbind(res)
#}

print(data)
