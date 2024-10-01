Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3707A1C6F4B
	for <linux-cxl@vger.kernel.org>; Tue,  1 Oct 2024 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790823; cv=none; b=jBcVQdLSawwlevC/i8IvWX9I3qSsVDO43lou0J3LbXaVPbMeeSvZ+Xe82Y+3t1ssauCxCYY2i47P2pd5PdQ0w5njVwtAihGPlveFUl+u1TpFeRJbQK0PoAbSkTNGH0d3tTAZJGJ9Kyl7LxsR5kILx7w8/WI/N6zs589vQN2ZMPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790823; c=relaxed/simple;
	bh=YevOv9CXMoCsWPZuusUeDfG4SKOg29+imb4Q0/GC8UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7DWckx9Mrn/Z2nCAYTxzvcOXTyuktVHWKOxNlF1vJbPwNkSIXacXugva4+KBIchY+3/SV6J5C2nA+Xc8e8PHG84iqT/wvSaAYE7/0SNFzDI+/htXpmtHFUHZPEfvMNVT5paTGQbF1+ra1zeMxXFZiV9VLHkJKADXObsUpHIo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kZ4g7tHw; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kZ4g7tHw"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cb3d2ce75eso37374506d6.0
        for <linux-cxl@vger.kernel.org>; Tue, 01 Oct 2024 06:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1727790819; x=1728395619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mFQGAUbeSLfIECNGNmCvVLq1+ZKKwQ4FuJAi/d5WHE4=;
        b=kZ4g7tHwyPVVQ8SW7zKISIEcqAd/ke7mh+tQFrNLtHV8wwCSx4xcClfEx5VTCqeid2
         12DyMv2KRGzl6euVBRueDX2TLfqp3ifg3p3TPNzZg5e/xLHuMa/cWP7WHbjyGV6rTRRC
         NunynNCFbdQKLrarIH7CHQDx75NKfYJ3sUgDvX9AjLEu1lUDfBggVyEfZ2V34TOIzWzr
         BdvKsLrKJvWMKirBd89bSO4a2mkhNMeJVsqEyr0FE1DLg5/ZXP+zQonVqhPR6qjhQvv5
         fPbb8+vzZEQgwHma8IxLFSbH++B3V5WuVdC3+fCUstMk9je6YmJje2uUsf5lvrhmTnJa
         Ro5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727790819; x=1728395619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFQGAUbeSLfIECNGNmCvVLq1+ZKKwQ4FuJAi/d5WHE4=;
        b=ndJKEzGro258cGNXpaRMs25sal6+3Qn4zS9jrumqrX1vw5GXXPy2OD3v+x7s4+YJ3V
         TTSle5gUgwAyvcs+0CPYrqTqWCnQAcdAU/Uc4vuuKHjNM+jcS/xNpLAxOhL9sJhrUaZJ
         05Oe0DPk0hC+tvNnKBZ162DT8rcdFh9bBre9NqIRYiVJO3dvI/qveCLTlweLXEfeGg8d
         822eJLJXOQfUNuOn3QArmPMiT7AVy2yODYrh/cgskIaE4Mz487IdfsgD58eEgLPj/oOB
         ZY7iOXMc8oPBm/o84C5YgH0G9X6Xzq23GX3XKTGj96GmXxqnAzH++WXu03nqI3m0Bu1q
         3v9w==
X-Forwarded-Encrypted: i=1; AJvYcCXbazWDCCwC97Ao4408wYuk85M0+zTt5sO0j9Tv71u+79VT7QmMEXnDTvbfQIRkJbu67fA/9mQQIYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDBenNfNQV/Gs4k5hiCSnG3TTRyTZoaOux/JwKm2OeDF7ESM4L
	OjBMZ8rYi4s4WSMMDNWb5XIi8om56kslSa0zusL/x8be0gAFnBPPW9J1TYZezY4=
X-Google-Smtp-Source: AGHT+IGMDILuJiNlDpH4UzWMjHVo6B9bDl4Xt7zGachG89go3KLnheesJvns9n3q9CHL3y+JdKAKXg==
X-Received: by 2002:a05:6214:260a:b0:6c3:575a:a975 with SMTP id 6a1803df08f44-6cb7291621dmr51931186d6.2.1727790819112;
        Tue, 01 Oct 2024 06:53:39 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b600f32sm49887686d6.22.2024.10.01.06.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 06:53:38 -0700 (PDT)
Date: Tue, 1 Oct 2024 09:53:09 -0400
From: Gregory Price <gourry@gourry.net>
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [RFC 3/5] cxl: Separate coherence from target type
Message-ID: <Zvv-xTGGTZee_fr8@PC2K9PVX.TheFacebook.com>
References: <20240925024647.46735-1-ying.huang@intel.com>
 <20240925024647.46735-4-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925024647.46735-4-ying.huang@intel.com>

On Wed, Sep 25, 2024 at 10:46:45AM +0800, Huang Ying wrote:
> Previously, target type (expander or accelerator) and
> coherence (HOSTONLY (HDM-H) or DEV (HDM-D/DB)) are synonym.  So target
> type is used to designate coherence too.  However, it's possible for
> expanders to use HDM-DB now.  So, we need to separate coherence from
> target type.
> 
> Accordingly, the HOSTONLY field of decoder ctrl
> register (CXL_HDM_DECODER0_CTRL_HOSTONLY) need to be set according to
> coherence.
> 
> The coherence of decoders can not be determined via target type too.
> So, accelerator/expander device drivers need to specify coherence
> explicitly via newly added coherence field in struct cxl_dev_state.
> 
> The coherence of each end points in a region need to be same.  So, the
> coherence of the first end point is recorded in struct region.  Which
> will be checked against the coherence of all other end points.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/hdm.c    | 22 +++++++++++++++-------
>  drivers/cxl/core/mbox.c   |  1 +
>  drivers/cxl/core/port.c   |  1 +
>  drivers/cxl/core/region.c | 37 ++++++++++++++++++++++++++++++++++---
>  drivers/cxl/cxl.h         |  9 +++++++++
>  drivers/cxl/cxlmem.h      | 11 +++++++++++
>  6 files changed, 71 insertions(+), 10 deletions(-)
> 

Reviewed-by: Gregory Price <gourry@gourry.net>

> @@ -1925,6 +1933,29 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> +	/* Set the coherence of region to that of the first endpoint */
> +	if (cxlr->coherence == CXL_DECODER_INVALIDCOH) {
> +		unsigned long flags = cxlrd->cxlsd.cxld.flags;
> +		enum cxl_decoder_coherence coherence = cxled->cxld.coherence;
> +
> +		cxlr->coherence = coherence;
> +		if ((coherence == CXL_DECODER_HOSTONLYCOH &&
> +		     !(flags & CXL_DECODER_F_HOSTONLYCOH)) ||
> +		    (coherence == CXL_DECODER_DEVCOH &&
> +		     !(flags & CXL_DECODER_F_DEVCOH))) {

silly nit but my gut tells me we can make this less ugly.
Not a blocker though.

> +			dev_dbg(&cxlr->dev,
> +"%s:%s endpoint coherence: %d isn't supported by root decoder: %#lx\n",
> +				dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +				coherence, flags);
> +			return -ENXIO;
> +		}
