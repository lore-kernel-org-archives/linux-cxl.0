Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0FC74E0C
	for <linux-cxl@vger.kernel.org>; Thu, 14 Mar 2024 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710446887; cv=none; b=Ng0VqXjbAD1tzQpmIysT6+F3LiEz3ka/eKRANePMQ0bwSYVgkCduBoJgYtFhf4xaBqYevyERd3+FRslVFqpWPjNH8qE46yj5muAzN4mhAB5chkta6j2RltuG7p9avQtoLFENFvgPUKCnskb9qgza43mV4akmvvYwckQrH59Lh30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710446887; c=relaxed/simple;
	bh=g6bpnktv63c8uNT+DNX2GSV8Qcdg3ahHtrx6Nn3Gt54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Im3h+cgujEb3/N32xCswPw6i2gh/RUZQEceYhfUINUZdJ/yL8AwtpnWMjIahW2Jsll2q53eqj2eg/Yorh8x0rBOvOTesJHbGTyl2dbbtlmlGEw+WQvjy3Mj2ZoU5Bd0d+6P8bEQIIAREny1ej/rnWKuRNxiUlPrTjDpt1SrZRTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUBTXAN6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUBTXAN6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710446886; x=1741982886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g6bpnktv63c8uNT+DNX2GSV8Qcdg3ahHtrx6Nn3Gt54=;
  b=kUBTXAN6dmPqFSBfmEzAsOGruRDEWi5u1bC3Q9MV1CZ5le3w9y9TZItf
   OKxcw9X/anp8bNAwsoGo6wSR/wDQ4Uhx1GhVSiAYlzRb/jqsr/OCZlTFg
   v7ZT98gKvBi5Dq0F+CMhWWdHmU4SV1/lfSdinx8N/UJspg6F6FDYnCjFN
   wdGu9dDT4rBDqZLOipvqxfwcKiTIGHMGbNYCiBEwSwMgZ0HGCKUJRKZtO
   sL5nqWaXvBWAwzGs7x1s3HCXqZqYiFFJkjAsq1tqZtm/VepyhcfT6MlIj
   XcWpzE+dGogwbkaviUO79C9k4qIrK3l3usOuzfi2WVNpPaNIPUaQiHpVD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="22810358"
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="22810358"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 13:08:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="17007748"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.72.214])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 13:08:04 -0700
Date: Thu, 14 Mar 2024 13:08:02 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/trace: Initialize cxl_poison region name to NULL
Message-ID: <ZfNZIlWumlLyWcjE@aschofie-mobl2>
References: <20240314044301.2108650-1-alison.schofield@intel.com>
 <65f3016b8b0d9_1fe3d329441@iweiny-mobl.notmuch>
 <ZfMuDlDbVHtlAL8z@aschofie-mobl2>
 <20240314144405.2ae1d16a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314144405.2ae1d16a@gandalf.local.home>

On Thu, Mar 14, 2024 at 02:44:05PM -0400, Steven Rostedt wrote:
> On Thu, 14 Mar 2024 10:04:14 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > On Thu, Mar 14, 2024 at 06:53:47AM -0700, Ira Weiny wrote:
> > > alison.schofield@ wrote:  
> > > > From: Alison Schofield <alison.schofield@intel.com>
> > > > 
> > > > The TP_STRUCT__entry that gets assigned the region name, or an
> > > > empty string if no region is present, is erroneously initialized
> > > > to the cxl_region pointer. It needs to be initialized to NULL
> > > > otherwise its length is wrong and garbage chars can appear in
> > > > the kernel trace output: /sys/kernel/tracing/trace
> > > > 
> > > > Impact is that tooling depending on that trace data can miss
> > > > picking up a valid event when searching by region name. The
> > > > TP_printk() output, if enabled, does emit the correct region
> > > > names in the dmesg log.
> > > > 
> > > > This was found during testing of the cxl-list option to report
> > > > media-errors for a region.
> > > > 
> > > > Fixes: ddf49d57b841 ("cxl/trace: Add TRACE support for CXL media-error records")
> > > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > > ---
> > > >  drivers/cxl/core/trace.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > > > index bdf117a33744..bc5ca4d530d1 100644
> > > > --- a/drivers/cxl/core/trace.h
> > > > +++ b/drivers/cxl/core/trace.h
> > > > @@ -657,7 +657,7 @@ TRACE_EVENT(cxl_poison,
> > > >  		__string(host, dev_name(cxlmd->dev.parent))
> > > >  		__field(u64, serial)
> > > >  		__field(u8, trace_type)
> > > > -		__string(region, region)
> > > > +		__string(region, NULL)  
> > > 
> > > Couldn't this be "" instead of NULL then remove the __assign_str() if
> > > region is NULL?
> 
> That will not work either.
> 
> 	__string() allocates the space on the ring buffer.
> 
> Getting rid of __assign_str() still leaves the buffer allocated with garbage.
> 
> As I said in the other email thread [1], __string() and __assign_str() are
> tightly coupled and are the equivalent of:
> 
>   #define __string(buf, str)		len = strlen(str); buf = malloc(len)
>   #define __assign_str(buf, str)	strcpy(buf, str)
> 
> I also mentioned that __string() does much more. It can handle NULL
> pointers, so it's more like:
> 
>   #define __string(buf, str)     len = str ? strlen(str) : strlen("null"); buf = malloc(len)
>   #define __assign_str(buf, str)  if (str) strcpy(buf, str); else strcpy(buf, "null")
> 
> So if the string is NULL, then you want to copy it. That said, looking at
> this trace-event, it's still broken, because region isn't a string, so you
> are basically doing:
> 
> 	len = strlen(region);
> 

Thanks Steve - 

> Which doesn't make sense. What you want is:
> 
> 	__string(region, region ? dev_name(&region->dev) : NULL)

Compiler didn't like that NULL. 
 warning: argument 1 null where non-null expected [-Wnonnull]
   50 |                     strlen((src) ? (const char *)(src) : "(null)") + 1)

Compiler was fine with, and it works with ""

> 
> and then you can add the __assign_str(region, NULL) to the else path.
The compiler was fine w NULL here but gave me garbage in the output when
region was NULL. "" worked.

I'm posting a v2 that functions. Please take another look.


- Alison

> 
> -- Steve
> 
> 
> [1] https://lore.kernel.org/all/20240314143406.6289a060@gandalf.local.home/
> 
