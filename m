Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9251E1304BA
	for <linux-cxl@vger.kernel.org>; Mon,  2 Dec 2024 18:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733165785; cv=none; b=MeizGAFZPxh7sA7QKli9Aaq83NRQJ71PcEi4p/MWL0cg79EodSuWw/Sm65oqOKsNltLX5czdMaUhrsT+bDN598/Gl/LPrQw5qBVr0bm9btto1muxdLw6U9SqlXZn+DcuihwK+160BJ5r0ioiAa/5BuqjqtiySzmbjnYWrGpJoMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733165785; c=relaxed/simple;
	bh=p1fpnecATPTxryB9R32qzTD8EuHqEeq9re64Av8FFpA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIbi2fBLa8ECijtrgp1p3/XXjJKm24s2Vv9YWyOy6NB/WbZoyrzSVJJtIYVH7MYnAmvhx1l9kMN/iA4MwyZ3pEKxVXc2N7bCLoQKXbS6ee2u/INL/BnMnToTfMfRkEqEn9YMMUzMbC4RlDesdvyMwRT9FGo2jQrIMP830bLiqcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp7hSHFN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp7hSHFN"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21200c749bfso40328075ad.1
        for <linux-cxl@vger.kernel.org>; Mon, 02 Dec 2024 10:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733165783; x=1733770583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RcYNbvRxmzFdfgrPFRhAAXEwiwJyjG9BESXy0MkNjBQ=;
        b=jp7hSHFNku1kBVm5yIu9qR2FK5cDba7sc7MglGondXwXHEKBWNPp3wxgAibd6OA0cG
         3iT3vz6klFPDoekpxP0y2Dz62kMdkOkQrPHhoUvS4iWgkaE5Sx7Qo/sO8HGVsINqlieX
         d+qjxnF1+kFDK6h09Xwj28Ozx47yErhMXs/bAvOaic1mshrSZsNJ34crJunW9rm9jlbc
         50hoegeTMJG0HFi3N+geiX5gpnN3Hwq433EBDZQEhFSOrsg32xvbWoxMgo3tQ40sAbgH
         eE/bFNugaKczgfxpWyFBa91Lmyowo7bF0uKqea/WqGU7/cVFWEBBGn5sq6P8rQrxAbjS
         lfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733165783; x=1733770583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcYNbvRxmzFdfgrPFRhAAXEwiwJyjG9BESXy0MkNjBQ=;
        b=CdnoazYos+OUp4G5i9wI9ihpWdoJyvLxEsSt6MDrV8GTswFZBZMD1QZ0Hqz4NH0gRX
         7Fn4OSN6jHMHoUU0OhwNKhfpYk/cPws8pdlxSZN5FcKC+rRWDPHPCWyVMPiZzTxeBtvi
         FXKLAwa8uU9Y3QCiLTi4FC9hMFAB5WzP9jtSGVFzxw12c2h0bCu71Y5diNVQVchTxAR5
         sjpBSEjSB7dvU8uOX7af3PKydUmK0Zi4h8TteTNaxvffHKR19hh1weeChj0gxU4kLrfv
         S3bujRqvoglAC7HQYYij2hV7r2ZeXAVu8sii6IcPEk8zH0nqqr8l6rOs0LTtF++yYddq
         B1Sw==
X-Forwarded-Encrypted: i=1; AJvYcCX0gX55POrGW6GFcpyDIl8+VBD+DOtiT8y1X1X4fu3dwKWztDW6hL5CRTSwSpcnkIO6SjSiPGy+L3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8h1WBivQcsk5RSZA2p407cKP2ydP4VrXAvkGTjrC/jUoYgupf
	Fk2+RlhCT36K3P5QzMafxml93svnahUq6Q3rYpDL7SV903t5dXJR3cqFYA==
X-Gm-Gg: ASbGnctf7WE7WMLGKT6Fd9mnNYL798VlCbuegKm84QZz7NkRYauEl0CDhJK5K02BtHQ
	FvMedq709a8wtfJ011NQl5QOivCU6i9QKmzUhle5BRvPazYG2ytukfxdDzC90li6y5GBLRCBg5F
	MdCdFlbc5NckJXLA0jrMz2j12dqkFvAk7UaBnclTIyt9FawU32w36paoD41QVZKgDv+EZMl9En+
	m4YQsygDJksdDOZAk3BpZpOJyQ4UJ4dxZE3/fc/aDILmRu5vkkVcg==
X-Google-Smtp-Source: AGHT+IHLZj6yTSfs9ZXhLJt3U+34O39eJvm4MKiMp3YXnQc3/osEwF077n23jN5W2XDXD5sC7Zk71w==
X-Received: by 2002:a17:902:e884:b0:202:cbf:2d6f with SMTP id d9443c01a7336-21501f6ef31mr241061275ad.57.1733165782665;
        Mon, 02 Dec 2024 10:56:22 -0800 (PST)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f1da4sm81021835ad.12.2024.12.02.10.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 10:56:22 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 2 Dec 2024 18:56:20 +0000
To: Nathan Fontenot <nathan.fontenot@amd.com>
Cc: alison.schofield@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] cxl: Update Soft Reserved resources upon region creation
Message-ID: <Z04C1JDl7N2wES5A@smc-140338-bm01>
References: <20241202155542.22111-1-nathan.fontenot@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202155542.22111-1-nathan.fontenot@amd.com>

On Mon, Dec 02, 2024 at 09:55:42AM -0600, Nathan Fontenot wrote:
> Update handling of SOFT RESERVE iomem resources that intersect with
> CXL region resources to remove the intersections from the SOFT RESERVE
> resources. The current approach of leaving the SOFT RESERVE
> resource as is can cause failures during hotplug replace of CXL
> devices because the resource is not available for reuse after
> teardown of the CXL device.
> 
> The approach is to trim out any pieces of SOFT RESERVE resources
> that intersect CXL regions. To do this, first set aside any SOFT RESERVE
> resources that intersect with a CFMWS into a separate resource tree
> during e820__reserve_resources_late() that would have been otherwise
> added to the iomem resource tree.
> 
> As CXL regions are created the cxl resource created for the new
> region is used to trim intersections from the SOFT RESERVE
> resources that were previously set aside.
> 
> Once CXL device probe has completed ant remaining SOFT RESERVE resources
/ant/any/
> remaining are added to the iomem resource tree. As each resource
> is added to the oiomem resource tree a new notifier chain is invoked
/oiomem/iomem/
> to notify the dax driver of newly added SOFT RESERVE resources so that
> the dax driver can consume them.

In general, the patch is kind of complicated and hard to review for me.
I am wondering if it can be broken down to make it easier to
review.

One minor thing inline.

> 
> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
> ---
>  arch/x86/kernel/e820.c    |  17 ++++-
>  drivers/cxl/core/region.c |   8 +-
>  drivers/cxl/port.c        |  15 ++++
>  drivers/dax/hmem/device.c |  13 ++--
>  drivers/dax/hmem/hmem.c   |  15 ++++
>  drivers/dax/hmem/hmem.h   |  11 +++
>  include/linux/dax.h       |   4 -
>  include/linux/ioport.h    |   6 ++
>  kernel/resource.c         | 155 +++++++++++++++++++++++++++++++++++++-
>  9 files changed, 229 insertions(+), 15 deletions(-)
>  create mode 100644 drivers/dax/hmem/hmem.h
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 4893d30ce438..cab82e9324a5 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1210,14 +1210,23 @@ static unsigned long __init ram_alignment(resource_size_t pos)
>  
>  void __init e820__reserve_resources_late(void)
>  {
> -	int i;
>  	struct resource *res;
> +	int i;
>  
> +	/*
> +	 * Prior to inserting SOFT_RESERVED resources we want to check for an
> +	 * intersection with potential CXL resources. Any SOFT_RESERVED resources
> +	 * that do intersect a potential CXL resource are set aside so they
> +	 * can be trimmed to accommodate CXL resource intersections and added to
> +	 * the iomem resource tree after the CXL drivers have completed their
> +	 * device probe.
> +	 */
>  	res = e820_res;
> -	for (i = 0; i < e820_table->nr_entries; i++) {
> -		if (!res->parent && res->end)
> +	for (i = 0; i < e820_table->nr_entries; i++, res++) {
> +		if (res->desc == IORES_DESC_SOFT_RESERVED)
> +			insert_soft_reserve_resource(res);
> +		else if (!res->parent && res->end)
>  			insert_resource_expand_to_fit(&iomem_resource, res);
> -		res++;
Maybe we can keep the original (res++) here to avoid the noise since it is a
style thing and does not affect what we want to achieve. 

Fan
>  	}
>  
>  	/*
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 21ad5f242875..c458a6313b31 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3226,6 +3226,12 @@ static int match_region_by_range(struct device *dev, void *data)
>  	return rc;
>  }
>  
> +static int insert_region_resource(struct resource *parent, struct resource *res)
> +{
> +	trim_soft_reserve_resources(res);
> +	return insert_resource(parent, res);
> +}
> +
>  /* Establish an empty region covering the given HPA range */
>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  					   struct cxl_endpoint_decoder *cxled)
> @@ -3272,7 +3278,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>  				    dev_name(&cxlr->dev));
> -	rc = insert_resource(cxlrd->res, res);
> +	rc = insert_region_resource(cxlrd->res, res);
>  	if (rc) {
>  		/*
>  		 * Platform-firmware may not have split resources like "System
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index d7d5d982ce69..4461f2a80d72 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -89,6 +89,20 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  	return -ENXIO;
>  }
>  
> +static void cxl_sr_update(struct work_struct *w)
> +{
> +	merge_soft_reserve_resources();
> +}
> +
> +DECLARE_DELAYED_WORK(cxl_sr_work, cxl_sr_update);
> +
> +static void schedule_soft_reserve_update(void)
> +{
> +	int timeout = 5 * HZ;
> +
> +	mod_delayed_work(system_wq, &cxl_sr_work, timeout);
> +}
> +
>  static int cxl_endpoint_port_probe(struct cxl_port *port)
>  {
>  	struct cxl_endpoint_dvsec_info info = { .port = port };
> @@ -140,6 +154,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	 */
>  	device_for_each_child(&port->dev, root, discover_region);
>  
> +	schedule_soft_reserve_update();
>  	return 0;
>  }
>  
> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
> index f9e1a76a04a9..c45791ad4858 100644
> --- a/drivers/dax/hmem/device.c
> +++ b/drivers/dax/hmem/device.c
> @@ -4,6 +4,7 @@
>  #include <linux/module.h>
>  #include <linux/dax.h>
>  #include <linux/mm.h>
> +#include "hmem.h"
>  
>  static bool nohmem;
>  module_param_named(disable, nohmem, bool, 0444);
> @@ -17,6 +18,9 @@ static struct resource hmem_active = {
>  	.flags = IORESOURCE_MEM,
>  };
>  
> +struct platform_device *hmem_pdev;
> +EXPORT_SYMBOL_GPL(hmem_pdev);
> +
>  int walk_hmem_resources(struct device *host, walk_hmem_fn fn)
>  {
>  	struct resource *res;
> @@ -35,7 +39,6 @@ EXPORT_SYMBOL_GPL(walk_hmem_resources);
>  
>  static void __hmem_register_resource(int target_nid, struct resource *res)
>  {
> -	struct platform_device *pdev;
>  	struct resource *new;
>  	int rc;
>  
> @@ -51,15 +54,15 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
>  	if (platform_initialized)
>  		return;
>  
> -	pdev = platform_device_alloc("hmem_platform", 0);
> -	if (!pdev) {
> +	hmem_pdev = platform_device_alloc("hmem_platform", 0);
> +	if (!hmem_pdev) {
>  		pr_err_once("failed to register device-dax hmem_platform device\n");
>  		return;
>  	}
>  
> -	rc = platform_device_add(pdev);
> +	rc = platform_device_add(hmem_pdev);
>  	if (rc)
> -		platform_device_put(pdev);
> +		platform_device_put(hmem_pdev);
>  	else
>  		platform_initialized = true;
>  }
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index 5e7c53f18491..d626b60a9716 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -5,6 +5,7 @@
>  #include <linux/pfn_t.h>
>  #include <linux/dax.h>
>  #include "../bus.h"
> +#include "hmem.h"
>  
>  static bool region_idle;
>  module_param_named(region_idle, region_idle, bool, 0644);
> @@ -123,8 +124,22 @@ static int hmem_register_device(struct device *host, int target_nid,
>  	return rc;
>  }
>  
> +static int dax_hmem_cb(struct notifier_block *nb, unsigned long action,
> +		       void *arg)
> +{
> +	struct resource *res = arg;
> +
> +	return hmem_register_device(&hmem_pdev->dev,
> +				    phys_to_target_node(res->start), res);
> +}
> +
> +static struct notifier_block hmem_nb = {
> +	.notifier_call = dax_hmem_cb
> +};
> +
>  static int dax_hmem_platform_probe(struct platform_device *pdev)
>  {
> +	register_soft_reserve_notifier(&hmem_nb);
>  	return walk_hmem_resources(&pdev->dev, hmem_register_device);
>  }
>  
> diff --git a/drivers/dax/hmem/hmem.h b/drivers/dax/hmem/hmem.h
> new file mode 100644
> index 000000000000..95583b59cef7
> --- /dev/null
> +++ b/drivers/dax/hmem/hmem.h
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#ifndef _HMEM_H
> +#define _HMEM_H
> +
> +typedef int (*walk_hmem_fn)(struct device *dev, int target_nid,
> +			    const struct resource *res);
> +int walk_hmem_resources(struct device *dev, walk_hmem_fn fn);
> +
> +extern struct platform_device *hmem_pdev;
> +
> +#endif
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 9d3e3327af4c..119b4e27a592 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -282,8 +282,4 @@ static inline void hmem_register_resource(int target_nid, struct resource *r)
>  {
>  }
>  #endif
> -
> -typedef int (*walk_hmem_fn)(struct device *dev, int target_nid,
> -			    const struct resource *res);
> -int walk_hmem_resources(struct device *dev, walk_hmem_fn fn);
>  #endif
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 6e9fb667a1c5..487371a46392 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -14,6 +14,7 @@
>  #include <linux/compiler.h>
>  #include <linux/minmax.h>
>  #include <linux/types.h>
> +#include <linux/notifier.h>
>  /*
>   * Resources are tree-like, allowing
>   * nesting etc..
> @@ -249,6 +250,11 @@ struct resource *lookup_resource(struct resource *root, resource_size_t start);
>  int adjust_resource(struct resource *res, resource_size_t start,
>  		    resource_size_t size);
>  resource_size_t resource_alignment(struct resource *res);
> +extern void trim_soft_reserve_resources(const struct resource *res);
> +extern void merge_soft_reserve_resources(void);
> +extern int insert_soft_reserve_resource(struct resource *res);
> +extern int register_soft_reserve_notifier(struct notifier_block *nb);
> +extern int unregister_soft_reserve_notifier(struct notifier_block *nb);
>  static inline resource_size_t resource_size(const struct resource *res)
>  {
>  	return res->end - res->start + 1;
> diff --git a/kernel/resource.c b/kernel/resource.c
> index a83040fde236..8fc4121a1887 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -30,7 +30,7 @@
>  #include <linux/string.h>
>  #include <linux/vmalloc.h>
>  #include <asm/io.h>
> -
> +#include <linux/acpi.h>
>  
>  struct resource ioport_resource = {
>  	.name	= "PCI IO",
> @@ -48,7 +48,15 @@ struct resource iomem_resource = {
>  };
>  EXPORT_SYMBOL(iomem_resource);
>  
> +struct resource srmem_resource = {
> +	.name	= "Soft Reserved mem",
> +	.start	= 0,
> +	.end	= -1,
> +	.flags	= IORESOURCE_MEM,
> +};
> +
>  static DEFINE_RWLOCK(resource_lock);
> +static DEFINE_RWLOCK(srmem_resource_lock);
>  
>  static struct resource *next_resource(struct resource *p, bool skip_children)
>  {
> @@ -1034,6 +1042,151 @@ int adjust_resource(struct resource *res, resource_size_t start,
>  }
>  EXPORT_SYMBOL(adjust_resource);
>  
> +static BLOCKING_NOTIFIER_HEAD(soft_reserve_chain);
> +
> +int register_soft_reserve_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&soft_reserve_chain, nb);
> +}
> +EXPORT_SYMBOL(register_soft_reserve_notifier);
> +
> +int unregister_soft_reserve_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&soft_reserve_chain, nb);
> +}
> +EXPORT_SYMBOL(unregister_soft_reserve_notifier);
> +
> +static int soft_reserve_notify(unsigned long val, void *v)
> +{
> +	struct resource *res = v;
> +
> +	pr_info("Adding Soft Reserve resource %pr\n", res);
> +	return blocking_notifier_call_chain(&soft_reserve_chain, val, v);
> +}
> +
> +static void trim_soft_reserve(struct resource *sr_res,
> +			      const struct resource *res)
> +{
> +	struct resource *new_res;
> +
> +	if (sr_res->start == res->start && sr_res->end == res->end) {
> +		release_resource(sr_res);
> +		free_resource(sr_res);
> +	} else if (sr_res->start == res->start) {
> +		WARN_ON(adjust_resource(sr_res, res->end + 1,
> +					sr_res->end - res->end));
> +	} else if (sr_res->end == res->end) {
> +		WARN_ON(adjust_resource(sr_res, sr_res->start,
> +					res->start - sr_res->start));
> +	} else {
> +		/*
> +		 * Adjust existing resource to cover the resource
> +		 * range prior to the range to be trimmed.
> +		 */
> +		adjust_resource(sr_res, sr_res->start,
> +				res->start - sr_res->start);
> +
> +		/*
> +		 * Add new resource to cover the resource range for
> +		 * the range after the range to be trimmed.
> +		 */
> +		new_res = alloc_resource(GFP_KERNEL);
> +		if (!new_res)
> +			return;
> +
> +		*new_res = DEFINE_RES_NAMED(res->end + 1, sr_res->end - res->end,
> +					    "Soft Reserved", sr_res->flags);
> +		new_res->desc = IORES_DESC_SOFT_RESERVED;
> +		insert_resource(&srmem_resource, new_res);
> +	}
> +}
> +
> +void trim_soft_reserve_resources(const struct resource *res)
> +{
> +	struct resource *sr_res;
> +
> +	write_lock(&srmem_resource_lock);
> +	for (sr_res = srmem_resource.child; sr_res; sr_res = sr_res->sibling) {
> +		if (resource_contains(sr_res, res)) {
> +			trim_soft_reserve(sr_res, res);
> +			break;
> +		}
> +	}
> +	write_unlock(&srmem_resource_lock);
> +}
> +EXPORT_SYMBOL(trim_soft_reserve_resources);
> +
> +void merge_soft_reserve_resources(void)
> +{
> +	struct resource *sr_res, *next;
> +
> +	write_lock(&srmem_resource_lock);
> +	for (sr_res = srmem_resource.child; sr_res; sr_res = next) {
> +		next = sr_res->sibling;
> +
> +		release_resource(sr_res);
> +		if (insert_resource(&iomem_resource, sr_res))
> +			pr_info("Could not add Soft Reserve %pr\n", sr_res);
> +		else
> +			soft_reserve_notify(0, sr_res);
> +	}
> +	write_unlock(&srmem_resource_lock);
> +}
> +EXPORT_SYMBOL(merge_soft_reserve_resources);
> +
> +struct srmem_arg {
> +	struct resource *res;
> +	int overlaps;
> +};
> +
> +static int srmem_parse_cfmws(union acpi_subtable_headers *hdr,
> +			     void *arg, const unsigned long unused)
> +{
> +	struct acpi_cedt_cfmws *cfmws;
> +	struct srmem_arg *args = arg;
> +	struct resource cfmws_res;
> +	struct resource *res;
> +
> +	res = args->res;
> +
> +	cfmws = (struct acpi_cedt_cfmws *)hdr;
> +	cfmws_res = DEFINE_RES_MEM(cfmws->base_hpa,
> +				   cfmws->base_hpa + cfmws->window_size);
> +
> +	if (resource_overlaps(&cfmws_res, res)) {
> +		args->overlaps += 1;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool resource_overlaps_cfmws(struct resource *res)
> +{
> +	struct srmem_arg arg = {
> +		.res = res,
> +		.overlaps = 0
> +	};
> +
> +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, srmem_parse_cfmws, &arg);
> +
> +	if (arg.overlaps)
> +		return true;
> +
> +	return false;
> +}
> +
> +int insert_soft_reserve_resource(struct resource *res)
> +{
> +	if (resource_overlaps_cfmws(res)) {
> +		pr_info("Reserving Soft Reserve %pr\n", res);
> +		return insert_resource(&srmem_resource, res);
> +	}
> +
> +	return insert_resource(&iomem_resource, res);
> +}
> +EXPORT_SYMBOL(insert_soft_reserve_resource);
> +
>  static void __init
>  __reserve_region_with_split(struct resource *root, resource_size_t start,
>  			    resource_size_t end, const char *name)
> -- 
> 2.43.0
> 

-- 
Fan Ni (From gmail)
