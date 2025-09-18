Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAD8246795
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758231943; cv=none; b=UGG9BjFLG74VpErZYenv6TL/Ri604EQm5ISGsHSDAC1nUWRodtbC+KARgeeVbTJs/w6oI3wbyNN7RFeUwsMPbiygFIuqw3njPUmyoDWtCKFEZrAtaAX8Mr2XkWhUMIHZ9rbGuCCJLOVf730VaPBaCmPqqHOpObFxrOrQMIJNsJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758231943; c=relaxed/simple;
	bh=+fjbc64Q1wUeUhqpFBhlQeSsDVZj0KxpLf9tTaq11Bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ze2nn1SfAN3iDvoqwaGCl3AgPKqHXrFA3AzOSZ0tvm7/hn/WV25YmdOfSxFwDyNPS9K9CvQYdviWEcyDe209GRKOnMgCApMTZVHqEeF+qZ5siL3U8PVFP5fK7rH50AQYsoG2kzBFI6hosOrNEClZHxaPbT8SECsT2hTgisHN6Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=afD05eVq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="afD05eVq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758231941; x=1789767941;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=+fjbc64Q1wUeUhqpFBhlQeSsDVZj0KxpLf9tTaq11Bs=;
  b=afD05eVqmFbC2CT7ULJ+KhtMvNcT6aaruebjyQmAb6t4rZKRyb51ZxaY
   Kdb7NR9YQ2SWN6mJ041bL1o4GrAxDDM+HcvNLoWD6PrNensFdNPQ1sRtC
   wctR56FqirGoBOCIq2IpWV9eYQ7/TVgo1vJIsr2TA4aFYpJhRmAt2Fdv9
   psmmg5MoeTL1ITXkg66nC9OkdVqXbOQ4Ec9ZTGYWZjosxhy7aHJTv1ZG7
   vEnzN00l61uaTKvCo1tuVkuaRmg+SHG6Px6iL8E2h0Qf6fNilxw76fGN2
   KWynD+akaCvwrV0f+51oaho3aIcukXlIL6dmHonCVU9IVzrZsnRGqCxj+
   A==;
X-CSE-ConnectionGUID: Tk07oQT6S5eWpmYlVsuWDw==
X-CSE-MsgGUID: bFL96qyeSSGnWCYTYayCBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="78179981"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="78179981"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 14:45:40 -0700
X-CSE-ConnectionGUID: CN+ZX/bqRHyRoTC5j+cXqA==
X-CSE-MsgGUID: kZV7Wv6FRk6XGafVjYLsTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="176471877"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.28]) ([10.125.108.28])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 14:45:40 -0700
Message-ID: <5edd311e-4ef5-454c-bdc3-6eac654e29e4@intel.com>
Date: Thu, 18 Sep 2025 14:45:38 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 18/18] cxl/core: Add cache device cache management
 attributes
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 linux-cxl@vger.kernel.org
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-19-Benjamin.Cheatham@amd.com>
 <29b9953a-8367-4545-a783-dfabbfa488d7@intel.com>
 <9002a2f5-6319-405f-9fb4-22c841ae0191@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <9002a2f5-6319-405f-9fb4-22c841ae0191@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/25 1:16 PM, Cheatham, Benjamin wrote:
> [snip]
> 
>>> +
>>> +int cxl_accel_caching_disabled(struct cxl_dev_state *cxlds)
>>
>> why not just return bool?
>>
> 
> If, in the unlikely case, pci_read_config_word() fails. I can change it to bool
> if we aren't concerned about that though.

I think if you hit error, you just end up with returning false indicating caching disabled (whether due to not enabled or due to error)?

> 
>>> +{
>>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>> +	int dvsec, rc;
>>> +	u16 ctrl2;
>>> +
>>> +	device_lock_assert(cxlds->dev);
>>> +
>>> +	if (!dev_is_pci(cxlds->dev))
>>> +		return -EINVAL;
>>> +	pdev = to_pci_dev(cxlds->dev);
>>> +
>>> +	dvsec = cxlds->cxl_dvsec;
>>> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &ctrl2);
>>> +	if (rc)
>>> +		return rc;
>>> +
>>> +	return !!(ctrl2 & CXL_DVSEC_DISABLE_CACHING);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_caching_disabled, "CXL");
>>> +
>>> +int cxl_accel_set_cache_disable(struct cxl_dev_state *cxlds, bool disable)
>>> +{
>>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>> +	int dvsec, rc;
>>> +	u16 ctrl2;
>>> +
>>> +	if (!dev_is_pci(cxlds->dev))
>>> +		return -EINVAL;
>>> +
>>> +	guard(device)(cxlds->dev);
>>> +	dvsec = cxlds->cxl_dvsec;
>>> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &ctrl2);
>>> +	if (rc)
>>> +		return rc;
>>> +
>>> +	if (!!(ctrl2 & CXL_DVSEC_DISABLE_CACHING) == disable)
>>> +		return 1;
>>> +
>>> +	ctrl2 &= ~CXL_DVSEC_DISABLE_CACHING;
>>> +	ctrl2 |= FIELD_PREP(CXL_DVSEC_DISABLE_CACHING, disable);
>>> +	return pci_write_config_word(pdev, dvsec + CXL_DVSEC_DISABLE_CACHING,
>>> +				     ctrl2);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_set_cache_disable, "CXL");
>>> +
>>> +int cxl_accel_initiate_wbinvd(struct cxl_dev_state *cxlds)
>>> +{
>>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>> +	int dvsec, rc;
>>> +	u16 ctrl2;
>>> +
>>> +	if (!dev_is_pci(cxlds->dev))
>>> +		return -EINVAL;
>>> +
>>> +	if (cxl_accel_caching_disabled(cxlds) != 1)
>>> +		return -EBUSY;
>>> +
>>> +	guard(device)(cxlds->dev);
>>> +	dvsec = cxlds->cxl_dvsec;
>>> +	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &ctrl2);
>>> +	if (rc)
>>> +		return rc;
>>> +
>>> +	ctrl2 |= CXL_DVSEC_INIT_WBINVD;
>>> +	return pci_write_config_word(pdev, dvsec + CXL_DVSEC_CTRL2_OFFSET,
>>> +				     ctrl2);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_initiate_wbinvd, "CXL");
>>> +
>>> +int cxl_accel_cache_invalid(struct cxl_dev_state *cxlds)
>>
>> return bool?
>>
> 
> Same idea as above.

Right, cache_invalid or error. Same result right? There is no different handling because of error.

> 
> Thanks,
> Ben
> 

