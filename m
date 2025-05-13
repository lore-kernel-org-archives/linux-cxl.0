Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84734A08
	for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152069; cv=none; b=R6m5WB/AlYUfQ902oiWEWSe8d9dTR8Y7jGAd6UCjIBIYJ/bqNwVb64Q+6TX4aQZyG0oAtNAD60CdhCBh/9uxGz4rJa7RWBwg89FtELWGv/IXO+DFtDKG5fGbe9L63yu+hhZD9r2i8d1UIGYuZgcteYVFAOdDh7D5LrsdXsuedeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152069; c=relaxed/simple;
	bh=lw7lBRyL5sfKKYS9w50lBwFnT4MV+3RgXOmFrrPFLYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvVq21RPlC0Sm8icThIZEifCcnPTnr4OHYzo06mMwhrlYOtFzxdEdvttuImlc+DHmT+9VLVuhtdQaL5wrWKuy3n5SfMnJ6IQ/TFI01RwclCXRoynY2qwJ3+wmWdYaNZb2FPvKJtJkJteUmvbg2M69qPbqZiaYSKGD7ahBMfqFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=YqW3iH8x; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="YqW3iH8x"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c56a3def84so615959785a.0
        for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747152066; x=1747756866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DKPHcYPz3lvrfO7MN3KJaDbFeEqr0QNii/X/LTWXV9I=;
        b=YqW3iH8xpb63WmmrUh593kX2jdMtQYyJyhkd3RJH3n9DXoAq7x65VltyiuSmXaeWhd
         ZEH0pW+hgyCWwdRUdPy4sH1CtBm+8XhYz17WPIRRxm/2xQlOSUEL94IQWXV/SvVZtS6w
         2mqhAuT//EdD2MY9tCPPKCIMGN0mAhv6oP++QghLLmHr65BgzK2HNfZZDUa3VfqrAgZK
         wO/TDeKW2WhFSK+d5HsAJ6tRdsF1Se1CHMuq96xkWENGxVYe9VM9FlLZ5QX6UwKXnUyv
         V4R6ZvOlzaVhbe30gRGjecT4I8dLxcSiJyf+nqoAWfBGS19r7xE/BFe/LlBX65uswF9f
         W88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747152066; x=1747756866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKPHcYPz3lvrfO7MN3KJaDbFeEqr0QNii/X/LTWXV9I=;
        b=HZQJlpdxmRuhILXOsJ/kovL7F9jdLncZlpJJVKkCzJGUrB/2TyMkf0DZwEifb/4tZg
         CUMqnvPN+99OJvNz/ruGOur8o8QrPgUfb6XVhC+s1TsAq4m88ktRjejnOdxTBVfy+qy0
         YEeiNDsNH3nJQVv13c/oi4WeaQAAnsRPf4GlO6lpnddP5zDLUpNGaj3DIkxxjCir3Vvs
         inLQgaVDgg+0e8YrbmB1acvfrPA2vdG3mn3xsyxRMVvFVj58rJRFmqBVC1vsF1iFOc6h
         kpf4vIOvKWXhYFAZ63jOcpXh42KBSF0CU8BqMoCRfMRF5C+KxIeEzEMuPPLk5foieZeC
         xK2A==
X-Gm-Message-State: AOJu0Ywtfu66B5vgQ0zxXDWfbW+lrOHSPW44E95W5EC9bcbQv2o0zXMb
	xxm16IL0iH5E3vdgjDx8v+Z/TZgQ64ywv02oj7JPmIylKVwimrGTaNtCR1idO2w=
X-Gm-Gg: ASbGncsMscKeQ1xKg2iG9SB2ve+QuA3iXZPUvM3Xc+9cbuL1HUlkN3Rg/Q9+Q45f3hh
	n+akkssHxzwFoJLRMNH30gxs/7jLKQhcegs7Rds8dPJFk0HuDd0RMJiVzqVxojXa3SM6HA4V2Vh
	8px8CbSRdbYisdIUC1mwZ9S/iwtf/f41eYiVMlsef89qKwF9Xg2bZPInkbf0cHnQA369jE9Pup7
	LMgNEqryhAmtCfdPUDiZrV3CRa0wh0REjHc/UdHdzkjDnSPd86hCRqZ5MFC1alkqH7aNRoqPWZi
	gK1O1jPqn/e7M6aQx/UPoGJ4Mtztv6/K9kY88gkMZ6ccTS7AKNlOG0PtpjKWiKXjogFioLB850s
	SvaC7MwNveBYYrEyjVvkPadnsC/nFc6U=
X-Google-Smtp-Source: AGHT+IEkOryOB8Mv36gJEPtcnJS5hBnwWOG+RB2K1lF1BcBa0HgGhhl608n/2RM/VtHACPfsbcwk9g==
X-Received: by 2002:a05:620a:298a:b0:7c8:e67b:8076 with SMTP id af79cd13be357-7cd2886f72bmr9443085a.50.1747152065552;
        Tue, 13 May 2025 09:01:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd00fe61edsm712311785a.106.2025.05.13.09.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 09:01:05 -0700 (PDT)
Date: Tue, 13 May 2025 12:01:03 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com, rrichter@amd.com,
	ming.li@zohomail.com
Subject: Re: [PATCH v2 09/10] cxl: Create an xarray to tie a host bridge to
 the cxl_root
Message-ID: <aCNsvxuftgUlFvoG@gourry-fedora-PF4VCD3F>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-10-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507004310.3536991-10-dave.jiang@intel.com>

On Tue, May 06, 2025 at 05:43:09PM -0700, Dave Jiang wrote:
> Add helper functions to setup association of a host bridge device to a
> related cxl_root. Functions are in preparation to support the moving
> of host bridge ports creation from cxl_acpi to cxl_memdev probe path.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

mostly wording/naming nits.

I think "udev" is a bad naming choice, but i don't know what to replace
it with.  Most of the scenarios below are host-bridge-uport specifical,
so maybe like "hbup" (actually no, hbup is ugly, but you get the point).

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 259b217e812f..a5a673d789f3 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
>  
> +/**
> + * cxl_udev_to_root - Retrieve cxl_root tied to the host bridge device
> + * @uport_dev: upstream port device that is the host bridge
                  "The host bridge's uport device connect to the root" ?

maybe instead of uport_dev, maybe hb_uport_dev? If this interface is
only intended to be used specifically with hb_uport.  This is a nit,
ignore it if you want.

> + *
> + * Return cxl_root on success or NULL on failure
> + *
> + * A reference is taken on the port device. Caller needs to call put_device()
> + * when done.
> + */
> +struct cxl_root *cxl_udev_to_root(struct device *uport_dev)

udev_to_root implies you can call this with any uport_dev.
hb_uport_to_root?

Functionality is fine.

> +{
> +	struct cxl_root *root;
> +
> +	root = xa_load(&cxl_root_ports, (unsigned long)uport_dev);
> +	if (!root)
> +		return NULL;
> +
> +	get_device(&root->port.dev);
> +
> +	return root;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_udev_to_root, "CXL");
> +
> +/**
> + * devm_cxl_register_udev_root_port - Tie a hostbridge device to a root port

Similar naming questions as above.

At this point i'm a bit convinced "udev" is not what we want.

> + * @host: device that hosts the memory for the xarray entries
> + * @uport_dev: host bridge device that serves as the xarray index
> + * @root: cxl_root that serves as the xarray entry data
> + *
> + * Return 0 on success or -errno on failure.
> + */
> +int devm_cxl_register_udev_root_port(struct device *host,
> +				     struct device *uport_dev,
> +				     struct cxl_root *root)
> +{
> +	int rc;
> +
> +	rc = xa_insert(&cxl_root_ports, (unsigned long)uport_dev, root,
> +		       GFP_KERNEL);
> +	if (rc)
> +		return rc;
> +
> +	return devm_add_action_or_reset(host, unregister_udev_root_ports,
> +					uport_dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_register_udev_root_port, "CXL");
> +
>  bool dev_is_cxl_root_child(struct device *dev)
>  {
>  	struct cxl_port *port, *parent;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 22f1a9542077..e0cba91803cc 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -736,6 +736,10 @@ struct pci_bus;
>  int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
>  			      struct pci_bus *bus);
>  struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port);
> +int devm_cxl_register_udev_root_port(struct device *host,
> +				     struct device *uport_dev,
> +				     struct cxl_root *root);
> +struct cxl_root *cxl_udev_to_root(struct device *uport_dev);
>  struct cxl_port *devm_cxl_add_port(struct device *host,
>  				   struct device *uport_dev,
>  				   resource_size_t component_reg_phys,
> -- 
> 2.49.0
> 
