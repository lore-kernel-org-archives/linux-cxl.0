Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ACD146D6A
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143467; cv=none; b=Exb4hNQOIn9bFc+7QHaOmowf/2v4O2LlZs3XWJjMEU4LkPEcZXJ+cSu0mPd2si+psjPIPpRMhkusZliodPszGczAxbwekGgf8tyjusiaTJ5UzE+JY04m6nj9uVBdTi+CFKNTTw8qbZOVFFrGXYZgRwVn1OI2OqPKDI+WEKhhwOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143467; c=relaxed/simple;
	bh=hIXx41zI5IgMaNBcBcKEg4W/gMOhVql+Shzgh1BpuMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aa2/5QEh+xZn6Yb/BuslHVj6xBHoNmOjWGbtZlnCE1JDgZYTvbmcycDw+v6+en9ISjMO7L7L1mUkzvlmsb4cn37FHLJwEKYSozmVxJ1fIbLUb/CccH4Z00mVEL6iJdYH96sBfRkXeQSB2g+QtLCc32mVXdtebXK7BFnfH5J+yl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iewM6U/V; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iewM6U/V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723143465; x=1754679465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hIXx41zI5IgMaNBcBcKEg4W/gMOhVql+Shzgh1BpuMg=;
  b=iewM6U/VhW4gWZT8K1+5LWxHqTpzncoqrYUnRhAkdSJ38EVts1v3bijl
   RVD8TV3OiodxhrCDaKQ8kBJ8LdjxZfK/Nh4w3xXBM0y2ruCHKJS2mX9ZG
   dO76ABE6Qy8HQxsnyfYldqftiDI6R+OsScJKIHEwbSh+Qgxz6nTiOAs6Z
   IwXFdR/gSbBvIRcTvgKV5HRxxlfOhiPTkfif0P6W3sCute5y4VRayAiWU
   JRICH/2sIcRu7GN+q62nKgz2A2WAX5RG9jFmaeokvxuG0NyOb8+DNGY7A
   LpJrK5C5DRKDiIsZg2nQGKgBwR306//4P8p+4qSOgxGcVKg9jDfmF5Qxo
   w==;
X-CSE-ConnectionGUID: LTPmMwT3SnqO5CZ/hcUqlQ==
X-CSE-MsgGUID: f70gtIfAR1Stp734Ij8w9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="31966015"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="31966015"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 11:57:43 -0700
X-CSE-ConnectionGUID: h2m21SjaRpSt0CthRJWOtg==
X-CSE-MsgGUID: mA0JVdXHQvSPvEuUijwOSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="80552113"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.12.215])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 11:57:43 -0700
Date: Thu, 8 Aug 2024 11:57:41 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Li, Ming4" <ming4.li@intel.com>
Cc: linux-cxl@vger.kernel.org, rrichter@amd.com, terry.bowman@amd.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH 1/1] cxl/pci: Get AER capability address from RCRB only
 for RCH dport
Message-ID: <ZrUVJUZQIU7yiW8V@aschofie-mobl2>
References: <20240806041547.1958787-1-ming4.li@intel.com>
 <ZrG0wKU1XgEutEO/@aschofie-mobl2>
 <1aa667ad-8581-4cc2-90c8-1c2fbd0592a9@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aa667ad-8581-4cc2-90c8-1c2fbd0592a9@intel.com>

On Thu, Aug 08, 2024 at 09:26:23AM +0800, Li, Ming4 wrote:
> On 8/6/2024 1:29 PM, Alison Schofield wrote:
> > On Tue, Aug 06, 2024 at 04:15:47AM +0000, Li Ming wrote:
> >> cxl_setup_parent_dport() needs to get RCH dport AER capability address
> >> from RCRB to disable AER interrupt. The function does not check if dport
> >> is RCH dport, it will get a wrong pci_host_bridge structure by dport_dev
> >> in VH case because dport_dev points to a pci device(RP or switch DSP)
> >> rather than a pci host bridge device.
> > Ming,
> >
> > Please add that this leads to a page fault. (from off-list chat)
> 
> Sure, will do it.
> 
> 
> >
> >> Besides, cxl_setup_parent_dport() can exit simply if a RCH dport in the
> >> RCH topology created by cxl-test, in the case, the RCH dport's dport_dev
> >> is a platform device, and RCH dport with an available RCRB and AER
> >> Capability is not supported yet.
> >>
> >> Fixes: f05fd10d138d ("cxl/pci: Add RCH downstream port AER register discovery")
> >> Signed-off-by: Li Ming <ming4.li@intel.com>
> >> ---
> >>  drivers/cxl/core/pci.c | 14 ++++++++++----
> >>  1 file changed, 10 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> >> index a663e7566c48..f8a3188f5b17 100644
> >> --- a/drivers/cxl/core/pci.c
> >> +++ b/drivers/cxl/core/pci.c
> >> @@ -4,6 +4,7 @@
> >>  #include <linux/io-64-nonatomic-lo-hi.h>
> >>  #include <linux/device.h>
> >>  #include <linux/delay.h>
> >> +#include <linux/platform_device.h>
> >>  #include <linux/pci.h>
> >>  #include <linux/pci-doe.h>
> >>  #include <linux/aer.h>
> >> @@ -834,11 +835,16 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
> >>  void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
> >>  {
> >>  	struct device *dport_dev = dport->dport_dev;
> >> -	struct pci_host_bridge *host_bridge;
> >>  
> >> -	host_bridge = to_pci_host_bridge(dport_dev);
> >> -	if (host_bridge->native_aer)
> >> -		dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
> >> +	if (dev_is_platform(dport_dev))
> >> +		return;
> > The above, dev_is_plaform(), is the cxl-test only case - right?
> 
> Thanks for review.
> 
> Right, only dports created by cxl-test using platform_device as dport->dport_dev.
> 
> 
> > I'm wondering if we need to mock something differently in cxl-test
> > because it is unusual to have a cxl-test special case in the driver.
> 
> Make sense, what do you think if I implement a mock function like mock_cxl_setup_parent_dport() for the case? The mock function can check if the dport is created by cxl-test then skip it.
>

Sounds good to me :)


> 
> Ming
> 
> >
> > Let's see what others say.
> >
> > --Alison
> >
> >
> >
> >> +
> >> +	if (dport->rch) {
> >> +		struct pci_host_bridge *host_bridge  = to_pci_host_bridge(dport_dev);
> >> +
> >> +		if (host_bridge->native_aer)
> >> +			dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
> >> +	}
> >>  
> >>  	dport->reg_map.host = host;
> >>  	cxl_dport_map_regs(dport);
> >> -- 
> >> 2.40.1
> >>
> >>
> 
