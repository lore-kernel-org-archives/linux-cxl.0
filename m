Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D470618D62A
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736287569; cv=none; b=o5VB+UsQphFconH4dmo7WA5PEtYI84f8Hq94ARwnVhmvArUwLDrHWdNWrnx097q1p8xRRGQm5WyqZdkSgZRAXyNg99lqNMd9cAAOIyeXD+Zbw40ZTj4yf41EA3Fztv1smG5sh3b69e6CWfG+v7bqIscgmaOS3dCi0FEXi6U5IQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736287569; c=relaxed/simple;
	bh=gQqmlZ2Qu336X+55S8DKUukQDskPOV40mepiZ7Nyf/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHlIQ+a6r4bI1tVroT1m7cY18wkFKATgeNrXoTC2XeJ2M288ghLE0Ve0jY5s/K4LrkyiZB5TL4E6fbNPEwX0W/TdSZKOyKwBO5/bFiL73DWQhjR10m4dDKJDqDG/hms3wK0XwFXJyFO3kifAaMSTqm7dML40T98UfFc3inqDM9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lJIyRokB; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lJIyRokB"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b702c3c021so1408158385a.3
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 14:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736287567; x=1736892367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Z+yvD09Jzs1/yuZRPpghwqxWVUjGbyixinTNjStfAg=;
        b=lJIyRokBjC/2xEPhFYrWEum344RIT403cdASWFHJ3nFYsnuIcwEUr1XtqsMvq2TFNI
         eo/TZKWfWvuJ/MPi/tib3FOO4KkJ9ZWrrXGXYf2hXda5Z8HOkHb6h3pUOKzCiyjQxQRR
         y58VarhCPM7qer/JzNjwFnwrFkkSicb0udJJeXxWYStHSLe2vBJJP5x45nOOlUhrkN92
         CjtYYlnquObeXz+X9RrYHCINOGYBgbwnT5aqfadySh9VWMWaborcaQB3XDrPmoiKLzjD
         h/UqbZYd80funnfkxrkMrR/FKzZ0jTOyjibmy+P+BD/oMwbQqkVkI5pclvZN5jbWt2ch
         jCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736287567; x=1736892367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Z+yvD09Jzs1/yuZRPpghwqxWVUjGbyixinTNjStfAg=;
        b=I9zK0XH7H7ljkQax2nWmHnmYUVKvPF0ubAaRnUXM8QItYthJjK3v9afTxd02JPYkwX
         8vlrhWLQgoGUCoABIVf+hKXJc7OwKFVAOBVIj0cdjD813UentFx4zYRcTVyh4aNwJaIM
         nDmQ569FUVikoLM76+9YiaFLSD+rnejm9tMuCuEAZaf5T9gC65qnQ3YnTXiOUvoiPGEl
         OEUsjXAkugMLJS2cYF1as0o48cTdYyAW2oeMgN1rtlpkSTZ1abzJd29s3JDJz7TEFp1k
         0w9/e26kh+zTtDTH4J7STnRj5t1D6m4nZTM0h9N23IGx5aNCEIy9n8zJ8h6R1FT1M4w4
         6Pvg==
X-Forwarded-Encrypted: i=1; AJvYcCV+6PMRepLYvcWgHPWRpo1+VCzWi9NAfymXjs3uynHGpH08vQ3PxVyg21W3lpYBMa9/huLRiTG1X3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEVXc4TVb6kUB8RNyoq47nHutlj0mbTYRh6AqxHJMAe5WqqR9h
	xrYfL7poZMFhqxcUb1AwD3C1Zp5uhD0PmKJVetsHPMaPcgsKC0Il8zpNOrOBfgE=
X-Gm-Gg: ASbGnctqJRjFUXxMZDpVexOm+TlSluTHpS8t5r58/OFXGVFh5hvIGoLJzBgINX3xT3s
	dtD8Ju/+in9QzhLvsdbwV8A76AlPtOOrcZWqVUhIow6qgIwN/muo0A31TuIFaNFox+yNc9ghID9
	pbZ6E9NZGRbzRDY/SeM661CPAJp6gGDHPc4bQB/oomOBsSIleLxkIPki8BYMeF9WReG1YcC02DA
	udoFygkpzIYQV9kcqqWFuAp14dYxftfKLaPGnoTw6RZdfZSL/A4Q5oO5x0BEZrkG7wnb9T/yCu3
	MsOmACXJ7tN3f4yaefbArZsuJu5vdDJ3CWGsmK4=
X-Google-Smtp-Source: AGHT+IEgDZGOqa8TX7wd/PNgsRBnOk+DEoNe71ker3ml/5i1HsRggxv30WWi37TXcHfg48T8s14/Eg==
X-Received: by 2002:a05:620a:4898:b0:7b6:cb4c:10e8 with SMTP id af79cd13be357-7bcd96e5593mr63273985a.11.1736287566863;
        Tue, 07 Jan 2025 14:06:06 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bd0a5sm1630202885a.20.2025.01.07.14.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 14:06:06 -0800 (PST)
Date: Tue, 7 Jan 2025 17:06:04 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 17/29] cxl/region: Rename function to
 cxl_find_decoder_early()
Message-ID: <Z32lTEVg0qCVtP4i@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-18-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-18-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:10:03PM +0100, Robert Richter wrote:
> Current function cxl_region_find_decoder() is used to find a port's
> decoder during region setup. The decoder is later used to attach the
> port to a region.
> 
> Rename function to cxl_find_decoder_early() to emphasize its use only
> during region setup in the early setup stage. Once a port is attached
> to a region, the region reference can be used to lookup a region's
> port and decoder configuration (see struct cxl_region_ref).
>

May want to add a comment preceding the function to record this in the
code along with the changelog.

> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  drivers/cxl/core/region.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c1e384e80d10..2bc2028988d3 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -878,9 +878,9 @@ static int match_auto_decoder(struct device *dev, void *data)
>  }
>  
>  static struct cxl_decoder *
> -cxl_region_find_decoder(struct cxl_port *port,
> -			struct cxl_endpoint_decoder *cxled,
> -			struct cxl_region *cxlr)
> +cxl_find_decoder_early(struct cxl_port *port,
> +		       struct cxl_endpoint_decoder *cxled,
> +		       struct cxl_region *cxlr)
>  {
>  	struct device *dev;
>  
> @@ -944,7 +944,7 @@ alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
>  		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  			struct cxl_decoder *cxld;
>  
> -			cxld = cxl_region_find_decoder(port, cxled, cxlr);
> +			cxld = cxl_find_decoder_early(port, cxled, cxlr);
>  			if (auto_order_ok(port, iter->region, cxld))
>  				continue;
>  		}
> @@ -1032,7 +1032,7 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  {
>  	struct cxl_decoder *cxld;
>  
> -	cxld = cxl_region_find_decoder(port, cxled, cxlr);
> +	cxld = cxl_find_decoder_early(port, cxled, cxlr);
>  	if (!cxld) {
>  		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
>  			dev_name(&port->dev));
> -- 
> 2.39.5
> 
