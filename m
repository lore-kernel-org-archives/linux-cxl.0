Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F2FEC7
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 01:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707959981; cv=none; b=qG7zMdvVgXbJ+WrIyWCZP/qjOrDdtdGH0DeeQ7nLXmAX65wfzUX/oSM7yfWGz8QZpWlhr43Wpciub4D+d/s4HFeYVdqq9kId905k+BKMSe8erEICPU0zYBjMciA+SHj84aFtGI5qSG5DJxdusU5GircxB7da986UZhFABD0LfdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707959981; c=relaxed/simple;
	bh=8etmOUolKQtAINrMulYOSO7ZrAS0mvvYXhM462kQD/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQQYQ7ojLHQSLDYoFhrxKv0p1X8qIPrHiNuT7b0NLmj10ezYmAsHCRD2e3vgwDgBSt70K0se/eZR272cCMpkL+qpXdQqyq9dGBHrQuKsd+mNGxmGmNOXw20KglGNq7vb/G3SNY7KXfzZqIRIIsqTIzVUgMfZhV8yCNxL94wrQ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hf7HAWp8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hf7HAWp8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707959979; x=1739495979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8etmOUolKQtAINrMulYOSO7ZrAS0mvvYXhM462kQD/0=;
  b=hf7HAWp8YN5EaIp3TFhcgTddH61seaZLR7cs4ivtQAj1H5pz+usePnA4
   uCyETigyUhBZzl8n+vTAKjjmO+uxCeqNX0tUf15GDA/S+1DKHxAKT48Hx
   mDNdIWKwBtAkhJ5cloKytn8cBy3GWx2n6qnuNv4/QTl9ZdqjWvaQidcEC
   V1DclLI/BjChWDht9C3QFg+h6PWlTpyrHFBLb+DSSMOiYBGHqSwN76Pur
   IRZNnLUlSy1A4j0QtliuLnyC70AA837qcSSHDuun1EjnjL1XruUZdZsUT
   KFEriX8kgLV3mWzrWV0R+ZEd39FSofDdmOMIKH23hkGEE2fIuS1OV83Nh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1914562"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="1914562"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 17:19:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3395181"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 17:19:38 -0800
Date: Wed, 14 Feb 2024 17:19:36 -0800
From: Tony Luck <tony.luck@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	Jonathan.Cameron@huawei.com, dan.j.williams@intel.com
Subject: Re: [RFC PATCH 3/5] cxl/core: introduce cxl_mem_report_poison()
Message-ID: <Zc1mqOp9WiV49_Yi@agluck-desk3>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
 <20240209115417.724638-6-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209115417.724638-6-ruansy.fnst@fujitsu.com>

On Fri, Feb 09, 2024 at 07:54:15PM +0800, Shiyang Ruan wrote:
> If poison is detected(reported from cxl memdev), OS should be notified to
> handle it.  Introduce this function:
>   1. translate DPA to HPA;
>   2. construct a MCE instance; (TODO: more details need to be filled)
>   3. log it into MCE event queue;
> 
> After that, MCE mechanism can walk over its notifier chain to execute
> specific handlers.

This looks like a useful proof of concept patch to pass errors to all
the existing logging systems (console, mcelog, rasdaemon, EDAC). But
it's a bare minimum (just passing the address and dropping any other
interesting information about the error). I think we need something
more advanced that covers more CXL error types.

> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c |  1 +
>  drivers/cxl/core/mbox.c        | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index bc39252bc54f..a64c0aceb7e0 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -131,6 +131,7 @@ void mce_setup(struct mce *m)
>  	m->ppin = cpu_data(m->extcpu).ppin;
>  	m->microcode = boot_cpu_data.microcode;
>  }
> +EXPORT_SYMBOL_GPL(mce_setup);
>  
>  DEFINE_PER_CPU(struct mce, injectm);
>  EXPORT_PER_CPU_SYMBOL_GPL(injectm);
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 27166a411705..f9b6f50fbe80 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -4,6 +4,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/ktime.h>
>  #include <linux/mutex.h>
> +#include <asm/mce.h>
>  #include <asm/unaligned.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
> @@ -1290,6 +1291,38 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
>  
> +static void cxl_mem_report_poison(struct cxl_memdev *cxlmd,
> +				  struct cxl_poison_record *poison)
> +{
> +	struct mce m;
> +	u64 dpa = le64_to_cpu(poison->address) & CXL_POISON_START_MASK;
> +	u64 len = le64_to_cpu(poison->length), i;
> +	phys_addr_t phys_addr = cxl_memdev_dpa_to_hpa(cxlmd, dpa);
> +
> +	if (phys_addr)
> +		return;
> +
> +	/*
> +	 * Initialize struct mce.  Call preempt_disable() to avoid
> +	 * "BUG: using smp_processor_id() in preemptible" for now, not sure
> +	 * if this is a correct way.
> +	 */
> +	preempt_disable();
> +	mce_setup(&m);
> +	preempt_enable();
> +
> +	m.bank = -1;
> +	/* Fake a memory read error with unknown channel */
> +	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV |
> +		   MCI_STATUS_MISCV | 0x9f;
> +	m.misc = (MCI_MISC_ADDR_PHYS << 6);
> +
> +	for (i = 0; i < len; i++) {
> +		m.addr = phys_addr++;
> +		mce_log(&m);

This loop looks wrong. What values do you expect for "len" (a.k.a.
poison->length)? Creating one log for each byte in the range will
be very noisy!

> +	}
> +}
> +
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr)
>  {
> -- 
> 2.34.1

-Tony
