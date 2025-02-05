Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FE71DF242
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777957; cv=none; b=RCjf9Ypk4a3C+WKtyQPq3yTFV5t+v/UbeKpa7+RDMOXGvfxshRQI/z+zhZAgO+2iOxhLmN+dVkyYQ6qsWsftvDninDgGWTOu1vcHMq+6SmRhObZZKyDQzLPGXK4A/mywfluU3jg0D3hEn6aWxH7YAAWicWUoe/8/IFxMpwLj8OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777957; c=relaxed/simple;
	bh=C9yoU41fZP6TEt758uDkc66qkW3/BQvO4YCMbAnR+eA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmN/jSqpAFniD0AKE7sRNgQyNewN5R2EUeEmSwbFtzxqqxtij8blKaRq2frMldfRNPnrvIlFeYR/Sma5fILP91UBTb/cdQ7h3kz9Q23mFx1/K6OtrEGz4Of+uTlOjnCBvUvGb679aOVjHyxRixcIKUEm4iBAY29ZqhmNV/rBqdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dSsqDpzx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSsqDpzx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738777949; x=1770313949;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C9yoU41fZP6TEt758uDkc66qkW3/BQvO4YCMbAnR+eA=;
  b=dSsqDpzxHcT6cik0/9wfmfec6vL08789uCJUEqk5r1lKZn3sMc2mr9MF
   xNWwYeKz7ehvtaGXtqP1AWwNypvotxKgN5NOOV8KuEoXVP7Cm7lCYtc1N
   c2f37g2m/HKkSamu2nMax0UphZ87D2GNV37wMWD6lsRV6R8gtKARsoOva
   sAj9mFRaPdMJ8w/qBYyLS/ZO3jDGlP9s2EembBSDEEvDAm0IJ4eBJ3/No
   apGG+TZ9Vop+uRWLxSA/e8rsSTKDmWYn5bArs8s8q3uTWnG+XyMEfcttq
   yh57ysdkxZ4LJZk+B6IuUQABPZdOYLwnw99+9sitGAqD1BhDmYJNlnfL/
   Q==;
X-CSE-ConnectionGUID: z/4dIffeSYCr0NDgmh4qsQ==
X-CSE-MsgGUID: XipdQC3iQvq3YCgDiz0V1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50749719"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="50749719"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 09:52:29 -0800
X-CSE-ConnectionGUID: nu4zTP7fTUmkIiyJrB96TA==
X-CSE-MsgGUID: pjwpmdMRT6ybDJ8zfWPNqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110818206"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.154]) ([10.125.110.154])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 09:52:27 -0800
Message-ID: <d53cdf76-7694-4615-93c9-6946f6639edb@intel.com>
Date: Wed, 5 Feb 2025 10:52:26 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/16] cxl: Refactor user ioctl command path from mds
 to mailbox
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250204220430.4146187-1-dave.jiang@intel.com>
 <20250204220430.4146187-2-dave.jiang@intel.com>
 <20250205174123.00005885@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250205174123.00005885@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/5/25 10:41 AM, Jonathan Cameron wrote:
> On Tue, 4 Feb 2025 15:03:02 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> With 'struct cxl_mailbox' context introduced, the helper functions
>> cxl_query_cmd() and cxl_send_cmd() can take a cxl_mailbox directly
>> rather than a cxl_memdev parameter. Refactor to use cxl_mailbox
>> directly.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
> 
> Dave, maybe it's worth nibbling this one off the front of the series
> and applying? 

Probably not a bad idea. I'll do that. 

> 
> Jonathan

