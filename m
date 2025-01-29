Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBB01DF975;
	Wed, 29 Jan 2025 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169516; cv=none; b=EucE9dcEMoBMZk/e9gHBqrnh5ckMxEMxIjXDeGumShL+4wXCrGKvWYgoNDIOPwORbNsN1KUvR6clY38KU4othznmE1179FRF2zB1nCBb4cC9QACnC5h2TVEsPK9pGMoFSbYcdqsSXsFc8UBlwpcr0eHuhqLXqQHN14VWnz45HhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169516; c=relaxed/simple;
	bh=g5r2e0UPlo5qJb9puOZH4xn1SKtebY37CCxIdtvocDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dU/v2QqAI9nLLd7tYlJefYHdjjqOJYciDlbqQ1vsEVzii0+SdbcvNYO2v23Ek/fpMhrV3JrSHkkqWKNceUf9gB5thiJTwpbj1KxVDdc4QeNjVTB1d/C2uecKMrsq4eO1mTo/hd0OZlC6M9lQQ7ca6pKBLqyEw98kCQEzkCx6FD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G0etiGPZ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0etiGPZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738169514; x=1769705514;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g5r2e0UPlo5qJb9puOZH4xn1SKtebY37CCxIdtvocDw=;
  b=G0etiGPZVHtvoZ9DtKFxafzY8mq7B3CIJyjUsnK70BQ8eaaTuJI69U1U
   DlRn9SPEK1VDjqP3TUoWJEL2cqKTpmArhrEfkKmNqdRdESeo8zZl37QxC
   EK1hZv98HBBuFfeLgR3YTGA3fadNBO7oN4ERh6yU25lOX6jdRXwblQLBF
   xjIpNCNgEaSoMBa7oY6+cGpRRnwLIeStm3u6rMffUZp6/pKNuG0HoiNyX
   N8Q1nhko9obZzfGWbdQZKsLZ4RrS14CsBUg9gFgyXNeskyyJFq2RZ7xH6
   /MQ6E4hAURjWQMAN+C2MeyBwfJWhEs3mTbNOk83ett+ZXj1UNyqpPWg0t
   g==;
X-CSE-ConnectionGUID: KtSifE1pS7KEJpjn0maMPA==
X-CSE-MsgGUID: l6ibRhh1TeCuiGLzkf7Sag==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="49348685"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="49348685"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 08:51:53 -0800
X-CSE-ConnectionGUID: SQurXeXdREOARJmUVFkOHA==
X-CSE-MsgGUID: fHiaR8SKQaKf6M9qah9duw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="108901676"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.108.127]) ([10.125.108.127])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 08:51:53 -0800
Message-ID: <a427509a-f428-44d3-a16d-3e39b246f51c@intel.com>
Date: Wed, 29 Jan 2025 09:51:52 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] cxl/memdev: Remove unused partition values
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
 <20250128-rfc-rearch-mem-res-v1-1-26d1ca151376@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250128-rfc-rearch-mem-res-v1-1-26d1ca151376@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/28/25 11:51 AM, Ira Weiny wrote:
> The next volatile and next persistent values are unused and are
> cluttering the cxl_memdev_state.
> 
> Remove these values.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/mbox.c | 4 ----
>  drivers/cxl/cxlmem.h    | 4 ----
>  2 files changed, 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 62bb3653362f5325cfdab7812633328eac50ab30..998e1df36db673c47c4e87b957df9c29bf3f291a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1097,10 +1097,6 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
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
> index f218d43dec9fd89f950af667ff033d0802084345..29817f533e5e408243d361c46ddbf0c295b4fda4 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -548,8 +548,6 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>   * @partition_align_bytes: alignment size for partition-able capacity
>   * @active_volatile_bytes: sum of hard + soft volatile
>   * @active_persistent_bytes: sum of hard + soft persistent
> - * @next_volatile_bytes: volatile capacity change pending device reset
> - * @next_persistent_bytes: persistent capacity change pending device reset
>   * @event: event log driver state
>   * @poison: poison driver state info
>   * @security: security driver state info
> @@ -570,8 +568,6 @@ struct cxl_memdev_state {
>  	u64 partition_align_bytes;
>  	u64 active_volatile_bytes;
>  	u64 active_persistent_bytes;
> -	u64 next_volatile_bytes;
> -	u64 next_persistent_bytes;
>  
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
> 

