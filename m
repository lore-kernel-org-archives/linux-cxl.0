Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBF31B6CF2;
	Wed, 16 Oct 2024 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112492; cv=none; b=kvrej3XQqOzBUUzuEIwF/m6EOBWt8Ey/IoJ2uLH3FOrwFjzVK260C/H4aaWpNWLetmtByZRyLN0T/RAd7tmVzDfu4zufqbmQLV+XuAXeXyk0n0OgVBmZ9fT1HNMWDdR3+OGPXcFthbQ5pFGTPLF8F74vSb7Bcg60/TEvn1rp5zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112492; c=relaxed/simple;
	bh=Dy250ErH1M84sPkAmkdtD//W3ieAYLPbTj8Aa5iqc6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTNt5/lwPnXlmd+lccqPXxpDxBjRZdAKsKW2UOzPiq/KF4I2FH26fsPRG+NrpNw1MIKKIHk67KN6PtitUxshAXyQjOFShpWjOQE0vs19lW4ySh+YUB+dfBMyzrTGZoHHvnvk1N9Zf3B+1BlLUIEiDAZVsjXZA8J3KnNG8jkuWy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mr5jHd4Q; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mr5jHd4Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729112490; x=1760648490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dy250ErH1M84sPkAmkdtD//W3ieAYLPbTj8Aa5iqc6g=;
  b=Mr5jHd4QqGkGo1JxeD5mehyaiDy1lKBtbS+JJTS05dF0WF4dEZA259yH
   JWRPIEdtKaFBe+PEoWsxWLDOpMTMLQl1cAVl1FvYBNJVjidZabLXh384G
   TSry/i1LolQMBKDOLP5kK+Q4nYVmCiLmopf8FUWTOOQz4ryjvWD5MvlvF
   gdng2O64mjFmutyO5LOPm2elg0DQq7SJOCuNV382gSMfKT+CditIMMYrD
   iQ7lzcKhnYFrUUIR+tkdQ8/dzVSyzbfM2s47NcWiY2VYn73ntqLXCY+2X
   V9XXc3REy8Zm2Jdpx0c21AFSCxIHQrUi9jBHWk6S029DhxWX5AKfIuO98
   A==;
X-CSE-ConnectionGUID: w6T5T1QSRKeG7DJNvp0CkQ==
X-CSE-MsgGUID: 17Q3vsWUTRKNxZ7puFNPHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46052583"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46052583"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 14:01:29 -0700
X-CSE-ConnectionGUID: QYPaPXYmTkSN6bnWJqd2uw==
X-CSE-MsgGUID: TS2YPx1tQF+r8SreI3BFew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="78375589"
Received: from inaky-mobl1.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.245])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 14:01:28 -0700
Date: Wed, 16 Oct 2024 14:01:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: shiju.jose@huawei.com
Cc: dave.jiang@intel.com, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dave@stgolabs.net, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com
Subject: Re: [RFC PATCH 0/4] Updates for CXL Event Records
Message-ID: <ZxAppnCBf4wFgcQ0@aschofie-mobl2.lan>
References: <20241016163349.1210-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016163349.1210-1-shiju.jose@huawei.com>

On Wed, Oct 16, 2024 at 05:33:45PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec rev 3.1 CXL Event Records has updated w.r.t CXL spec rev 3.0.
> Add updates for the above spec changes in the CXL events records and CXL
> trace events implementation.
> 
> Note: Please apply following fix patch first if not present.
> https://patchwork.kernel.org/project/cxl/patch/20241014143003.1170-1-shiju.jose@huawei.com/
> 
> Shiju Jose (4):
>   cxl/events: Updates for CXL Common Event Record Format
>   cxl/events: Updates for CXL General Media Event Record
>   cxl/events: Updates for CXL DRAM Event Record
>   cxl/events: Updates for CXL Memory Module Event Record

Thanks, this looks useful! I didn't review line by line but do
have some feedback before for a v1:

- Suggest being more explicit in the commit msg(s). Something like:
cxl/events: Update Common Event Record to CXL spec 3.1

- I was a bit surprised that this doesn't simply append new fields
to the TP_printk() output. Is there some reason for that?

- How about updating the mock of these events to include these new
fields. I don't think this introduces any new formats, but I would
certainly eyeball all 3: dmesg tp_printk, trace file, and monitor
output because all 3 (sadly) present a bit differently.

-- Alison

> 
>  drivers/cxl/core/trace.h | 201 +++++++++++++++++++++++++++++++++------
>  include/cxl/event.h      |  20 +++-
>  2 files changed, 190 insertions(+), 31 deletions(-)
> 
> -- 
> 2.34.1
> 
