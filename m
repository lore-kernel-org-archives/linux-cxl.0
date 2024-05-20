Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB541F945;
	Mon, 20 May 2024 19:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234138; cv=none; b=XyuiDWo72O56PszwmPuFqSDLZodYjkwxNzSnGDrZRhGNnc/naRLAiCHYzGtQabnbGx+/GoBDgDzCFZpC4V5Mxrji4oqTyYobYh6XkTWerhcPE2tfIMN42aLN7de4M5fncCuv42jrARpXwNTrItiP1mCeS/F+vZcNpvf5BAdflLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234138; c=relaxed/simple;
	bh=TC5YGn3w3/yr6FzaVfTxCUg2L4p7HcRQyWWJNr6TxLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQaPqLibCX/SZku58ej44/9bu2a/dF3BxolSzfLgsIJzoVDU25ZFqJce7aByu/cO8HouxPxRWr8mYJd2ADVn2jnJxwBNOloNLiUqEHrFHRYr1f49uUu/1nFAqLvzXYe5nIpQgoX5QEBo6wdiPQ/WsmVdClc5265vxmXE+cDWLGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRWA5uQO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRWA5uQO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716234136; x=1747770136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TC5YGn3w3/yr6FzaVfTxCUg2L4p7HcRQyWWJNr6TxLw=;
  b=HRWA5uQOtwYXdC7crIJ9L9MZZoojy+BtPeUHNhPqbTxtPv9OFKKnj23U
   TS/NtZ3jSLW5MKlT8FgFyK67LJ56KBZfR9HkZTKHdRI+k1fi4vdw40+8h
   qbYtzF7Oal8FR598up4prYq11f4dt7iTl7p3KVMbkW6fv6FupDnE46SdY
   4qpDxUUpkh2CgbDl54wygitu78zr5qnB8bb9mVAvMKIR4sTXVZ38g5nex
   IeCHAPRzV6WP8e1KsX5qoYl9zRNJ3QbY6kp9RIQnumbBj8YLGlisMBkn/
   MQYp8ReGck2dhV8BqXP0QgxjaF4jhtH888XlPRZkXCnVUlrK78iDCFrmS
   g==;
X-CSE-ConnectionGUID: eRQVHExySMqckBT1aK++iQ==
X-CSE-MsgGUID: +/XrUf5MRi2MPBICT6csiw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="34904044"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="34904044"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 12:42:15 -0700
X-CSE-ConnectionGUID: VJN3Ja6FS4CQZEk6Pkjwyw==
X-CSE-MsgGUID: 3bmG9zIhQo+9cSrOrLUu5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="37598254"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.51.95])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 12:42:15 -0700
Date: Mon, 20 May 2024 12:42:13 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cxl/events: Use a common struct for DRAM and General
 Media events
Message-ID: <Zkunlbv2qIOaLaq3@aschofie-mobl2>
References: <20240518113317.3683718-1-fabio.m.de.francesco@linux.intel.com>
 <4446774.UPlyArG6xL@fdefranc-mobl3>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4446774.UPlyArG6xL@fdefranc-mobl3>

On Mon, May 20, 2024 at 07:55:17PM +0200, Fabio M. De Francesco wrote:
> On Saturday, May 18, 2024 1:26:21 PM GMT+2 Fabio M. De Francesco wrote:
> > cxl_event_common was an unfortunate naming choice and caused confusion with
> > the existing Common Event Record. Furthermore, its fields didn't map all
> > the common information between DRAM and General Media Events.
> > 
> > Remove cxl_event_common and introduce cxl_event_media_hdr to record common
> > information between DRAM and General Media events.
> > 
> > cxl_event_media_hdr, which is embedded in both cxl_event_gen_media and
> > cxl_event_dram, leverages the commonalities between the two events to
> > simplify their respective handling.
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> > ---
> > 
> > [...]
> > -
> >  union cxl_event {
> >  	struct cxl_event_generic generic;
> >  	struct cxl_event_gen_media gen_media;
> >  	struct cxl_event_dram dram;
> >  	struct cxl_event_mem_module mem_module;
> > -	struct cxl_event_common common;
> > +	struct cxl_event_media_hdr media_hdr;
> >  } __packed;
> 
> Today I was thinking about a comment from Ira. He didn't like the addition of 
> an event that is not in the specs.[0] (Notice that the other issues have been 
> already addressed). 
> 
> I dislike the addition of an artificial event for the very same reasons Ira 
> expressed.

Agree it should not appear like an artifical event. It should appear
as a special member of the union. A union's purpose is to allow access
like this. Perhaps it's a naming thing.

How about s/cxl_event_media_hdr/cxl_media_hdr and add a comment:

-	struct cxl_event_common common;
+	struct cxl_media_hdr media_hdr; /* dram & gen_media event header */

> 
> This additional event could be easily removed by something simple like the 
> following diff.

Some typos below and also you'll need to look at the larger chunk of
code and reconsider the if/else flow. Perhaps revert to an earlier
version of the event patchset.

-- Alison

> 
> Fabio
> 
> [0] https://lore.kernel.org/linux-cxl/66467b8b47170_8c79294b3@iweiny-mobl.notmuch/
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index a08f050cc1ca..05de8836adea 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -875,7 +875,13 @@ void cxl_event_trace_record(const struct cxl_memdev 
> *cxlmd,
>                 guard(rwsem_read)(&cxl_region_rwsem);
>                 guard(rwsem_read)(&cxl_dpa_rwsem);
>  
> -               dpa = le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_MASK;
> +               if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
> +                       dpa = le64_to_cpu(evt->gen_media.media_hdr.phys_addr)
> +                             & CXL_DPA_MASK;
> +               else if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
> +                       dpa = le64_to_cpu(evt->dram.media_hdr.phys_addr)
> +                             & CXL_DPA_MASK;
> +
>                 cxlr = cxl_dpa_to_region(cxlmd, dpa);
>                 if (cxlr)
>                         hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 6562663a036d..f0a5be131e6a 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -97,7 +97,6 @@ union cxl_event {
>         struct cxl_event_gen_media gen_media;
>         struct cxl_event_dram dram;
>         struct cxl_event_mem_module mem_module;
> -       struct cxl_event_media_hdr media_hdr;
>  } __packed;
>  
>  /*
> 
> 
> 
