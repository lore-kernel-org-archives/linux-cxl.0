Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A889A186294
	for <linux-cxl@vger.kernel.org>; Wed, 12 Nov 2025 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762988445; cv=none; b=hAUbOClaXYIGFqpsLfgDgVAA7vmMlANDQw4Sr/fsOMqKSdRZha9XmguUxV9jF6z/0Wsm1S8nKHkr7Jr+Q28K0jPCNTNWzYJdOa1OVu+XFYcH+PkLn/yy+Y7tNVMHj0XL8T+cBYlL5mm6jibnguRXQ/XC1GFG5M7izuF+Ev+w93s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762988445; c=relaxed/simple;
	bh=vS2mZNb/QPOp/YjlDKrru+c71JmWvPZTAinIhh6sfBo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ddUoL2D6stDn6gkCvaCgWJXWY50weNYPG0gkPynBp6MfdheE5FuR4GAWz2KYeFaz8clQZWLYa+/CMCESQaGfd30CXJOWi+mxyuov4ZQdgwbFWxayndZ59zCsdUN9WxG8HshogcL1MH8QIcsCTXF6Qqo8wLFSsrd55L+7BicyZF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2/0crNo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2/0crNo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762988444; x=1794524444;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=vS2mZNb/QPOp/YjlDKrru+c71JmWvPZTAinIhh6sfBo=;
  b=f2/0crNoYC+A4mKKobYtqYM12/b6AmIfLAeA1iIRZGjTeDZg1fv08eL1
   zIdPJG3L42zvwB/Ids93XPeuKrgL7PC96zhSn0hD+AVZfOvz94DYfhWVR
   3fm426c0FTzCHXwRDg7i7VdNaMisxLLumxPCJAleLOZWWkDcUtFvwMbOw
   HsWIkfFkCzhGqriFW9ypQooOIERXQJfInlqKOCoTfu2oSYqj2lTpx68sf
   iC9hCQzJ6wxTmPFsPTgzV/ecpKHi2yLIj2r/fUQGhZWNIrXM1PDieVzaW
   lsVnDR3hs0WP5KCjm352Mt+lu42etpyZNe/FtlkdYPscb+HMod0lE8ZCT
   w==;
X-CSE-ConnectionGUID: 1/8TGP4WRq2W2hp8vmf3Hg==
X-CSE-MsgGUID: tOsCE6GYSWKwgxk3aWwyTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="75676151"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="75676151"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 15:00:43 -0800
X-CSE-ConnectionGUID: wFqbLcZMQMOgzl/w2zS1/A==
X-CSE-MsgGUID: MSlBcvetQj+O9SlVYTJdCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="189197553"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.108.30]) ([10.125.108.30])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 15:00:41 -0800
Message-ID: <7602dde9-ff71-4bde-a056-58c171e25ea5@intel.com>
Date: Wed, 12 Nov 2025 16:00:40 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cxl: Cleanup region_res_match_cxl_range() function
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
References: <20251106170108.1468304-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251106170108.1468304-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/25 10:01 AM, Dave Jiang wrote:
> Small series rename and clean up comment of region_res_match_cxl_range().
> 
> Dave Jiang (2):
>   cxl: Rename region_res_match_cxl_range() to spa_maps_hpa()
>   cxl: Clarify comment in spa_maps_hpa()
> 
>  drivers/cxl/core/region.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> 
> base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0

Applied to cxl/next
c43521b9db7f5ed481cfdfb04ad2e7fe0cb9dcf5
8d27dd0b219f00fc1e0548ae5008abd7bb350611


