Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D571C4A24
	for <linux-cxl@vger.kernel.org>; Tue, 15 Jul 2025 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752615237; cv=none; b=V2slbXVm9Ijpy0gasjRiCoTtBrmlKn+n5l3TmBZpzEB2HxV8tivn6kxj4JBYQoN9zxHz2su1j2tKcQivJwcTWb6UOyEm8lHGmtG/psd9uc4KT7cRh02OswZaY8/sgafJmlkYiDZfEqIQ9SsZdtYddr63bMAlcu18/MNEMyGfxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752615237; c=relaxed/simple;
	bh=KfvnScsRhv9l9F+7cJ66xrJ3ktjLDEPQ+Qjm739fREs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjo3/2yG0f+Xln5l49R4MLFHyUbxBeXq+4SgAko0Y+l6xhf9Wd7iG5ugJhkIJsAf13Bh2T3Hkv23lLKJSxANuRl4r7fyuG6e7sTtH27DqJsiPLIMT6JaJH/DDx2B+5pHUFWlsk8uCeFhxKM5/DQxrjKsA584dgYawqiKl9OWtFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gxfHz3jg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxfHz3jg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752615236; x=1784151236;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KfvnScsRhv9l9F+7cJ66xrJ3ktjLDEPQ+Qjm739fREs=;
  b=gxfHz3jgTes8plvXUWpMxdspCVEF/nKfJKj/HKNxth6Mcck3ovj/f0wu
   +rVQiZV9ztQZgoqsozzmmDPezjYReBCXRS4HZ264ADQul0PVzNbIrYsI0
   Fs2740Is9yPgHMdlEdS5/i9FJQhgPib+uWSE+7sff3yE2cony2/o56IeN
   C9vOouZ3BGzpoSvCV5Rx06uxDv7r4zX5JV7a2sxyfF7gWoo+UOYAPoiQb
   DARgZI8N/MMYNg1wS0SsKQbWynpWQT5ChZhXjorJK1Xebegl4NZOI8z7g
   pWQqMrbM7uVfb8Gsw2+BdgnX7D39cTRlwrK2QZLAcNpIsAVd6GYL/6lrE
   Q==;
X-CSE-ConnectionGUID: BC+5jcG6QBmTgbySwMT3kA==
X-CSE-MsgGUID: 6q9dgnXUSMiQqAt/3t+Vcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="72302665"
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="72302665"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 14:33:55 -0700
X-CSE-ConnectionGUID: UdYNxMFgR4yIvObrrWoYzQ==
X-CSE-MsgGUID: KpTrhUmYRQi+gSQOAUQ8cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="161653521"
Received: from tcingleb-desk1.amr.corp.intel.com (HELO [10.125.111.148]) ([10.125.111.148])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 14:33:55 -0700
Message-ID: <7f96a87e-0be6-4973-add3-51d2b5cbd6ef@intel.com>
Date: Tue, 15 Jul 2025 14:33:53 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] cxl/core: Add locked variants of the poison inject
 and clear funcs
To: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1752365427.git.alison.schofield@intel.com>
 <fce084f133cd1d53fe442ae67dc0cf3b00b2c2af.1752365427.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <fce084f133cd1d53fe442ae67dc0cf3b00b2c2af.1752365427.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/12/25 7:37 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The core functions that validate and send inject and clear commands
> to the memdev devices require holding both the dpa_rwsem and the
> region_rwsem.
> 
> In preparation for another caller of these functions that must hold
> the locks upon entry, split the work into a locked and unlocked pair.
> 
> Consideration was given to moving the locking to both callers,
> however, the existing caller is not in the core (mem.c) and cannot
> access the locks.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> 
> Changes in v3:
> Undo v2 return of rc from locked variants. Return 0. (Jonathan)
> 
>  drivers/cxl/core/memdev.c | 56 ++++++++++++++++++++++++++++-----------
>  drivers/cxl/cxlmem.h      |  2 ++
>  2 files changed, 42 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f5fbd34310fd..097fc9828f3a 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -276,7 +276,7 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
>  	return 0;
>  }
>  
> -int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
> +int cxl_inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
>  {
>  	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	struct cxl_mbox_inject_poison inject;
> @@ -288,13 +288,8 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> -	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> -	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
> -		return rc;
> -
> -	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
> -	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
> -		return rc;
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +	lockdep_assert_held(&cxl_rwsem.region);
>  
>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>  	if (rc)
> @@ -324,9 +319,26 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  
>  	return 0;
>  }
> +
> +int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
> +{
> +	int rc;
> +
> +	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
> +		return rc;
> +
> +	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
> +		return rc;
> +
> +	rc = cxl_inject_poison_locked(cxlmd, dpa);
> +
> +	return rc;
> +}
>  EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, "CXL");
>  
> -int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
> +int cxl_clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
>  {
>  	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>  	struct cxl_mbox_clear_poison clear;
> @@ -338,13 +350,8 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> -	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> -	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
> -		return rc;
> -
> -	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
> -	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
> -		return rc;
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +	lockdep_assert_held(&cxl_rwsem.region);
>  
>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>  	if (rc)
> @@ -383,6 +390,23 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  
>  	return 0;
>  }
> +
> +int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
> +{
> +	int rc;
> +
> +	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
> +		return rc;
> +
> +	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
> +		return rc;
> +
> +	rc = cxl_clear_poison_locked(cxlmd, dpa);
> +
> +	return rc;
> +}
>  EXPORT_SYMBOL_NS_GPL(cxl_clear_poison, "CXL");
>  
>  static struct attribute *cxl_memdev_attributes[] = {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index f5b20641e57c..869c73de12c8 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -861,6 +861,8 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
> +int cxl_inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa);
> +int cxl_clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa);
>  
>  #ifdef CONFIG_CXL_EDAC_MEM_FEATURES
>  int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd);

