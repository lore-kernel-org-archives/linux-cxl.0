Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7467E46444
	for <linux-cxl@vger.kernel.org>; Tue, 11 Jun 2024 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126063; cv=none; b=px+L5dfcNuJOwq2MUk/HLDnHWneImzKoDvXCEDug62PmzBCUDN3WEUiEHxTrMUh8DDrdJRsZ0mPaRIa1g5fOMKvZMDvBbcedI9akkpu2I80JOFsouwWsTtdt1zKoqRc3RSyYI21D21eQiUkAMtnL0k9pUXJcnixJJYcZz3Jnywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126063; c=relaxed/simple;
	bh=MSJ7Lh9zOOxEjT11gFxAg1C/eKtumhb9xIt2mpPPWWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJQsojxjdcovL/ztslST1wDRea0g4S45sxO7EpZ+uLSx/J1hcl84fVe99dpy5SQSpOC0B18jYmje4Ib1FfmCIP7vkQFsA1LJ1ym0tSDor7LbxtG3P3dHSRMRRzVguPcximB4pfCia34uFeh35lP/lH61vdXu+DCNySWfjpNZDkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLB3towd; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLB3towd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718126061; x=1749662061;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MSJ7Lh9zOOxEjT11gFxAg1C/eKtumhb9xIt2mpPPWWc=;
  b=nLB3towdHpp+J+SPiNEnMkqsx7JaF6/nI3MJRA/b1P+8shq7LoNUp8sc
   R59T70FZ5vf/ad3OXxJwjAGJ5qtiLyK2PAoGSCU4L/bpd4flexgyZ2mMD
   oSVqQ8GA0Qt8SrOIzWDSNJDUZykBDiVr1XpUcPIIGhuJOKasWz8kc5Z6W
   pJDOfY4KVPCwejkr/zx8Xzioez6ITNHvx4Bx3PxlPVLyUD3vMTLzfLmh8
   Q6JErZ/QPsT8J8V9J87oNqB3vOf+N5FNS6pkorhKH6r+sUa4Bpq3/oC4W
   ZoG1QzUQEqn1al4gyU9z1qKmMSWWgzOgpUzC95ehL4babjrQmCSBYSVJN
   A==;
X-CSE-ConnectionGUID: eFjjA8GWREKgGy4jofy6sQ==
X-CSE-MsgGUID: EwMm8EDWRxSSvtUiAAlHjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="12022403"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="12022403"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 10:14:20 -0700
X-CSE-ConnectionGUID: 1mdnt1hFROiBxfNPlUGqOA==
X-CSE-MsgGUID: KLKPwY5HTA+NS6EEjT4P3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39482420"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.110.160]) ([10.125.110.160])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 10:14:20 -0700
Message-ID: <2852ad68-6fa2-4eaa-9024-ca401e57e666@intel.com>
Date: Tue, 11 Jun 2024 10:14:19 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] cxl/region: check interleave capability
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>, dave@stgolabs.net,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, jim.harris@samsung.com, linux-cxl@vger.kernel.org
References: <20240611021511.35315-1-yaoxt.fnst@fujitsu.com>
 <d7416f60-28fa-4848-a0cc-61431528db8a@intel.com>
 <20240611174618.000040ff@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240611174618.000040ff@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/11/24 9:46 AM, Jonathan Cameron wrote:
> 
>>>  drivers/cxl/core/hdm.c    | 10 +++++
>>>  drivers/cxl/core/region.c | 89 +++++++++++++++++++++++++++++++++++++++
>>>  drivers/cxl/cxl.h         |  2 +
>>>  drivers/cxl/cxlmem.h      |  1 +
>>>  4 files changed, 102 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>>> index 7d97790b893d..5b7dff19bbfa 100644
>>> --- a/drivers/cxl/core/hdm.c
>>> +++ b/drivers/cxl/core/hdm.c
>>> @@ -52,6 +52,11 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>>>  	struct cxl_dport *dport = NULL;
>>>  	int single_port_map[1];
>>>  	unsigned long index;
>>> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>>> +
>>> +	/* allow all the interleave capabilities for passthrough decoder */
>>> +	cxlhdm->interleave_mask = GENMASK(14, 8);
>>> +	cxlhdm->iw_cap_mask = BIT(1) | BIT(2) | BIT(4) | BIT(8);
>>>  
>>>  	cxlsd = cxl_switch_decoder_alloc(port, 1);
>>>  	if (IS_ERR(cxlsd))
>>> @@ -79,6 +84,11 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>>>  		cxlhdm->interleave_mask |= GENMASK(11, 8);
>>>  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
>>>  		cxlhdm->interleave_mask |= GENMASK(14, 12);
>>> +	cxlhdm->iw_cap_mask = BIT(1) | BIT(2) | BIT(4) | BIT(8);  
>>
>> Should define a mask for this. Probably should have defined masks for all of the open coded BIT() sets.
> 
> I don't agreed.  These bits are logically independent specifying each
> supported value of interleave ways.
> Put them under a define and I think you end up with less readable code.
> 

Seeing the 1,2,4,8 being set twice looks like a common pattern. but I don't have a strong opinion on this.

>>
>>> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, hdm_cap))
>>> +		cxlhdm->iw_cap_mask |= BIT(3) | BIT(6) | BIT(12);
>>> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
>>> +		cxlhdm->iw_cap_mask |= BIT(16);
>>>  }
> 
> 
> 
> 
