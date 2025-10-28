Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17572857EA
	for <linux-cxl@vger.kernel.org>; Tue, 28 Oct 2025 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664652; cv=none; b=XyfweZI858LI1bza7bzSIcjbLPBJIFlkDdbCCRyywa5ms9xI1pUZS/4t46L1f3u9PSPC8R1YvzLXxm/XVTwmtREHUfVE7futg+KVIxGNLIGJmal1MFZrv1++q7Rmar97J7/zrSbvocqOWyIivIF5FxrP1Kob3z7Xq0ggynUP9ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664652; c=relaxed/simple;
	bh=fpuGpyx9H+JfRQ2CF7OEmvY7upB+tOWhkDFgf9UInmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibAgFnWWLKoxUSlV4GaZobGZoBRV5pbIqch6Fhxll+OF3GXRMZGIsJuCfSesVcdtQiVCG8HGs7IpZB0iIYt4iibxKjKRY7ZY10mazmtXyzrxnpgcOb1psGaBvMFHVlEMNUwXAWc7QH0wcYTdVhI4UXYnxDqwBnAOrraaPIYLRN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gA/SIejx; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gA/SIejx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761664650; x=1793200650;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fpuGpyx9H+JfRQ2CF7OEmvY7upB+tOWhkDFgf9UInmw=;
  b=gA/SIejxk+bbN4ua9TW03odG8mua0XWUwcIZwF11kYKOsx6SYFcEAwz2
   S7JgdCC0O2GqVobR5H+wbaTLqBA4oEiYfi/mmDZnPHNMSkOVwkXy/f2Rv
   rTrlA9vfUSTUy3Dzw/zNOWrnDCsAqhtDAz6VvqgQ/3OVTDAT3YIVZt9M9
   xGvQWVBXopXSDu3Swrbr5jga4vfrDJARLF2HXuAF1tg6aHhvILzmsDzB4
   i+VI8i9Uq+tlMlDdjlyr3nVE8qglrMsjddvK2mNeEZTMQ9N5fOkK6lQId
   GCz+QpmIK4MgfpXo+BgIpqGnSGCTDvw9nSDaWoSrab5XyupHJisvneMkD
   A==;
X-CSE-ConnectionGUID: QDgqIlhjRZCrUNRC6VcRwg==
X-CSE-MsgGUID: 5a71keNeR7mEKzuBrxj0qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62796828"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="62796828"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 08:17:30 -0700
X-CSE-ConnectionGUID: 0cdGij9SQEqryR0EI1Qpeg==
X-CSE-MsgGUID: tCANMlVUSOmKtNQ26rEjFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="222585095"
Received: from tslove-mobl4.amr.corp.intel.com (HELO [10.125.109.156]) ([10.125.109.156])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 08:17:30 -0700
Message-ID: <637292ff-0cca-41bd-8ce9-4e38d6b1ff1b@intel.com>
Date: Tue, 28 Oct 2025 08:17:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Add handling of locked CXL decoder
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20251021205055.2081800-1-dave.jiang@intel.com>
 <20251028143914.00004f46@huawei.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251028143914.00004f46@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/28/25 7:39 AM, Jonathan Cameron wrote:
> On Tue, 21 Oct 2025 13:50:55 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
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
> 
> Fully agree with what should be happening here, but a question below
> on the implementation.
> 
>> ---
>>  drivers/cxl/core/hdm.c    |  3 +++
>>  drivers/cxl/core/region.c | 16 ++++++++++++++++
>>  drivers/cxl/cxl.h         |  8 ++++++++
>>  3 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index d3a094ca01ad..1c5d2022c87a 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -905,6 +905,9 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>>  	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
>>  		return;
>>  
>> +	if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags))
>> +		return;
>> +
>>  	if (port->commit_end == id)
>>  		cxl_port_commit_reap(cxld);
>>  	else
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index b06fee1978ba..8647eff4fb78 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -419,6 +419,9 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
>>  		return len;
>>  	}
>>  
>> +	if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
>> +		return -EPERM;
>> +
>>  	rc = queue_reset(cxlr);
>>  	if (rc)
>>  		return rc;
>> @@ -1059,6 +1062,16 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>>  	return 0;
>>  }
>>  
>> +static void cxl_region_set_lock(struct cxl_region *cxlr,
>> +				struct cxl_decoder *cxld)
>> +{
>> +	if (!test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
>> +		return;
>> +
>> +	set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
> 
> The sequence above here looks odd.  If the bit is not set, then don't 
> set it? If already set then set it again? Was one of these meant to be
> related to the decoder that was passed in? 
> 
> Maybe I need more coffee...

No. That's my mistake. It should be checking the cxld for locked bit and not the region.

DJ

> 
> 
>> +	clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
>> +}
>> +
>>  /**
>>   * cxl_port_attach_region() - track a region's interest in a port by endpoint
>>   * @port: port to add a new region reference 'struct cxl_region_ref'
>> @@ -1170,6 +1183,8 @@ static int cxl_port_attach_region(struct cxl_port *port,
>>  		}
>>  	}
>>  
>> +	cxl_region_set_lock(cxlr, cxld);
>> +
>>  	rc = cxl_rr_ep_add(cxl_rr, cxled);
>>  	if (rc) {
>>  		dev_dbg(&cxlr->dev,
>> @@ -2439,6 +2454,7 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
>>  	dev->bus = &cxl_bus_type;
>>  	dev->type = &cxl_region_type;
>>  	cxlr->id = id;
>> +	cxl_region_set_lock(cxlr, &cxlrd->cxlsd.cxld);
>>  
>>  	return cxlr;
>>  }
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 231ddccf8977..6382f1983865 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -517,6 +517,14 @@ enum cxl_partition_mode {
>>   */
>>  #define CXL_REGION_F_NEEDS_RESET 1
>>  
>> +/*
>> + * Indicate whether this region is locked due to 1 or more decoders that have
>> + * been locked. The approach of all or nothing is taken with regard to the
>> + * locked attribute. CXL_REGION_F_NEEDS_RESET should not be set if this flag is
>> + * set.
>> + */
>> +#define CXL_REGION_F_LOCK 2
>> +
>>  /**
>>   * struct cxl_region - CXL region
>>   * @dev: This region's device
>>
>> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
> 

