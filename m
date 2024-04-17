Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA220364
	for <linux-cxl@vger.kernel.org>; Wed, 17 Apr 2024 00:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713314384; cv=none; b=hYmnxv1zxqp2L4ynsgUAEMvSx5+eRqeszxci0zxFVPBUsS1coLoR7DUqBp6iVzWzYOqkGLf04+sujpv0PCTovnuAwOabZTtVvVyadMI/SIHD+1XTLEVhppRkOviV1QdAxPRcx3n3AfboVt/cyZxj+oLuASfNXhQuKwaFborHb3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713314384; c=relaxed/simple;
	bh=nJvD7iLpDcOYhZWd+hthRSbx94QtM9cWcqyWCIbCVjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nwtu57E8skZW+au5KfpKUAn7ugJuhObCsllJ/nJZXGuP6toHW1+OVnF5onq2V5ZK8Ykb8htM0bEA/Ze4jtXTgJKQwvEbQmcdAXust59KWtHJ7nZS9cZC7K4wFvLd3fHGctk2cSGuuIXMj3dUZg0aR05xHVQoJEPk7FkoHbdIjAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIKNM0Mn; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIKNM0Mn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713314383; x=1744850383;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nJvD7iLpDcOYhZWd+hthRSbx94QtM9cWcqyWCIbCVjA=;
  b=HIKNM0MnxnLD7XdfpgjKo2OPvBBaT5oHX+f6AFqHTXL0MxTa2vXsUhKp
   c98LV3ys65nTnqtcahC4I6ZntbpPp8+Sn4tfajH/Yzp790KzIatrG7d1j
   u7ZeLydRcfT1n3RsPBQMgrj7VJ0Z5kVVDM3L/lcPwSWMD0R6DV2N5T025
   FNaSXu2kNj/t16MBRAKDKA6iDC5UaplH7DFr6skQ/WUUtVuNevqUkieN2
   Fq5Pam1YN9r/XJIem3QInzB7s0/3gpra6vAj1lISO9cmvfQq8/2jeiazh
   fxeyKhy9hWvHQHpemB77UD0uy4sTu/2wICysgvqsPk4esOt6b+rR9FF0a
   Q==;
X-CSE-ConnectionGUID: ZcveuZ4uT72ww8lCUqwI8Q==
X-CSE-MsgGUID: kmbUGjQVQAGc3arMcLEvhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12572845"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="12572845"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 17:39:43 -0700
X-CSE-ConnectionGUID: qdfigzMsSve0pIsytIkUHA==
X-CSE-MsgGUID: l7e7R6vnTgSPWgTXJ0YYag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22517874"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.184.212])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 17:39:42 -0700
Date: Tue, 16 Apr 2024 17:39:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/4] cxl/core: Add region info to cxl_general_media and
 cxl_dram events
Message-ID: <Zh8aTGIBOYW5Hl/n@aschofie-mobl2>
References: <cover.1711598777.git.alison.schofield@intel.com>
 <061d1eac5d4e270337911199f0b0633c0ff230b4.1711598777.git.alison.schofield@intel.com>
 <661eaee1cadc2_3f1829294fe@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <661eaee1cadc2_3f1829294fe@iweiny-mobl.notmuch>

+ Steve 

On Tue, Apr 16, 2024 at 10:01:21AM -0700, Ira Weiny wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> 
> [snip]
> 
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index 161bdb5734b0..6ad4998aeb9a 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -14,6 +14,22 @@
> >  #include <cxlmem.h>
> >  #include "core.h"
> > 

snip

> > +#define store_region_info(cxlmd, dpa, entry_uuid, entry_hpa)		\
> > +	do {								\
> > +		struct cxl_region *cxlr;				\
> > +									\
> > +		cxlr = cxl_dpa_to_region(cxlmd, dpa);			\
> > +		if (cxlr) {						\
> > +			uuid_copy(&(entry_uuid), &cxlr->params.uuid);	\
> > +			entry_hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);	\
> > +		} else {						\
> 
> Does the record get zeroed such that uuid is 0 here?

It appears in my usage, but I don't know for sure. 
CC'ing Steve to tell me if the TP_PROTO macro initializes the
__field_struct to zero.

Left in the snippets below that shows its definition...

> 
> > +			entry_hpa = ULLONG_MAX;				\
> > +		}							\
> > +	} while (0)

snip


> >  TRACE_EVENT(cxl_general_media,
> >  
> >  	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
> > @@ -330,10 +349,13 @@ TRACE_EVENT(cxl_general_media,
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
> > +		__string(region_name, to_region_name(cxlmd, to_gm_dpa(record)))
> >  	),
> >  
> >  	TP_fast_assign(
> > @@ -354,18 +376,23 @@ TRACE_EVENT(cxl_general_media,
> >  		memcpy(__entry->comp_id, &rec->component_id,
> >  			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
> >  		__entry->validity_flags = get_unaligned_le16(&rec->validity_flags);
> > +		__assign_str(region_name, to_region_name(cxlmd, to_gm_dpa(record)));
> > +		store_region_info(cxlmd, to_gm_dpa(record),
> > +				  __entry->region_uuid, __entry->hpa);
> >  	),
> >  
> >  	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' " \
> >  		"descriptor='%s' type='%s' transaction_type='%s' channel=%u rank=%u " \
> > -		"device=%x comp_id=%s validity_flags='%s'",
> > +		"device=%x comp_id=%s validity_flags='%s' " \
> > +		"hpa=%llx region=%s region_uuid=%pUb",
> >  		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
> >  		show_event_desc_flags(__entry->descriptor),
> >  		show_mem_event_type(__entry->type),
> >  		show_trans_type(__entry->transaction_type),
> >  		__entry->channel, __entry->rank, __entry->device,
> >  		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
> > -		show_valid_flags(__entry->validity_flags)
> > +		show_valid_flags(__entry->validity_flags),
> > +		__entry->hpa, __get_str(region_name), &__entry->region_uuid
> >  	)
> >  );
> >  
