Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4508F13A897
	for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 19:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988027; cv=none; b=sYnc9G9pbWLppfAdb6VhGMcw8ouBjuas/ei1pflTrJ11V+utBbh9IteRAabBfkEbK5ttojry03ZuqD1svoi6WjQX8KVOgR/BJ8pYMG16UuL+YSsegebsZDSk4vqNkp3DQVGKd5wXerB9xvTBukDrSCbY4Xi71K0n4Ne0RmCd8Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988027; c=relaxed/simple;
	bh=9s+EdBicP4IHBtopwdwbj/FeUOZJPHSxTUqtr66axVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l47SL09Uw5vueTu/XHDUFxHGRW+wP/WVIRM3jz5T6ycsBPfGJBuCWTTZnMOzUOc0gZXads0mT/jjLZCia099LhYuXKRzH3afN9ol4yDF60DMBVkkekUbhCIurn4XyDZwIC4SNHj+EgEop5I79X/cvMrLnA8K1Pb92a7vhhs7K0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oxo0lL5p; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oxo0lL5p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713988025; x=1745524025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9s+EdBicP4IHBtopwdwbj/FeUOZJPHSxTUqtr66axVg=;
  b=Oxo0lL5pH2zl3PAabfwNbjQghJVq7Sa5j5eZLIgFsU99GlsNk3PPZ6ph
   fM2k2WJ+n8p6pO02nrVBpo4WMVmgJROC06Cmed400zF+bSnJGrS47vW6E
   T7o74W9BO2W0ZZrzB/HXn1ME2KGUbdCR+asNFMnEw7TfjBo1AsFSTcHc8
   SrPsqrhk5RaYTfv6ybKa0eTAcN2bWV5C5e9xCHbHqS1Oi96UjxXNoeE3V
   yxTKujvW7IGIIV4zEn5BQ9m6F0AjidzmY1beEFzH+ziFaBbmumg3kbqfL
   5AnX9whkyNBetfcGKt53SHTMwwdeAE/Znhn0vYmBgoimtigtbt1vwVJCy
   A==;
X-CSE-ConnectionGUID: LEpEA4MZQ+q2iITrq7ZC/A==
X-CSE-MsgGUID: aR55vkbNRaG+mkA2uB3dvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9513603"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="9513603"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 12:47:05 -0700
X-CSE-ConnectionGUID: 281rLJNDR8qMnpbmbI8RMw==
X-CSE-MsgGUID: Ia33xT66RZW254tOaPVjqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="48071040"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.186.94])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 12:47:04 -0700
Date: Wed, 24 Apr 2024 12:47:02 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 3/4] cxl/core: Add region info to cxl_general_media
 and cxl_dram events
Message-ID: <ZilhtqkbgYTKs8A3@aschofie-mobl2>
References: <cover.1713842838.git.alison.schofield@intel.com>
 <800328a3fdffa0f3ece709be337bd64a07089bff.1713842838.git.alison.schofield@intel.com>
 <662895f86a0d9_a96f2949d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662895f86a0d9_a96f2949d@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Tue, Apr 23, 2024 at 10:17:44PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > User space may need to know which region, if any, maps the DPAs
> > (device physical addresses) reported in a cxl_general_media or
> > cxl_dram event. Since the mapping can change, the kernel provides
> > this information at the time the event occurs. This informs user
> > space that at event <timestamp> this <region> mapped this <DPA>
> > to this <HPA>.
> > 
> > Add the same region info that is included in the cxl_poison trace
> > event: the DPA->HPA translation, region name, and region uuid.
> > Introduce and use new helpers that lookup that region info using
> > the struct cxl_memdev and a DPA.
> > 
> > The new fields are inserted in the trace event and no existing
> > fields are modified. If the DPA is not mapped, user will see:
> > hpa=ULLONG_MAX, region="", and uuid=0
> > 
> > This work must be protected by dpa_rwsem & region_rwsem since
> > it is looking up region mappings.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/cxl/core/core.h   |  6 +++++
> >  drivers/cxl/core/mbox.c   | 17 ++++++++++---
> >  drivers/cxl/core/region.c |  8 ++++++
> >  drivers/cxl/core/trace.h  | 52 +++++++++++++++++++++++++++++++++++----
> >  4 files changed, 74 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index 625394486459..2fd8d9797f36 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -30,8 +30,14 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
> >  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
> >  u64 cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> >  		  u64 dpa);
> > +const char *cxl_trace_to_region_name(const struct cxl_memdev *cxlmd, u64 dpa);
> >  
> >  #else
> > +static inline
> > +const char *cxl_trace_to_region_name(const struct cxl_memdev *cxlmd, u64 dpa)
> > +{
> > +	return "";
> > +}
> >  static inline u64
> >  cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd, u64 dpa)
> >  {
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 9adda4795eb7..3c1c37d5fcb0 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -842,14 +842,23 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> >  			    enum cxl_event_type event_type,
> >  			    const uuid_t *uuid, union cxl_event *evt)
> >  {
> > +	if (event_type == CXL_CPER_EVENT_MEM_MODULE) {
> > +		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
> > +		return;
> > +	}
> > +	if (event_type == CXL_CPER_EVENT_GENERIC) {
> > +		trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
> > +		return;
> > +	}
> > +
> > +	/* Protect trace events that do DPA->HPA translations */
> > +	guard(rwsem_read)(&cxl_region_rwsem);
> > +	guard(rwsem_read)(&cxl_dpa_rwsem);
> > +
> >  	if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
> >  		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
> >  	else if (event_type == CXL_CPER_EVENT_DRAM)
> >  		trace_cxl_dram(cxlmd, type, &evt->dram);
> > -	else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
> > -		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
> > -	else
> > -		trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
> >  
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 45eb9c560fd6..a5b1eaee1e58 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2723,6 +2723,14 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
> >  	return ctx.cxlr;
> >  }
> >  
> > +const char *cxl_trace_to_region_name(const struct cxl_memdev *cxlmd, u64 dpa)
> > +{
> > +	struct cxl_region *cxlr = cxl_dpa_to_region(cxlmd, dpa);
> > +
> > +	/* trace __string() assignment requires "", not NULL */
> > +	return cxlr ? dev_name(&cxlr->dev) : "";
> > +}
> > +
> >  static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
> >  {
> >  	struct cxl_region_params *p = &cxlr->params;
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index 161bdb5734b0..2e24364b2b8d 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -14,6 +14,28 @@
> >  #include <cxlmem.h>
> >  #include "core.h"
> >  
> > +#ifndef __CXL_EVENTS_DECLARE_ONCE_ONLY
> > +#define __CXL_EVENTS_DECLARE_ONCE_ONLY
> > +static inline
> > +void store_region_info(const struct cxl_memdev *cxlmd, u64 dpa, uuid_t *uuid,
> > +		       u64 *hpa)
> > +{
> > +	struct cxl_region *cxlr;
> > +
> > +	cxlr = cxl_dpa_to_region(cxlmd, dpa);
> > +	if (cxlr) {
> > +		uuid_copy(uuid, &cxlr->params.uuid);
> > +		*hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
> > +	} else {
> > +		uuid_copy(uuid, &uuid_null);
> > +		*hpa = ULLONG_MAX;
> > +	}
> > +}
> > +#endif /* __CXL_EVENTS_DECLARE_ONCE_ONLY */
> 
> This ifdef usage looks awkward...

I only mimic'd others that defined static inline funcs in trace header files.
I originally thought it would be protected from this define that already
wraps this header file content, but it doesn't.

#if !defined(_CXL_EVENTS_H) || defined(TRACE_HEADER_MULTI_READ)
#define _CXL_EVENTS_H

> 
> > +
> > +#define rec_pa_to_dpa(record)						\
> > +	(le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK)
> > +
> >  #define CXL_RAS_UC_CACHE_DATA_PARITY	BIT(0)
> >  #define CXL_RAS_UC_CACHE_ADDR_PARITY	BIT(1)
> >  #define CXL_RAS_UC_CACHE_BE_PARITY	BIT(2)
> > @@ -330,10 +352,14 @@ TRACE_EVENT(cxl_general_media,
> >  		__field(u8, channel)
> >  		__field(u32, device)
> >  		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
> > -		__field(u16, validity_flags)
> >  		/* Following are out of order to pack trace record */
> > +		__field(u64, hpa)
> > +		__field_struct(uuid_t, region_uuid)
> > +		__field(u16, validity_flags)
> >  		__field(u8, rank)
> >  		__field(u8, dpa_flags)
> > +		__string(region_name,
> > +			 cxl_trace_to_region_name(cxlmd, rec_pa_to_dpa(record)))
> 
> ...and this looks complicated.
> 
> A bit too much dynamic resolution happening within the trace function
> for my taste. Just do the region lookup in cxl_event_trace_record() and
> pass it in. That also makes the rwsem usage more apparent rather than
> digging through trace to find the dependency.

When these cxl_general_media,dram,poison trace events were originally
created once of the goals was to push work down *here* so that if the
trace events were not enable, no needless work is done.

When you suggest doing the region lookup before calling the trace handler,
I'm thinking something like this where the region lookup work still gets
skipped if tracing is not enabled:

	if (trace_cxl_general_media_enabled()) {
		cxlr = lookup_region(cxlmd, record);
		trace_cxl_general_media(...., cxlr);

-- Alison
