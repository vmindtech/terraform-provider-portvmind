package main

import (
	"context"
	"flag"
	"log"

	tfprovider "github.com/hashicorp/terraform-plugin-framework/provider"
	"github.com/hashicorp/terraform-plugin-framework/providerserver"

	vkeprovider "github.com/vmindtech/terraform-provider-vke/internal/provider"
)

func main() {
	var debug bool
	flag.BoolVar(&debug, "debug", false, "Enable Terraform provider debug logging")
	flag.Parse()

	opts := providerserver.ServeOpts{
		Address: "registry.terraform.io/vmindtech/vke",
		Debug:   debug,
	}

	err := providerserver.Serve(context.Background(), func() tfprovider.Provider {
		return vkeprovider.New()
	}, opts)
	if err != nil {
		log.Fatal(err)
	}
}
