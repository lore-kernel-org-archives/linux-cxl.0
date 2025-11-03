Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC92314B96
	for <linux-cxl@vger.kernel.org>; Mon,  3 Nov 2025 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183201; cv=none; b=AribIoLdDrt6PpYEhTHimCeNxDQZW5PTysdgkrpa8FVNhyzTLW83+74JD4JlceEvQc8uhn5w5Zz96usSYIPPfOTAl9svkhMofR1oeMzt7vOr9cA1RjKqF3sc/D4HJ4VmzX9B+/a66SPz1G5g9R9wfD/uffbORKM9nuzZkKbc2AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183201; c=relaxed/simple;
	bh=rQJjivmDhsN/iIZOPP9iXrMzalJ44AxBglUcbe50G4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0rUnaJU0ItU8e+C+lRlomC6R/ssnhVZUWP7juWwgRgAOy3JD4G7ht9kEWg7cGtsF2agGaAip/GeoZ/bnQBVcqtjtaPhOc0t1cLlXCNhJ3oo1weupwBsaoMXb1wmQu6Rc9Lz2eK7BPeWkfv1s5TJPxme6T90brHp9v3frIIOQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQy7HMqv; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQy7HMqv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762183198; x=1793719198;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rQJjivmDhsN/iIZOPP9iXrMzalJ44AxBglUcbe50G4I=;
  b=DQy7HMqvlHeqUTTOT8iR5Vg80jWD7hYtXJImL+fn/2gqt152lScGHb5F
   MDAc/YvvTAo/7549a3Q1L9FSMIHb2sxJb08QhvQDi1lqlbf8yBRayjXRb
   PCp1RkNWtwDp3kxnN87mzKvxV3v0P8V+Rm0lgcHh0bk0zmfIWNIZ1HtFz
   d3jTakp3llDJS3+NTPIwHz8Hjm5OH7LOywnuPO8E5ShVbyYMwN42IMbUV
   O2X5zOpW1Uuhq9KMtCZybqfehjJVDeFCCwi5Lnev+3Fx4AUY57WMjMT4k
   EiOv1wjBMDk2VyInGXh2Y4OusTQJVfd3fkPBeyP3VhY7Rd1xAzsfEdRxi
   Q==;
X-CSE-ConnectionGUID: fPjkxcsvTtydZKH8JqavBw==
X-CSE-MsgGUID: L+ns8zDOR1G+oCu6XQDJmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75708620"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="75708620"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 07:19:57 -0800
X-CSE-ConnectionGUID: oF2Ix+ksTwWEe2xS+bqRrw==
X-CSE-MsgGUID: LxYQQNCCSTisG7cCEQb0dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="186567021"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.110.133]) ([10.125.110.133])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 07:19:56 -0800
Message-ID: <7cba5fad-7acc-4fb9-bf9c-b4fca7ce9665@intel.com>
Date: Mon, 3 Nov 2025 08:19:55 -0700
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
 <031a0108-6d30-4dab-b615-03a261eee18b@intel.com>
 <6904e489-2039-4e18-b9a0-8177df1d0a83@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <6904e489-2039-4e18-b9a0-8177df1d0a83@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/3/25 4:25 AM, Alejandro Lucero Palau wrote:
> 
> On 10/31/25 23:16, Dave Jiang wrote:
>>
>> On 10/29/25 9:17 AM, Alejandro Lucero Palau wrote:
>>> On 10/21/25 21:50, Dave Jiang wrote:
>>>> When a decoder is locked, it means that its configuration cannot be
>>>> changed. CXL spec r3.2 8.2.4.20.13 discusses the details regarding
>>>> locked decoders. Locking happens when bit 8 of the decoder control
>>>> register is set and then the decoder is committed afterwards (CXL
>>>> spec r3.2 8.2.4.20.7).
>>>>
>>>> Given that the driver creates a virtual decoder for each CFMWS, the
>>>> Fixed Device Configuration (bit 4) of the Window Restriction field is
>>>> considered as locking for the virtual decoder by the driver.
>>>>
>>>> The current driver code disregards the locked status and a region can
>>>> be destroyed regardless of the locking state.
>>>>
>>>> Add a region flag to indicate the region is in a locked configuration.
>>>> The driver will considered a region locked if the CFMWS or any decoder
>>>> is configured as locked. The consideration is all or nothing regarding
>>>> the locked state. It is reasonable to determine the region "locked"
>>>> status while the region is being assembled based on the decoders.
>>>>
>>>> Add a check in region commit_store() to intercept when a 0 is written
>>>> to the commit sysfs attribute in order to prevent the destruction of a
>>>> region when in locked state. This should be the only entry point from user
>>>> space to destroy a region.
>>>>
>>>> Add a check is added to cxl_decoder_reset() to prevent resetting a locked
>>>> decoder within the kernel driver.
>>>>
>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>> ---
>>>>    drivers/cxl/core/hdm.c    |  3 +++
>>>>    drivers/cxl/core/region.c | 16 ++++++++++++++++
>>>>    drivers/cxl/cxl.h         |  8 ++++++++
>>>>    3 files changed, 27 insertions(+)
>>>>
>>>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>>>> index d3a094ca01ad..1c5d2022c87a 100644
>>>> --- a/drivers/cxl/core/hdm.c
>>>> +++ b/drivers/cxl/core/hdm.c
>>>> @@ -905,6 +905,9 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>>>>        if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
>>>>            return;
>>>>    +    if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags))
>>>> +        return;
>>>> +
>>>
>>> This is correct, but is it enough?
>>>
>>>
>>> Would not the region teardown imply also the reset of those decoders in the path from the root port? Can we assume those will also be locked or should we add some sanity checking here?
>> Would checking the region the decoder belongs to for lock flag be sufficient?
> 
> 
> Yes, so any trying for removing the region failing, but maybe I'm confused with this check inside cxl_decoder_reset which implies to me such a region is being removed. I would expect a check in cxl_region_decode_reset which invokes this other function.

Yeah you are right, we should do the region lock check at cxl_region_decode_reset() and just leave the simple decoder lock check to cxl_decoder_reset(). > 
> 
> But my point is if we should check, maybe just at region creation time, if all the involved decoders have the lock bit set for coherency, assuming here the specs refer to such "locking path". Does locking an endpoint HDM decoder, by firmware or driver, implies the locking of the related decoders creating the path?

I'm not sure if the spec implies that. At least currently I'm setting that as a Linux policy to make things simple. We can consider altering that in the future if there's some specific case to consider that goes opposing to that.

DJ

> 
> 
>> DJ
>>
>>>
>>>>        if (port->commit_end == id)
>>>>            cxl_port_commit_reap(cxld);
>>>>        else
>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>> index b06fee1978ba..8647eff4fb78 100644
>>>> --- a/drivers/cxl/core/region.c
>>>> +++ b/drivers/cxl/core/region.c
>>>> @@ -419,6 +419,9 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
>>>>            return len;
>>>>        }
>>>>    +    if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
>>>> +        return -EPERM;
>>>> +
>>>>        rc = queue_reset(cxlr);
>>>>        if (rc)
>>>>            return rc;
>>>> @@ -1059,6 +1062,16 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>>>>        return 0;
>>>>    }
>>>>    +static void cxl_region_set_lock(struct cxl_region *cxlr,
>>>> +                struct cxl_decoder *cxld)
>>>> +{
>>>> +    if (!test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
>>>> +        return;
>>>> +
>>>> +    set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
>>>> +    clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
>>>> +}
>>>> +
>>>>    /**
>>>>     * cxl_port_attach_region() - track a region's interest in a port by endpoint
>>>>     * @port: port to add a new region reference 'struct cxl_region_ref'
>>>> @@ -1170,6 +1183,8 @@ static int cxl_port_attach_region(struct cxl_port *port,
>>>>            }
>>>>        }
>>>>    +    cxl_region_set_lock(cxlr, cxld);
>>>> +
>>>>        rc = cxl_rr_ep_add(cxl_rr, cxled);
>>>>        if (rc) {
>>>>            dev_dbg(&cxlr->dev,
>>>> @@ -2439,6 +2454,7 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
>>>>        dev->bus = &cxl_bus_type;
>>>>        dev->type = &cxl_region_type;
>>>>        cxlr->id = id;
>>>> +    cxl_region_set_lock(cxlr, &cxlrd->cxlsd.cxld);
>>>>          return cxlr;
>>>>    }
>>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>>> index 231ddccf8977..6382f1983865 100644
>>>> --- a/drivers/cxl/cxl.h
>>>> +++ b/drivers/cxl/cxl.h
>>>> @@ -517,6 +517,14 @@ enum cxl_partition_mode {
>>>>     */
>>>>    #define CXL_REGION_F_NEEDS_RESET 1
>>>>    +/*
>>>> + * Indicate whether this region is locked due to 1 or more decoders that have
>>>> + * been locked. The approach of all or nothing is taken with regard to the
>>>> + * locked attribute. CXL_REGION_F_NEEDS_RESET should not be set if this flag is
>>>> + * set.
>>>> + */
>>>> +#define CXL_REGION_F_LOCK 2
>>>> +
>>>>    /**
>>>>     * struct cxl_region - CXL region
>>>>     * @dev: This region's device
>>>>
>>>> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada

