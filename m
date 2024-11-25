Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255F115B10D;
	Mon, 25 Nov 2024 20:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732567575; cv=none; b=WmCe7B4pNKaALQYKrRImRT8/UQjsIMzyinRDKPFhO+6BhWXxF8QWkAcrlMC+UZyhGCHHl9qVQ4KAxlOSS8ioVi1iAuuPUW3Iqtab9zWbpXCiLXW9LEeN/EWdFpUUDXhrKBNCKya8ADFgKS08KOrhrIr1T4RWERdhsG5Si+025TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732567575; c=relaxed/simple;
	bh=Df61xeZOHjROwxfb/YrRue9P2QcbBbfOZA3JhzZMi3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvSwtLjErbbx0HLvnFkauqummT1rXPaMGuQ6s/85CDI95kQFxifQECMCRE5/JijvElg7/w9hFPP9w9CdO80x+CidkB/KdIh+goI1x35lV82z54D5Os+NNECSBWvQ+uLb++Eiplq0/ZWMcM/iBNSJxMK28a7kDpteAmk9GHPyVhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQ/ql6+t; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQ/ql6+t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732567573; x=1764103573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Df61xeZOHjROwxfb/YrRue9P2QcbBbfOZA3JhzZMi3M=;
  b=SQ/ql6+t/lj0qt0SpgtJugaM/7gcO2BHR030YyHVfszjxcvGbPYkhYBw
   umZSncTmk0/kEMR9RvvZvZHcgnFB4s9eexLRJmxPpS/e9Gy7d3NR3jvT3
   BZ3EZgRDz9frK6UMYrVfW4DqoEi7pnQ5ozogpl4P2DiE8s4nZDn0P18GG
   j3/lQqaVf538dv3VY6ejzEVSr9E7yoMErIqLHgQJak2oSh/9Pqq/5fHr6
   NompRai1MO9Ctr2LUWbxmtwJcsSXllbLq/oItMRIFewcF+oxwIvANNzmm
   RYnCNSPtmg4NnPhKsoaJIra8RJ1x/+4rmXfSm+0pRh4jZbm+ln6I4Iue/
   A==;
X-CSE-ConnectionGUID: gt0177kGTN6HssVROE725w==
X-CSE-MsgGUID: 96lkpff1QHizhNVIVBfkbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="32636024"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="32636024"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 12:46:13 -0800
X-CSE-ConnectionGUID: tBWPjkQfQOCKuqY1DqqLnQ==
X-CSE-MsgGUID: LypB05aaR+6o+lsQAKp4ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="91842932"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.188])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 12:46:12 -0800
Date: Mon, 25 Nov 2024 12:46:10 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Li Ming <ming4.li@intel.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/3] cxl/test: Simulate an x86 Low Memory Hole for tests
Message-ID: <Z0TiEq2xExrejxTD@aschofie-mobl2.lan>
References: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
 <20241122155226.2068287-4-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122155226.2068287-4-fabio.m.de.francesco@linux.intel.com>

On Fri, Nov 22, 2024 at 04:51:54PM +0100, Fabio M. De Francesco wrote:
> Simulate an x86 Low Memory Hole for the CXL tests by changing
> mock_cfmws[0] range size to 768MB and CXL Endpoint Decoder HPA range size
> to 1GB and have get_cfmws_range_start() return two different addresses
> which depend on whether the passed device is real or mock.

How about adding:

Since the auto-created region of cxl-test uses mock_cfmws[0], the
LMH path in the CXL Driver will be exercised every time the cxl-test
module is loaded. Executing unit test: cxl-topology.sh, confirms the
region created succesfully with a LMH.

> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/core/lmh.c       | 21 +++++++++++++--------
>  drivers/cxl/cxl.h            |  7 +++++++
>  tools/testing/cxl/Kbuild     |  1 +
>  tools/testing/cxl/test/cxl.c |  4 ++--
>  4 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
> index da76b2a534ec..350008324bdc 100644
> --- a/drivers/cxl/core/lmh.c
> +++ b/drivers/cxl/core/lmh.c
> @@ -1,10 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
>  #include <linux/range.h>
> +#include <linux/pci.h>
>  #include "cxl.h"
>  
> -/* In x86 with memory hole, misaligned CFMWS range starts at 0x0 */
> -#define MISALIGNED_CFMWS_RANGE_BASE 0x0
> +u64 get_cfmws_range_start(struct device *dev)

Can this func be static, and then keep the #defines here, in lmh.c,
rather than move to cxl.h ?


> +{
> +	if (dev_is_pci(dev))
> +		return MISALIGNED_CFMWS_RANGE_START;

space before final return please

> +	return MISALIGNED_MOCK_CFMWS_RANGE_START;
> +}
>  

snip


> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a5ad4499381e..51dc80f8e50c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -903,12 +903,19 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  
>  #ifdef CONFIG_CXL_ARCH_LOW_MEMORY_HOLE
> +
> +/* Range start address of misaligned CFMWS in x86 with LMH */
> +#define MISALIGNED_CFMWS_RANGE_START 0x0
> +/* Range start address of mock misaligned CFMWS for tests */
> +#define MISALIGNED_MOCK_CFMWS_RANGE_START 0xf010000000
> +

As noted above, wondering why these need to be in cxl.h

Why 'MISALIGNED_ and not 'LMH_' , especially if you can move to lmh.c.

Is it guaranteed that MOCK_CFMWS_RANGE_START is at 0xf010000000?

-- Alison


snip to end

