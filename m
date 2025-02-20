Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04224BD1C
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079706; cv=none; b=ui93DmzMm9mqNoybUnSV1MYYHUzlkfBhHCGpSTpbr9P4hDm4QC9NSq6Fp/eEB7afiHoVMk7yXtjHvJZbs0iV5gAzggvFiPefV/NQKZka5e+pgRFyZvNaQhn6f0VW5/H8ga7OETv2dGjTI2VV+Lastdr8d5mvAk9NiyFY1Te6P1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079706; c=relaxed/simple;
	bh=uZc0Vvw+sYnSQ9lrCmIfjQyqVvDzE0cjPbU8SKuGveM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbR4qt5QqmoMH+EEcQ39z/aQldAqX3a7SzvTTetb13XWOd7GmX0iqDnNBtkDBTnvWgREy/5vKd75GqZ2Isjyq+ouEviwUfzayq80AoLpi6N7tY9YCdNFSpLUzzOiazOQh50I9oc2kbGoFUJoQugO5E7TQt28VHFxmlq4d1QZ51c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MhrFpiv4; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MhrFpiv4"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c09a30e14dso218018985a.0
        for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 11:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740079703; x=1740684503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3bAoXj6icIETl691BNDEUKP9/6VrvAsHwv5WY3HYyfY=;
        b=MhrFpiv4pr7/HuJty453Q3xMlV4UG9SshbIv4TfniVr1dnK8ovik9vQhrs7Gi+TNiR
         9ssqnOltzsRvVuHLCrhWZr2FVAxBOr4THJMHtvyp41gfSNXhD6qjrKhQBKWRP7SlvNrg
         EjzUxDdRJ3CLWdxf+Ezjs/zkS9GZPy+mLrJSK6nOg6GOLFFkplu81UJk6q1syvqFzwLK
         R/WVh3CLDvOkcGzM2Y25fdhyTsDRWscwMtoKuAl3PBZpYFglduN7GcqeXBtRlGn02ueu
         OjazzXiVU9Mz3n0xJnOORg6/OiDnnj4VgC0nphWXeNVPWkRnc68G6MbNclo72gRxkpg7
         kIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740079703; x=1740684503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bAoXj6icIETl691BNDEUKP9/6VrvAsHwv5WY3HYyfY=;
        b=O1onUDjHdeoOtSB8R2mRfv8ck5hUv8IhOGhdrnbrRIdqc1HR5NPQAxZ9XcFeFn7lfN
         eagRLKYyNbboumvkxJ6ZFThPqRzAbyocNT9Wd4nKNtA/MIlqbAvU3cHjNEFEbjRScr0G
         p0eIikNqRt7Kh6LkfsbyHnegLxWwHBz1bLnkB2Kw1fWRW4idN0k0Q28sMkUKyG4/r18D
         Esaj/BXjlkeD5ssXFwXBlJDSZvajZ9981IfwK7hLCyu/YUpocUQ3D4vHcqwB30pMoF0l
         H2XMoKyklFLcyYvI3UmOGz8tv3PyJGkeHqVLycOgHiTjSzfY0daCO9JDkeoyCZCS8yAU
         h43g==
X-Forwarded-Encrypted: i=1; AJvYcCUw6mCfQht2xc4OVsbE9Jn9cscRnBmCE6qTcLVDeGTDVT9fGkhS9gWB1PLzt4CZPAfPW8cM7qQMels=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfwqNSFfkIIrkJZ29heh+OwPkNE+jDhm6PIhGdITWcsTZEPJuV
	nTuWwZwSDCtVYf9VDpB0VVawx4OWyCTey4UMUtoNNkCfebCQ8XTMMD8yWFvwojs=
X-Gm-Gg: ASbGnctEv79iAiH4YKqJ8zjSpBCst6cFmmWu0y2gfaLbKB1Oob9Mu29cGKSDCaAZJqe
	fpXXlclPdDDCTGYznqnI183FUZ5zkk1k7JEu0KjysIVJaZS6Q9JWcZatG+EKgUifRTENEt034Za
	xPKPgYXsS39y5dQHhUBIlLKiAJvcmjyl9bOcJ5+ZZxX9yJDvoari6lLDNkfFZ+QaeTcQCQ0xX53
	Tj5KAeCyLxBqFEiAjfccNNw4D4EXNwmbGeIfVn/laOm3SsuTtEbcxt52/hnMLo6grgVCpvYwrzz
	yKZpaIGvjTlQBAs7OtWONDHjLK6FrU9UMTPlcXsnT8RCIHjppW3FEvjwxoXM37dYiwTUZsO4lA=
	=
X-Google-Smtp-Source: AGHT+IEa1R676oQHuTRGhqpovSkZNvRRmrFks88DAX5Y5EkMm1UGg3rbd89nS/D7LHAg9cvaoAYyWg==
X-Received: by 2002:a05:620a:2b97:b0:7c0:b76a:51de with SMTP id af79cd13be357-7c0cef71bf8mr80109985a.51.1740079701294;
        Thu, 20 Feb 2025 11:28:21 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a62e9865sm426571785a.59.2025.02.20.11.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:28:20 -0800 (PST)
Date: Thu, 20 Feb 2025 14:28:19 -0500
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
Subject: Re: [PATCH v2 08/15] cxl/region: Use the endpoint's SPA range to
 find a region
Message-ID: <Z7eCU3njj64GZFsJ@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-9-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-9-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:49PM +0100, Robert Richter wrote:
> To find the correct region and root port of an endpoint of a system
> needing address translation, the endpoint's HPA range must be
> translated to each of the parent port address ranges up to the root
> decoder.
> 
> Use the calculated SPA range of an endpoint to find the endpoint's
> region.
>
> Signed-off-by: Robert Richter <rrichter@amd.com>

May be worth noting that cxl_endpoint_initialize() will set
cxled->spa_range regardless of whether HPA=SPA or not, and so it will
always contain the correct value at this point - even if translation
was not required.

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  drivers/cxl/core/region.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6d5ede5b4c43..ffe6038249ed 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3535,7 +3535,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  static int cxl_endpoint_decoder_add(struct cxl_endpoint_decoder *cxled)
>  {
> -	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_root_decoder *cxlrd = cxled->cxlrd;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
> @@ -3547,7 +3546,7 @@ static int cxl_endpoint_decoder_add(struct cxl_endpoint_decoder *cxled)
>  	 * one does the construction and the others add to that.
>  	 */
>  	mutex_lock(&cxlrd->range_lock);
> -	cxlr = cxl_find_region_by_range(cxlrd, hpa);
> +	cxlr = cxl_find_region_by_range(cxlrd, &cxled->spa_range);
>  	if (!cxlr)
>  		cxlr = construct_region(cxlrd, cxled);
>  	mutex_unlock(&cxlrd->range_lock);
> -- 
> 2.39.5
> 
