Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8CD328270;
	Wed, 12 Nov 2025 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965279; cv=none; b=ZJXBStMZa/Y2nPIm6rC94i5RtyBBtKVbELoTSVdRlv7xWRtVLnuYUiII23NTnkU+G1wrm+9J7/lzwL0GoQ0BEhjCv593xMehfg00HFYjgCU4hpQd9ngerr4kfsikPyuw1dy7E3J2rPBGZNhoLFnqVMsSpu7f238kSC2dPhomAsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965279; c=relaxed/simple;
	bh=/l9AryvK0XODGKgVN8v4lcQFAVF222fvqL2WuzAN7xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGs6XP02xZB8V3Hr/Ijovyzngh8Ff+sAB4NVvkKzBjrwWaobmsriZ1DqkrH9KEQ+0MbkZpVE1+xGVcvkMEBMYJYrHGHDbjn8a5b5eOl41tmqWiuOGLRMo6YfeMw4f+HV5aly2S1ZHbsMatbcQs74o0EmRw+hZyybn7rM4S2a8zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=la1RCOx0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="la1RCOx0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762965277; x=1794501277;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/l9AryvK0XODGKgVN8v4lcQFAVF222fvqL2WuzAN7xI=;
  b=la1RCOx0ux8ziX/4W0OsxzsZbgc6iIVZKdK0lfoFIHwcG7VWLyibuA8T
   cXO29Tz7yCGUqeu8qUIHrWei8ZlrS0Kwxg5nKPtTIpInf5IF9LKrHsADF
   ToEHcBLw18wGQSfHyEGtTUehN7aB3FcqrXuzvJCX1JSQ909ziYagBVCP0
   Gd/0kpPWEL5tqLuGDqVLO3orYB/NKaJuw7KypFfGTDHSwH4GfWJu7FN/D
   hnIMtkTUkZbqgSYhJf61b/C77yaBbP9eABxR5cCNxHNEE2jg8koFxFwHf
   b3zkcTG1i7UCPOzjEAkQqtho5kY24Iy6qwHrop5ZPLM+V1XDVpkQBJtyL
   w==;
X-CSE-ConnectionGUID: dnhteoXQTBqdk8Ua+CTCrA==
X-CSE-MsgGUID: BdWO9u6RRgqqn+b5YnAcdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64917130"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="64917130"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 08:34:36 -0800
X-CSE-ConnectionGUID: VJ0H4UPWRNueNF3K+BF+sA==
X-CSE-MsgGUID: qrv1CK8wTvyDqxkZiIwaIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="188515630"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.108.30]) ([10.125.108.30])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 08:34:36 -0800
Message-ID: <6f1eaf10-071c-41ad-bda3-62eb6b1119e9@intel.com>
Date: Wed, 12 Nov 2025 09:34:34 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/14] cxl/atl: Lock decoders that need address
 translation
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-12-rrichter@amd.com>
 <ae28560c-ed16-400b-bf3d-86e2cc8617cf@intel.com>
 <aRMx-YYhaouP4LvR@rric.localdomain>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <aRMx-YYhaouP4LvR@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/25 5:54 AM, Robert Richter wrote:
> On 04.11.25 10:13:34, Dave Jiang wrote:
>>
>>
>> On 11/3/25 11:47 AM, Robert Richter wrote:
>>> There is only support to translate addresses from an endpoint to its
>>> CXL host bridge, but not in the opposite direction from the bridge to
>>> the endpoint. Thus, the endpoint address range cannot be determined
>>> and setup manually for a given SPA range of a region. If the endpoint
>>> has address translation enabled, lock it to prevent the kernel from
>>> reconfiguring it.
>>>
>>> Reviewed-by: Gregory Price <gourry@gourry.net>
>>> Signed-off-by: Robert Richter <rrichter@amd.com>
>>> ---
>>>  drivers/cxl/core/atl.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
>>> index d6aa7e6d0ac5..5c15e4d12193 100644
>>> --- a/drivers/cxl/core/atl.c
>>> +++ b/drivers/cxl/core/atl.c
>>> @@ -158,6 +158,16 @@ static int cxl_prm_translate_hpa_range(struct cxl_root *cxl_root, void *data)
>>>  		return -ENXIO;
>>>  	}
>>>  
>>> +	/*
>>> +	 * There is only support to translate from the endpoint to its
>>> +	 * parent port, but not in the opposite direction from the
>>> +	 * parent to the endpoint. Thus, the endpoint address range
>>> +	 * cannot be determined and setup manually. If the address range
>>> +	 * was translated and modified, forbid reprogramming of the
>>> +	 * decoders and lock them.
>>> +	 */
>>> +	cxld->flags |= CXL_DECODER_F_LOCK;
>>
>  
>> Feels like this should be something the BIOS should enforce if that
>> is the expectation? And the kernel checks and warns if that is not
>> the case.
> 
> I think this is more a limitation of the kernel implementation rather
> than the BIOS. The BIOS provides enought information by CFMWS, PRM,
> HDM and PCI topology. In theory and if there is demand for it, support
> could be added for driver region setup.

But shouldn't the BIOS set the decoder lock rather than the kernel setting a software lock flag based on assumption of the PRM based setup?

DJ

> 
> -Robert
> 
>>
>>> +
>>>  	ctx->hpa_range = hpa_range;
>>>  	ctx->interleave_ways = ways;
>>>  	ctx->interleave_granularity = gran;
>>
> ?

