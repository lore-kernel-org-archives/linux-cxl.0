Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBD3376
	for <linux-cxl@vger.kernel.org>; Mon, 29 Apr 2024 02:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714357870; cv=none; b=UInu33MEJ+2hHZcQuUa/urperNmbpF/U0BxKwUxVpPrU4uOvHWuZn4+ALz6K6WEBs03e7gaABCQo3Fj3WvLgKqUT4TbJW5MSUHViH+hVzRcjRND+3csWK48Shn1X5L6LYK2O3r+gM/MBY0NcUT6KnGi57cNXJFlPXi1c1fmk6Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714357870; c=relaxed/simple;
	bh=Rv/FsgiRp1Y9Y8iwjCUBl6a9q3zAzKK5dg2/vL4S7f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFhGwUXxhd4VjtCK5ZDNQTt6NZn2FUtdJmjHDI4AzTx/o1vzHnBZAt0ayuugsIbMGRU8lYpRK3od9Z/51mFEC1pHf5ANajv/nuT1yzvIEwc425PmIqcYso5DGAmZedEWWNjsqQG3plsfs0HbErN8BZ5NGKILuT56zNZ+E/JIx88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bK/Hhg4Y; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bK/Hhg4Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714357869; x=1745893869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rv/FsgiRp1Y9Y8iwjCUBl6a9q3zAzKK5dg2/vL4S7f4=;
  b=bK/Hhg4YuFk3q7T8z3C8C/r6rx0sLLWV6cbZ3oQ+ohM602kdcuQR4TzS
   dDcLY2zkSHjxX6mam1uZiLcQgOsO08Zskr0hmpKRdxsHyQu8Pc7bIVvGS
   vT9LmzwUHWc04J6TmEmqAxKl1XGgnCvkO+MMle1QmLEaUVER0Cceh2PbE
   RjaGq4eXzxctmQeDonMzmOoy1cbxuez2pZw+ae8uvMxrwhyk8BfubKSCX
   jpzYYYGnhZhUsrDyowRemmJ1L9Lg4mAwXPeTAH9MRDijMibO01lnMu0mR
   EB4hF7UxWaSlaM/yhLMPuU2gjP+LpV2O37GMgNxNBjOqb3TteXutz6+1R
   w==;
X-CSE-ConnectionGUID: s4GkOjgxTeuW+Ok1vTSVDA==
X-CSE-MsgGUID: DEW7Ljt8SoOzwS8q1UiB6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10167515"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="10167515"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 19:31:08 -0700
X-CSE-ConnectionGUID: WJclRqmATv2aleaJhandmg==
X-CSE-MsgGUID: 6YrA/sa8SGuFHyBsgfFvTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="30621504"
Received: from tekstrom-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.96.112])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 19:31:07 -0700
Date: Sun, 28 Apr 2024 19:31:05 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 3/3] cxl/core: Add region info to cxl_general_media
 and cxl_dram events
Message-ID: <Zi8GaXl3odQqQiMz@aschofie-mobl2>
References: <cover.1714102202.git.alison.schofield@intel.com>
 <a45eef6938944be3a21e862d238ba65921f07a42.1714102202.git.alison.schofield@intel.com>
 <662c471aefe43_b6e029445@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662c471aefe43_b6e029445@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Fri, Apr 26, 2024 at 05:30:19PM -0700, Dan Williams wrote:
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
> > 
> > The new fields are inserted in the trace event and no existing
> > fields are modified. If the DPA is not mapped, user will see:
> > hpa=ULLONG_MAX, region="", and uuid=0
> > 
> > This work must be protected by dpa_rwsem & region_rwsem since
> > it is looking up region mappings.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/mbox.c   | 36 ++++++++++++++++++++++++++------
> >  drivers/cxl/core/trace.h  | 44 +++++++++++++++++++++++++++++++--------
> >  include/linux/cxl-event.h | 10 +++++++++
> >  3 files changed, 75 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 9adda4795eb7..df0fc2a4570f 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -842,14 +842,38 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> >  			    enum cxl_event_type event_type,
> >  			    const uuid_t *uuid, union cxl_event *evt)
> >  {
> > -	if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
> > -		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
> > -	else if (event_type == CXL_CPER_EVENT_DRAM)
> > -		trace_cxl_dram(cxlmd, type, &evt->dram);
> > -	else if (event_type == CXL_CPER_EVENT_MEM_MODULE)
> > +	if (event_type == CXL_CPER_EVENT_MEM_MODULE) {
> >  		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
> > -	else
> > +		return;
> > +	}
> > +	if (event_type == CXL_CPER_EVENT_GENERIC) {
> >  		trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
> > +		return;
> 
> Minor, but I think you could shave a couple more lines by keeping the
> else-if tree going and skip the early "return" calls with a final:
> 
> 	else if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled())
> 

I think I didn't do that because this last 'if' breaks the pattern
since it's not based on event_type. We're doing something different
in this chunk of code.

A switch would be well suited, but it uses even more LOC - like this:

+
+
+	switch (event_type) {
+	case CXL_CPER_EVENT_MEM_MODULE:
+		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
+		break;
+
+	case CXL_CPER_EVENT_GENERIC:
+		trace_cxl_generic_event(cxlmd, type, uuid, &evt->generic);
+		break;
+
+	case CXL_CPER_EVENT_GEN_MEDIA:
+	case CXL_CPER_EVENT_DRAM:
+		u64 dpa, hpa = ULLONG_MAX;
+		struct cxl_region *cxlr;
+
+		if (!trace_cxl_general_media_enabled() &&
+		    !trace_cxl_dram_enabled())
+			break;
+		/*
+		 * These trace points are annotated with HPA and region
+		 * translations. Take topology mutation locks and lookup
+		 * { HPA, REGION } from { DPA, MEMDEV } in the event record.
+		 */
+		guard(rwsem_read)(&cxl_region_rwsem);
+		guard(rwsem_read)(&cxl_dpa_rwsem);
+
+		dpa = le64_to_cpu(evt->common.phys_addr) & CXL_DPA_MASK;
+		cxlr = cxl_dpa_to_region(cxlmd, dpa);
+		if (cxlr)
+			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
+
+		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
+			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
+						&evt->gen_media);
+		else if (event_type == CXL_CPER_EVENT_DRAM)
+			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->dram);
+		break;
+	default:
+		break;
+	}
+

Maybe if I just move the comment before the changed chunk of code,
the break in flow will be easier to follow.

> > +	}

	/* Move the comment below to here */
> > +
> > +	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
> > +		u64 dpa, hpa = ULLONG_MAX;
> > +		struct cxl_region *cxlr;
> > +
> > +		/*
> > +		 * These trace points are annotated with HPA and region
> > +		 * translations. Take topology mutation locks and lookup
> > +		 * { HPA, REGION } from { DPA, MEMDEV } in the event record.
> > +		 */
> > +		guard(rwsem_read)(&cxl_region_rwsem);
> > +		guard(rwsem_read)(&cxl_dpa_rwsem);
> > +
> > +		dpa = le64_to_cpu(evt->common.phys_addr) & CXL_DPA_MASK;
> 
> A merge issue here for Dave to handle here since CXL_DPA_MASK is known
> broken. Do you want to wait until that bikeshedding on CXL_DPA_MASK
> replacement name completes, or just take the simple:
> 
>   -#define CXL_DPA_FLAGS_MASK                   0x3F
>   +#define CXL_DPA_FLAGS_MASK                   0x3FULL
> 
> ...for now?

I'm optimistic we can get that fixes patch in. Don't worry about it ;)

> 
> Otherwise,
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
