
ARTICLES = $(wildcard [1-9]*) about
INCS = head.inc foot.inc

ALL = index.html $(ARTICLES:%=%/index.html) feed.rss

all: $(ALL)

head.inc: head.inc.in config.sh
	sh replace_config.sh $< $@

index.html: $(ARTICLES) $(INCS) index.sh
	sh index.sh > $@.tmp && mv $@.tmp $@

%/index.html: %/src.txt $(INCS) article.sh config.sh
	sh article.sh $(subst /index.html,,$@) < $< > $@.tmp && mv $@.tmp $@

feed.rss: $(ARTICLES) feed.sh
	sh feed.sh > $@.tmp && mv $@.tmp $@

clean:
	rm -f $(ALL) head.inc
