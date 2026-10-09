Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF8536CDF2
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791582196; cv=none; b=b8Lzfl1b4rP2GnZ7SW7NzKTuPJe3hMUKkqQRCSBBf1/6ah8QU/GO7Ox7qkTNu2Xv2PbHY3jjW8kDJDD7lCAFyevJZggIP7kID26x2n1d1bEcgn0z2G8NTzPiIXuHYKQeFOGVyHYqHY7y7oawy8KSWXuIzMVOgMsULyHo4NoFNbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791582196; c=relaxed/simple;
	bh=mWZDCTWFE3fidZBIJg6u5KtYwk+IR5P3DOEBRUdliiQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JH58wPEBcUk9j/xza3rNgshDIlPOR72pbAU8Z05ickFV7y5+zrCEgpSo7TO0Pwa5OIugWrB9A1hhhezZ5EKGrlecbmlEvx8+DRKzd8eXVEMTNkP4Qzsk8t9/e1CTpdHTdU4P82rdQcMj77NqLgzfCkvUW5YE6OlVJzvIbKN++xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCSIyz3s; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCSIyz3s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791582193; x=1823118193;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=mWZDCTWFE3fidZBIJg6u5KtYwk+IR5P3DOEBRUdliiQ=;
  b=DCSIyz3sDa9ua2A8JCiQ11ys8n684m/eFyM3qECXQliifR5fXeEgVkWB
   boqEf4vmuEV7SsRHhnbLeRwA9Q2LCx3SzGgnwE9O6IjCf6G0MVvVfgA7Q
   bMHMdBEuFZkVfbL8T32eUwJqtZYZDbiXPoFzq7unvVzf2gfyg1fni2fuv
   rvKo4L0+HLcw6SvSLcDasL4Vmxvwl5MmIm/Lg71SpGn0KGg0f7rprjRNO
   Wq9vs3zqwb2O+R7rXclQZz/BCHmLJWv/+1HsvA/Gy4w/I+vb8TZsgkIT6
   j9+ITcsXdVK4ueM2iXwB/fZmyx3z8wZcfJOfG/P7ghANWGfgNU/NwTvz2
   Q==;
X-CSE-ConnectionGUID: HBxQtaoLRYSFXYbrCewvPA==
X-CSE-MsgGUID: 0LMzQDn6QxyyX7bzTHupdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="274883"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="274883"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 14:43:13 -0700
X-CSE-ConnectionGUID: U4yFHAC3TG+7kMjHIKNtUQ==
X-CSE-MsgGUID: EnCaSBsnRjuNHXQVKhbgXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="341382"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.109.123]) ([10.125.109.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 14:43:13 -0700
Message-ID: <c5a0b714-31b6-4fe4-88c4-97eb5d1cbc0f@intel.com>
Date: Fri, 9 Oct 2026 14:43:11 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] cxl: dport fixes from sashiko reports
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 ming.li@zohomail.com, icheng@nvidia.com
References: <20261001154744.1095902-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261001154744.1095902-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/1/26 8:47 AM, Dave Jiang wrote:
> Couple dport fixes resulted from sashiko pre-existing issue reports.
> There are no depedencies between the two patches.
> 
> v4:
> - Drop the unused dport output parameter in patch 2. (Sashiko, Alison)
> - Add review tags from Alison and Ming.
> 
> v3:
> - Add patch 3 to attach endpoints under the dport's port lock. (Ming)
> - Add review tags from Ming and Gregory to patch 1.
> 
> v2:
> - Addressed couple things from Jonathan. See patch for revlog.
> 
> Dave Jiang (3):
>   cxl/port: Clear cached dport pointers when a dport is removed
>   cxl/core: Hold the dport host lock across dport lookup and use
>   cxl/port: Attach endpoints to a dport under the lock that pins it
> 
>  drivers/cxl/core/core.h    |   6 +-
>  drivers/cxl/core/pci.c     |   8 +-
>  drivers/cxl/core/port.c    | 206 ++++++++++++++++++++++++-------------
>  drivers/cxl/core/ras_rch.c |  12 ++-
>  drivers/cxl/cxl.h          |  22 +++-
>  drivers/cxl/mem.c          |  14 ++-
>  drivers/cxl/pci.c          |  11 +-
>  7 files changed, 186 insertions(+), 93 deletions(-)
> 
> 
> base-commit: fd73f4a6659897191fa0d40695fe370925dd3780


Applied to cxl/next
bcda00c78d07
b72a03ebd958
019560d23450
