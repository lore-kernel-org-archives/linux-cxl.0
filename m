Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CF6238E06
	for <linux-cxl@vger.kernel.org>; Wed, 11 Dec 2024 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916725; cv=none; b=HceyWkSeyYuhNuaGYR262cqpIrxJdr4NkpBO9TqjrRO0QO9U0FkzOMjigfI8qpPCjpySnPawGUasim6RqpYzFRH1McPhNlNYhbN1j1T9N5w8O67RiC4qqgUX8lC7hu85BFyOmZCG66nlOOiUWxh1zokUA2nwX/6sD4tf9RJDO28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916725; c=relaxed/simple;
	bh=AKTqxmpi4mJNDPKknySvlHdWar61q7LraKA5yizjjz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiVLSXKCx0hGfrzjPZlgpZ9D55ZNoxX1LgHv76zbCxLXuAeP6rm2jRoKyiOtgPonCjNqcsw+4R9pdN7peOhOT8iVJaveI0WwfyV3MbLcqpGBYRUY4VZyTqkvVR73uGD8QHeix2iH1snpZo83gE5kP3ydZRouUHuwJdVL7mh259E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bJaX1VUV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJaX1VUV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733916723; x=1765452723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AKTqxmpi4mJNDPKknySvlHdWar61q7LraKA5yizjjz4=;
  b=bJaX1VUVDLQSibUNrr/NdZ41HPHnlkkhRsnTJYDSTkNjLKOhPxHb8B8R
   j/O81Nlo845tNEehnNzQLK3dDc5nBjnvCw2Dqk05FS49c7/8Z8ZdQoZbT
   bS1tINTkZZgMj3sYvePEkyOpY8bAG3Ip842II84mwKp+zY18twNws/7ok
   bqJHAJQIVTFUZrX1tB7ViqiEMDFKUNUh6M4YjHnTrHV8HPVSCtvKlFY3x
   qGhaLyEcATP0Bbjpsco1YBDdUThVIyQgLepaM7Rm85/OCH1lbASMLPZZ8
   m9jyQnMIB60Ve/2KjbYaUeyMnpyo24FwRXbY8m7DR6kxx/7iqq5dsTmtD
   Q==;
X-CSE-ConnectionGUID: j3FYMQXlReqJsH9J83QndA==
X-CSE-MsgGUID: 5OkpNo3yScKYs9QjFOj0PA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34431595"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="34431595"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 03:32:02 -0800
X-CSE-ConnectionGUID: X+fvPiiPQqKq4DAY4ZxPMg==
X-CSE-MsgGUID: zfPiE9JwR7u0HlE9L2+aSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="96241618"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 03:32:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tLKwf-00000006Vco-2NNL;
	Wed, 11 Dec 2024 13:31:57 +0200
Date: Wed, 11 Dec 2024 13:31:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nathan Fontenot <nathan.fontenot@amd.com>
Cc: alison.schofield@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] cxl: Update Soft Reserved resources upon region creation
Message-ID: <Z1l4LSIIzmoInQXp@smile.fi.intel.com>
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
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

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
> remaining are added to the iomem resource tree. As each resource
> is added to the oiomem resource tree a new notifier chain is invoked
> to notify the dax driver of newly added SOFT RESERVE resources so that
> the dax driver can consume them.

...

>  void __init e820__reserve_resources_late(void)
>  {
> -	int i;
>  	struct resource *res;
> +	int i;

Unrelated change.

...

> -	for (i = 0; i < e820_table->nr_entries; i++) {

> +	for (i = 0; i < e820_table->nr_entries; i++, res++) {


> -		res++;

Unrelated change.


>  	}

...

> +static struct notifier_block hmem_nb = {
> +	.notifier_call = dax_hmem_cb

It's better to leave trailing comma as it reduces churn in the future is
anything to add here.

> +};

...

> +++ b/drivers/dax/hmem/hmem.h
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#ifndef _HMEM_H
> +#define _HMEM_H

This needs a few forward declarations

struct device;
struct platform_device;
struct resource;

> +typedef int (*walk_hmem_fn)(struct device *dev, int target_nid,
> +			    const struct resource *res);
> +int walk_hmem_resources(struct device *dev, walk_hmem_fn fn);
> +
> +extern struct platform_device *hmem_pdev;
> +
> +#endif

...

>  #include <linux/compiler.h>
>  #include <linux/minmax.h>
>  #include <linux/types.h>
> +#include <linux/notifier.h>

I would put it before types.h to have more ordered piece.

...

> +extern void trim_soft_reserve_resources(const struct resource *res);
> +extern void merge_soft_reserve_resources(void);
> +extern int insert_soft_reserve_resource(struct resource *res);
> +extern int register_soft_reserve_notifier(struct notifier_block *nb);
> +extern int unregister_soft_reserve_notifier(struct notifier_block *nb);

Why extern?

...

> +++ b/kernel/resource.c
> @@ -30,7 +30,7 @@
>  #include <linux/string.h>
>  #include <linux/vmalloc.h>
>  #include <asm/io.h>
> -
> +#include <linux/acpi.h>

We don't usually interleave linux and asm headers, moreover the list seems to
be sorted (ordered, please preserve the ordering).

...

> +struct resource srmem_resource = {
> +	.name	= "Soft Reserved mem",
> +	.start	= 0,
> +	.end	= -1,
> +	.flags	= IORESOURCE_MEM,

This can use DEFINE_RES_MEM_NAMED() as well.

> +};

...

> +	if (sr_res->start == res->start && sr_res->end == res->end) {

Wondering if we have a helper to exact match the resource by range...

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

...

> +void trim_soft_reserve_resources(const struct resource *res)
> +{
> +	struct resource *sr_res;
> +
> +	write_lock(&srmem_resource_lock);
> +	for (sr_res = srmem_resource.child; sr_res; sr_res = sr_res->sibling) {

Can this utilise for_each_resource*()?
Ditto for the rest of open coded for each type of loops.

> +		if (resource_contains(sr_res, res)) {
> +			trim_soft_reserve(sr_res, res);
> +			break;
> +		}
> +	}
> +	write_unlock(&srmem_resource_lock);
> +}

...

> +	cfmws_res = DEFINE_RES_MEM(cfmws->base_hpa,
> +				   cfmws->base_hpa + cfmws->window_size);

Can be one line.
But is this correct? The parameters are start,size, and here it seems like start,end.

...

> +static bool resource_overlaps_cfmws(struct resource *res)
> +{
> +	struct srmem_arg arg = {
> +		.res = res,

> +		.overlaps = 0
Keep trailing comma.

> +	};
> +
> +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, srmem_parse_cfmws, &arg);

> +	if (arg.overlaps)
> +		return true;
> +
> +	return false;

	return arg.overlaps;

> +}

...

> +int insert_soft_reserve_resource(struct resource *res)
> +{
> +	if (resource_overlaps_cfmws(res)) {
> +		pr_info("Reserving Soft Reserve %pr\n", res);

Btw, do we have pr_fmt() defined in this file?

> +		return insert_resource(&srmem_resource, res);
> +	}
> +
> +	return insert_resource(&iomem_resource, res);
> +}

-- 
With Best Regards,
Andy Shevchenko


