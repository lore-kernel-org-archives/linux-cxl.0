Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0A81DED56;
	Wed,  9 Apr 2025 20:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744230781; cv=none; b=c+sqNKBmXPb2WNXsZeZFn9pCap28wnt38hFAxOPfcwETM1E3ncvwkB5qUuRXmU5D+UTxJF8H1d0A1gfE8GsYtIrWIwKD/Ef+Lop+/Npfwfe0lF1DqYi8aST5vbA5AadnXpRNAZMLTD0ry+Vce/8/+vhlybZovZxHRGMlTB94dbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744230781; c=relaxed/simple;
	bh=wEV5pNX/q1/43F1QtMqhF2KdbPDZFZVR+q+fOBC+7Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMTR+5jF6Ij+dGAQoVYpeBUt2rxf9x3TByTf0DmxEy4Y6AeujqWmAYEwyAXfVMvDQ8bt01LuhpZkWN0Pd9tIJSDXiGt7S8fmTCHCEearPZWBkQOxjbJdWZ/cy08BDv+dJQNL8G8jam76erkPXp3rya80FBaKaQ2M8r/cSc//bfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ar+LAyAt; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ar+LAyAt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744230779; x=1775766779;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wEV5pNX/q1/43F1QtMqhF2KdbPDZFZVR+q+fOBC+7Ew=;
  b=Ar+LAyAtB68AALUNxNNgk6hYyo73MrCq/ysBo71dqfBEqmKXumuFYsDj
   es83lQ7OxBOGJPvIJqyULEjsEuOWTcLEqF1/pxNmaPfM7JfXlS96kxCHo
   EfwQLlEKQn/rQkU0mxibsU45mqsxaAEmIRqu4WCI8OHXLB8TC5dJAVpLb
   Nz8pv5SDzIsv3RL0B2BcORyseI/+6SRXTivfLi70efAlw39RRry4+dpm+
   QBwCBRxjXpbYNK5ncf1L6/tNcZJ4UcFVzuhic0OQaK542hdbMEQqBttTQ
   qseVrOkgOpSSDiS3pNH9toCt+vGHtX9JFH9rZCjUrOrZT2YuN2QkFrTBs
   w==;
X-CSE-ConnectionGUID: KQd7KeSmTaeAFHZuxvhHOQ==
X-CSE-MsgGUID: c4BaLHFeT2GbSS5nVPmRtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="57100651"
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="57100651"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 13:32:58 -0700
X-CSE-ConnectionGUID: ShSHhaLCRkOJn21GoBiWeA==
X-CSE-MsgGUID: 05YMCmJnSreQim31Isd97w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,201,1739865600"; 
   d="scan'208";a="129039266"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.111.236]) ([10.125.111.236])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 13:32:57 -0700
Message-ID: <f066cf58-b29e-4b5c-a22a-413fd9d03edd@intel.com>
Date: Wed, 9 Apr 2025 13:32:55 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Fix using wrong GPF DVSEC location issue
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250323093110.233040-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250323093110.233040-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/23/25 2:31 AM, Li Ming wrote:
> During review all new patches in branch cxl/next. I noticed there may be
> a problem in below commit.
> 
> commit a52b6a2c1c99 ("cxl/pci: Support Global Persistent Flush (GPF)")
> 
> There is a new field gpf_dvsec in struct cxl_port to cache GPF DVSEC for
> Port(DVSEC ID 04h) location. When the first EP attaching to a cxl port,
> it will trigger locating GPF DVSEC on the cxl dport which the first EP
> is under, then the location is cached in port->gpf_dvsec. So if another
> EP under another dport is attaching, it will reuse the value of
> port->gpf_dvsec as GPF DVSEC location for this another dport. The
> problem is the cached location may be a wrong location for other dports
> of the port.
> 
> Per Table 8-2 in CXL r3.2 section 8.1.1 and CXL r3.2 section 8.1.6, Each
> CXL Downstream switch ports and CXL root ports have their own GPF DVSEC
> for Port(DVSEC ID 04h). So my understanding is that CXL subsystem should
> locate GPF DVSEC for Port for each dport rather than using the cached
> location in CXL port.

Applied to cxl/fixes for 6.15-rc

> 
> base-commit: 3b5d43245f0a56390baaa670e1b6d898772266b3 cxl/next
> 
> v2:
> - Drop RFC tag.
> - Add Fixes tag to patch #1.
> - Pickup reviews.
> - Add tested by Davidlohr.
> - Adjust the changelog of patch #2.(Davidlohr)
> - Fix typo issue in patch #2.(Davidlohr)
> 
> Li Ming (3):
>   cxl/core: Fix caching dport GPF DVSEC issue
>   cxl/pci: Update Port GPF timeout only when the first EP attaching
>   cxl/pci: Drop the parameter is_port of cxl_gpf_get_dvsec()
> 
>  drivers/cxl/core/core.h |  2 +-
>  drivers/cxl/core/pci.c  | 30 +++++++++++++++++-------------
>  drivers/cxl/core/port.c |  2 +-
>  drivers/cxl/cxl.h       |  6 +++---
>  drivers/cxl/pmem.c      |  2 +-
>  5 files changed, 23 insertions(+), 19 deletions(-)
> 

