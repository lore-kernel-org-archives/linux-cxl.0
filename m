Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9388E270EC1
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768258584; cv=none; b=hke/9otdRj/1+MfV/QDTiSWSuU/dosidDBQC0OQmrDW5GGc6jLSncmN0451+uLWwzpXsgLfir/onu7FuIbR6V5OblTTtdYoLDUAe5mc2//ul/J0m+t2BReSCKZeAD/qmTU9POkSYhxGkMlBQ5VQ8qyMHkyUR6BVSTboZtCdQKBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768258584; c=relaxed/simple;
	bh=ejCplHzC+Tu2w3PsevSnIjD8tqUKuLqW+qh97NVsHB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2GUZEGa+TPfDCzUDFszj7A+uJG7eOfz/Y9WvD8HMYm19TkZpCJK7nFeOt6nFUR7q4IW0SwyqmqAtlzFS8k4+QdVt+YPM7HIdzlb3zL021tVHj1oNLKcUYk0HCIPWaq/8YkocDRMSrBUfgAgCBLTAYmb3luHQkA6JaLnGdd1g0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=a1X6wWsX; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="a1X6wWsX"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b21fc25ae1so755426485a.1
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 14:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768258581; x=1768863381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EI2wzbmRYxHUYAt7IwCanPsfLjl0x0cz9M/LLZ/wyRc=;
        b=a1X6wWsXfc1QoDeL3uyt5y8pCEz6wC2VEsT/mPPqlRMG8Um9ZtQpU1WUJr1FWJpcWN
         aSruaby7NTKFO9kWrFHdRGMTNE6AS0C1aKn/KQgeOuB/MIew6/bdpkM0fJg3CdDI1n7g
         AtMCoqOXyRUp4cWCAZV3b1/Pxka84Wc6hlz1EyP0P/dhEv/2HasuUCtcUjjefOSvs0hf
         3UTDAfm/OCaaAF4x3HX/eOdA2/Ck7JRYC/ncwEdTFvaX9D1mjdeTzT3XfS8yKG9ogGmQ
         6DwQfapSjNgxh5s3yaAboclIrLgcBzhpfahV0qF8eeFuWjT6ROEaOEqQc/x7+Cx2msJn
         zfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768258581; x=1768863381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EI2wzbmRYxHUYAt7IwCanPsfLjl0x0cz9M/LLZ/wyRc=;
        b=EcBRB7tp5OeBxusz0xBNOsK3ko59jBXY35VPcaLCmEndXr/xQwlmCqXMb2vPrHFKvh
         nKV8i9gdYjDlU9N0mnMFoFSPIg/EsHkw+u+NrIYHESRfRe1We3cA/euvqO+3yTPCMHi0
         XVhrTSiCmVJGb3EqgMZI7n7M06ldotC9HII1RdvZ7ORFZr92QS2xXUoH+qK4jqn23dnu
         1+KSRisq4N+d/EdCXCUbvj0wr7lPCTQkfk6HZH9GlUxmOZJW2SC/Rtkqk8gj9KfZk6s9
         9gItN+1I75BfPjl/71BmpB+UJBxJ6nh1zykT18ZVj54jU9hZbQtfTxfVz+3g/Hh3s7Lm
         6ozw==
X-Gm-Message-State: AOJu0Yz+KZhz//NyxZIrjmm+MpMNWzTgM6kmmMf13ItzuiHGfxmfpkMP
	crGjQ37MH9gv/raxxiv3qEminzFqb2BfTP2hMzzqnN+Co0nNf0h07sz8VFsF0/fJC7k=
X-Gm-Gg: AY/fxX5stRxAtaercVTrFQ21m9t+nuHehpIjM9x03oczwx2QCJqjLXZHWXNYjuNR8ov
	nf4YIPZU/tkc/Ppt4WY85V8IGWZNWHi9N/nqiAf2h9QD2rVR4vEq2VQvMUw3msrsai+NsP6w2CU
	bddt7OY8qodFDcOOofeDeeyTsJ8mBFCb2qqCiJ9Ac6vPfXcyySc/rM0a+epF6yg1DoT1g2s93gb
	ImN4HLr8TOOIgK4BZGNt0nr6gpBbOFYinDsKsLlkuqmJVWcSuv4pQnvOKNzCOzXmwhfDUq0AG1b
	zCZj2fspLtkKVyf5mg0zUiMZ+HDaqYPd4KHd+I1LZJfOn6tPThd5jd9029oOzj3EHrlZdOatW+c
	+Cv42UptYUsDmVrcBKxIx0mlefK7N88pWh7PDSWCe6WePnIY0FYwpnQClhdHSpSO+6mvlfxlhoe
	wf1NUtjLg+pO2jxH4TCXw09FrVP5L0aM/dwCIhMVb0WsrRbGo09BQD+vCzhYExqBR7oMFJ6g==
X-Google-Smtp-Source: AGHT+IFv3Sn0EsUlnOalQIMkDKqklRX1J7jw1KxbNLDLTvSkqm6TMh8FGq2VJ+f3/jQ5s5cnkQpChQ==
X-Received: by 2002:a05:620a:4626:b0:8bb:7dd8:1922 with SMTP id af79cd13be357-8c38939d234mr2764850085a.40.1768258581518;
        Mon, 12 Jan 2026 14:56:21 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f532bc3sm1599675485a.45.2026.01.12.14.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 14:56:20 -0800 (PST)
Date: Mon, 12 Jan 2026 17:55:47 -0500
From: Gregory Price <gourry@gourry.net>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH 2/6] cxl: add sysram_region memory controller
Message-ID: <aWV78x2NZd0-iNSv@gourry-fedora-PF4VCD3F>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-3-gourry@gourry.net>
 <0233bdab-9b59-4394-9ce4-c3a5df2be06d@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0233bdab-9b59-4394-9ce4-c3a5df2be06d@amd.com>

On Mon, Jan 12, 2026 at 03:10:41PM -0600, Cheatham, Benjamin wrote:
> On 1/12/2026 10:35 AM, Gregory Price wrote:
> > Add a sysram memctrl that directly hotplugs memory without needing to
> > route through DAX.  This simplifies the sysram usecase considerably.
> > 
> > The sysram memctl adds new sysfs controls when registered:
> > 	region/memctrl/[hotplug, hotunplug, state]
> > 
> > hotplug:   controller attempts to hotplug the memory region
> > hotunplug: controller attempts to offline and hotunplug the memory region
> 
> Nit: Would it be better to use hotadd/hotremove here instead of hotplug/hotunplug? The terms
> are basically synonymous, but I think hotadd and hotremove are more descriptive.

I will defer to David on this.  I think keeping the terminology
consistent is better, but also hotplug is overloaded between physical
and logical.  It ultimately means the same thing to be honest.

> > state:     [online,online_normal,offline]
> >    online       : controller onlines blocks in ZONE_MOVABLE
> >    online_normal: controller onlines blocks in ZONE_NORMAL
> 
> The naming for online states could be improved imo. I understand and agree with the motivation
> behind the names, but I could see the use of the word "normal" being confusing to less savvy users.
> You could change it to include the zone for both (online_movable/online_normal), but I think it may
> be easier to mark which one has drawbacks, i.e. change "online_normal" to something like "online_nonremovable".
> That way, anyone who doesn't want to go find the documentation for these can understand the user-visible
> impact.
> 
> In any case, all of these attributes need ABI documentation as well.
> 

This is what i was getting at originally, I will consider the other
feedback and spin a v2 with this simplified a bit.

I'm leaning towards agreeing with Dan and David that probably we just
keep online/online_movable since it's consistent with base/memory.c, but
we can continue to have this argument.

I don't think we can reasonable get away from users of this interface
understanding the implications of ZONEs, since whatever they choose to
do dictates what zone the memory gets added to.

> > +static DEFINE_MUTEX(cxl_memory_type_lock);
> > +static LIST_HEAD(cxl_memory_types);
> > +
> > +static struct cxl_region *to_cxl_region(struct device *dev)
> > +{
> > +	if (dev->type != &cxl_region_type)
> > +		return NULL;
> > +	return container_of(dev, struct cxl_region, dev);
> > +}
> 
> What's the reasoning behind redefining this in this file? It's still defined in cxl/core/region.c,
> so I would probably just drop the static there and include it through core.h.
> 

Just cruft from rapidly moving stuff around.  Will fixup.

> > +	rc = cxl_sysram_range(cxlr, &range);
> > +	if (rc) {
> > +		dev_info(dev, "range %#llx-%#llx too small after alignment\n",
> > +			 range.start, range.end);
> 
> This should probably be a warning instead. You do it for the next check which is essentially the same
> case, so may as well do it here.

ack.

> > +	if (!total_len) {
> > +		dev_warn(dev, "rejecting CXL region without any memory after alignment\n");
> > +		return -EINVAL;
> > +	}
> 
> I don't think this check is needed. cxl_sysram_range() checks if the range->start == range->end (i.e. size == 0)
> and errors out. That should cause the above check to error out before this.

ack

> > +	/*
> > +	 * Setup flags for System RAM. Leave _BUSY clear so add_memory() can add
> > +	 * a child resource. Do not inherit flags from parent since it may set
> > +	 * flags unknown to us that will the break add_memory() below.
> > +	 */
> > +	res->flags = IORESOURCE_SYSTEM_RAM;
> > +	mhp_flags = MHP_NID_IS_MGID;
> > +	rc = add_memory_driver_managed(data->mgid, range.start,
> > +				       range_len(&range), sysram_name, mhp_flags);
> 
> Look like mhp_flags is only used once, I'd get rid of it and just use MHP_NID_IS_MGID instead.
> 

ack - yeah this was cribbed from dax.c

Thank you!
~Gregory
