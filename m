Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5C31DDC04;
	Thu,  6 Feb 2025 21:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738876175; cv=none; b=ra4CGm4TH+tYRgwGmEbolStLwil/gkh+s9xxKrh6sbTq4Y6DTJjELTwfzMvGXbDVkJNatpO1Y0Xp/TSianpGf4gw4fPOqAL1aB8YFOUIY0rtH+JX14VpvhOPvJVaAW0t1voK+FzRdsE1gHaJo4/4y15UKKUC1/bK6iBO8zLVGeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738876175; c=relaxed/simple;
	bh=WLG+5Ize6NTQ4vHNiLZ25t7qbylKa3tUlPCB7J7dRDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbkSfGCcSL7VJ3enrp8zaXuT78tpggdMJcC82qQAX3FsSSMLAhhB8pbNSgp9B9smV71fmYSdEYretkbZxDKgQO5V8FD0KDI4NzyLEMclmOmaGneKqPBvtXt7+BrfBM6iUQNRWkYUHkxeYjH6qZgot//mg+SGJ0+JqT1V4FKScOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lS2Yuw/s; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lS2Yuw/s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738876173; x=1770412173;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WLG+5Ize6NTQ4vHNiLZ25t7qbylKa3tUlPCB7J7dRDU=;
  b=lS2Yuw/s26un37Bu/ctzHmXKgAHdEzZHycvA6wloGPJBa9hxd80rqi44
   mCDmYuVIIRQiPjeRSlbiRhMzvwppEfipdWZY6PWZIe7ho59Ktu3kgo7fP
   abZC9s4FZNETwyfpCMeFFl7rKpBV2IUf8LqmH2zF+325z45uiFhS1XW1X
   D26qy76FfcrI+SDP2c0GMGx0LxHNsppYfZmZdQEWxzR4B8kg/JqAAB6Tf
   iChNun7SRiV5AoYC1grCQaR07PtGirzOGoWnELWRXaWaV+0/uwqhN52Z/
   3nMICkUpez67NdudesYPrA4mI5wAWqDHDdQknmoS4SOJ+SfPawQxCXIb8
   w==;
X-CSE-ConnectionGUID: AaBak31HS4as8fnuNR00Og==
X-CSE-MsgGUID: UoE2UbSmROaUqthI+82T9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39621286"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39621286"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 13:09:32 -0800
X-CSE-ConnectionGUID: SG75rTwQRv+F4tpCnw8MFQ==
X-CSE-MsgGUID: +61D17zNQzqGdJVe/01pPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="111524957"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.110.242]) ([10.125.110.242])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 13:09:30 -0800
Message-ID: <d8cc2de3-32ae-4873-9dea-d78d619c2777@intel.com>
Date: Thu, 6 Feb 2025 14:09:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/memdev: Remove unused partition values
To: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fan Ni <fan.ni@samsung.com>
References: <20250206-cxl-cleanup-v1-1-9ddf26dd8433@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250206-cxl-cleanup-v1-1-9ddf26dd8433@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/25 12:34 PM, Ira Weiny wrote:
> The next volatile and next persistent values are unused and are
> cluttering the cxl_memdev_state.
> 
> Remove these values.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Applied to cxl/next

> ---
>  drivers/cxl/core/mbox.c | 4 ----
>  drivers/cxl/cxlmem.h    | 4 ----
>  2 files changed, 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 8d95281c52d4368cd28dcf48b6cdd13b95901429..c5eedcae3b022cfee8166eb13a1529ccf6200196 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1092,10 +1092,6 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
>  		le64_to_cpu(pi.active_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
>  	mds->active_persistent_bytes =
>  		le64_to_cpu(pi.active_persistent_cap) * CXL_CAPACITY_MULTIPLIER;
> -	mds->next_volatile_bytes =
> -		le64_to_cpu(pi.next_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
> -	mds->next_persistent_bytes =
> -		le64_to_cpu(pi.next_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
>  
>  	return 0;
>  }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c0d2a8b6aaf694587ae321d257e74d5e92a20cd5..8e1e46c348f5a10f4fa15dce8ac57a3480c8c509 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -468,8 +468,6 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>   * @partition_align_bytes: alignment size for partition-able capacity
>   * @active_volatile_bytes: sum of hard + soft volatile
>   * @active_persistent_bytes: sum of hard + soft persistent
> - * @next_volatile_bytes: volatile capacity change pending device reset
> - * @next_persistent_bytes: persistent capacity change pending device reset
>   * @event: event log driver state
>   * @poison: poison driver state info
>   * @security: security driver state info
> @@ -488,8 +486,6 @@ struct cxl_memdev_state {
>  	u64 partition_align_bytes;
>  	u64 active_volatile_bytes;
>  	u64 active_persistent_bytes;
> -	u64 next_volatile_bytes;
> -	u64 next_persistent_bytes;
>  
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
> 
> ---
> base-commit: 861e232e15c278d6cfc5a675efe393b4838b1773
> change-id: 20250206-cxl-cleanup-818a668841db
> 
> Best regards,

