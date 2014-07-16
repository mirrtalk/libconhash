
# output path
BIN = ./bin
SRC = ./src

# debug stuff 
ifeq ($(CFLAG), DEBUG)
	CFLAGS += -g
endif

AR  = ar -cqs
# itermidiate objects
OBJ = $(addprefix $(BIN)/, \
	  md5.o \
	  util_rbtree.o  \
	  conhash_inter.o \
	  conhash_util.o  \
	  conhash.o \
	  )

SAMPLE_OBJS = $(addprefix $(BIN)/, \
		sample.o \
		)
		
# include file path
INC = -I$(SRC)

TARGETS = $(BIN)/libconhash.a $(BIN)/sample
 
all: clean prepare $(TARGETS)

# build libconhash as a static lib 
$(BIN)/libconhash.a: $(OBJ) 
	$(AR) $@ $(OBJ)
	
# build sample
$(BIN)/sample: $(SAMPLE_OBJS)
	gcc -O -o $@ $(SAMPLE_OBJS) -L. -L$(BIN) -lconhash

	
$(BIN)/%.o: $(SRC)/%.c
	gcc $(INC) $(CFLAGS) -c $< -o $@	

# prepare the bin dir	
prepare: 
		-mkdir $(BIN)
	  
clean:
		-rm -rf $(BIN)

.PHONY: all prepare clean
