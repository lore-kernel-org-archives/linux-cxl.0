Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2036D1B86D5
	for <linux-cxl@vger.kernel.org>; Fri, 19 Jul 2024 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721404048; cv=none; b=WmYJPelUCQb7SH7p6Wqejpko2F9a/2XH5MnpbaGit3Q0qghxoFTEaYVDMKuTGlp4f/2W3w0HENraZ1A17wdF9HS7co8dRa9AEhihQvVSOSpszROHPmytFzYo/qOchsFbEOkifj24J5TMhJzFwuD0+tTZSEtp5caKpH0AwBuTHKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721404048; c=relaxed/simple;
	bh=s24sc678AL/O5pQNdR3Ij2WBkFTgrLEIrDDk7zwo+t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAIj8ueOe90Cl5YV1eoz6LDeYrPyOmuylBeIz+p1ODSUKLxnzwQ6KjfUhdaOXZoODNgn+6GAbm17YrbVLFoLEsR+ER2fTubT2O0ClzjwkUikSXElqRYZF/qQyy3TaJLZRDOcZ6otCeop/wVZ1LPwWDLJ9Oca11jyRQQR2WWNT2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ebsf6Xfr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ebsf6Xfr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721404046; x=1752940046;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s24sc678AL/O5pQNdR3Ij2WBkFTgrLEIrDDk7zwo+t0=;
  b=Ebsf6Xfr7x078oSuJB886/Yx0HXbuv7f4I94VWWw5DmyqlCltBolFXaJ
   tMZAQ/CnykjQ6H8eXHwnao4PpqmSV8rI2vMZG3YfZGTNyNvYjqgqHj7+j
   P2lNGjcfp9KXGQb88UNxK3llGUFb24Xcfjpjn8IaIrAp4c+GSUNJc1vsg
   AZof0fN4vF2S/eyl+3SDl/i/XarVJ1P2TjeEdV5EfnQyjnHGcxdoEfUfI
   ary0FhhKcopqysktOE4j1OJC6Tsb7N9g5njsBRCtZ3ygG7pxPh8caMFXl
   X3iUhwfCrdCgaQb29wobzONzqG05mUYylFquS1RlsaLcPC2IlbrrvtEHu
   Q==;
X-CSE-ConnectionGUID: Qasw7O52SFya0puPsC0wfw==
X-CSE-MsgGUID: m8JP6ZvMS4mPqaHk/+5nYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="18982653"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="18982653"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 08:47:25 -0700
X-CSE-ConnectionGUID: Yv5H6eEHQNuBTXDgOd1+lg==
X-CSE-MsgGUID: 1HURWsWKSkuaj8OIEo8fPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="51221423"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.46]) ([10.125.109.46])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 08:47:24 -0700
Message-ID: <0d9e88e2-e79a-4ce6-87ec-3cd33b4afeed@intel.com>
Date: Fri, 19 Jul 2024 08:47:23 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/13] cxl: Move mailbox related bits to the same
 context
To: Alejandro Lucero Palau <alucerop@amd.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <20240718213446.1750135-2-dave.jiang@intel.com>
 <6f0a4aaa-c555-ae7e-2614-f15871e5725a@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6f0a4aaa-c555-ae7e-2614-f15871e5725a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/18/24 11:31 PM, Alejandro Lucero Palau wrote:
> 
> On 7/18/24 22:32, Dave Jiang wrote:

<snip>

>>   /*
>>    * Per CXL 3.0 Section 8.2.8.4.5.1
>>    */
>> @@ -438,6 +403,7 @@ struct cxl_dev_state {
>>       struct resource ram_res;
>>       u64 serial;
>>       enum cxl_devtype type;
>> +    struct cxl_mailbox cxl_mbox;
>>   };
>>   
> 
> 
> Being a mailbox an optional capability for Type2, not sure it should be here. Maybe it should but as a pointer for dynamically creating the struct if needed.
> 
>

Yes.... Which actually also ties in with your Type2 work. I talked to Dan last night while looking at your patch where the a software cap mask gets passed in for mailbox and HDM enumeration. The conclusion was that we need to refactor the code to deal with the optional component enumeration. For mailbox, it needs to be independent of memdev device state and the enumeration needs to be split out. I'm going to try to take a crack at it, unless you want to do it. :)

