Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763EB3264D5
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588714; cv=none; b=gZOI4KVrEf92anaSUqwnZSWZD2WKAXGyrxMkbsXNzB05vJFi/5JorxOyFGH5QczIVUo1jw04IK71ZTxBG0yOCl8NOI3yptGvptEg3h2GMdDfIXaTmJbG/UeBlo/NRoNK44DzrayhP7/aHeZpBCDNQuMQqSW4/OMo9mjeKD+n948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588714; c=relaxed/simple;
	bh=9rnsSqtwrOt0BrsX7D7tMAUmK8zlmkbd6fy+1baUwZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vv/l31ZcUIe/MNUlLMds54A5vJ3sFdlqIYOyabgPqaKNv/YFCSs+3ksOyIJpey+YKZ87nyT/v6txuTbBNt1IwZKT3TavagFSj5+g83mSGh7BYXJ8R8x3GPd9nAn3mZQyfDeEWtsb3XnIy7WS168pyDT7ULMniIN1Qx7eoMA2foU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3bMLQ/S; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3bMLQ/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780588713; x=1812124713;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9rnsSqtwrOt0BrsX7D7tMAUmK8zlmkbd6fy+1baUwZ4=;
  b=U3bMLQ/SvQHyMHu99loyqPhayUTyfdBnxX/XrpJDANlI2dB2+T3L7YWE
   nEehFsb1nuaXS+wqseWz85+uLK4RP4gWw2DLzNzEClqlCPVuM3WU6t7uw
   bhYn6+2SCQokUjlseb9BTcaRVdRxFSjK+lVtHRtlx+n/MEjg2zFp1u+gO
   LRxFivcYqjzN8QG6wODTkvVOhZSF0kIyfmsn8bZ6dM+XGZE69soitCOI2
   AaYmreaLU3lQ885ArMAdLV1Padm5xvv/nSjg2FwfiO4gUTQNV9gsPFTWh
   iyqgWlsE5bQhI4nbH2fYCnhMdGVLCbz1kn5WgvyCKUcW2S3Yx+VNuZ2YV
   w==;
X-CSE-ConnectionGUID: 8Y28IvtwQUOI23yrYR7kEA==
X-CSE-MsgGUID: +2b5AdGFT/2aZRqNSCx5Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="106865474"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="106865474"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 08:58:33 -0700
X-CSE-ConnectionGUID: sOg/+dUYRKmU34zWyKINkQ==
X-CSE-MsgGUID: z31z1F4DSKi+YQc67BBj+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="248926361"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.108.206]) ([10.125.108.206])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 08:58:32 -0700
Message-ID: <7e72a70e-2f59-40b7-a3c1-9a9b5ac62b30@intel.com>
Date: Thu, 4 Jun 2026 08:58:31 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cxl/pci: Fix the incorrect check of
 pci_config_read/write*() returns
To: Richard Cheng <icheng@nvidia.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, alison.schofield@intel.com,
 djbw@kernel.org
References: <20260603185752.4149725-1-dave.jiang@intel.com>
 <20260604111744.74cfc2bb@jic23-huawei> <aiFTbzlUZEr4UT6F@MWDK4CY14F>
 <aiFXjmEsg1-_6EtP@MWDK4CY14F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aiFXjmEsg1-_6EtP@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/4/26 3:51 AM, Richard Cheng wrote:
> On Thu, Jun 04, 2026 at 06:30:48PM +0800, Richard Cheng wrote:
>> On Thu, Jun 04, 2026 at 11:17:44AM +0800, Jonathan Cameron wrote:
>>> On Wed,  3 Jun 2026 11:57:50 -0700
>>> Dave Jiang <dave.jiang@intel.com> wrote:
>>>
>>>> The patches are inspired by comments from Richard Cheng WRT pci config
>>>> accessors return PCIBIOS errors that are positive integers rather than
>>>> negative errnos. I went and audited the cxl PCI code and found a few
>>>> locations that need to be fixed. There are other locations that may
>>>> trigger issues, but at this point we'll fix them as they happen.
>>
>> Hi Dave,
>>
>> Thanks for this, sorry I miss the email somehow
>> I'll look into details later, seems reasonable to me from
>> a glimpse.
>>
>> Best regards,
>> Richard Cheng.
>>
>>>>
>>> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
>>>
> 
> 
> The series looks good to me. There is still some minor cleanup left — 
> for example, cxl_dvsec_mem_range_active() still has the same problem.
> I plan to send follow-up patches for the remaining sites unless you
> prefer to fold them into this series.
> Let me know what you think.

Go ahead and send your follow on patches since you know which sites you want to fix. I'll create a branch that you can apply on top of with these two.

DJ

> 
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
>  
>>>>
>>>> Dave Jiang (2):
>>>>   cxl/pci: Fix the incorrect check of pci_read_config_word() return
>>>>   cxl/pci: Convert PCIBIOS errors to errno on DVSEC config accesses
>>>>
>>>>  drivers/cxl/core/pci.c | 22 +++++++++++-----------
>>>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>>>
>>>>
>>>> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
>>>
>>>
>>

