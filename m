Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31B5224AFB
	for <linux-cxl@vger.kernel.org>; Mon,  6 Oct 2025 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772788; cv=none; b=eP8dJF4c/3MTJt2VvidKGl7UTfmly/W+53k4ZoJurRYfkXfFZT9X3Zi00pRKB/pCY78Y/uD2vEmiIL4c9028XpPEXd8eMzy1gO45fScOhD1Tx2COHCboJjJk/PCmJcop0Cm1xITjmz88bMPcKS1poFnYd+Aac46axVVpFyJb2ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772788; c=relaxed/simple;
	bh=BGtlhNEOznmLiP8Td9R6UOdRpHKv83zIL/Fw14yz6Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqBOwv0KIE8fy0mdrreFf4lpu7aqAVxqjJ/N5C2HRzou5cZFY1Z+gdUUcnzTF0j/eIhwVDEihimITtBoWI7xFJrQJ+B9DZIthmWR1rddjuYmFcdoOY1xiVcimkj/i72wjkkx7UVgf5lQ7RieqOgjfvxMu6U+7l0EEMibHTejKXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Azr4PsSJ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Azr4PsSJ"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-791875a9071so51195776d6.1
        for <linux-cxl@vger.kernel.org>; Mon, 06 Oct 2025 10:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759772786; x=1760377586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mV5BjCFzof/sFlEEwNlSlREaw9vi7GsMBGBoLtecLf0=;
        b=Azr4PsSJmwu73Gq7Q6Wypi5cfiPLOiVgHe62iNVFQIT2UeiPtoxrSH8FoKrDTsbNEw
         mDkG8AU/tCr0NBQaJn1zHy7eAxy/PCApRKyDMvQ0eOP6Od4zmwZN7KumzY+jdJBKGS4o
         /Ra74Jk5lMSuRpb9tNSDhTDbae1CXonczD3KAjtmweekGaR5WhuPqU/8zumVRK4aln4k
         vGTsqUM/RlU72NWhH3yJHqDKsNBakxrQAMKNgsGhy28aVa7eCKROl4Lv8fBLFAsM7U6E
         5ymnH62eP7+rBviiuIetXZLc1lJWfgZfpFGZd+2dm87edorWLYDCnqT9L57IGOUnk0Dp
         vi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759772786; x=1760377586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mV5BjCFzof/sFlEEwNlSlREaw9vi7GsMBGBoLtecLf0=;
        b=nONTtHsBI0cCD3zfKG2ZqNyN9ridRu9ybijbtVHg0sYD8HtpPfzPM8gX6KHvcX2bmH
         gTZ7Bjw0h//m+6BzjaK9EBiXrwFW7cfwKGXYnd6HBnfuMVn16Dsv5JcpdfFUrggMDOjU
         7JkzjOlhB+T93qvGyomhvv24qJ/27LWQ3QmpQMDUNMbiIrcA1cgIoEzDJf/20vmeZ6cb
         FORX1c5shdCLkAK0RgNF60UqyIVdRj6bOtVmXocUD71S/DQ1J16/+V6RfZuMLsMoHWjS
         sP4cfmQ8SbQuc/3JZptdYzmDHeUal8ZaEZUzvka0B9fxHaKY8ZxT8TMGl1yR4BzDj2um
         JbkQ==
X-Gm-Message-State: AOJu0YzprtRhLfMQ703oDGKtmdbzN1HPznTk6mhNSSzcDVq8pVtlzu8c
	x5uubQ4UZ3/UNUa1VG/rikQDh1S5LWYkkGJ7jFAEf/y1mBWpMuyJUT3rBWdT40+looo=
X-Gm-Gg: ASbGnct772Z8aLobgC9H02ctKRhz2V6TY5szmmK23hPBx9VdTJULZHF9iMHDhJHT4dl
	qqxwHjvIl5BVFsTCWvpu/81r2yU3PDnJQNkWzYERKvgWB2nTfVV+T+3Z+Vt26VqcaOx8WRvWG1d
	vRojrNFbvIC6qdvgYdX8d5M3IIzb0QGBh3G9x4eelXhiqsEt5nJrzlycFzezYjORELG+Oeshgzr
	5L5WzKu5KqjDf/g6n5Jhwdd7JeBdMI7Pb87atOW/qf1Ae0Mc/7SDMx8ONwOzHa4/Txjdjirqbi4
	TNjH1IhF/2pRoa2Yn8WLj6U5mLXVttuG/L2SmSw3NkPISP3SY22jbpR7DvQTvaUr8ZtZyd8dLlQ
	I5Oa34r+NFC3AX530+v3vB8C1C5iqoi1MiUgVE1OyZTJWyhA7gsANzTniVAdtDvw9qFiYHaM7ll
	qIgdFZIwc5H855CavdTsrg8lnYQy9HOy8XKLKSFBtW
X-Google-Smtp-Source: AGHT+IF/GPa4ozi9y7BOzBQqoUumY05J+0iFBW4qq7MNJrp4XZQ1zNaIlGSXGXlJSe7DbRBRRQjNVA==
X-Received: by 2002:a05:620a:4709:b0:85f:82c1:c8ed with SMTP id af79cd13be357-87a37cb2f16mr1907191185a.37.1759772785714;
        Mon, 06 Oct 2025 10:46:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-877796a1de6sm1267593985a.49.2025.10.06.10.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 10:46:24 -0700 (PDT)
Date: Mon, 6 Oct 2025 13:46:23 -0400
From: Gregory Price <gourry@gourry.net>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robert Richter <rrichter@amd.com>,
	Cheatham Benjamin <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 3/4 v5] cxl/core: Enable Region creation on x86 with LMH
Message-ID: <aOQAb9H-wIxc6j31@gourry-fedora-PF4VCD3F>
References: <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
 <20251006155836.791418-4-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006155836.791418-4-fabio.m.de.francesco@linux.intel.com>

On Mon, Oct 06, 2025 at 05:58:06PM +0200, Fabio M. De Francesco wrote:
> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more
> Host Physical Address (HPA) windows that are associated with each CXL
> Host Bridge. Each window represents a contiguous HPA that may be
> interleaved with one or more targets (CXL v3.2 - 9.18.1.3).
> 
...
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

Couple inlines but just nits

Reviewed-by: Gregory Price <gourry@gourry.net>

> @@ -1770,6 +1778,7 @@ static int match_cxlsd_to_cxled_by_range(struct device *dev, const void *data)
>  {
>  	const struct cxl_endpoint_decoder *cxled = data;
>  	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
>  	const struct range *r1, *r2;
>  
>  	if (!is_switch_decoder(dev))
> @@ -1779,8 +1788,13 @@ static int match_cxlsd_to_cxled_by_range(struct device *dev, const void *data)
>  	r1 = &cxlsd->cxld.hpa_range;
>  	r2 = &cxled->cxld.hpa_range;
>  
> -	if (is_root_decoder(dev))
> -		return range_contains(r1, r2);
> +	if (is_root_decoder(dev)) {
> +		if (range_contains(r1, r2))
> +			return 1;
> +		cxlrd = to_cxl_root_decoder(dev);
> +		if (platform_cxlrd_matches_cxled(cxlrd, cxled))
> +			return 1;
> +	}

Is there any concern for longer term maintainability if addition
match_*() functions are added?  Or is this upkeep just the unfortunate
maintenance cost of supportering the quirk?

>  
>  static struct cxl_decoder *
> @@ -3406,8 +3421,12 @@ static int match_region_to_cxled_by_range(struct device *dev, const void *data)
>  	p = &cxlr->params;
>  
>  	guard(rwsem_read)(&cxl_rwsem.region);
> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
> -		return 1;
> +	if (p->res) {
> +		if (p->res->start == r->start && p->res->end == r->end)
> +			return 1;
> +		if (platform_region_matches_cxld(p, &cxled->cxld))
> +			return 1;
> +	}


if (!p->res)
	return 0;
if (p->res->start == r->start && p->res->end == r->end)
	return 1;
if (platform_region_matches_cxld(p, &cxled->cxld))
	return 1;
return 0;

?

I like flat, but I also dislike not-logic.  Style choice here, unless
others have a strong feeling this is fine.

~Gregory
