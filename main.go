package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
	"net/http/httputil"
	"net/url"
	"os"
)

var server *http.Server

type Handler struct {
	appPath, apiPath, proxyHeader string
}

func director(u *url.URL) func(*http.Request) {
	return func(r *http.Request) {
		r.URL.Scheme = u.Scheme
		if r.URL.Scheme == "" {
			r.URL.Scheme = "https"
		}
		r.URL.Host = u.Host
		log.Printf("Directing to %+v: %+v", u, r)
	}
}

func proxy(url *url.URL) *httputil.ReverseProxy {
	return &httputil.ReverseProxy{
		Director: director(url),
	}
}

func (h *Handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	if hosts, found := r.Header["X-Proxymate-Host"]; found {
		for _, host := range hosts {
			u, err := url.Parse(host)
			if err == nil {
				upstream := proxy(u)
				upstream.ServeHTTP(w, r)
				return
			}
			log.Printf("Invalid URL %q: %e", host, err)
		}
		log.Printf("No hosts responded (%v)", hosts)
		http.Error(w, "No hosts responded", 504)
		return
	}
	http.NotFound(w, r)
}

func init() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8899"
	}
	server = new(http.Server)
	server.Handler = &Handler{}
	flag.StringVar(&server.Addr, "p", fmt.Sprintf(":%s", port), "TCP bind address")
}

func main() {
	flag.Parse()
	log.Printf("proxymate listening on %s\n", server.Addr)
	log.Fatal(server.ListenAndServe())
}
