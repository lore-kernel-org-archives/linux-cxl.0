Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35EE18E20
	for <linux-cxl@vger.kernel.org>; Thu, 14 Mar 2024 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435859; cv=none; b=Iwu4yDBRWmgFALqdk6RGEThUdl1kK3b43jlpwbTe4nYn3sjYPX/FqYnOKjQ0IckTJEP7hUZFVtSNezCD/++dP2K5UzmVUJLcfNbVw3/97rd6ZIVNe0zNPnKqd6wHJ4fzpw5p1VfanSUqCxH9I3UoRZ7Gv0yXqCfEBfshv6VJjdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435859; c=relaxed/simple;
	bh=+McQi+zAl7nLWnHepH5SwQrGinXr7aIF0glK4bcwl4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMEJ7oC2DCgyksij/2RytCLeDVs7vdh46C6skMcwilhyfnvjZ4oP+5J1meJYxaNOtwevJjevu77E/DbVlc0hrbbjsIwRIrVfR6tGZwvhV9STf3oEOzM9zW2LX+CXub/m7Ljs6KUaUNqWuREO7IaXyeVdv90k2HmXhIf9116IAA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hoSXZgdg; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hoSXZgdg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710435857; x=1741971857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+McQi+zAl7nLWnHepH5SwQrGinXr7aIF0glK4bcwl4I=;
  b=hoSXZgdgthBqE43boquSdkfHsob4qX5cT0wRHFPdEPfWinQJZIacv7ll
   vKhUzu/ka9ufbfUMiRTBa+uOJS79k53DeZZMzSkLV/8sm75fxYpBXzNg8
   aU9BFejNiUjz4cFdnHETmU2zcBf11fid/6a6DNt0gr0UFwJ49gJFrKRKg
   MFN3UiZwGhb9ZwNh0ZS7j2qc8jCTgtyoirYrvCCKS5fQTAB4QdAvMQv9h
   ELBo+kc4QL+grtcRoW5ld63tn5GdwYpHqPktSPYEVpdOv4uHxd9WaQKRW
   I/bMglIgUv6fvHc3dXxSqnt94cnI7w6mQ1l0WZZ8raA7RKIZ1JctygPTE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5139610"
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="5139610"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 10:04:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="43273063"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.72.214])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 10:04:15 -0700
Date: Thu, 14 Mar 2024 10:04:14 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, rostedt@goodmis.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/trace: Initialize cxl_poison region name to NULL
Message-ID: <ZfMuDlDbVHtlAL8z@aschofie-mobl2>
References: <20240314044301.2108650-1-alison.schofield@intel.com>
 <65f3016b8b0d9_1fe3d329441@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65f3016b8b0d9_1fe3d329441@iweiny-mobl.notmuch>

On Thu, Mar 14, 2024 at 06:53:47AM -0700, Ira Weiny wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > The TP_STRUCT__entry that gets assigned the region name, or an
> > empty string if no region is present, is erroneously initialized
> > to the cxl_region pointer. It needs to be initialized to NULL
> > otherwise its length is wrong and garbage chars can appear in
> > the kernel trace output: /sys/kernel/tracing/trace
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
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/trace.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index bdf117a33744..bc5ca4d530d1 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -657,7 +657,7 @@ TRACE_EVENT(cxl_poison,
> >  		__string(host, dev_name(cxlmd->dev.parent))
> >  		__field(u64, serial)
> >  		__field(u8, trace_type)
> > -		__string(region, region)
> > +		__string(region, NULL)
> 
> Couldn't this be "" instead of NULL then remove the __assign_str() if
> region is NULL?
> 
> Ira

Thanks for the review Ira.

That doesn't work because it inits with too short of a length and the
region names all get truncated.

Adding Steve to this thread. He has upcoming changes to this space, but
I also should note that I think this fix may want to be applied
backwards, ie to stable, so we cannot count on Steves upcoming changes.

> 
> >  		__field(u64, overflow_ts)
> >  		__field(u64, hpa)
> >  		__field(u64, dpa)
> > 
> > base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
> > -- 
> > 2.37.3
> > 
> 
> k
