Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D1F1D516C;
	Mon, 12 Jan 2026 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768248061; cv=none; b=n3F8NP6Dw1R/sPBFGTsBTZI9bQaS8/5ZntXVmADUuw5doEgSwhEDPIl8Z6jZbRsQQ1Pvb7LS4QYnLn9pp/OOgoL4AmPtqjMJ61zeaTOx1iqcZ1nMiRF7jIJOAqVsSZOxlYUlmJEypbjKXjR4eyF1W/0plXXQOtu+YSOxewp6+i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768248061; c=relaxed/simple;
	bh=sbklOWqNGVE2rKFh7cQ1BWi4dGVLww5u/e3o3eCHZ4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eus/tbaSsfDzGot2CPELeeXT+pEogacT+PM4bmHYoXJvdscy3ue+VrscmWXooxHsaatQdnS/SaHd+onH+j9A9OfGkrrjiUEZ7T0uDNQ5y+IJQuTZ0vFgnse0BfAvdp3nJNpRnn9Mvc16ruzXrHuUt9DBAV1oC9sxAtd+ly9A4Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7HBMZxF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7HBMZxF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF2CC116D0;
	Mon, 12 Jan 2026 20:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768248060;
	bh=sbklOWqNGVE2rKFh7cQ1BWi4dGVLww5u/e3o3eCHZ4o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W7HBMZxFxMdeIQx0IXK2B5jaEpZ18vCNnSRtDj6ebsX1yv9RWpXtq0lqkGq5wGkr+
	 73PI064/F+SHoyDXRAVsNZheeK2NMLWVIzNRQOD7lA9ocsRi2Kwj8tGVjo1FbxR7CB
	 2iN/3VgtY9h/0ERlXUmpOiU7mohGHpLzDkbs91ROsbefeHZTjARiMl8YhEOs9NvcjW
	 A/+shwtXB0SnzJRK62mHP82DnjWd6827SdugOHr6+OjdYOkuxQ7O7rCTVdXTkWOvY1
	 pkyJG9p1YpA1tAR2JEa89k+roU0Kyz9NRXBjzzyWRkIhWfI7g1zHqpeMi9XcwZzBgc
	 3WW08c6IaR1Lg==
Message-ID: <3d5ccbb3-a083-4a5c-8c97-2db2adbc5446@kernel.org>
Date: Mon, 12 Jan 2026 21:00:54 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] cxl: add sysram_region memory controller
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-3-gourry@gourry.net>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
In-Reply-To: <20260112163514.2551809-3-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/12/26 17:35, Gregory Price wrote:
> Add a sysram memctrl that directly hotplugs memory without needing to
> route through DAX.  This simplifies the sysram usecase considerably.
> 
> The sysram memctl adds new sysfs controls when registered:
> 	region/memctrl/[hotplug, hotunplug, state]
> 
> hotplug:   controller attempts to hotplug the memory region

Why disconnect the hotplug from the online state?

echo online_movable > hotplug ?

Then we can just have something like add_and_online_memory() in the core.

> hotunplug: controller attempts to offline and hotunplug the memory region
> state:     [online,online_normal,offline]
>     online       : controller onlines blocks in ZONE_MOVABLE

I don't like this incosistency regarding the remainder of common hotplug 
toggles.

We should use exactly the same values with exactly the same semantics. 
Yes, user-space tooling should be thaught to pass in online_movable :)

>     online_normal: controller onlines blocks in ZONE_NORMAL
>     offline      : controller attempts to offline the memory blocks

Why is that required? ideally we'd start with hotplug vs. hotunplug and 
leave manual onlining/offlining out of this interface for now.

> 
> Hotplug note - by default the controller will hotplug the blocks, but
> leave them offline (unless MHP auto-online in Kconfig is enabled).
> 
> Setting state to "online_normal" may prevent future hot-unplug of sysram
> regions, and unbinding a memory region with memory online in ZONE_NORMAL
> may result in the device being removed but the memory remaining online.
> 
> This can result in future management functions failing (such as adding a
> new region).  This is why "online_normal" is explicit, and the default
> online zone is ZONE_MOVABLE.
> 
> Cc: David Hildenbrand <david@kernel.org>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>   drivers/cxl/core/core.h                  |   2 +
>   drivers/cxl/core/memctrl/Makefile        |   1 +
>   drivers/cxl/core/memctrl/memctrl.c       |   2 +
>   drivers/cxl/core/memctrl/sysram_region.c | 358 +++++++++++++++++++++++
>   drivers/cxl/core/region.c                |   5 +
>   drivers/cxl/cxl.h                        |   6 +-
>   6 files changed, 372 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/cxl/core/memctrl/sysram_region.c
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1156a4bd0080..18cb84950500 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -31,6 +31,8 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
>   		       struct cxl_endpoint_decoder *cxled, int pos,
>   		       enum cxl_detach_mode mode);
>   
> +int devm_cxl_add_sysram_region(struct cxl_region *cxlr);
> +
>   #define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
>   #define CXL_REGION_TYPE(x) (&cxl_region_type)
>   #define SET_CXL_REGION_ATTR(x) (&dev_attr_##x.attr),
> diff --git a/drivers/cxl/core/memctrl/Makefile b/drivers/cxl/core/memctrl/Makefile
> index 8165aad5a52a..1c52c7d75570 100644
> --- a/drivers/cxl/core/memctrl/Makefile
> +++ b/drivers/cxl/core/memctrl/Makefile
> @@ -2,3 +2,4 @@
>   
>   cxl_core-$(CONFIG_CXL_REGION) += memctrl/memctrl.o
>   cxl_core-$(CONFIG_CXL_REGION) += memctrl/dax_region.o
> +cxl_core-$(CONFIG_CXL_REGION) += memctrl/sysram_region.o
> diff --git a/drivers/cxl/core/memctrl/memctrl.c b/drivers/cxl/core/memctrl/memctrl.c
> index 24e0e14b39c7..40ffb59353bb 100644
> --- a/drivers/cxl/core/memctrl/memctrl.c
> +++ b/drivers/cxl/core/memctrl/memctrl.c
> @@ -34,6 +34,8 @@ int cxl_enable_memctrl(struct cxl_region *cxlr)
>   		return devm_cxl_add_dax_region(cxlr);
>   	case CXL_MEMCTRL_DAX:
>   		return devm_cxl_add_dax_region(cxlr);
> +	case CXL_MEMCTRL_SYSRAM:
> +		return devm_cxl_add_sysram_region(cxlr);
>   	default:
>   		return -EINVAL;
>   	}
> diff --git a/drivers/cxl/core/memctrl/sysram_region.c b/drivers/cxl/core/memctrl/sysram_region.c
> new file mode 100644
> index 000000000000..a7570c8a54e1
> --- /dev/null
> +++ b/drivers/cxl/core/memctrl/sysram_region.c
> @@ -0,0 +1,358 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2026 Meta Inc. All rights reserved. */
> +#include <linux/memremap.h>
> +#include <linux/memory.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <linux/mm.h>
> +#include <linux/memory-tiers.h>
> +#include <linux/memory_hotplug.h>
> +#include <linux/string_helpers.h>
> +#include <linux/sched/signal.h>
> +#include <cxlmem.h>
> +#include <cxl.h>
> +#include "../core.h"
> +
> +/* If HMAT was unavailable, assign a default distance. */
> +#define MEMTIER_DEFAULT_CXL_ADISTANCE	(MEMTIER_ADISTANCE_DRAM * 5)
> +
> +static const char *sysram_name = "System RAM (CXL)";
> +
> +struct cxl_sysram_data {
> +	const char *res_name;
> +	int mgid;
> +	struct resource *res;
> +};
> +
> +static DEFINE_MUTEX(cxl_memory_type_lock);
> +static LIST_HEAD(cxl_memory_types);
> +
> +static struct cxl_region *to_cxl_region(struct device *dev)
> +{
> +	if (dev->type != &cxl_region_type)
> +		return NULL;
> +	return container_of(dev, struct cxl_region, dev);
> +}
> +
> +static struct memory_dev_type *cxl_find_alloc_memory_type(int adist)
> +{
> +	guard(mutex)(&cxl_memory_type_lock);
> +	return mt_find_alloc_memory_type(adist, &cxl_memory_types);
> +}
> +
> +static void __maybe_unused cxl_put_memory_types(void)
> +{
> +	guard(mutex)(&cxl_memory_type_lock);
> +	mt_put_memory_types(&cxl_memory_types);
> +}
> +
> +static int cxl_sysram_range(struct cxl_region *cxlr, struct range *r)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +
> +	if (!p->res)
> +		return -ENODEV;
> +
> +	/* memory-block align the hotplug range */
> +	r->start = ALIGN(p->res->start, memory_block_size_bytes());
> +	r->end = ALIGN_DOWN(p->res->end + 1, memory_block_size_bytes()) - 1;
> +	if (r->start >= r->end) {
> +		r->start = p->res->start;
> +		r->end = p->res->end;
> +		return -ENOSPC;
> +	}
> +	return 0;
> +}
> +
> +static ssize_t hotunplug_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct range range;
> +	int rc;
> +
> +	if (!cxlr)
> +		return -ENODEV;
> +
> +	rc = cxl_sysram_range(cxlr, &range);
> +	if (rc)
> +		return rc;
> +
> +	rc = offline_and_remove_memory(range.start, range_len(&range));
> +
> +	if (rc)
> +		return rc;
> +
> +	return len;
> +}
> +static DEVICE_ATTR_WO(hotunplug);
> +
> +struct online_memory_cb_arg {
> +	int online_type;
> +	int rc;
> +};
> +
> +static int online_memory_block_cb(struct memory_block *mem, void *arg)
> +{
> +	struct online_memory_cb_arg *cb_arg = arg;
> +
> +	if (signal_pending(current))
> +		return -EINTR;
> +
> +	cond_resched();
> +
> +	if (mem->state == MEM_ONLINE)
> +		return 0;
> +
> +	mem->online_type = cb_arg->online_type;
> +	cb_arg->rc = device_online(&mem->dev);
> +
> +	return cb_arg->rc;
> +}
> +
> +static int offline_memory_block_cb(struct memory_block *mem, void *arg)
> +{
> +	int *rc = arg;
> +
> +	if (signal_pending(current))
> +		return -EINTR;
> +
> +	cond_resched();
> +
> +	if (mem->state == MEM_OFFLINE)
> +		return 0;
> +
> +	*rc = device_offline(&mem->dev);
> +
> +	return *rc;
> +}
> +
> +static ssize_t state_store(struct device *dev,
> +			   struct device_attribute *attr,
> +			   const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct online_memory_cb_arg cb_arg;
> +	struct range range;
> +	int rc;
> +
> +	if (!cxlr)
> +		return -ENODEV;
> +
> +	rc = cxl_sysram_range(cxlr, &range);
> +	if (rc)
> +		return rc;
> +
> +	rc = lock_device_hotplug_sysfs();
> +	if (rc)
> +		return rc;
> +
> +	if (sysfs_streq(buf, "online")) {
> +		cb_arg.online_type = MMOP_ONLINE_MOVABLE;
> +		cb_arg.rc = 0;
> +		rc = walk_memory_blocks(range.start, range_len(&range),
> +					&cb_arg, online_memory_block_cb);
> +		if (!rc)
> +			rc = cb_arg.rc;
> +	} else if (sysfs_streq(buf, "online_normal")) {
> +		cb_arg.online_type = MMOP_ONLINE;
> +		cb_arg.rc = 0;
> +		rc = walk_memory_blocks(range.start, range_len(&range),
> +					&cb_arg, online_memory_block_cb);
> +		if (!rc)
> +			rc = cb_arg.rc;
> +	} else if (sysfs_streq(buf, "offline")) {
> +		int offline_rc = 0;
> +
> +		rc = walk_memory_blocks(range.start, range_len(&range),
> +					&offline_rc, offline_memory_block_cb);
> +		if (!rc)
> +			rc = offline_rc;

Let's expose this functionality through some common-code helpers. I 
really don't want more code doing this non-obvious device_offline() etc 
dance.

walk_memory_blocks() should become a core-mm helper. Maybe we can also 
cleanup drivers/acpi/acpi_memhotplug.c in that regard.

Hopefully we can then also reuse these helpers in ppc code (see 
dlpar_add_lmb() and dlpar_remove_lmb() that do something similar, but 
grab the device hotplug lock themselves as they want to perform some 
additional operations).

-- 
Cheers

David
