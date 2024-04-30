Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D911733
	for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 04:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714450428; cv=none; b=k7YoedGMxAoYwdciIxTgR6Glte+eFmNplbr9Td25ALN8nE/g69Ww5cThxgPZCrA1dd4i1l58MWSMjNTl96n6xeOP8tbvU+Mj8MxRnQHUg+h9nn57z9Yi3Mpkx+qJwvSRrJgjmQpKOrs9ceg/p6yB6lmIcN13bCEebKwYwenXtXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714450428; c=relaxed/simple;
	bh=C+tOIzR2GAj+TapS2u7/3XbwoOG4ntGtNa1HpD3cdg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6BwgLox0PdttqzE9OpFioA3Gdr1LU+KfGQWJIQ48eepjpcdYXP6FWMCjHL1AyfQ1AI9MVLjseg2Nav/zJlIAu8OHHD/N1OkT7C+PzS3jSoEsfNw+qeS7UESKPz97eIMlbxu9FBzBmE5Z2c2sHD05woms4rHwMU53sbFX3WOGMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2+rrL3/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2+rrL3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714450426; x=1745986426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C+tOIzR2GAj+TapS2u7/3XbwoOG4ntGtNa1HpD3cdg0=;
  b=n2+rrL3/Eo66Zxbt0AUzd3qh8dKsrGVQY3j1aX3RdI9J6RtDmEqO58mp
   DJJyw5JqAgGX4kwUxQCq6P9Jp1vM3c9II4kwh7Y4NXuBLxMvMdJrHN6bc
   Or54huYeT/2oZgpHLEkSsuIYtBzknwxPabgIu9mjY30FDz9y4JGI1Cdmf
   Gx2TWka4NIyFeOhpjcbZeOxmAwZGaT0c/fc2muPBhDp8kuRuxbHBjzFNz
   LAjRUM+uHCsTDfxCCCQvVqmFxkBJzF+Snp4LPUUIJCPYNXSlOR+Hg4G5p
   PWa8lZyiOMoIDziyKYIMHgdAgOO5nAS1O3Lvlls8NSDKiKl5y7ecQiwgL
   w==;
X-CSE-ConnectionGUID: jWi9GTJbQOGOnTbWGxKjXg==
X-CSE-MsgGUID: 5RHsvpEGRN2xjt8YHSlAfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10354569"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10354569"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 21:13:14 -0700
X-CSE-ConnectionGUID: XvSUuArLQZiox26l9mjqtA==
X-CSE-MsgGUID: XBM0lnb4SjyemKffh9F+hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="57515115"
Received: from rthapar-mobl1.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.128.213])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 21:13:14 -0700
Date: Mon, 29 Apr 2024 21:13:11 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH v5 4/4] cxl/core: Add region info to cxl_general_media
 and cxl_dram events
Message-ID: <ZjBv1zWDbdYYtjQ5@aschofie-mobl2>
References: <cover.1714435815.git.alison.schofield@intel.com>
 <ff90c45820c502c5f39c671fb159cc7b2ca8123b.1714435815.git.alison.schofield@intel.com>
 <66305516ba200_1b13712942b@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66305516ba200_1b13712942b@iweiny-mobl.notmuch>

On Mon, Apr 29, 2024 at 07:19:02PM -0700, Ira Weiny wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> 
> [snip]
> 
> > diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> > index 03fa6d50d46f..5342755777cc 100644
> > --- a/include/linux/cxl-event.h
> > +++ b/include/linux/cxl-event.h
> > @@ -91,11 +91,21 @@ struct cxl_event_mem_module {
> >  	u8 reserved[0x3d];
> >  } __packed;
> >  
> > +/*
> > + * General Media or DRAM Event Common Fields
> > + * - provides common access to phys_addr
> > + */
> > +struct cxl_event_common {
> > +	struct cxl_event_record_hdr hdr;
> > +	__le64 phys_addr;
> > +} __packed;
> 
> Was this left over from a previous version?
> 
> I don't see it used.  Nor is it a defined event in the spec AFAIK.
> 

I introduced it in v4. It is for the 'convenience' of getting at that
common phys_addr field. You snipped the usage away. I'll paste it back 
here:

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c

@@ -842,14 +842,38 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			    enum cxl_event_type event_type,
 			    const uuid_t *uuid, union cxl_event *evt)
 {

my snip...

+	if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
+		u64 dpa, hpa = ULLONG_MAX;
+		struct cxl_region *cxlr;
+
+		/*
+		 * These trace points are annotated with HPA and region
+		 * translations. Take topology mutation locks and lookup
+		 * { HPA, REGION } from { DPA, MEMDEV } in the event record.
+		 */
+		guard(rwsem_read)(&cxl_region_rwsem);
+		guard(rwsem_read)(&cxl_dpa_rwsem);
+
+		dpa = le64_to_cpu(evt->common.phys_addr) & CXL_DPA_MASK;

Used above. OK?

+		cxlr = cxl_dpa_to_region(cxlmd, dpa);
+		if (cxlr)
+			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
+
+		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
+			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
+						&evt->gen_media);
+		else if (event_type == CXL_CPER_EVENT_DRAM)
+			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->dram);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);




> The rest looks good.
> 
> Ira
> 
> > +
> >  union cxl_event {
> >  	struct cxl_event_generic generic;
> >  	struct cxl_event_gen_media gen_media;
> >  	struct cxl_event_dram dram;
> >  	struct cxl_event_mem_module mem_module;
> > +	struct cxl_event_common common;
> >  } __packed;
> >  
> >  /*
> > -- 
> > 2.37.3
> > 
> 
> 
