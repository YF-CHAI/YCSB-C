CC=g++
CFLAGS=-std=c++11 -Wall -pthread -I./
LDFLAGS= -L/home/basicthinker/Projects/sitevm_dune-master/bin -L/home/basicthinker/Projects/dune/libdune -lpthread -ltbb -lsitevm -ldune
SUBDIRS=core db
SUBSRCS=$(wildcard core/*.cc) $(wildcard db/*.cc)
SVMSRCS=$(wildcard db/*.cpp)
OBJECTS=$(SUBSRCS:.cc=.o) $(SVMSRCS:.cpp=.o)
EXEC=ycsbc

all: $(SUBDIRS) $(EXEC)

$(SUBDIRS):
	$(MAKE) -C $@

$(EXEC): $(wildcard *.cc) $(OBJECTS)
	$(CC) $(CFLAGS) $^ $(LDFLAGS) -o $@

clean:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir $@; \
	done
	$(RM) $(EXEC)

.PHONY: $(SUBDIRS) $(EXEC)
