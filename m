Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24461DF58
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068926; cv=none; b=FAZDtJVA7Hxf1R/kk3yg7azQeFNtVBMwJYrVx7MdO0s9xVodj+KYcLmQN//8DXv6+YUXvaI5VbfBZwHMMQowMWclWprwO2nNxYeOs7wmAi9sLMP1qQUpfMPGVIbtSBCm2aJ3H3zVicAG5ajsxxjJ5P9mYtfr75dbzH7Q/unMc3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068926; c=relaxed/simple;
	bh=qtZvEjj3Lx7yqO+SKHcxEAF3FCWhyE/jBk/4XkhKUHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAHyLPWkB+3oMOErs/LYiFjYQWbOs+6LZUy3UT1GJ16Yolv/uU5TRGW50VYY1FofLmTuJr9aFaZNS7o3NWijjMXXrebO91ajTAr1fBkuI2Z1HTCjbITaw5MtH2kplYKAJU3Fy6AqL3WytUQFXtUW2zVwyvbOvSgZ2ny7VxJxK4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=vCUzGkuM; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="vCUzGkuM"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c0892e4b19so123489485a.3
        for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 08:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740068923; x=1740673723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6zPKPwpgMpfH3brPd29df7mwe+JvN1VwGQmS25Yuk50=;
        b=vCUzGkuMsP9JQS/QWcl3XWgfSJ3fY6m8qeLG0kmNyNkt39Na2wQxRQ2uIX3dar1PuO
         gKQ6UZAjKXnqHN6wnZfnIjHIY5UMlWbHYh/QsJUtmxIA2SseglV5roC4S2pM5DJXS7cJ
         mZzSqdyF29ATpTa6e7oOUcE81dFMJ4OKj94Lk2qbM+k1HjEtNfS8SS33cMhBDTKhxaVo
         TRMPNOCGkbaUTFJbvalO7lREpk34EajTxSku493IsM7VUI7F+bJqdkNtjXlfAvmz7oLm
         xIr5uRAafsGj5VPREpxoOx1uiIfFeqAwcynhnvDAJ0hEfL3HprjVicYMzQfH8kO3j4mb
         vCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068923; x=1740673723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zPKPwpgMpfH3brPd29df7mwe+JvN1VwGQmS25Yuk50=;
        b=HQFE8n+BEcmbB1nr1N4PBSx48+T8xnYVPgEkaeYxvk4CwyDpXlwv4XagqVXbOCazf5
         VOe46+9taptFEExWL7iSakJ7+8NPJFYVi/zeIf/agJvdZBMGu0tIGseLOm5O35/W2LQK
         ZCltDnsf7zejOMVllQ5esK6Ooho7qQKIz+R64tgHAXT9MpUBoKEkzVnMJDMPzFI3iAUS
         QqrRShfp498tfAW7eXP14rF+PzJqm1eMYTjZ2aISG6r5b6vfr8kVFEFsyA0+ofFBiqN4
         S2pNr5N46nSLBMamkOVhriOQKU5S8/wImENFPtOjCVpZYwwdbOVfBvNB/A48LHEp1rv0
         ymhA==
X-Forwarded-Encrypted: i=1; AJvYcCWjY/nxgINsahlNCLnUsBJIgJSd4HVmKMWJPStUvrTWClD07Gm7adn9ZX08RM7y8T8QVp46eIzCFwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsiI7Oa/9FYxdnTJRlHYJfizXcnpf/+Q9G1mr/D77zuoQ4IFf5
	aZVfXWHR7Do0Fsz+EQyj0f/s+BYl/cguP4nKlvfDCW+Gcz8JFI7LBdW0hevFzs8=
X-Gm-Gg: ASbGncvwkRr2/gdHIy0rBoGW0OVQGMY9Hviml/Hae64kC4/io+AE9c4rHj510mTS2tu
	yvT8lH2SDfNH9oH5lTFlvFhDoU70nKabeMgTTNmmO7OjuS3/MTAsH0yQSoWvh2wxDTAdZewNKu3
	Oc72X30LCIziEaYWmDuc664dDayre0IgeuZmD5dcTcg8j3eaHcvlVclg0BSLwa5+olYS80jSO/L
	G0QMtJR2TJHfVHdETF3mDO0QfJAYUdLISVJWeGgMSZl8Y3eskuYG33fJyVPmv9H5DGE5FZOqio6
	aORICurT0TRuLnlWh0Qe82jYizwywYTtzatXT69TXpmWkNMJNgW4gxXB7tRYLz/MkAEQUMj+Tw=
	=
X-Google-Smtp-Source: AGHT+IGeFR8D7nMbaUp/3ATL7D3M3qMty7rR8JIiXinKvzPnvyJ/Rj3ZuPHNQJnrNccn1sWN2TpbjQ==
X-Received: by 2002:a05:620a:28d1:b0:7c0:b0b7:493e with SMTP id af79cd13be357-7c0b51cdf04mr1099093585a.7.1740068923018;
        Thu, 20 Feb 2025 08:28:43 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a62e9865sm409747885a.59.2025.02.20.08.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:28:42 -0800 (PST)
Date: Thu, 20 Feb 2025 11:28:40 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 03/15] cxl/region: Factor out code for interleaving
 calculations
Message-ID: <Z7dYODuRrRv1bXpV@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-4-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-4-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:44PM +0100, Robert Richter wrote:
> Function cxl_calc_interleave_pos() contains code to calculate the
> interleaving parameters of a port. Factor out that code for later
> reuse. Add function cxl_port_calc_interleave() for this and introduce
> struct cxl_interleave_context to collect all interleaving data.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 63 ++++++++++++++++++++++++++-------------
>  1 file changed, 43 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c118bda93e86..ad4a6ce37216 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1800,27 +1800,34 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  	return rc;
>  }
>  
> +struct cxl_interleave_context {
> +	struct range *hpa_range;
> +	int pos;
> +};
> +

I get that this will be used later to pass information back, but this
patch by itself is a little confusing because ctx seems pointless since
the function still returns the position and accesses the hpa_range directly

Looked at in isolation, having the context structure change in this
patch than just adding the hpa_range as an argument and adding the
context later when it's actually relevant.

static int cxl_port_calc_interleave(struct cxl_port *port,
				    struct range *hpa_range);

> +static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_port *iter, *port = cxled_to_port(cxled);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_interleave_context ctx;
> +	int pos = 0;
> +
> +	ctx = (struct cxl_interleave_context) {
> +		.hpa_range = &cxled->cxld.hpa_range,
> +	};
> +
> +	for (iter = cxled_to_port(cxled); pos >= 0 && iter;
> +	     iter = parent_port_of(iter))
> +		pos = cxl_port_calc_interleave(iter, &ctx);
>  
>  	dev_dbg(&cxlmd->dev,
>  		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
>  		dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
> -		dev_name(&port->dev), range->start, range->end, pos);
> +		dev_name(&port->dev), ctx.hpa_range->start, ctx.hpa_range->end,
> +		ctx.pos);
> 

	context just gets discarded here and hpa_range and pos are
	otherwise still accessible if you just pass hpa_range as an
	argument.  So I would push off adding the context argument to
	the patch that actually needs it.

>  	return pos;
>  }

~Gregory
