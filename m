Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02101E5207;
	Fri, 12 Jun 2026 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282433; cv=none; b=KuiC78JIEqxUWB+MCh8rLIqJLCjqHQCBVPfb4CXAkuHLBfllHegD9LF59u9kFYFZe9yhPLRG5m//hDH0ZA7MU7matmTWcS+/GAyq/ECayiUrFW90cvaFCCqCbTjuNVk+1K3mtvZ3jIBNYMPMG6mMvFDFIL5HOKBoH77geWoqqjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282433; c=relaxed/simple;
	bh=Po/oipcflQXBE5G9u7oO+y2uYETJTL/zlyZhCN3p0sQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zfe6PbCZY9w6zJy+7Hjwp6mJ3HKOOiygHqdbez0M4Ug3T7dUJxwx0hDdrgUF4tgQyXicg+MMmpY5y3mO1D53MBKJC2Q14bl/KLKF87vtD+C/c+WxLM07kV01PRk9uEmjzUs6AkydiHijZ9rGgpMoIQlYDuSJ6Yh8If27Texrc7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f3cwcg4R; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f3cwcg4R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781282431; x=1812818431;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Po/oipcflQXBE5G9u7oO+y2uYETJTL/zlyZhCN3p0sQ=;
  b=f3cwcg4Rl2VfUf49saL/amKcut3Wst1XbYWjHFoX217gI+v66ZCQhdS2
   ngWihNRbAqVcnBORk2WF4N/vLefjlIE0i7IHrV+IWl/IHG18dELr95C5x
   yyEzjNtKwN96p6Dlaeuq+NAd7AAJhONzKsh2XCT6ZS4Tc1WRfucuFZm5/
   m+BOvaZCxyPBhG4VdKYmGyJ1H7oiDjzh/ybigSEF4GxhXuq3Z+z395v/O
   iYNKcCTSivxMnL1DJpw15yDjxAkX2YfqYub2bOUWe3XgbUQ8IlA0nxk5o
   VNT5CKWKdazHDir9PM4L9aZBOMGPeTeBgih/h+INHdmYcMw5R6L7qtuY1
   w==;
X-CSE-ConnectionGUID: TnMbCj/FTbujol5z7FcU4Q==
X-CSE-MsgGUID: HMRMx6VJSR24Oa2NboNCUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="81859665"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="81859665"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 09:40:30 -0700
X-CSE-ConnectionGUID: KgcRpej/RrO58D/3UXr00Q==
X-CSE-MsgGUID: z8wGDfdESHGA7EIAboFpUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="242490728"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 09:40:29 -0700
Message-ID: <19588fe6-62f9-43e2-af34-89c4c4c9939c@intel.com>
Date: Fri, 12 Jun 2026 09:40:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cxl/region: Fix two decoder attach/detach issues for
 auto-assembly region
To: Li Ming <ming.li@zohomail.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-v1-0-5d94ca06c4e4@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-v1-0-5d94ca06c4e4@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/6/26 12:50 AM, Li Ming wrote:
> This patchset includes two fixes for endpoint decoder attach/detach for
> auto-assembly region.
> 
> Patch #1 fixes OOB access in cxl_cancel_auto_attach().
> 
> Patch #2 fixes NULL endpoint pointers hole in p->targets[]. CXL driver
> does not allow any NULL pointer hole in p->targets[], it will cause
> NULL pointer dereference issue. However, if an assigned endpoint decoder
> is removed from an auto-assembly region, it could make it happen.
> 
> The following operations can always trigger NULL pointer hole issue.
> Precondition:
> an auto-assembly region with LOCK flags or its assigned endpoint
> decoders with LOCK flags. This means these assigned endpoint decoders
> could be re-attached to the region after being detached.
> 
> echo {one of cxl pci BDF} > /sys/bus/pci/drivers/cxl_pci/unbind
> echo {one of cxl pci BDF} > /sys/bus/pci/drivers/cxl_pci/bind
> 
> it will trigger the NUll pointer dereference issuse fixed by patch #2.
> 
> Note: Patch #2 only fixes NULL pointer dereference issue, re-attaching
> a removal endpoint decoder to the auto-assembly region still fails
> with the patch, because there are other issues blocking re-attachment
> flow. One of them is that re-attachment will trigger calling
> cxl_region_attach_position() for each targets in p->targets[] again, but
> the function fails on the targets which have been attached. I am not
> sure whether re-attachment is a valid user usage, if yes, I will work on
> that later.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
> Li Ming (2):
>       cxl/region: Fix out-of-bounds access in cxl_cancel_auto_attach()
>       cxl/region: Fill first free targets[] slot during auto-discovery

applied to cxl/next
cbda6a2c2bec
aa8a76711c15

> 
>  drivers/cxl/core/region.c | 55 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 33 insertions(+), 22 deletions(-)
> ---
> base-commit: a1516711b95490ad6c9f05b61500e73d4f603d28
> change-id: 20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-6267f4fdce27
> 
> Best regards,

