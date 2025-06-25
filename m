Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FEC29B239
	for <linux-cxl@vger.kernel.org>; Wed, 25 Jun 2025 22:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750889751; cv=none; b=IrMlfnWsbz8ngJU3b5moc8g6Ey2uOrFaZiNG7W4A882AXIDcf3SXoaPoxpi5qFdumjRhnGUi8Jp5DQLmQEt1vtI91/O2BVioA3+sXGz8ctMDI8LKtTnP5DbS6AyQdMHWqs8XP/zFDaA1z4/yUHed9/6mTPW+NYKoook3iTNxk/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750889751; c=relaxed/simple;
	bh=DlJSzgfC1sEMmUJU5hO3ScyaV5UFF9CQVu3984R47ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKVpmqPQuZGzoaWmK8pYM1XUuWLJm0df7x8cWzN2X7xlxlfv4m7kDObhLEqPueHvT0GLc5pjrmk61bnCsB3e2Nox0bhEnjN8VavCKyUhi2kgXVIAsaqU1KDDBJ+4u5ypRL8bJk5k3tF/nkXX8wCa5fzjMiDbEoQB1PhbiuUrlN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQmXmBql; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQmXmBql"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750889750; x=1782425750;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DlJSzgfC1sEMmUJU5hO3ScyaV5UFF9CQVu3984R47ls=;
  b=TQmXmBqliSnsL8vivp4Hup4qcFICTVXu7W65NX5wlhsOV4np+ZGxFn3g
   QieFtnNBFfRLOguQGnwNZW8MJl+G712d3o/3gyDLliWtvDdgIPLRvSW4K
   fsbgWoBkLP2YOxsZtySvZLKONxFm0AjbbzKOxhYxjq7sz5CzuGLcg1Sel
   9qlivNmCJ6ipmKZz44Znx3f2YQk0pp3KHnO8MZQLgSqOLAkge4qMLgz9I
   B0yRf7aQo/Crz0V9TmzOFBoX5MI4goFD5NDJR3vwFVlRmRvFznFI+P+DY
   CuHwMR+1unSB6+GnEkQoWJ8Wz4snWXKDPB1LeQ/TY8/xpjse5df50+a35
   A==;
X-CSE-ConnectionGUID: QXS7Htx9SvGZOunNiIt1Fg==
X-CSE-MsgGUID: Oho3TvLnSiG2c3n80n6c+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="56960772"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="56960772"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 15:15:49 -0700
X-CSE-ConnectionGUID: AKGvo5dRRM+hG8hVg1WGeQ==
X-CSE-MsgGUID: avzPDImARASm71eiWrb7kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="183366548"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.109.5]) ([10.125.109.5])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 15:15:49 -0700
Message-ID: <be43f6b8-907b-4476-a84a-0c7b801a3f94@intel.com>
Date: Wed, 25 Jun 2025 15:15:45 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cxl/core: Add locked variants of the poison inject
 and clear funcs
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, alison.schofield@intel.com
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
References: <cover.1750725512.git.alison.schofield@intel.com>
 <71f51bcc7d335c9f558441bb68f05f546230696a.1750725512.git.alison.schofield@intel.com>
 <20250624143822.00003256@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250624143822.00003256@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/24/25 6:38 AM, Jonathan Cameron wrote:
> On Mon, 23 Jun 2025 17:53:34 -0700
> alison.schofield@intel.com wrote:
> 
>> From: Alison Schofield <alison.schofield@intel.com>
>>
>> The core functions that validate and send inject and clear commands
>> to the memdev devices require holding both the dpa_rwsem and the
>> region_rwsem.
>>
>> In preparation for another caller of these functions that must hold
>> the locks upon entry, split the work into a locked and unlocked pair.
>>
>> Consideration was given to moving the locking to both callers,
>> however, the existing caller is not in the core (mem.c) and cannot
>> access the locks.
>>
>> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> This will clash with Dan's ACQUIRE() set.  Up to Dave on how
> to handle that but my gut feeling is that if we want to queue much
> else this cycle and that we should ask for patches on top of the
> ACQUIRE() series.  The risk being that gets some later push back.

I think this patch may simplify more with ACQUIRE() if Dan hasn't already refactored the function. We can wait for a rev based off of that given there's an immutable branch with the ACQUIRE() patch on cxl.git already.

DJ

> 
> Ah well I'll apply the someone else's problem field.
> 
> Given reuse of these in patch 3 this looks sensible to me.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> 
>> ---
>>  drivers/cxl/core/memdev.c | 77 +++++++++++++++++++++++++--------------
>>  drivers/cxl/cxlmem.h      |  2 +
>>  2 files changed, 52 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index f88a13adf7fa..b38141761f47 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -280,7 +280,7 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
>>  	return 0;
>>  }
>>  
>> -int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>> +int __inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
>>  {
>>  	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>>  	struct cxl_mbox_inject_poison inject;
>> @@ -292,19 +292,12 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>>  		return 0;
>>  
>> -	rc = down_read_interruptible(&cxl_region_rwsem);
>> -	if (rc)
>> -		return rc;
>> -
>> -	rc = down_read_interruptible(&cxl_dpa_rwsem);
>> -	if (rc) {
>> -		up_read(&cxl_region_rwsem);
>> -		return rc;
>> -	}
>> +	lockdep_assert_held(&cxl_dpa_rwsem);
>> +	lockdep_assert_held(&cxl_region_rwsem);
>>  
>>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>>  	if (rc)
>> -		goto out;
>> +		return rc;
>>  
>>  	inject.address = cpu_to_le64(dpa);
>>  	mbox_cmd = (struct cxl_mbox_cmd) {
>> @@ -314,7 +307,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>  	};
>>  	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>>  	if (rc)
>> -		goto out;
>> +		return rc;
>>  
>>  	cxlr = cxl_dpa_to_region(cxlmd, dpa);
>>  	if (cxlr)
>> @@ -327,7 +320,26 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>  		.length = cpu_to_le32(1),
>>  	};
>>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
>> -out:
>> +
>> +	return rc;
>> +}
>> +
>> +int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>> +{
>> +	int rc;
>> +
>> +	rc = down_read_interruptible(&cxl_region_rwsem);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = down_read_interruptible(&cxl_dpa_rwsem);
>> +	if (rc) {
>> +		up_read(&cxl_region_rwsem);
>> +		return rc;
>> +	}
>> +
>> +	rc = __inject_poison_locked(cxlmd, dpa);
>> +
>>  	up_read(&cxl_dpa_rwsem);
>>  	up_read(&cxl_region_rwsem);
>>  
>> @@ -335,7 +347,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, "CXL");
>>  
>> -int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>> +int __clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
>>  {
>>  	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
>>  	struct cxl_mbox_clear_poison clear;
>> @@ -347,20 +359,12 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>>  		return 0;
>>  
>> -	rc = down_read_interruptible(&cxl_region_rwsem);
>> -	if (rc)
>> -		return rc;
>> -
>> -	rc = down_read_interruptible(&cxl_dpa_rwsem);
>> -	if (rc) {
>> -		up_read(&cxl_region_rwsem);
>> -		return rc;
>> -	}
>> +	lockdep_assert_held(&cxl_dpa_rwsem);
>> +	lockdep_assert_held(&cxl_region_rwsem);
>>  
>>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>>  	if (rc)
>> -		goto out;
>> -
>> +		return rc;
>>  	/*
>>  	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
>>  	 * is defined to accept 64 bytes of write-data, along with the
>> @@ -378,7 +382,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>  
>>  	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>>  	if (rc)
>> -		goto out;
>> +		return rc;
>>  
>>  	cxlr = cxl_dpa_to_region(cxlmd, dpa);
>>  	if (cxlr)
>> @@ -391,7 +395,26 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>  		.length = cpu_to_le32(1),
>>  	};
>>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
>> -out:
>> +
>> +	return rc;
>> +}
>> +
>> +int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>> +{
>> +	int rc;
>> +
>> +	rc = down_read_interruptible(&cxl_region_rwsem);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = down_read_interruptible(&cxl_dpa_rwsem);
>> +	if (rc) {
>> +		up_read(&cxl_region_rwsem);
>> +		return rc;
>> +	}
>> +
>> +	rc = __clear_poison_locked(cxlmd, dpa);
>> +
>>  	up_read(&cxl_dpa_rwsem);
>>  	up_read(&cxl_region_rwsem);
>>  
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 551b0ba2caa1..c0643e8b9d8f 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -861,6 +861,8 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>>  int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>>  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>>  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>> +int __inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa);
>> +int __clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa);
>>  
>>  #ifdef CONFIG_CXL_EDAC_MEM_FEATURES
>>  int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd);
> 

