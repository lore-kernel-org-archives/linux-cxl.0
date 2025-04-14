Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C1B25229C
	for <linux-cxl@vger.kernel.org>; Mon, 14 Apr 2025 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744644902; cv=none; b=HzhVQvYhz3S/lzDgx+JEC+l/Zg6OapDZlTEraMR5iDLgIyz/NhvF7AmuXJM7jqg48wtYeZHcxbcsdAdbtDM03yxTgAfY8ZQSrsikNDFj+p+AUxGy//sJ3/xuq46LsWbBfLFAxCTy2V1zQni3ZZAScMBtdfYsPEWiMBeeTu6vqNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744644902; c=relaxed/simple;
	bh=SoQl7Kw18vc5tGflCwbyGzAGRoWpOB9Zj0rp8zAz578=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZdXihGguvGkONWGAl0maaeFYZsluJf/X3nXicbACTFgfr8QQ/J71zJ3BEAF/TbyofAwus11cbAGN4NmuNy9pJPn9ls8DyqU54P/KGBJK1nVZOZJbP5soG/u+NcBGXecFqI0Y1Ci6VAso/gIJdgx/leq6SsQflpoXOS0RMV8ltI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4g9os3k; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4g9os3k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744644901; x=1776180901;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SoQl7Kw18vc5tGflCwbyGzAGRoWpOB9Zj0rp8zAz578=;
  b=i4g9os3k3EwV0CC6c7gg1SfNT2TE58ytxHLgCN/rGsLmb/8Xn7whRYwg
   eLnNkyB99xB0h1tcWYoy1aCpBGC3UUaYAUqwE0m+i7zJt84bNmHh+y+yY
   GPpOEId6yDoRjkWJn9tzS3qwfraeYASWpCWi4w2svPRnCLHceOS5Qvp8v
   SCUefXEhuow0E5v0CMcaHC1WT0kt2oyz6SrXBtyL+u1/BQV8IMbXbYYoe
   LDBriJyjK4vj06bvuzQLN24hwXgvlSRVILXBDqi/z9T7Q+AGXPkPQhnuF
   5SHY8u+8pmmZCoW9DFna24ulkSJ2LPx52wfc7Y/4J4xi+9OHKu695TBI+
   Q==;
X-CSE-ConnectionGUID: sFW/8vS+SHSNetpx0PzzLg==
X-CSE-MsgGUID: YGC9DgRJQHmDsM3g+WPu9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="68610969"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="68610969"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 08:35:00 -0700
X-CSE-ConnectionGUID: Lwu+Ey23S7mTG07T0JsM/g==
X-CSE-MsgGUID: r2wJd81pTmewNJLnUpXx2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="130386553"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.28]) ([10.125.109.28])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 08:35:00 -0700
Message-ID: <7f535cf7-6231-4a90-96cf-a5beaad38bb5@intel.com>
Date: Mon, 14 Apr 2025 08:34:58 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] cxl: Delay HB port and switch dport probing until
 endpoint dev probe
To: Li Ming <ming.li@zohomail.com>
Cc: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com, rrichter@amd.com,
 linux-cxl@vger.kernel.org
References: <20250404230049.3578835-1-dave.jiang@intel.com>
 <ecc9fca5-5166-4516-9eda-2562a0350378@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ecc9fca5-5166-4516-9eda-2562a0350378@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/10/25 8:05 PM, Li Ming wrote:
> On 4/5/2025 6:57 AM, Dave Jiang wrote:
>> This series attempts to delay the setup of dports and Host Bridge (HB) register
>> probing until when the endpoint device (memdev) is being probed. At this point,
>> the CXL link is established and all the devices along the CXL link path up to
>> the Root Port (RP) should be active.
>>
>> And hopefully this help a bit with Robert's issue raised in the "Inactive
>> downstream port handling" series [1]. Testing would be appreicated. Thank you!
>>
>> [1]: https://lore.kernel.org/linux-cxl/67c8a0cc23ec_24b64294f6@dwillia2-xfh.jf.intel.com.notmuch/
> 
> Hi Dave,
> 
> Thanks for that, you can also mention the patchset is also a long term solution for the issue[2]
> 
> [2]: https://lore.kernel.org/linux-cxl/6712b7bf2c1cd_10a03294b3@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> 
> 
> After going through the implementation, Setup component registers is triggered on root port and HB when the first endpoint under them attaching, then component registers information are cached. But the information will not be reset after the last endpoint under the root port and HB removed. So the information will be resued when an new endpoint is re-attached to the root port and HB.
> 
> I am not sure if component registers information on hardware side is possible to be changed in above case. Just want to know if we need to consider about it?

I do not know either and I don't have the hotplug hardware to see. Unless someone can report the behavior, it may be one of those we cross that bridge when we get there situation.

> 
> 
> Ming
> 

