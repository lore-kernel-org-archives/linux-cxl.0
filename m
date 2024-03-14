Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44D47604E
	for <linux-cxl@vger.kernel.org>; Thu, 14 Mar 2024 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710450305; cv=none; b=H7hPbHSqsFxBhNswR3OIerm8etIYgehIwYt1dTlsvy9bcDuTImLPjsPJHOwiXx6RrY+RkihqLcdKhnU4pfe7giPubia+G/ASsf6WcDzAbNwu3T70oSEkMwzHoQ0WArsFnsU0xnoux0oJ+ZnOep3UNalVDF7NUtOd9+cFd/Q7Xog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710450305; c=relaxed/simple;
	bh=3Dqu9pYrzHo8Fgvo8SwSlverzWibX5G50ZP53g8Q8z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ct/Nsg3hfiFgbkHSoKWH5IySqlUqtt4rS9jjNSa/hrhDUnDP2dRbJcFQKzxyMXXE0vMTQHh5w/qnuf7eobfsJLrbf4CxNAT8UwljUminu2VJOwYfHypg6pAYkM5Dhv056G3HDIR7s6EL1g59VxAUNm1hKOeS4dcK4VRfrQWEgvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5tjF2kZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5tjF2kZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710450304; x=1741986304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3Dqu9pYrzHo8Fgvo8SwSlverzWibX5G50ZP53g8Q8z0=;
  b=l5tjF2kZv6k5hk8gkcLHaMyo8RpvAy5W5p06b3j4hH/rddFM5aGEw6KC
   5I0nwkMaStCq5myfizPem78uLL417hJlTpndO25+gyu9qyQGaDu2cvbNl
   XIjZnuQfIgIM0UQ4o6bdtSNtmilDifmiOF6ie2O/45FthKc2CdhYZVqlA
   KbBQOOnTafajS6/DIszpa183h1TZKGsRwuya7tiRzOiA88s2QXwN4eyGi
   F0BnonQywBLm6Qrx2oAz6knCAKrhjqaLAQwHCB5MCfF/3VqsWCrcqiOw/
   UG4afqGBTqg4TqrGRlgmKgKKKF7vrb9f44TYOJwUx2ySuuQzLWfNaTZK8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5235657"
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="5235657"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 14:05:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="43453198"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.72.214])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 14:05:02 -0700
Date: Thu, 14 Mar 2024 14:05:00 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/trace: Properly initialize cxl_poison region name
Message-ID: <ZfNmfCmgCs4Nc+EH@aschofie-mobl2>
References: <20240314201217.2112644-1-alison.schofield@intel.com>
 <20240314164136.6d10aa28@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240314164136.6d10aa28@gandalf.local.home>

On Thu, Mar 14, 2024 at 04:41:36PM -0400, Steven Rostedt wrote:
> On Thu, 14 Mar 2024 13:12:17 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > The TP_STRUCT__entry that gets assigned the region name, or an
> > empty string if no region is present, is erroneously initialized
> > to the cxl_region pointer. It needs to be properly initialized
> > otherwise it's length is wrong and garbage chars can appear in
> > the kernel trace output: /sys/kernel/tracing/trace
> > 
> > The bad initialization was due in part to a naming conflict with
> > the parameter: struct cxl_region *region. The field 'region' is
> > already exposed externally as the region name, so changing that
> > to something logical, like 'region_name' is not an option. Instead
> > rename the internal only struct cxl_region to the commonly used
> > 'cxlr'.
> > 
> > Impact is that tooling depending on that trace data can miss
> > picking up a valid event when searching by region name. The
> > TP_printk() output, if enabled, does emit the correct region
> > names in the dmesg log.
> > 
> > This was found during testing of the cxl-list option to report
> > media-errors for a region.
> > 
> > Fixes: ddf49d57b841 ("cxl/trace: Add TRACE support for CXL media-error records")
> 
> Probably should add Cc: stable, as passing in region as a string was a real
> bug.
> 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> > 
> > Changes in v2:
> > - Initialize the region name with an assignment (Steve)
> > - Rename struct cxl_region 'cxlr' instead of overusing 'region' identifier
> > - Update commit message & log
> > 
> > 
> >  drivers/cxl/core/trace.h | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index bdf117a33744..e5f13260fc52 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -646,18 +646,18 @@ u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *memdev, u64 dpa);
> >  
> >  TRACE_EVENT(cxl_poison,
> >  
> > -	TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *region,
> > +	TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *cxlr,
> >  		 const struct cxl_poison_record *record, u8 flags,
> >  		 __le64 overflow_ts, enum cxl_poison_trace_type trace_type),
> >  
> > -	TP_ARGS(cxlmd, region, record, flags, overflow_ts, trace_type),
> > +	TP_ARGS(cxlmd, cxlr, record, flags, overflow_ts, trace_type),
> >  
> >  	TP_STRUCT__entry(
> >  		__string(memdev, dev_name(&cxlmd->dev))
> >  		__string(host, dev_name(cxlmd->dev.parent))
> >  		__field(u64, serial)
> >  		__field(u8, trace_type)
> > -		__string(region, region)
> > +		__string(region, cxlr ? dev_name(&cxlr->dev) : "")
> 
> I'm still curious to why NULL didn't work. I guess it may never have as I
> noticed there's nothing else doing that. There are cases that a variable
> returns NULL and the __string() handles it. But I guess the compiler gets
> confused if the NULL is a possible return to the condition in __string().

Here's the full warning spew:

In file included from ./include/trace/define_trace.h:102,
                 from drivers/cxl/core/trace.h:713,
                 from drivers/cxl/core/trace.c:8:
drivers/cxl/core/./trace.h: In function ‘trace_event_get_offsets_cxl_poison’:
./include/trace/stages/stage5_get_offsets.h:50:21: warning: argument 1 null where non-null expected [-Wnonnull]
   50 |                     strlen((src) ? (const char *)(src) : "(null)") + 1)
      |                     ^~~~~~
./include/trace/trace_events.h:263:9: note: in definition of macro ‘DECLARE_EVENT_CLASS’
  263 |         tstruct;                                                        \
      |         ^~~~~~~
./include/trace/trace_events.h:43:30: note: in expansion of macro ‘PARAMS’
   43 |                              PARAMS(tstruct),                  \
      |                              ^~~~~~
drivers/cxl/core/./trace.h:647:1: note: in expansion of macro ‘TRACE_EVENT’
  647 | TRACE_EVENT(cxl_poison,
      | ^~~~~~~~~~~
drivers/cxl/core/./trace.h:655:9: note: in expansion of macro ‘TP_STRUCT__entry’
  655 |         TP_STRUCT__entry(
      |         ^~~~~~~~~~~~~~~~
./include/trace/stages/stage5_get_offsets.h:49:29: note: in expansion of macro ‘__dynamic_array’
   49 | #define __string(item, src) __dynamic_array(char, item,                 \
      |                             ^~~~~~~~~~~~~~~
drivers/cxl/core/./trace.h:660:17: note: in expansion of macro ‘__string’
  660 |                 __string(region, cxlr ? dev_name(&cxlr->dev) : NULL)
      |                 ^~~~~~~~
In file included from ./include/linux/uuid.h:11,
                 from ./include/linux/libnvdimm.h:12,
                 from ./drivers/cxl/cxl.h:7,
                 from drivers/cxl/core/trace.c:4:
./include/linux/string.h:126:24: note: in a call to function ‘strlen’ declared ‘nonnull’
  126 | extern __kernel_size_t strlen(const char *);
      |                        ^~~~~~


> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve
> 
> 
> 
> >  		__field(u64, overflow_ts)
> >  		__field(u64, hpa)
> >  		__field(u64, dpa)
> > @@ -677,10 +677,10 @@ TRACE_EVENT(cxl_poison,
> >  		__entry->source = cxl_poison_record_source(record);
> >  		__entry->trace_type = trace_type;
> >  		__entry->flags = flags;
> > -		if (region) {
> > -			__assign_str(region, dev_name(&region->dev));
> > -			memcpy(__entry->uuid, &region->params.uuid, 16);
> > -			__entry->hpa = cxl_trace_hpa(region, cxlmd,
> > +		if (cxlr) {
> > +			__assign_str(region, dev_name(&cxlr->dev));
> > +			memcpy(__entry->uuid, &cxlr->params.uuid, 16);
> > +			__entry->hpa = cxl_trace_hpa(cxlr, cxlmd,
> >  						     __entry->dpa);
> >  		} else {
> >  			__assign_str(region, "");
> > 
> > base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
> 
> 
