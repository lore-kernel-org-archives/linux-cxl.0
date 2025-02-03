Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5C0204C34
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738599782; cv=none; b=fcQu5PUQ5msH8gT8NPuk5zEKI00kudgJtggjwlIsIUnsvy+EfD9HNBROQAqflvD3FmXyFTw0V6JB4boymm9TXW5xmHXu6MI5vgvurmL9Z7SFACDYI9nBPFEa6wzSX2daH2cOrzIshIr1nkUvgyZjhcipM8575Huus6uhJbDEx5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738599782; c=relaxed/simple;
	bh=Y9NtgN28aL9HuEiwk4Sj0Yk3lAFeA1h6G81r8+3RunI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clSkuJRWul7tiqE5b6d8VH5LfnIIfFe9E+JrQhn35vzV94mZL9VLAT3cTEY7XLehCCbbaua1JQRdgvu1M1a4E4gN3/R1UluZi8ww9BtYuOXaX9ZZioxXpThtAcwwjAI/AwcDn55Ej5/xIzgFgA6i00Ah+OLHn4PlMxfKHY+kOro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iPsd61UK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iPsd61UK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738599780; x=1770135780;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y9NtgN28aL9HuEiwk4Sj0Yk3lAFeA1h6G81r8+3RunI=;
  b=iPsd61UKtIf+l8+sXnAx7ZDIbha0C3WwBX9FIuil5uC0bY77ADJA/7wX
   1KvIR/kc+b6RK456i/quwBFMxQ+gEHy2PdW7dedOZRB9CPXDkdJO2usCd
   x2ojJnws2gvYgVlO1xs2npkJEFzwWNsPE8ra1GmAzpXf0nDqrZw4c2pOs
   Vkpba1Ge0jEApAylpfTTNi3R07NivM/qGhjWNF6d29OT0+ND4pZNh2m3f
   LP/33lFz5m+JylcU/u5JRmXTtFmblhhZCIhMS6Jtd7gc+d8LYR+2HnLvT
   HSrsKd2g5KnnMZ3vUHSidv0QYsWqoNYm1wj9SMdfD77Sx9NyztohdU5W1
   w==;
X-CSE-ConnectionGUID: OCK7RNGnT6mXLDTJxsmjwg==
X-CSE-MsgGUID: aF7qDU/2TvmQzPN2Dsve5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="56636018"
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="56636018"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 08:22:59 -0800
X-CSE-ConnectionGUID: Zo2LGYl4SduKwp7hbjHw3g==
X-CSE-MsgGUID: Eb9tbLVZRj+R+cCNwoDL5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="141185661"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.109.215]) ([10.125.109.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 08:22:58 -0800
Message-ID: <2ab57ca5-40a9-471c-9b13-10b9b2bbc504@intel.com>
Date: Mon, 3 Feb 2025 09:22:48 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] cxl: Add FWCTL support to the CXL memdev driver
To: Jason Gunthorpe <jgg@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net,
 shiju.jose@huawei.com
References: <20250201004459.466499-1-dave.jiang@intel.com>
 <20250201004459.466499-9-dave.jiang@intel.com>
 <20250203124232.00003dd2@huawei.com> <20250203142554.GV5556@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250203142554.GV5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/3/25 7:25 AM, Jason Gunthorpe wrote:
> On Mon, Feb 03, 2025 at 12:42:32PM +0000, Jonathan Cameron wrote:
> 
>>> diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
>>> index 82598a409acc..2dcfefdfa6b3 100644
>>> --- a/drivers/cxl/features.c
>>> +++ b/drivers/cxl/features.c
>>
>>>  
>>> +/* The __weak symbol gets replaced by FWCTL allocation function in fwctl.c */
>>> +struct cxl_features_state * __weak devm_cxlfs_allocate(struct cxl_memdev *cxlmd)
>>> +{
> 
>> This use of weak functions is a bit too clever for me to be entirely happy but it
>> seems right so fair enough.
> 
> weak functions have become frowned upon lately and I can't clearly see
> why you'd want this? Can you do it without it please?

The intent is to allow the allocation function to be replaced with the FWCTL version when CONFIG_CXL_FWCTL is set. I'll think about how to do this differently. I was really trying to avoid doing #ifdef in the C file. 
 
> 
> Jason

