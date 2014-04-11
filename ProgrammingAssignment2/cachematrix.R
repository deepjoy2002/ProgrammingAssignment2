#Matrix inversion is usually a costly computation and their may be some benefit 
#to caching the inverse of a matrix rather than compute it repeatedly  
#In this assignment the aim is to write a pair of functions that cache the inverse of 
#a matrix.


##makeCacheMatrix function creates a special "matrix" object that can cache its inverse.
makeCacheMatrix <- function(x = matrix()) {
  # 'inv' variable will store the cached inverse of the matrix
  # Initialize 'inv' to be zero
  inv <- NULL
  
  # Define 'set' function that can be used to set the value of input matrix
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  
  # Define 'get' function that can be used to get the value of input matrix
  get <- function() x
  
  # Define 'setinv' function that can be used to cache the value of inverse
  setinv <- function(solve) inv <<- solve
  
  # Define 'getinv' function that can be used to get the cached value of inverse
  getinv <- function() inv
  
  
  # Return the list containing the four functions defined above
  list(set = set, get = get,
       setinv = setinv,
       getinv = getinv)
}


## cacheSolve function computes the inverse of the special "matrix" returned by 
##makeCacheMatrix above. If the inverse has already been calculated (and 
##the matrix has not changed), then the cachesolve should retrieve the 
##inverse from the cache.
cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  
  # Get cached value of the inverse
  inv <- x$getinv()
  
  # If inv is not NULL, then the input matrix has not changed and the inv
  # contains the cached value of the matrix, then return inv
  if(!is.null(inv)) {
    message("getting cached data")
    return(inv)
  }
  
  # Get the latest value of the input matrix for calculating inverse
  data <- x$get()
  
  # Solve the matrix for inverse and save the value of inverse in 'inv'
  inv <- solve(data, ...)
  
  # Cache the new value of inverse
  x$setinv(inv)
  
  # Return the updated value of inverse
  inv
}
