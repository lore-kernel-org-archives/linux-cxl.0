Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101D198E81
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982980; cv=none; b=awZe+JKOBL1vGJ5jSmsDyv+yWSMsq19T1JVO79PWIX02rw4bDH0kK0s4yYvEfqp8kmqAKts28A8Iv9Czva7dltVfYMx07aLqxcHcjPw7sokgfxLK0/QaryTLpGteDbJp27wgxjMdGxd6segJ1YcL4tON6tQkY9Q9zPUEHBZFt3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982980; c=relaxed/simple;
	bh=vpat3ICs6/FR2l3kGqefBzsBsJh/G/BikZTczr304Uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxSzWzLOsjY0o013nAHxNcAvY5/4q3puhYGcaKkn/X5LTk0OPH89YHPaFDpcSpVaVwgYDhazrWjCwuvcPCJqujdWdRZej9+dUS+B2ISe7WJzfw/Gu4BYK1MIRmXWWtyDyQzC4IcSzLZzLsly9UiQ5+7yfzBBZ/0/rng3Xgq92ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDv6nfYa; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDv6nfYa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739982979; x=1771518979;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vpat3ICs6/FR2l3kGqefBzsBsJh/G/BikZTczr304Uk=;
  b=EDv6nfYaCwy2lP1HffYHWidq5j0h2DSYnFH7A1eVeIa/+5PCLG3Kao55
   UAQMyUa6ZQptlP+Z236lT7toyyWpJ+XNf7wq7q40mJ604Ay7uk4oCCPb8
   DsUHJnO74wtvLrTwXkefu8FjLolL9ptFrCRCsMeBcijr2mhGSlua3qkh7
   oMtfDTuXvPvlH9IHRiUMcJF+AOnZ0YI9M0cYYFw0fZRio3phciXM2co86
   k7XbcK8Q3MqC55J2FLa++fsJfYF16QlvlVRAdjf/EUWLmJ/QJRFFA+aTZ
   Va1CY3FihG+SYEyeMjGGNnenLY9jDAr0FmT8yWKaBxA9A/FAyk/Pf+pvu
   A==;
X-CSE-ConnectionGUID: 7CXjNjXuQKKSNIAQrVMzBg==
X-CSE-MsgGUID: aEUsEFYoTc++lJiGxWaFdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51710616"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="51710616"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 08:36:16 -0800
X-CSE-ConnectionGUID: s9QFpunMRh6dfT6S6VCn4Q==
X-CSE-MsgGUID: 3kDPi+CBSuChQs/ej3tG5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115664679"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 08:34:30 -0800
Message-ID: <21a5e8e1-d807-4bf2-978e-cc72f81d5e44@intel.com>
Date: Wed, 19 Feb 2025 09:34:17 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] cxl/pmem: Rename cxl_dirty_shutdown_state()
To: Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, seven.yi.lee@gmail.com,
 a.manzanares@samsung.com, fan.ni@samsung.com, anisa.su@samsung.com,
 linux-cxl@vger.kernel.org
References: <20250219062832.237881-1-dave@stgolabs.net>
 <20250219062832.237881-3-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250219062832.237881-3-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/18/25 11:28 PM, Davidlohr Bueso wrote:
> ... to a better suited 'cxl_arm_dirty_shutdown()'.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/mbox.c | 4 ++--
>  drivers/cxl/cxlmem.h    | 2 +-
>  drivers/cxl/pmem.c      | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index c5eedcae3b02..86d13f4a1c18 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1281,7 +1281,7 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
>  
> -int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds)
> +int cxl_arm_dirty_shutdown(struct cxl_memdev_state *mds)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_cmd mbox_cmd;
> @@ -1297,7 +1297,7 @@ int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds)
>  
>  	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_dirty_shutdown_state, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_arm_dirty_shutdown, "CXL");
>  
>  int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 8e1e46c348f5..6d60030139df 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -822,7 +822,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			    enum cxl_event_log_type type,
>  			    enum cxl_event_type event_type,
>  			    const uuid_t *uuid, union cxl_event *evt);
> -int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds);
> +int cxl_arm_dirty_shutdown(struct cxl_memdev_state *mds);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index a39e2c52d7ab..6b284962592f 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -90,7 +90,7 @@ static int cxl_nvdimm_probe(struct device *dev)
>  	 * clear it upon a successful GPF flow. The exception to this
>  	 * is upon Viral detection, per CXL 3.2 section 12.4.2.
>  	 */
> -	if (cxl_dirty_shutdown_state(mds))
> +	if (cxl_arm_dirty_shutdown(mds))
>  		dev_warn(dev, "GPF: could not dirty shutdown state\n");
>  
>  	dev_set_drvdata(dev, nvdimm);

