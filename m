Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F6654F95
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093412; cv=none; b=Htr8LhrPw6lwsLzUuozZHzSN2KdlKqVgJSiFLvDGAo1fk/yH7hlMdHCTx+WGAXSFi7nQ912lrYyeNU44cul+cM3lfjfgI6FLeEBajJeTpIVLPuhLg26buwLHxx/LIGbtfWLSjAg0C2pQ/f6AWXWZZUwe2hBAYD1TEBWV9l3Qd1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093412; c=relaxed/simple;
	bh=0A9nxMVYRGxm7UNVyBEfYHOLIktKXlT8Wp+rMYJ1OhM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=or36dogYDlfpMw6wx3OZXkykUi4n0M5h5Xx3rmogJ6/P/Q67vtgogtTVi3qIgGk/dTJiehhZoKni9fgUTU8NYnJx1QtP1O7kXBJFUUgAlRnqkjpTmVKJ/oumWNK7zQnKazKYfbQnbDKaql504c+h2A012Ot4sMOKHMPcHCmSzJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTFZK1lzgz6FGpD;
	Wed, 16 Oct 2024 23:41:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 682A5140393;
	Wed, 16 Oct 2024 23:43:26 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Oct
 2024 17:43:26 +0200
Date: Wed, 16 Oct 2024 16:43:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Nathan Fontenot <nathan.fontenot@amd.com>
CC: <alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [RFC] cxl: Update Soft Reserved resources upon region creation
Message-ID: <20241016164324.000037b9@Huawei.com>
In-Reply-To: <20241004181754.8960-1-nathan.fontenot@amd.com>
References: <20241004181754.8960-1-nathan.fontenot@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 4 Oct 2024 13:17:54 -0500
Nathan Fontenot <nathan.fontenot@amd.com> wrote:

> Update handling of SOFT RESERVE iomem resources that intersect with
> CXL region resources to remove the intersections from the SOFT RESERVE
> resources. The current approach of leaving the SOFT RESERVE
> resource as is can cause failures during hotplug replace of CXL
> devices because the resource is not available for reuse after
> teardown.
Good to give an example here + any debug error messages etc.

> 
> The approach sought is to trim out any pieces of SOFT RESERVE
> resources that intersect with CXL regions. To do this, first set
> aside any SOFT RESERVE resources that intersect with a CFMWS
> into a separate resource tree during e820__reserve_resources_late()
> that would have been otherwise added to the iomem resource tree.
> 
> As CXL regions are created the cxl resource created for the new
> region is used to trim intersections from the SOFT RESERVE
> resources that were previously set aside.
> 
> The next steps are to add any SOFT RESERVE resources remaining to the
> iomem resource tree after CXL device probe completes and to notify
> the dax driver so it may consume the added SOFT RESERVE resources.
> 
> This patch includes the use of a delayed work queue to wait
> for CXL device probe completion and then have a worker thread add
> any remaining SOFT RESERVE resources to the iomem resource tree.
> 
> Not in this patch is notification of the dax driver so it may consume
> the SOFT RESERVE resources.
> 
> The goal of presenting this RFC is to drive discussion of the
> current approach for trimming SOFT RESERVE resources, the use of
> a delayed work queue to add remaining SOFT RESERVE resources to
> the iomem resource tree, and methods for notifying the dax driver
> of any newly added SOFT RESERVE resources.
> 
> NOTE: As this is a RFC the temporary pr_err("CXL DEBUG...")  messages
> have been left in to aid in testing and validation.
> 
> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Trivial, but why Alison's SoB?  She didn't send the patch which would
be normal reason for last SoB in a list like this (handling of the patch).

Maybe a Co-developed-by is missing?

Whilst I appreciate this is an RFC, the arch specific bleed
into CXL code needs to go.  + we need some info here on whether this
is an x86 specific issue.  I'm fairly sure it's not and that should
be called out as future work.

Also, much of this is actually generic, with only a few bits
being e820 related.  Can we pull the soft reserve list etc out
of them into generic code.

To me the general approach seems reasonable but I'd suggest +CC linux-mm
as the issue maybe more about the impacts on DAX than this working for CXL.

Comments inline are mostly general suggestions of simplifications
and refactoring to aid readability.

> ---
>  arch/x86/include/asm/e820/api.h |   3 +
>  arch/x86/kernel/e820.c          | 156 +++++++++++++++++++++++++++++++-
>  drivers/cxl/core/region.c       |  14 ++-
>  drivers/cxl/port.c              |  34 +++++++
>  4 files changed, 203 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
> index 2e74a7f0e935..542a52871beb 100644
> --- a/arch/x86/include/asm/e820/api.h
> +++ b/arch/x86/include/asm/e820/api.h
> @@ -44,6 +44,9 @@ extern void e820__register_nosave_regions(unsigned long limit_pfn);
>  
>  extern int  e820__get_entry_type(u64 start, u64 end);
>  
> +extern void e820__trim_soft_reserves(const struct resource *cxl_res);
> +extern void e820__insert_soft_reserves(void);
> +
>  /*
>   * Returns true iff the specified range [start,end) is completely contained inside
>   * the ISA region.
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 4893d30ce438..855c26460bb9 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c



> +static void e820__trim_soft_reserve(struct resource *res,
> +				    const struct resource *cxl_res)
> +{
> +	resource_size_t new_start, new_end;
> +	int rc;
> +
> +	pr_err("CXL DEBUG Trimming Soft Reserves for %pr\n", cxl_res);
> +
> +	if (res->start == cxl_res->start && res->end == cxl_res->end) {
> +		pr_err("CXL DEBUG Releasing resource %pr\n", res);
> +		release_resource(res);
> +		kfree(res);
> +	} else if (res->start == cxl_res->start || res->end == cxl_res->end) {
> +		if (res->start == cxl_res->start) {
Not a huge amount of sharing in here.
	} else if (res->start = cxl_res->start) {	
		/* Left over bit at top end */
		rc = adjust_resource(res, cxl_res->end + 1, res->end - cxl_res->end);
		if (rc)...

	} else if (res->end == cxl_res->end) {
		/* Left over bit at bottom end */
		rc = adjust_resource(res, res->start, cxl_res->start - res->start);
		if (rc) ...
	} else {
		/* Left over bits on either side. */
	}
> +			new_start = cxl_res->end + 1;
> +			new_end = res->end;
> +		} else {
> +			new_start = res->start;
> +			new_end = cxl_res->start - 1;
> +		}
> +
> +		pr_err("CXL DEBUG Adjusting resource %pr (%llx - %llx)\n",
> +		       res, new_start, new_end);
> +		rc = adjust_resource(res, new_start, new_end - new_start + 1);
> +		if (rc)
> +			pr_debug("Cannot adjust soft reserved resource %pr\n",
> +				 res);
> +	} else {
> +		new_start = res->start;
> +		new_end = res->end;
Confusing use of parameters here as they don't match use in early legs.
Maybe just putting the values inline would be clearer.
> +
> +		/*Adjust existing to beginning resource */
> +		pr_err("CXL DEBUG Adjusting resource %pr (%llx - %llx)\n", res,
> +		       new_start, cxl_res->start);
> +		adjust_resource(res, new_start, cxl_res->start - new_start + 1);

Off by 1?  It's different form above leftover bottom part (should be the same).


> +
> +		/* Add new resource for end piece */
> +		e820__add_soft_reserve(cxl_res->end + 1, new_end - cxl_res->end,
> +				       res->flags);
> +	}
> +}
> +
> +void e820__trim_soft_reserves(const struct resource *cxl_res)
> +{
> +	struct resource *res, *next;
> +
> +	pr_err("CXL DEBUG Trimming Soft Reserves\n");
> +	for (res = e820_sr_res.child; res; res = next) {
	for (res = e820_sr_res.child; res; res = res->sibling)
is the same I think and avoids need for next.
> +		next = res->sibling;
> +
> +		if (resource_contains(res, cxl_res)) {
> +			e820__trim_soft_reserve(res, cxl_res);
> +			break;
return;

> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(e820__trim_soft_reserves);
> +
> +static int __init e820_parse_cfmws(union acpi_subtable_headers *hdr, void *arg,
> +				   const unsigned long unused)
> +{
> +	struct acpi_cedt_cfmws *cfmws;
> +	struct resource *res = arg;
> +	struct resource cfmws_res;
> +
> +	/* Validation check, remove when finished debugging */
> +	if (!res->parent && res->end)
> +		pr_err("CXL DEBUG Should insert %pr\n", res);
> +
> +	if (res->parent || !res->end)
> +		return 0;
> +
> +	cfmws = (struct acpi_cedt_cfmws *)hdr;
> +	cfmws_res = DEFINE_RES_MEM(cfmws->base_hpa,
> +				   cfmws->base_hpa + cfmws->window_size);
> +	pr_err("CXL DEBUG Found CFMWS: %pr\n", &cfmws_res);
> +
> +	if (resource_overlaps(&cfmws_res, res)) {
> +		pr_err("CXL DEBUG Found SOFT RESERVE intersection %llx - %llx : %llx - %llx\n",
> +		       res->start, res->end, cfmws_res.start, cfmws_res.end);
> +		e820__add_soft_reserve(res->start, resource_size(res),
> +				       res->flags);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  void __init e820__reserve_resources_late(void)
>  {
> -	int i;
> +	int i, rc;
>  	struct resource *res;
>  
> +	/*
> +	 * Prior to inserting SOFT_RESERVED resources we want to check for an
> +	 * intersection with potential CXL resources. Any SOFT_RESERVED resources
> +	 * that do intersect a potential CXL resource are set aside so they
> +	 * can be trimmed to accommodate CXL resource intersections and added to
> +	 * the iomem resource tree after the CXL drivers have completed their
> +	 * device probe.
> +	 */
> +	pr_err("CXL DEBUG Checking e820 iomem resources\n");
> +
>  	res = e820_res;
>  	for (i = 0; i < e820_table->nr_entries; i++) {
> -		if (!res->parent && res->end)
> -			insert_resource_expand_to_fit(&iomem_resource, res);
> +		pr_err("CXL DEBUG Checking e820 iomem resource %llx - %llx\n",
> +		       res->start, res->end);
> +		if (res->desc == IORES_DESC_SOFT_RESERVED) {
> +			rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS,
> +						   e820_parse_cfmws, res);
Can we make this somewhat generic by having a parse to find a match
then call 
e820__add_soft_reserve(res->start, resource_size(res), res->flags);
if the match occurs. That way the check can be in arch independent code.

cxl_res_overlaps_cfmws() perhaps.


> +			if (rc) {
> +				res++;

Move the res++ into the for loop ... i++, res++)

> +				continue;
> +			}
> +		}
> +		pr_err("CXL DEBUG Inserting %llx - %llx\n", res->start, res->end);
> +		insert_resource_expand_to_fit(&iomem_resource, res);
>  		res++;
>  	}
>  

> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index d7d5d982ce69..9f94730c488f 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -7,6 +7,10 @@
>  #include "cxlmem.h"
>  #include "cxlpci.h"
>  
> +#if CONFIG_X86
> +#include <asm/e820/api.h>
> +#endif
> +
>  /**
>   * DOC: cxl port
>   *
> @@ -89,6 +93,35 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  	return -ENXIO;
>  }
>  
> +DECLARE_RWSEM(cxl_sr_rwsem);
> +
> +static void cxl_sr_update(struct work_struct *w)
> +{
> +	down_write(&cxl_sr_rwsem);
> +	pr_err("CXL DEBUG Updating soft reserves\n");
> +	e820__insert_soft_reserves();

That's arch specific code bleeding over to the cxl code.
So needs at minimum to be hidden behind an arch call.

> +	up_write(&cxl_sr_rwsem);
> +}
> +
> +DECLARE_DELAYED_WORK(cxl_sr_work, cxl_sr_update);
> +
> +static void schedule_soft_reserve_update(void)
> +{
> +	static bool update_scheduled;
> +	int timeout = 5 * HZ;
> +
> +	down_write(&cxl_sr_rwsem);
For the locks use guard()

However, what are they for?

> +	if (update_scheduled) {
> +		pr_err("CXL DEBUG modifying delayed work timeout\n");
> +		mod_delayed_work(system_wq, &cxl_sr_work, timeout);

See docs for mod_delayed_work_on()

"If @dwork is idle, equivalent to queue_delayed_work_on(); "
which is where schedule_delayed_work() ends up.
So other than maybe for the debug prints you don't need this dance
just always call mod_delayed_work()



> +	} else {
> +		pr_err("CXL DEBUG Adding delayed work\n");
> +		schedule_delayed_work(&cxl_sr_work, timeout);
> +		update_scheduled = true;
> +	}
> +	up_write(&cxl_sr_rwsem);
> +}
> +
>  static int cxl_endpoint_port_probe(struct cxl_port *port)
>  {
>  	struct cxl_endpoint_dvsec_info info = { .port = port };
> @@ -140,6 +173,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	 */
>  	device_for_each_child(&port->dev, root, discover_region);
>  
> +	schedule_soft_reserve_update();
>  	return 0;
>  }
>  

