Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23D9223322
	for <linux-cxl@vger.kernel.org>; Wed, 26 Feb 2025 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583924; cv=none; b=ETmbKSh2ere//lYRvIYNf2pN5ZOjRpQJLSnXGlQntUcschYeP8Wusvlgmjy3acB5tzyGyNjV1LXnlsyAnJ+KHY3tqIRRc83BJC/+RQ8iSygMt9MumpZ+2kx6CNfUinBL/xqXGyKc7RvSYZehfGItpjp2yEwaRHGeKoLKG1XkTTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583924; c=relaxed/simple;
	bh=RvToxFAFuALC0pHhSU273G82vZ1p3oS2SL0PpHAoLpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTNHgUNURRy36nCKI7yEtkA5V1Q/UPQL40sLqfx4iX5/sS1gq0kW016KbQ9iBN/eGQY6ZXu7itexX3Zcs8JYAOOAIUGd5k4xV0y0QB98XLmaXarxwiOE9f7PdKW/dmsMHyPgiDx4SwXlcbPf05mmwwVMcwOiO3bCfkwiRDyigH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FY1S7BS5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FY1S7BS5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740583922; x=1772119922;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RvToxFAFuALC0pHhSU273G82vZ1p3oS2SL0PpHAoLpY=;
  b=FY1S7BS5ghMncw+GuuV23zGPtXrwZSCGlsxnQMFdx0xfqxIpEbMRc2Bx
   DY2kKrno4WY2XLrkiM2GuWtyl/iVQUzbb92O92yKl0Lb/cLHTfFQNaNA4
   9vfXhnD9TBuJ3tsDTmrGvZX23GrvVZnDZmwOQ2fbNU7lFN5HDahJs01x+
   bab3otkOTMQhY4INSE2kuKfsDopPYgrceswLUCHZksJNDvNV4SHuRz7zd
   jLDTwxMePlwKJJvCOaSq4IVH9dVFf/tc7JmpGE7443kVaUlRJQ0LD1a49
   ZhtGhs5U03ZA4jtGf55yZ7MBWMRka7DuibnqQDUimLqpvoy5Pp8ZfzAkp
   Q==;
X-CSE-ConnectionGUID: zthgpbGUTvKSgkAXj3Skig==
X-CSE-MsgGUID: 3iQGoVqJT0mGOmWfD3o5dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="40674177"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="40674177"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 07:32:01 -0800
X-CSE-ConnectionGUID: F/9wpJFXROmzq168Pkw90w==
X-CSE-MsgGUID: 8hylXUMUQm2mgoQBVZUqrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="117222360"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.108.7]) ([10.125.108.7])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 07:32:00 -0800
Message-ID: <d6eaed28-1a82-4cee-af00-002e556725fe@intel.com>
Date: Wed, 26 Feb 2025 08:31:58 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/14] cxl: Add Get Supported Features command for
 kernel usage
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, jgg@nvidia.com, shiju.jose@huawei.com,
 Li Ming <ming.li@zohomail.com>
References: <20250220194438.2281088-1-dave.jiang@intel.com>
 <20250220194438.2281088-3-dave.jiang@intel.com>
 <20250225210016.vdci7r7pwseytsyr@offworld>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250225210016.vdci7r7pwseytsyr@offworld>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/25/25 2:01 PM, Davidlohr Bueso wrote:
> On Thu, 20 Feb 2025, Dave Jiang wrote:
> 
>> CXL spec r3.2 8.2.9.6.1 Get Supported Features (Opcode 0500h)
>> The command retrieve the list of supported device-specific features
>> (identified by UUID) and general information about each Feature.
>>
>> The driver will retrieve the Feature entries in order to make checks and
>> provide information for the Get Feature and Set Feature command. One of
>> the main piece of information retrieved are the effects a Set Feature
>> command would have for a particular feature. The retrieved Feature
>> entries are stored in the cxl_mailbox context.
>>
>> The setup of Features is initiated via devm_cxl_setup_features() during the
>> pci probe function before the cxl_memdev is enumerated.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Li Ming <ming.li@zohomail.com>
>> Tested-by: Shiju Jose <shiju.jose@huawei.com>
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> 
> ... with a comment below.
> 
>> +config CXL_FEATURES
>> +    bool "CXL: Features"
>> +    depends on CXL_PCI
>> +    help
>> +      Enable support for CXL Features. A CXL device that includes a mailbox
>> +      supports commands that allows listing, getting, and setting of
>> +      optionally defined features such as memory sparing or post package
>> +      sparing. Vendors may define custom features for the device.
>> +
>> +      If unsure say 'n'
> 
> When would a user want to disable this (admittedly this might become clearer further
> into the series)? But it seems this should not be tucked behind a kconfig, much less
> default to off.

At this point probably when the user want a locked down kernel without fwctl support. Dan wanted the entire Features support behind a kconfig for now.
https://lore.kernel.org/linux-cxl/67a2b6d345b61_2d2c2943c@dwillia2-xfh.jf.intel.com.notmuch/

 

> 
> Thanks,
> Davidlohr

