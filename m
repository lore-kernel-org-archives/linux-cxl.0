Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AC819B581
	for <linux-cxl@vger.kernel.org>; Fri,  7 Jun 2024 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782347; cv=none; b=fLri5wsexqOov0M8bazEk984BZKnNn5ZW2ITtCcPzhgojm9altm+DG8XZcP59BiADDh8cN2DImpSU1U8xMPlrrITUSKSihaY04BzMb4eYUluh1r54gXc0227YlcTV2U7IQZ0xsheu5AOhZTGymqBFn1BHoXhSROStaAAg4bx5QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782347; c=relaxed/simple;
	bh=3b8laMjgi8nuU/gBLXLDJVsd+JbhieidtEH53qxtXok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ/EUuOMYoLGQcKD7DTDiMYF8URT6h6FR4ER2BQAadUAIkAkGMrG6xyK4DxbYdLpS2C0JFG2fBa+hUgWKrdFbQ99E/uJbu4PG3xq8Fkg2s/5f7lJYF/jX94NigsI2VYc1IE+3a1j4vyNryo+i2F4k4IRifYsPMh4p1sCFeXX3WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kMzMyQ4q; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kMzMyQ4q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717782346; x=1749318346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3b8laMjgi8nuU/gBLXLDJVsd+JbhieidtEH53qxtXok=;
  b=kMzMyQ4q3CLUVc2wpemxutdTtmBan56xSe6++pCmfoss2O+hGnswsphG
   vE8n/KLNaUlybSpLD3HuUPYajKKXB8ijpzX444R0XXsAHdS9ijYsZ9xmN
   k7CgQPUUyhue5k7hktQ0L8l4sWf2Ti3tKQYdsby0FxQc9p2pBTjrIlhGY
   RowAk1lJWLUHKJ9pAKpa4jhViCqa4VvgRU1qGQUgo6Q2Ib1zsq8x6LtHF
   shNTFJfRUgVoN7+mtdgPOHog80kToeV2RsJcfckPb/9D+Fj5BJrU73upD
   BFcKUJSRXY77c2E+JJzlj87Y9xyJ/M4eQuS1KzPPnKH13wRcfHGz/roXk
   w==;
X-CSE-ConnectionGUID: B8IWkQlYRrypGReKED+Xaw==
X-CSE-MsgGUID: MNozIcjDQDanFFrapBr5Sg==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="17443067"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="17443067"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 10:45:45 -0700
X-CSE-ConnectionGUID: eJKReMppSzCh2tlK6l2T9w==
X-CSE-MsgGUID: 6cunr8ZaSDKM64lg3T0Pig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38382109"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.38.179])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 10:45:44 -0700
Date: Fri, 7 Jun 2024 10:45:42 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/4] cxl/core: Rename cxl_trace_hpa() to
 cxl_translate()
Message-ID: <ZmNHRrzl2tJvR2SW@aschofie-mobl2>
References: <cover.1715192606.git.alison.schofield@intel.com>
 <27686c91cf4f8b09991534708f6ad2dfc2443af1.1715192606.git.alison.schofield@intel.com>
 <20240607154025.0000786d@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607154025.0000786d@Huawei.com>

On Fri, Jun 07, 2024 at 03:40:25PM +0100, Jonathan Cameron wrote:
> On Wed,  8 May 2024 11:47:50 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Although cxl_trace_hpa() is used to populate TRACE EVENTs with HPA
> > addresses, the work it performs is a translation (dpa->hpa), not a
> > trace. Rename it. Since this is the only translate work in CXL,
> > drop the _hpa suffix in the rename.
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Maybe makes some sense to keep the direction in the name?
> 
> I can see for things like PPR we may need to go HPA to DPA as
> it'll be based on error counts that may be reported in HPA.
> 
> So Friday bikeshedding time. 
> cxl_dpa_to_hpa()?

Thanks for the review Jonathan!

Let's sync on the possible dpa->hpa->dpa use cases and then I'll
weigh in on your bikeshedding.

Agree we need HPA->DPA support for userspace. User needs ability
to find which device maps an HPA.

wrt PPR, do you think that is an in kernel need?
If the PPR maintenance was done in response to a CXL event, the DPA
is already in the event trace along with the HPA so I wouldn't expect
that a lookup is needed, at least not within the kernel.

Your explicit cxl_dpa_to_hpa() name is good.

--Alison



> 
> 
> > ---
> >  drivers/cxl/core/core.h   | 4 ++--
> >  drivers/cxl/core/mbox.c   | 2 +-
> >  drivers/cxl/core/region.c | 2 +-
> >  drivers/cxl/core/trace.h  | 2 +-
> >  4 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index 625394486459..8ceebd3b51d2 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -28,12 +28,12 @@ int cxl_region_init(void);
> >  void cxl_region_exit(void);
> >  int cxl_get_poison_by_endpoint(struct cxl_port *port);
> >  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
> > -u64 cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> > +u64 cxl_translate(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> >  		  u64 dpa);
> >  
> >  #else
> >  static inline u64
> > -cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd, u64 dpa)
> > +cxl_translate(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd, u64 dpa)
> >  {
> >  	return ULLONG_MAX;
> >  }
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 2626f3fff201..edc54a1ca298 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -878,7 +878,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> >  		dpa = le64_to_cpu(evt->common.phys_addr) & CXL_DPA_MASK;
> >  		cxlr = cxl_dpa_to_region(cxlmd, dpa);
> >  		if (cxlr)
> > -			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
> > +			hpa = cxl_translate(cxlr, cxlmd, dpa);
> >  
> >  		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
> >  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 00a9f0eef8dd..245edf748906 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2797,7 +2797,7 @@ static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
> >  	return hpa;
> >  }
> >  
> > -u64 cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> > +u64 cxl_translate(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> >  		  u64 dpa)
> >  {
> >  	struct cxl_region_params *p = &cxlr->params;
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index 07a0394b1d99..6925a6a31f01 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -704,7 +704,7 @@ TRACE_EVENT(cxl_poison,
> >  		if (cxlr) {
> >  			__assign_str(region, dev_name(&cxlr->dev));
> >  			memcpy(__entry->uuid, &cxlr->params.uuid, 16);
> > -			__entry->hpa = cxl_trace_hpa(cxlr, cxlmd,
> > +			__entry->hpa = cxl_translate(cxlr, cxlmd,
> >  						     __entry->dpa);
> >  		} else {
> >  			__assign_str(region, "");
> 
