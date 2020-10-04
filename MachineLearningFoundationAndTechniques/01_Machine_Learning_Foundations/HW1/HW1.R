
# HW1: Q15

dat <- read.table("hw1_15_train.dat", header=FALSE)

weight <- rep(0, 5)
X <- cbind(rep(1, nrow(dat)), as.matrix(dat[, 1:4]))
Y <- as.vector(dat[, 5])

pla <- function(X, Y, weight_init, eta=1) {
    update <- 0
    weight <- weight_init
    yhat <- rep(0, nrow(X))
    while (any(sign(yhat) != Y)) {
        for (j in 1:nrow(X)) {
            yhat[j] <- X[j, ] %*% weight
            if (yhat[j] == 0) {
                yhat[j] <- -1
            }
            if (sign(yhat[j]) != Y[j]) {
                weight <- weight + X[j, ] * Y[j] * eta
                update <- update + 1
            }
        }
    }
    return (update)
}

pla(X, Y, weight)


# HW1: Q16

updates <- rep(0, 2000)
for (i in 1:2000) {
    set.seed(i)
    ind <- sample(1:nrow(X), nrow(X), replace=FALSE)
    X <- X[ind, ]
    Y <- Y[ind]
    weight <- rep(0, 5)
    updates[i] <- pla(X, Y, weight)
}
mean(updates)


# HW1: Q17

updates <- rep(0, 2000)
for (i in 1:2000) {
    set.seed(i)
    ind <- sample(1:nrow(X), nrow(X), replace=FALSE)
    X <- X[ind, ]
    Y <- Y[ind]
    weight <- rep(0, 5)
    updates[i] <- pla(X, Y, weight, 0.5)
}
mean(updates)


# HW1: Q18

train <- read.table("hw1_18_train.dat", header=FALSE)
test <- read.table("hw1_18_test.dat", header=FALSE)

weight <- rep(0, 5)
X <- cbind(rep(1, nrow(train)), as.matrix(train[, 1:4]))
Y <- as.vector(train[, 5])
X_test <- cbind(rep(1, nrow(test)), as.matrix(test[, 1:4]))
Y_test <- as.vector(test[, 5])

pocket <- function(X, Y, weight_init, eta=1, update_time=50) {
    
    weight <- newweight <- weight_init
    mistake_old <- nrow(X)
    update <- 0
    yhat <- as.vector(ifelse(X %*% weight == 0, -1, X %*% weight))
    
    while (update <= update_time) {
        
        posi <- which(sign(yhat) != Y)
        if (length(posi) > 0) {
            
            j <- sample(posi, size=1)
            newweight <- newweight + X[j, ] * Y[j] * eta
            yhat <- as.vector(ifelse(X %*% newweight == 0, -1, X %*% newweight))
            mistake_new <- sum(sign(yhat) != Y)
                
            if (mistake_new < mistake_old) {
                weight_pocket <- newweight
                mistake_old <- mistake_new
            }
            
            update <- update + 1
            
        }
        
    }
    
    return (weight_pocket)
}


errorrate <- rep(0, 2000)

for (i in 1:2000) {
    set.seed(i)
    ind <- sample(1:nrow(X), nrow(X), replace=FALSE)
    X <- X[ind, ]
    Y <- Y[ind]
    weight <- rep(0, 5)
    newweight <- pocket(X, Y, weight)
    
    yhat_new <- as.vector(ifelse(X_test %*% newweight == 0, -1, X_test %*% newweight))
    errorrate[i] <- sum(sign(yhat_new) != Y_test)/nrow(X_test)

}
mean(errorrate)


# HW1: Q19


pocket_1 <- function(X, Y, weight_init, eta=1, update_time=50) {
    
    weight <- newweight <- weight_init
    mistake_old <- nrow(X)
    update <- 0
    yhat <- as.vector(ifelse(X %*% weight == 0, -1, X %*% weight))
    
    while (update <= update_time) {
        
        posi <- which(sign(yhat) != Y)
        if (length(posi) > 0) {
            
            j <- sample(posi, size=1)
            newweight <- newweight + X[j, ] * Y[j] * eta
            yhat <- as.vector(ifelse(X %*% newweight == 0, -1, X %*% newweight))
            
            update <- update + 1
            
        }
        
    }
    
    return (newweight)
}


errorrate <- rep(0, 2000)

for (i in 1:2000) {
    set.seed(i)
    ind <- sample(1:nrow(X), nrow(X), replace=FALSE)
    X <- X[ind, ]
    Y <- Y[ind]
    weight <- rep(0, 5)
    newweight <- pocket_1(X, Y, weight)
    
    yhat_new <- as.vector(ifelse(X_test %*% newweight == 0, -1, X_test %*% newweight))
    errorrate[i] <- sum(sign(yhat_new) != Y_test)/nrow(X_test)
    
}
mean(errorrate)


# HW1: Q20

errorrate <- rep(0, 2000)

for (i in 1:2000) {
    set.seed(i)
    ind <- sample(1:nrow(X), nrow(X), replace=FALSE)
    X <- X[ind, ]
    Y <- Y[ind]
    weight <- rep(0, 5)
    newweight <- pocket(X, Y, weight, update_time=100)
    
    yhat_new <- as.vector(ifelse(X_test %*% newweight == 0, -1, X_test %*% newweight))
    errorrate[i] <- sum(sign(yhat_new) != Y_test)/nrow(X_test)
    
}
mean(errorrate)
