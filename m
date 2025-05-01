Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08E22B9BF
	for <linux-cxl@vger.kernel.org>; Thu,  1 May 2025 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746112148; cv=none; b=ql0u1ByNIYCjqenVJ+9BtcBdPcIczmHuwe06t0a1HI6MbBl3zf8kIu6FihIDWxFWJw2eeNQcuUYGm4lzJGSFIqxiM0QBF1tQl1Wxvh+7v+VTFxfyDhnUWhq43lJu0JdIiVyxMnWe/bNsXIpyGF5Q0JTMCE2Rlr2lFLuSEmDzHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746112148; c=relaxed/simple;
	bh=1J1brWDWuFaZ1MLUNUDiZU/tmrot54X6gLbfI6EZgl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOr/LrpPHszbUOr6mLrISbrRlpcT/dCcvJePVXTLz5f5pw1xwzwIeFPvxNtTg2MbxLZfmLE0y74ktC962vRIlcbnX4PRoLgHSArdAN/N46O9sKN0EhnyPVUF9m+vHqBGfzIHSNl1moIW/2bFFHSOMekrL1EgTtoqh+B9bochAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nj/gs1uS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nj/gs1uS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746112146; x=1777648146;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1J1brWDWuFaZ1MLUNUDiZU/tmrot54X6gLbfI6EZgl0=;
  b=Nj/gs1uSYgU7UXo7Ym8q+UkQ41QsfLK17c41jcY9QeaItMMRB3gSBgfs
   My9MF/zhjsQqt/a1cUjrDaD+lXlUW9gbXqpF0aoLVvCdwPddzrReLRV9w
   7bMcuav3DHlDcQvcSCP6y7M/GwN+ZIK3PxUskM8drDJfchPr65ti9/Ra4
   IrhTR9Zo8yF4IV9IZzSH55ynJvTPV21UsUsDfrSXy+6xd4l3DAO1upEYp
   YydEFLvKz35XCbvkla536AaVy20Q7NEvYArWvOOIEcW1uA/93gESJGRSV
   yLmLEGcrLF5qhNosqcLWtxsdaFIaVa2J8ztWLaA2yPAIb+B/1UiVAiq+x
   A==;
X-CSE-ConnectionGUID: PdaBGw2/QsuemPR7Nt8vPA==
X-CSE-MsgGUID: sfP5N/1yStSmf0PWfjGUTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="70290182"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="70290182"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 08:09:05 -0700
X-CSE-ConnectionGUID: rWAlVPj/SP6T7haFuPcHRw==
X-CSE-MsgGUID: eOtZ/HCQRDm+3DI5HEsQ5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="134360030"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.107]) ([10.125.110.107])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 08:09:04 -0700
Message-ID: <2562ba5b-cd14-4961-a2a7-c0ebcd204fa2@intel.com>
Date: Thu, 1 May 2025 08:09:00 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Add decoder check to check_commit_order()
To: dan.j.williams@intel.com, Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 linux-cxl@vger.kernel.org
References: <20250430213653.1904302-1-dave.jiang@intel.com>
 <9516517f-9d04-423b-bcd0-123a76598c06@zohomail.com>
 <681306aba4219_29cd5100c3@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <681306aba4219_29cd5100c3@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/30/25 10:29 PM, dan.j.williams@intel.com wrote:
> Li Ming wrote:
>> On 5/1/2025 5:36 AM, Dave Jiang wrote:
>>> check_commit_order() attempts to convert a device to a decoder without
>>> making sure the device is a decoder. So far this has been working due
>>> to pure luck. Issue discovered while doing deferred dport probing when
>>> child ports are now in the midst of decoders due to ordering change
>>> of child port additions. Add a check before attempting to do decoder
>>> conversion.
>>>
>>> Fixes: 105b6235ad0f ("cxl/port: Prevent out-of-order decoder allocation")
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> I also have a patch for this issue during I worked on deferred dport probing.
>>
>> https://lore.kernel.org/linux-cxl/20250107035708.1134954-4-ming.li@zohomail.com/
>>
>> I am not sure if we should define it as a bug, my understanding is
>> that it will never happen with current implementation, it only happens
>> when we are trying to delay the switch decoders initialization.
> 
> Agree. This is not a fix. The current implementation is lucky that ports
> are always registered after decoders. So there is zero exposure to this
> issue for current kernels.
> 
> Dave, please just include this as a prep patch in the same series that
> invalidates the port child device ordering assumption.

will do
