package main

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestProxyHandler(t *testing.T) {
	w := httptest.NewRecorder()
	r, err := http.NewRequest("GET", "/foo/bar", nil)
	if err != nil {
		t.Fatalf("Error making a HTTP request [%s]", err)
	}
	handler := ProxyHandler()
	handler.ServeHTTP(w, r)
	if w.Code != http.StatusOK {
		t.Fatalf("expected code %d, got %d", http.StatusOK, w.Code)
	}
	body := string(w.Body.Bytes())
	if len(body) == 0 {
		t.Fatalf("expected non-empty response body")
	}
}
