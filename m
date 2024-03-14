Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F3E73161
	for <linux-cxl@vger.kernel.org>; Thu, 14 Mar 2024 18:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441716; cv=none; b=h12VUXwI0i9l3oJ4NOaveWQM7ztcqNwJtLP4ce9fUGB7uKBp9SQsG229fFfDht9GnMwXppcaW+w7FKa3C6uPh+IoGXpoztGdjHFlfmrHDRyGEB1xVzoN7fSL/ZVhRiE9YvimHxFfMqD/+oBylaLJEDO9NYtHjkyRXC6ZT6HWgKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441716; c=relaxed/simple;
	bh=ShVPBylVEN2Tbf2eivoz5wVoudsJkfJrlUOdUv1I05E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGcvfVgmLJWLpmxWWSnvsJd6iP5QjvLECtQrMAvRAGjODwkbyJvHfrS9vmanyz57FEZHlPMsyIkKrgT2I3+iGwpYnW3tZbmbDQeUGaG7b3rfyWz6oJQE7ER6D2xyAL4FKRmcBYKvpZhJ6FjnntcCEAPsXL2iSIQNBopRoBsjodA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2E0C433F1;
	Thu, 14 Mar 2024 18:41:54 +0000 (UTC)
Date: Thu, 14 Mar 2024 14:44:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
 <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/trace: Initialize cxl_poison region name to NULL
Message-ID: <20240314144405.2ae1d16a@gandalf.local.home>
In-Reply-To: <ZfMuDlDbVHtlAL8z@aschofie-mobl2>
References: <20240314044301.2108650-1-alison.schofield@intel.com>
	<65f3016b8b0d9_1fe3d329441@iweiny-mobl.notmuch>
	<ZfMuDlDbVHtlAL8z@aschofie-mobl2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 10:04:14 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Thu, Mar 14, 2024 at 06:53:47AM -0700, Ira Weiny wrote:
> > alison.schofield@ wrote:  
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > The TP_STRUCT__entry that gets assigned the region name, or an
> > > empty string if no region is present, is erroneously initialized
> > > to the cxl_region pointer. It needs to be initialized to NULL
> > > otherwise its length is wrong and garbage chars can appear in
> > > the kernel trace output: /sys/kernel/tracing/trace
> > > 
> > > Impact is that tooling depending on that trace data can miss
> > > picking up a valid event when searching by region name. The
> > > TP_printk() output, if enabled, does emit the correct region
> > > names in the dmesg log.
> > > 
> > > This was found during testing of the cxl-list option to report
> > > media-errors for a region.
> > > 
> > > Fixes: ddf49d57b841 ("cxl/trace: Add TRACE support for CXL media-error records")
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > >  drivers/cxl/core/trace.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > > index bdf117a33744..bc5ca4d530d1 100644
> > > --- a/drivers/cxl/core/trace.h
> > > +++ b/drivers/cxl/core/trace.h
> > > @@ -657,7 +657,7 @@ TRACE_EVENT(cxl_poison,
> > >  		__string(host, dev_name(cxlmd->dev.parent))
> > >  		__field(u64, serial)
> > >  		__field(u8, trace_type)
> > > -		__string(region, region)
> > > +		__string(region, NULL)  
> > 
> > Couldn't this be "" instead of NULL then remove the __assign_str() if
> > region is NULL?

That will not work either.

	__string() allocates the space on the ring buffer.

Getting rid of __assign_str() still leaves the buffer allocated with garbage.

As I said in the other email thread [1], __string() and __assign_str() are
tightly coupled and are the equivalent of:

  #define __string(buf, str)		len = strlen(str); buf = malloc(len)
  #define __assign_str(buf, str)	strcpy(buf, str)

I also mentioned that __string() does much more. It can handle NULL
pointers, so it's more like:

  #define __string(buf, str)     len = str ? strlen(str) : strlen("null"); buf = malloc(len)
  #define __assign_str(buf, str)  if (str) strcpy(buf, str); else strcpy(buf, "null")

So if the string is NULL, then you want to copy it. That said, looking at
this trace-event, it's still broken, because region isn't a string, so you
are basically doing:

	len = strlen(region);

Which doesn't make sense. What you want is:

	__string(region, region ? dev_name(&region->dev) : NULL)

and then you can add the __assign_str(region, NULL) to the else path.

-- Steve


[1] https://lore.kernel.org/all/20240314143406.6289a060@gandalf.local.home/

