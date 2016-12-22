# Network Data Visualized
# Facebook, data nodes and graphs

edges = read.csv("edges.csv")
users = read.csv("users.csv") 
str(edges)
str(users)
table(users$locale, users$school)
table(users$gender, users$school)

library(igraph)
g = graph.data.frame(edges, FALSE, users)
plot(g, vertex.size=5, vertex.label=NA)

# degree gives the connections
table(degree(g))

# Changiong the size of nodes based on degree
V(g)$size = degree(g)/2+2
plot(g, vertex.label=NA)

# colouring based on gender
V(g)$color = "black"
V(g)$color[V(g)$gender == "A"] = "red"
V(g)$color[V(g)$gender == "B"] = "light blue"
plot(g, vertex.label=NA)

# based on school
V(g)$color = "black"
V(g)$color[V(g)$school == "A"] = "red"
V(g)$color[V(g)$school == "AB"] = "light blue"
plot(g, vertex.label=NA)

# locale based
V(g)$color = "black"
V(g)$color[V(g)$locale == "A"] = "red"
V(g)$color[V(g)$locale == "B"] = "light blue"
plot(g, vertex.label=NA)
