Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2650155351
	for <linux-cxl@vger.kernel.org>; Tue, 18 Jun 2024 23:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718753751; cv=none; b=TFC9Rj0qF1pnH8o7fTE2i3wRzdU8gHiq8SSxgs5OM4R8t7AG2pKnL8ZXs4MDkKHbbzgdz8VWnOTcTAHZcXP3Kspxqpri3Khcy07UiNq6TdPsAklPjqsVBhCjNBe9Am4AdZ8DgTibb14ImjJFROHqeSYYJcuD3/7TkawTdt9PjTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718753751; c=relaxed/simple;
	bh=M1FEDauRjB/4gINRNPjojWAMB+egJq4MMB0aPzU2x14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQMqCgQqPymbX4K77IYU7Z4V4C2mLjZqRvUUGcetMC/LitGIB+HPN9Op2xcXvNAfcZPWxyCeG9eIXfCUF6L4SL8QvdZwCj/gC11+K4HLs5CgPpyteEodY1ppL7fAEqU+obmhp5RzPk4ZmYTS/bdrTBg6Sz0ZpI7YHu34AAumGNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JxRUkDvX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JxRUkDvX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718753749; x=1750289749;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M1FEDauRjB/4gINRNPjojWAMB+egJq4MMB0aPzU2x14=;
  b=JxRUkDvXImKcTp0hxXCqHixtw5JRll6iNCZPpR/NgbSQDh2LIRqU7JXK
   pFIpH1EjspdxOwVyd+ahweuQUJLuXKk3RqQ//6/hv901NctQ1ropW8zpB
   XfDfOmDxQxBzx4WcEKWe/dY9IFmSBQczeW3wHnRIgSUAPCAZgX+u8jf67
   IsTJeJJPdjvnuTqXpD5wGW+TAcQyqIl+UwwZq8quJQy6nynB21aMs7Fwq
   7o0lOjsf5Vweu0Wjn1gzhEGjP160K4slmP4V3h8yB+06T/YDg3kg8k89N
   2ZiAhAE9mY2qbskCdr0gOD5GAmuQsYeS34G6x86wXorumgqikIajNZBIM
   A==;
X-CSE-ConnectionGUID: j5kmBitZSFSzflAr0R7ypg==
X-CSE-MsgGUID: sKtPObMASV+jpJyvdb4Hsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15382247"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15382247"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 16:35:48 -0700
X-CSE-ConnectionGUID: AMbu1aL7Ru6/aO4Vv+HzMw==
X-CSE-MsgGUID: PIcFpnTxRFaosnHDijLJqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="79183071"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.111.236]) ([10.125.111.236])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 16:35:48 -0700
Message-ID: <be14ee00-6d43-4db1-ad63-beac6aacb814@intel.com>
Date: Tue, 18 Jun 2024 16:35:46 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net,
 ira.weiny@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/18/24 9:53 AM, Shiyang Ruan wrote:
> Background:
> Since CXL device is a memory device, while CPU consumes a poison page of 
> CXL device, it always triggers a MCE by interrupt (INT18), no matter 
> which-First path is configured.  This is the first report.  Then 
> currently, in FW-First path, the poison event is transferred according 
> to the following process: CXL device -> firmware -> OS:ACPI->APEI->GHES 
>  -> CPER -> trace report.  This is the second one.  These two reports
> are indicating the same poisoning page, which is the so-called "duplicate
> report"[1].  And the memory_failure() handling I'm trying to add in
> OS-First path could also be another duplicate report.
> 
> Hope the flow below could make it easier to understand:
> CPU accesses bad memory on CXL device, then
>  -> MCE (INT18), *always* report (1)
>  -> * FW-First (implemented now)
>       -> CXL device -> FW
> 	      -> OS:ACPI->APEI->GHES->CPER -> trace report (2.a)
>     * OS-First (not implemented yet, I'm working on it)
>       -> CXL device -> MSI
> 	      -> OS:CXL driver -> memory_failure() (2.b)
> so, the (1) and (2.a/b) are duplicated.
> 
> (I didn't get response in my reply for [1] while I have to make patch to
> solve this problem, so please correct me if my understanding is wrong.)
> 
> This patch adds a new notifier_block and MCE_PRIO_CXL, for CXL memdev
> to check whether the current poison page has been reported (if yes,
> stop the notifier chain, won't call the following memory_failure()
> to report), into `x86_mce_decoder_chain`.  In this way, if the poison
> page already handled(recorded and reported) in (1) or (2), the other one
> won't duplicate the report.  The record could be clear when
> cxl_clear_poison() is called.
> 
> [1] https://lore.kernel.org/linux-cxl/664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  arch/x86/include/asm/mce.h |   1 +
>  drivers/cxl/core/mbox.c    | 130 +++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/memdev.c  |   6 +-
>  drivers/cxl/cxlmem.h       |   3 +
>  4 files changed, 139 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index dfd2e9699bd7..d8109c48e7d9 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -182,6 +182,7 @@ enum mce_notifier_prios {
>  	MCE_PRIO_NFIT,
>  	MCE_PRIO_EXTLOG,
>  	MCE_PRIO_UC,
> +	MCE_PRIO_CXL,
>  	MCE_PRIO_EARLY,
>  	MCE_PRIO_CEC,
>  	MCE_PRIO_HIGHEST = MCE_PRIO_CEC
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2626f3fff201..0eb3c5401e81 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -4,6 +4,8 @@
>  #include <linux/debugfs.h>
>  #include <linux/ktime.h>
>  #include <linux/mutex.h>
> +#include <linux/notifier.h>
> +#include <asm/mce.h>
>  #include <asm/unaligned.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
> @@ -880,6 +882,9 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  		if (cxlr)
>  			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
>  
> +		if (hpa != ULLONG_MAX && cxl_mce_recorded(hpa))
> +			return;
> +
>  		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
>  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
>  						&evt->gen_media);
> @@ -1408,6 +1413,127 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
>  
> +struct cxl_mce_record {
> +	struct list_head node;
> +	u64 hpa;
> +};
> +LIST_HEAD(cxl_mce_records);
> +DEFINE_MUTEX(cxl_mce_mutex);
> +
> +bool cxl_mce_recorded(u64 hpa)
> +{
> +	struct cxl_mce_record *cur, *next, *rec;
> +	int rc;
> +
> +	rc = mutex_lock_interruptible(&cxl_mce_mutex);
> +	if (rc)
> +		return false;
> +
> +	list_for_each_entry_safe(cur, next, &cxl_mce_records, node) {
> +		if (cur->hpa == hpa) {
> +			mutex_unlock(&cxl_mce_mutex);
> +			return true;
> +		}
> +	}
> +
> +	rec = kmalloc(sizeof(struct cxl_mce_record), GFP_KERNEL);
> +	rec->hpa = hpa;
> +	list_add(&cxl_mce_records, &rec->node);
> +
> +	mutex_unlock(&cxl_mce_mutex);
> +
> +	return false;
> +}
> +
> +void cxl_mce_clear(u64 hpa)
> +{
> +	struct cxl_mce_record *cur, *next;
> +	int rc;
> +
> +	rc = mutex_lock_interruptible(&cxl_mce_mutex);
> +	if (rc)
> +		return;
> +
> +	list_for_each_entry_safe(cur, next, &cxl_mce_records, node) {
> +		if (cur->hpa == hpa) {
> +			list_del(&cur->node);
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&cxl_mce_mutex);
> +}
> +
> +struct cxl_contains_hpa_context {
> +	bool contains;
> +	u64 hpa;
> +};
> +
> +static int __cxl_contains_hpa(struct device *dev, void *arg)
> +{
> +	struct cxl_contains_hpa_context *ctx = arg;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct range *range;
> +	u64 hpa = ctx->hpa;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	range = &cxled->cxld.hpa_range;
> +
> +	if (range->start <= hpa && hpa <= range->end) {
> +		ctx->contains = true;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool cxl_contains_hpa(const struct cxl_memdev *cxlmd, u64 hpa)
> +{
> +	struct cxl_contains_hpa_context ctx = {
> +		.contains = false,
> +		.hpa = hpa,
> +	};
> +	struct cxl_port *port;
> +
> +	port = cxlmd->endpoint;
> +	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))

Maybe no need to check is_cxl_endpoint() if the port is retrieved from cxlmd->endpoint.

Also, in order to use cxl_num_decoders_committed(), cxl_region_rwsem must be held. See the lockdep_assert_held() in the function. Maybe add a
guard(cxl_regoin_rwsem);
before the if statement above.

DJ

> +		device_for_each_child(&port->dev, &ctx, __cxl_contains_hpa);
> +
> +	return ctx.contains;
> +}
> +
> +static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
> +			  void *data)
> +{
> +	struct mce *mce = (struct mce *)data;
> +	struct cxl_memdev_state *mds = container_of(nb, struct cxl_memdev_state,
> +						    mce_notifier);
> +	u64 hpa;
> +
> +	if (!mce || !mce_usable_address(mce))
> +		return NOTIFY_DONE;
> +
> +	hpa = mce->addr & MCI_ADDR_PHYSADDR;
> +
> +	/* Check if the PFN is located on this CXL device */
> +	if (!pfn_valid(hpa >> PAGE_SHIFT) &&
> +	    !cxl_contains_hpa(mds->cxlds.cxlmd, hpa))
> +		return NOTIFY_DONE;
> +
> +	/*
> +	 * Search PFN in the cxl_mce_records, if already exists, don't continue
> +	 * to do memory_failure() to avoid a poison address being reported
> +	 * more than once.
> +	 */
> +	if (cxl_mce_recorded(hpa))
> +		return NOTIFY_STOP;
> +	else
> +		return NOTIFY_OK;
> +}
> +
>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  {
>  	struct cxl_memdev_state *mds;
> @@ -1427,6 +1553,10 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
>  	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
>  
> +	mds->mce_notifier.notifier_call = cxl_handle_mce;
> +	mds->mce_notifier.priority = MCE_PRIO_CXL;
> +	mce_register_decode_chain(&mds->mce_notifier);
> +
>  	return mds;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, CXL);
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 0277726afd04..aa3ac89d17be 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -376,10 +376,14 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  		goto out;
>  
>  	cxlr = cxl_dpa_to_region(cxlmd, dpa);
> -	if (cxlr)
> +	if (cxlr) {
> +		u64 hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
> +
> +		cxl_mce_clear(hpa);
>  		dev_warn_once(mds->cxlds.dev,
>  			      "poison clear dpa:%#llx region: %s\n", dpa,
>  			      dev_name(&cxlr->dev));
> +	}
>  
>  	record = (struct cxl_poison_record) {
>  		.address = cpu_to_le64(dpa),
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 19aba81cdf13..fbf8d9f46984 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -501,6 +501,7 @@ struct cxl_memdev_state {
>  	struct cxl_fw_state fw;
>  
>  	struct rcuwait mbox_wait;
> +	struct notifier_block mce_notifier;
>  	int (*mbox_send)(struct cxl_memdev_state *mds,
>  			 struct cxl_mbox_cmd *cmd);
>  };
> @@ -836,6 +837,8 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
> +bool cxl_mce_recorded(u64 pfn);
> +void cxl_mce_clear(u64 pfn);
>  
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
