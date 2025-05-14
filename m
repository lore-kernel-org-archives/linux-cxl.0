Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD4026AC3
	for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747260910; cv=none; b=obI+6/JGEnpSJTMuBw9Dg2YFl/KtW2RA8BB9vKua5uutX8gQYGiuBKvEB/oE4gCWPmRSLpcParNyBaeaguY53vI4hCCR5mxy3oqmPWONizidtV3xSAqceFXZaFcMVxVTtkIpdFNNwiJ+5x7IoSmlI5edT0rhHtp8X59JeWH1/ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747260910; c=relaxed/simple;
	bh=KPmpEA9UfvpFZ9bG2ShXQlu9+Yg6AYL026dfFSh5bFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M2o/fHqvHHuIg0b/OhhuZw52Qto4Xv+nKEAwiXsnC/KG3J9c/khgw0q1p1DEB+RBaYSvLoqwKOnBz7Lw7KXsoSCKkYufN1d5koDTqXM1A2FwvKito87W9sUZPNh/cYXvHAWZ4/3PW/gHx7mrag+JnA55x1ZdySMrOIQnSqxGh6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UqywRVFa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UqywRVFa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747260908; x=1778796908;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KPmpEA9UfvpFZ9bG2ShXQlu9+Yg6AYL026dfFSh5bFI=;
  b=UqywRVFaYTC0oJ77cjSI8m3edSVi0VuP0iFZ8fmgDNWj++t/xfHFFlyw
   qTpJSjT2jxndMx3B+mxO7Kj2wSv5XTbuF5cl0REdFQ7Pl06R/ShxoQC76
   Plr4qBFPQny57RsnBEjqrGXEZ70EsMp7bPSyG7wVqiSTxGqjplsgBYMe+
   jtbnMQCVHjl0nNLrWXvYYNdLQhDQ7fcMrCNuoNQ1QAbSrv7/dM1neRlR5
   qpCOCt0GR49QnN4qmIpIlqD13gRLeBo/bRxCIfarlbVb71RWDAPcqT5AX
   +IY+9uAgrH5Gif19FOOyzTkIuQqqr/BrbWhl+D1ynCvlCElC9VwgpkvCU
   A==;
X-CSE-ConnectionGUID: NGWllLsQSoavXeqP8kTVHw==
X-CSE-MsgGUID: PW0O7r/UTLuW5Fi83/sG3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49163603"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="49163603"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 15:15:07 -0700
X-CSE-ConnectionGUID: 7HnPYtEaTaWsz9VkMdscCA==
X-CSE-MsgGUID: 3QzpwReTRAyTjDyD58WkHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="169110121"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.31]) ([10.125.109.31])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 15:15:07 -0700
Message-ID: <1defbbab-4a7e-4691-9b96-50ccb076054f@intel.com>
Date: Wed, 14 May 2025 15:15:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] cxl: docs/platform/cdat reference documentation
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20250514003133.584401-1-dave.jiang@intel.com>
 <20250514003133.584401-2-dave.jiang@intel.com>
 <aCTA-C9StbfHjCMn@gourry-fedora-PF4VCD3F>
 <9ca53bc9-2eeb-4490-ac3c-fcb8cec0da78@intel.com>
 <aCUSXEA9cfHeGpSB@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aCUSXEA9cfHeGpSB@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/14/25 2:59 PM, Gregory Price wrote:
> On Wed, May 14, 2025 at 12:02:01PM -0700, Dave Jiang wrote:
>>
>>>                                                       ^^^^^^^^^^^^^
>>> 						      provided by what?
>>>> +Generic Target performance data provided by HMAT+SRAT to create the whole path performance
>>>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>    The is provided by SRAT right?
>>
>> SRAT only provide the association of a device handle and proximity domain for a generic target. The HMAT provides the performance numbers based on the PXM.
>>
>> DJ
>>
> 
> Hm, maybe this is best expressed in an example configuration?
> 
> I find it hard to keep the various table contents in my head while
> reading document pieces like this, so having examples all in one doc
> that show the relationships would be nice.

I wonder if I should add the explanation in the SRAT document when talking about Generic Port as that's probably the relevant location.

> 
> ~Gregory

