Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65CF1624DF
	for <linux-cxl@vger.kernel.org>; Fri, 31 Oct 2025 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761952591; cv=none; b=KMEluLq/sIzDpgLF+N/aud/lp0eLRi9YONS9yRuYAhzSc7tXMaE5uuXqYNBPtk67OcsvUC1ECKyz08ZwJS7I7LzDj8IqJEJylGdyzawgx4852MDb9m+UYsArgj175+pxi8xerw/KDtgGdLN5c1hAnv/ExntjArqXVsta446OXL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761952591; c=relaxed/simple;
	bh=1VjmH4Nd2lJX6DwpcsHJHjBZpz6LiVVa8KH1fqJQExI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHBzZsUhRWZoVjkRtWlGeUwAqo7h8QuS2KO2xVzLyERh6aX9cifCErvQj4EXBqob4F2pEYiePHqRVeH/j5hc4vcl/nTkZsWDBjp7flpjAVRllxQs/wQx3Y9AmrEFqvg7aumcSzTtFSMTxfdq31ETKpmS+O44uQHvLJXDTZ5pV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vvw7agWz; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vvw7agWz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761952590; x=1793488590;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1VjmH4Nd2lJX6DwpcsHJHjBZpz6LiVVa8KH1fqJQExI=;
  b=Vvw7agWzazJk1b+vXRjXH/Q0NINDjZYdhdPG71UI2MBpHMXww6uM0WTo
   I8+tsOqndx2sdE3CnlBIpA6LE4NTMcR7J+uD3bytaAOKD5rgB108X1gF3
   PbfN9T5doFFseVH3ulmwhD11oys8DbOmpynptmumSOX6YnW7jrzRcT/vc
   F+21jVU6uGRlOwwt81+bjfqG2vy3KvRgAi3FA7a8HWu8Z3avfOkXs0WDy
   FIez8CKjoFSIpME91nvc0jDfQiK5Z01H+YLE4cQv0/8m9ymJHxRjVR4Vu
   onUYQf9h1L4UM4ra6kHj3rvEanjyhgllusGzPeUtEu3+R1g0Kmr0y6nUw
   w==;
X-CSE-ConnectionGUID: PNWlRp7KTNqrRAbXgrV7VQ==
X-CSE-MsgGUID: zg3Rut9XRjaU5rsjVvuBdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="64269218"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="64269218"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 16:16:29 -0700
X-CSE-ConnectionGUID: pGTHgb3eRvyK4k9JHcxKkg==
X-CSE-MsgGUID: 344TO1wvRs63ahRjxxOOTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="187090411"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.49]) ([10.125.110.49])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 16:16:28 -0700
Message-ID: <031a0108-6d30-4dab-b615-03a261eee18b@intel.com>
Date: Fri, 31 Oct 2025 16:16:27 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Add handling of locked CXL decoder
To: Alejandro Lucero Palau <alucerop@amd.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20251021205055.2081800-1-dave.jiang@intel.com>
 <0884302f-8713-4d97-9a08-56091985a5d1@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <0884302f-8713-4d97-9a08-56091985a5d1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/29/25 9:17 AM, Alejandro Lucero Palau wrote:
> 
> On 10/21/25 21:50, Dave Jiang wrote:
>> When a decoder is locked, it means that its configuration cannot be
>> changed. CXL spec r3.2 8.2.4.20.13 discusses the details regarding
>> locked decoders. Locking happens when bit 8 of the decoder control
>> register is set and then the decoder is committed afterwards (CXL
>> spec r3.2 8.2.4.20.7).
>>
>> Given that the driver creates a virtual decoder for each CFMWS, the
>> Fixed Device Configuration (bit 4) of the Window Restriction field is
>> considered as locking for the virtual decoder by the driver.
>>
>> The current driver code disregards the locked status and a region can
>> be destroyed regardless of the locking state.
>>
>> Add a region flag to indicate the region is in a locked configuration.
>> The driver will considered a region locked if the CFMWS or any decoder
>> is configured as locked. The consideration is all or nothing regarding
>> the locked state. It is reasonable to determine the region "locked"
>> status while the region is being assembled based on the decoders.
>>
>> Add a check in region commit_store() to intercept when a 0 is written
>> to the commit sysfs attribute in order to prevent the destruction of a
>> region when in locked state. This should be the only entry point from user
>> space to destroy a region.
>>
>> Add a check is added to cxl_decoder_reset() to prevent resetting a locked
>> decoder within the kernel driver.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/core/hdm.c    |  3 +++
>>   drivers/cxl/core/region.c | 16 ++++++++++++++++
>>   drivers/cxl/cxl.h         |  8 ++++++++
>>   3 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index d3a094ca01ad..1c5d2022c87a 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -905,6 +905,9 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>>       if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
>>           return;
>>   +    if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags))
>> +        return;
>> +
> 
> 
> This is correct, but is it enough?
> 
> 
> Would not the region teardown imply also the reset of those decoders in the path from the root port? Can we assume those will also be locked or should we add some sanity checking here?

Would checking the region the decoder belongs to for lock flag be sufficient?

DJ

> 
> 
>>       if (port->commit_end == id)
>>           cxl_port_commit_reap(cxld);
>>       else
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index b06fee1978ba..8647eff4fb78 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -419,6 +419,9 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
>>           return len;
>>       }
>>   +    if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
>> +        return -EPERM;
>> +
>>       rc = queue_reset(cxlr);
>>       if (rc)
>>           return rc;
>> @@ -1059,6 +1062,16 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>>       return 0;
>>   }
>>   +static void cxl_region_set_lock(struct cxl_region *cxlr,
>> +                struct cxl_decoder *cxld)
>> +{
>> +    if (!test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
>> +        return;
>> +
>> +    set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
>> +    clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
>> +}
>> +
>>   /**
>>    * cxl_port_attach_region() - track a region's interest in a port by endpoint
>>    * @port: port to add a new region reference 'struct cxl_region_ref'
>> @@ -1170,6 +1183,8 @@ static int cxl_port_attach_region(struct cxl_port *port,
>>           }
>>       }
>>   +    cxl_region_set_lock(cxlr, cxld);
>> +
>>       rc = cxl_rr_ep_add(cxl_rr, cxled);
>>       if (rc) {
>>           dev_dbg(&cxlr->dev,
>> @@ -2439,6 +2454,7 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
>>       dev->bus = &cxl_bus_type;
>>       dev->type = &cxl_region_type;
>>       cxlr->id = id;
>> +    cxl_region_set_lock(cxlr, &cxlrd->cxlsd.cxld);
>>         return cxlr;
>>   }
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 231ddccf8977..6382f1983865 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -517,6 +517,14 @@ enum cxl_partition_mode {
>>    */
>>   #define CXL_REGION_F_NEEDS_RESET 1
>>   +/*
>> + * Indicate whether this region is locked due to 1 or more decoders that have
>> + * been locked. The approach of all or nothing is taken with regard to the
>> + * locked attribute. CXL_REGION_F_NEEDS_RESET should not be set if this flag is
>> + * set.
>> + */
>> +#define CXL_REGION_F_LOCK 2
>> +
>>   /**
>>    * struct cxl_region - CXL region
>>    * @dev: This region's device
>>
>> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada

