Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AD97483;
	Fri,  5 Sep 2025 00:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757030861; cv=none; b=uBMYIMAoOPKRMcZZ/t24SXJG+ST5ANtkDpRjkdJsVMXRpTM1JetJvBT0UHLKAyZ+ulCrjUfuSkw4ATa05TZVNaiRCqe6IWUw7bAupPHAdJiwkgYOuwDdYakRx2yRR6j+mHIG8rEGS96kiIIinl65Utkc3RY37MD5yANhkvEnBjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757030861; c=relaxed/simple;
	bh=lHqY1wJPcSDmE3iUOhGZSBp2N+TGzbF6LV8oPS5ZZII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxB5QtgTCacB/UdXvKGAPX7KgpVz4lsxdbfFlUGyh2HYfKvTX8UOwM8Hur/uORfcUbJu49b6dNel/OBeceJ0yqQNNYI0G8WboNXHU6DZ5U8XXTxSWvipKZAUxmx0YS8NkVg4Wr0xlMi/DksuEQiIgQbX0hlQT713R2rvoEk0v8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LAbwofok; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAbwofok"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757030860; x=1788566860;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lHqY1wJPcSDmE3iUOhGZSBp2N+TGzbF6LV8oPS5ZZII=;
  b=LAbwofok4rzlgMJdKJBlJctGfZdugRypwjfivcm1cF70ohXOVtvHqO6v
   mAkf6k3Q3dt9hmhLutr4QfF5CD7KfQoSKNECuLSr5yDmvK5NDVLBulL1B
   R558w6e2do9NwBACbafFBmiBBC4g/Vh4FgxbGL9BKhiV+eaOgbqDaW4bU
   saKeYlZ7klXt6KNSmTHQ0QUSJwtlanIJd3GGa+/iZJcgdgkq8lf8McM2W
   tYlM3glWisd2LYk8qCM//tq7ruoKQjMZky6vogM7FC8OWxWjBKOiT6j2n
   IdwLjERBQXOxZMKTvY5mRx8lJVk5d3AkF+2xo4VhDwVaJ6288erobTiJq
   Q==;
X-CSE-ConnectionGUID: 6rrXIuaGTOyvKlBUr3Gygg==
X-CSE-MsgGUID: AKR1lR8ySd+7DOATQkx+Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="63024435"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="63024435"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 17:07:39 -0700
X-CSE-ConnectionGUID: /gxvi3aKS4C/ERgaNyKIig==
X-CSE-MsgGUID: mtSvOWMbToSsCr8vtc1sEQ==
X-ExtLoop1: 1
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.110.24]) ([10.125.110.24])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 17:07:37 -0700
Message-ID: <91f42134-851d-446b-8b60-f93c429cfc59@intel.com>
Date: Thu, 4 Sep 2025 17:07:36 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4 v4] cxl/core: Enable Region creation/attach on x86
 with LMH
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>,
 ming.li@zohomail.com, linux-kernel@vger.kernel.org
References: <20250724142144.776992-1-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250724142144.776992-1-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/24/25 7:20 AM, Fabio M. De Francesco wrote:
> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> Physical Address (HPA) windows that are associated with each CXL Host
> Bridge. Each window represents a contiguous HPA that may be interleaved
> with one or more targets (CXL v3.1 - 9.18.1.3).
>  
> The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> memory to which systems cannot send transactions. On those systems, BIOS
> publishes CFMWS which communicate the active System Physical Address (SPA)
> ranges that map to a subset of the Host Physical Address (HPA) ranges. The
> SPA range trims out the hole, and capacity in the endpoint is lost with no
> SPA to map to CXL HPA in that hole.
>  
> In the early stages of CXL Regions construction and attach on platforms
> with Low Memory Holes, the driver fails and returns an error because it
> expects that the CXL Endpoint Decoder range is a subset of the Root
> Decoder's (SPA >= HPA). On x86 with LMH's, it happens that SPA < HPA.
> 
> Therefore, detect x86 Low Memory Holes, match CXL Root and Endpoint
> Decoders or already made CXL Regions and Decoders to allow the
> construction of new CXL Regions and the attachment of Endpoint Decoders,
> even if SPA < HPA. If needed because of LMH's, adjust the Endpoint Decoder
> range end to match Root Decoder's.
> 
> - Patch 1/4 changes the calling conventions of three match_*_by_range()
>   helpers in preparation of 3/4.
> - Patch 2/4 Introduces helpers to detect LMH's and also one to adjust
>   the HPA range end for CXL Regions construction.
> - Patch 3/4 enables CXL Regions construction and Endpoint Decoders
>   attachment by matching Root Decoders or Regions with Endpoint
>   Decoders, adjusting Endpoint Decoders HPA range end, and relaxing
>   constraints while Endpoints decoders' attachment.
> - Patch 4/4 simulates a LMH for the CXL tests on patched CXL driver.
> 
> Many thanks to Alison, Dan, Dave and Ira for their help.
> 
> Commenting on v1, Alison wrote a couple of observations on what users
> will see. I suggest anyone interested to see how this series affect
> users to take a look at her observations.[0] Thank you!
> 
> Changes for v4:
> 
>   Re-base on top of 
> 	"cxl: Address translation support, part 1: Cleanups and refactoring";[1] 
>   Drop no more necessary 2/4;
>   Drop collected tags because of major changes throughout the series.
> 
>   1/3 - Adjust Endpoint Decoders dpa_res->end (Alison) [2] 
>   3/3 - Use weak/strong mechanism (Dan) [3]
> 
> Changes for v3:
> 
>   Re-base the series on cxl/next.
> 
>   1/4 - 2/4:
>         Constify local variables.
>   3/4:
>         Call arch_match_region() from region_res_match_cxl_range().
>   4/4:
>         arch_match_region() - Check that region end is under start + 4G;
>         arch_match_spa() - Check that SPA range start is cfmws_range_start.
> 
> v3 - https://lore.kernel.org/linux-cxl/20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com/
> v2 - https://lore.kernel.org/linux-cxl/20250114203432.31861-1-fabio.m.de.francesco@linux.intel.com/
> v1 - https://lore.kernel.org/all/20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com/
> 
> [0] - https://lore.kernel.org/all/Z0Tzif55CcHuujJ-@aschofie-mobl2.lan/
> [1] - https://lore.kernel.org/linux-cxl/20250509150700.2817697-1-rrichter@amd.com/
> [2] - https://lore.kernel.org/linux-cxl/Z9tzZkn1rqd2Uk_6@aschofie-mobl2.lan/
> [3] - https://lore.kernel.org/linux-cxl/67ee07cd4f8ec_1c2c6294d5@dwillia2-xfh.jf.intel.com.notmuch/
> 
> Fabio M. De Francesco (4):
>   cxl/core: Change match_*_by_range() signatures
>   cxl/core: Add helpers to detect Low Memory Holes on x86
>   cxl/core: Enable Region creation on x86 with LMH
>   cxl/test: Simulate an x86 Low Memory Hole for tests
> 
>  drivers/cxl/Kconfig               |   5 ++
>  drivers/cxl/core/Makefile         |   1 +
>  drivers/cxl/core/platform.c       |  86 +++++++++++++++++++
>  drivers/cxl/core/platform.h       |  32 +++++++
>  drivers/cxl/core/region.c         | 113 ++++++++++++++++--------
>  tools/testing/cxl/Kbuild          |   2 +
>  tools/testing/cxl/mock_platform.c | 137 ++++++++++++++++++++++++++++++
>  tools/testing/cxl/test/cxl.c      |  10 +++
>  tools/testing/cxl/test/mock.h     |   1 +
>  9 files changed, 352 insertions(+), 35 deletions(-)
>  create mode 100644 drivers/cxl/core/platform.c
>  create mode 100644 drivers/cxl/core/platform.h
>  create mode 100644 tools/testing/cxl/mock_platform.c
> 
> base-commit: acc2913692413df9d1

The series doesn't seem to apply to this base commit. 
> 

