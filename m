Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E831A9B40
	for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152724; cv=none; b=FNJFyXJ8Ff6K0PIHjmO36XQ2I+kwvpI7LIySiSPyxCiPvo8TbYvyl8laX3rwvUjPAY8gfsSSGppXeacjHtt6T+jmQzxhySGEDHFECzkRaWIAJkC/XvB1yMq5zR4Y8gXWQB5QyXgd1tC9Zvh3yPzUro5UQQuf+E6eyUPc/bbpoQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152724; c=relaxed/simple;
	bh=bUfmXo++zlfyXQxyZfBw+MNuexuviTIiBlQDKEuQrZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbvlRMeVFVbm5smoFEuhSMRxWvjTLwuUvLbOyfjJa7SxqMiame/czq1sRWOegJlfdrlqiu1leUFvPTmRk/BINDUCVrdV9VcVj9o4oUcZLR5vaFmbO4ZUZQx2VdABUk3wtri8dEfL1zHxthTgITA69xq8UEzGSAD0U21x+tSJgoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HtEHOa4T; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HtEHOa4T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747152723; x=1778688723;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bUfmXo++zlfyXQxyZfBw+MNuexuviTIiBlQDKEuQrZg=;
  b=HtEHOa4TEFhXWBJ+uHrjml96/XJByjCt5FVWH6EnCClAoMYBslIU14Xq
   ChPmLNtJ6Zo2graFLewJCCqveofLLwWcGfJ2bItIGfG8VQsLsfmPH9Gzi
   4uhNgCV/ZlezVeytOop6SiJwh6NHnM5HXgT1JQBiP2N8Xaka4QKFIVE1M
   OIJQmDRqMxa9iiQ5ObZziqU2J5HnK6gATCrmHJd0cdry2gF0CprcN5Eoq
   hhs8XzztNJwmYpzrCZiOZmQHcDwlg6B8XcbCtDIv+QGAV3kgLGFLXyYNf
   I3JG9Mk9GAQc+q0DnRuyCFG/eXM6bu6FDeIz4QhEdeDi9iue3ar20mczp
   g==;
X-CSE-ConnectionGUID: b+r9cX0kRbOfPK3xHjaQ3w==
X-CSE-MsgGUID: N43MmChUSeqcX09yl0YDvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="49173720"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="49173720"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 09:12:02 -0700
X-CSE-ConnectionGUID: NZIUMQsNQXiGXJIWOHEkVw==
X-CSE-MsgGUID: rmmPWP5TQyS+F3H8f2/pYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="138168972"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.109.12]) ([10.125.109.12])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 09:12:01 -0700
Message-ID: <96957e88-778e-41d6-a503-1819fac51855@intel.com>
Date: Tue, 13 May 2025 09:12:00 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] cxl: Add helper to detect top of CXL device
 topology
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, rrichter@amd.com, ming.li@zohomail.com
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-9-dave.jiang@intel.com>
 <aCNqJ5JI2_U7zh-Z@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aCNqJ5JI2_U7zh-Z@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/25 8:49 AM, Gregory Price wrote:
> On Tue, May 06, 2025 at 05:43:08PM -0700, Dave Jiang wrote:
>> Add a helper to replace the open code detection of CXL device hierarchy
>> root. The helper will be used for delayed hostbridge port creation later
>> on.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ignorant terminology question: what's the different between the
> "cxl hierarchy head" and "cxl root"?

I struggle to find the correct terminology between the head of the PCI (or platform device for cxl_test) hierarchy vs the CXL one we constructed for the 'cxl_port' hierarchy. I'm open to suggestions to use better words to distinguish that. 
> 
> ~Gregory
> 

