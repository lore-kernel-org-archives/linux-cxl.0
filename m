Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7080517BCD
	for <linux-cxl@vger.kernel.org>; Wed,  5 Jun 2024 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601533; cv=none; b=oL1GM0HXsoQ5UdmfLafWfA18yk7im2stx2EZbnx7TdqXLyloo1lgvEui77wx1IuodTw4i/+93ul8BmIqI81j/7cNykyJF2BVt8aJs+s4msF3lhZUVHuIZwIN9GiTzP1KsQ5UXM2X90+sCbaMyDMPclXrsFCs7eCiV1vlYpJmBUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601533; c=relaxed/simple;
	bh=b2wwg+A/XyGKAByJSA87N53BjijBr1o4e6BLgyJeYEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPH4VwW93qBqrwrTwhJyX8KgGPXi3aBx5G2lEIivgdIooiHpR51RTanrNb2LpbPDpPoPHPCdK3hAQq2gwriGHjz9YTF9IYcxMnc6wBNeqTUjTgIwAfu0e+3mRasMgsNcsnhBeue9n8p6BH9V173OkNsdPgbSe1qppMBsGO/GCLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EjmypOnc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EjmypOnc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717601532; x=1749137532;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b2wwg+A/XyGKAByJSA87N53BjijBr1o4e6BLgyJeYEM=;
  b=EjmypOncnMvv1QfI+oPXhEuZBbl+LFypjw5Fa12w1ewUFR7wqfGQwwDo
   PatC/+YcwS5RP1aVfAhPWJyZjisOTl+03vRPjM7RUPMc2xhBRCvxSiLrn
   005PuMjZ1Wi09yqrvMNZ9X/fRAQGO/edq823jCy/3Z5FGpUykAzatZG5w
   zHYLGBzo4m19Dv1wSBDSm4wVgZBMxOfR2GCuGk6E2/N+imo5fWF1EUnPR
   eG/6us8cEo03qwez1QMgXt8wexpR68UALlp2rpDI2+k/EIfKLLIE1H1LR
   TmzpjSCluFnfI3Gb1GHCEigGQLiBAvYXv2RYEqRDobHlUL8W2y18N10Uk
   g==;
X-CSE-ConnectionGUID: 3JhZlZXTQ/6Aq5b7LnK1Zg==
X-CSE-MsgGUID: IukeQaEJQdeoKqQvG1lTag==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="24853738"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="24853738"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 08:31:40 -0700
X-CSE-ConnectionGUID: JlZrCqQGS06lXIKoYwDBrQ==
X-CSE-MsgGUID: 6fKfta+nRSekRX0B0rdwtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="42044145"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.22.89])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 08:31:39 -0700
Date: Wed, 5 Jun 2024 08:31:37 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/region: Fix null pointer dereference in region
 lookup
Message-ID: <ZmCE2Qn0h2FZwl6+@aschofie-mobl2>
References: <20240605021928.223287-1-alison.schofield@intel.com>
 <20240605131835.00000048@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605131835.00000048@Huawei.com>

On Wed, Jun 05, 2024 at 01:18:35PM +0100, Jonathan Cameron wrote:
> On Tue,  4 Jun 2024 19:19:28 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > cxl_dpa_to_region() looks up a region based on a memdev and DPA.
> > It wrongly assumes an endpoint found mapping the DPA is also of
> > a fully assembled region. When not true it leads to a null pointer
> > dereference looking up the region name.
> > 
> > BUG: kernel NULL pointer dereference, address: 0000000000000050
> > RIP: 0010:__cxl_dpa_to_region+0x8c/0xc0 [cxl_core]
> > Call Trace:
> >  <TASK>
> >  ? show_regs+0x5f/0x70
> >  ? __die+0x1f/0x70
> >  ? page_fault_oops+0x14b/0x430
> >  ? __cxl_dpa_to_region+0x8c/0xc0 [cxl_core]
> >  ? search_exception_tables+0x5b/0x60
> >  ? fixup_exception+0x22/0x300
> >  ? kernelmode_fixup_or_oops.constprop.0+0x5a/0x70
> >  ? __bad_area_nosemaphore+0x166/0x230
> >  ? up_read+0x43/0x90
> >  ? bad_area_nosemaphore+0x11/0x20
> >  ? do_user_addr_fault+0x2cb/0x6b0
> >  ? find_held_lock+0x31/0x90
> >  ? exc_page_fault+0x6e/0x220
> >  ? asm_exc_page_fault+0x27/0x30
> >  ? __cxl_dpa_to_region+0x8c/0xc0 [cxl_core]
> >  ? __cxl_dpa_to_region+0x35/0xc0 [cxl_core]
> >  ? __pfx___cxl_dpa_to_region+0x10/0x10 [cxl_core]
> >  device_for_each_child+0x4a/0x70
> >  cxl_dpa_to_region+0x61/0x70 [cxl_core]
> >  cxl_inject_poison+0xde/0x1e0 [cxl_core]
> >  cxl_debugfs_poison_inject+0x9/0x10 [cxl_mem]
> > 
> > This appears during testing of region lookup after a failure to
> > assemble a BIOS defined region or if the lookup raced with the
> > assembly of the BIOS defined region.
> > 
> > Failure to clean up BIOS defined regions that fail assembly is an
> > issue in itself and a fix to that problem will alleviate some of
> > the impact. It will not alleviate the race condition so let's harden
> > this path.
> > 
> > The behavior change is that the kernel oops due to a null pointer
> > dereference is replaced with a dev_dbg() message noting that an
> > endpoint was mapped.
> > 
> > Additional comments are added so that future users of this function
> > can more clearly understand what it provides.
> > 
> > Fixes: 0a105ab28a4d ("cxl/memdev: Warn of poison inject or clear to a mapped region")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This simplified version works for me so keep the tag... However given the spirit of
> the patch changed rather a lot would have been reasonable to drop the RB.

Understand, sorry for the oversight.
Thanks for the second review too.
-- Alison

