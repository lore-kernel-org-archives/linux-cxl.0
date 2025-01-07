Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1851E4106
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291346; cv=none; b=QunMZ/oOlx4Aya1ThVLtQo0KMT/ADPGQvAsLJiuSb9XQ1QpZPtycuP3xjOmNYPRCDGwa46WHEg70iwnciPgZRKv1qr5vNvvoXRYBXurkssUCn4M8NBGOw3Z5zM2NX8jH5j13ElAxtGu/hyWcNro3MlHVQKNBPRXRsQEIOJcYEzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291346; c=relaxed/simple;
	bh=PfkwO8faLiud7byrQVdjPYqIyxgxutA1/x5yQjedIEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQ1GVLJ8M6CNF/LPSCKxxgqKCaQ2+FlepF7UwjdqEfW5/d3ayK15BcNgkKCFo1uG1MxUMovul4eAhvyLH50Z7tKZOvxs1xElNf8tOP+/qHThYIhl5d+I8qGIBbbR3r4HvO9ZQUp6dijnG65p03nZSBJrL5+YI0WunqJEZFevAE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tdilPgvC; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tdilPgvC"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6e4d38185so1285034685a.0
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 15:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736291343; x=1736896143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MOHJ8z+VZigiYhm0fJ16gfpWojOduZJ7KNV8uUz8tsE=;
        b=tdilPgvCacN5WLiCVkWtPFBvbad88Gx2Rd4yMhPhYODwmToK9Pa3wB7fH+RdhMD432
         toRRNV4VqGxGOS7AiR8zlxUz3fuISmTldRntL6Vx2dBQ6wlxjLrv7v7QCaGGyHkJ27Bc
         lo1rrCVeGyEXNCddB8aKGYQA+CIeIe0IMZ10it9WdEGZ+y7Z4LvmSX02zBA3AwJ3Raq8
         VT3dqW7t8AA5euoxWUeU6m0n3HZDCQuGL/OYqZc6zPwnyUFWGnduH37yOvuPuQCVHHzf
         yx9ROEOOKy2PzxMoghzSvITVibFQ9fnMQSOcemrY2lDFO6BJHAbzbyrtCICR5zkQ8moO
         GkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736291343; x=1736896143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOHJ8z+VZigiYhm0fJ16gfpWojOduZJ7KNV8uUz8tsE=;
        b=WTl64IyAEQthFNsDTeqHjZh57+Bw5wWhlpXc2BMdwddvhvGGXj/S3DJnmNDfD6+hIB
         hpjyheN0O5e+ZgSoa/XHqqlJFyKI/DhEc3wiPnaXdnLfh62kO6dNMjaJFWk8HlblNOQI
         UZWcNnAEPXhuj1YPijVpDvIb1Y2GONOAwbGn/QBPeIjWAozi1Ju71h91rw7b2fiwY1cM
         UGYMsr4WzvIt00ut1MPiOuJG4ok3i69VDmvFuCiqkfuOr81R8/FAbSuFR9Th3VgA8W0J
         kpo8klR/CKM0r1SRCDYVzhUAXVpLS9sarCNlqs+4NocNnEDjlAzv2+bt0AJ+4W4nV5F0
         SUYw==
X-Forwarded-Encrypted: i=1; AJvYcCVizhnkV+xTbPDKqgpRChgjRxp0Lx2BOps9VRdGAWVxtp5HMs+vIR5YOXAvRlOTT/FImEWb8P/JKJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8gdIdRU2vX7vVsOFwL5mOmwG2wAk8gDt0f9iZWWkJvoW0qnZM
	yOM6rhF0H4Bjhzro7HtpFTxB66FG7VOAInAhxHGymPBtCXdxuSAuLflUawXvjMg=
X-Gm-Gg: ASbGncuT6d8aIntnBd+hXMNRP0jDAeCEqwU7NAsK2OnFtNQvkB5GBy7O/oBXeE5sJgz
	3SOu+f3WCsmCdY3l0DeYRuu6BICoje2Vcc6wp1uiKUB0mCofQgq/vbb5AiVeaqTUqHUCQzDh7+1
	MGCSQzCz17Zr5kn5MTs5MNP7YCROmeEsPPjzLzwX55oovtx3p2Hxzocmz0f4l2RIneM7zPIv+ko
	05bdZcfveUDUmTcEkowGJav6Kf735EC2Gfze/3aSqxTxsrh9Lq07+PBhNCBNRNduy+2oSBcghpg
	WTMfOp8HBXA9BqJmE6dBHGMxrsQK33biOjhWfSQ=
X-Google-Smtp-Source: AGHT+IG02fA/737ZKr+q7e3UvoDWLXu3b1yxK62LwgPWBnyY5//4sdFUZ5gsvVg7SZ7WrVD+qs6K7Q==
X-Received: by 2002:a05:620a:2a08:b0:7b6:c92e:2e74 with SMTP id af79cd13be357-7bcd9709396mr93508785a.20.1736291342698;
        Tue, 07 Jan 2025 15:09:02 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bbfc5sm1628638485a.1.2025.01.07.15.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 15:09:01 -0800 (PST)
Date: Tue, 7 Jan 2025 18:08:59 -0500
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
Subject: Re: [PATCH v1 22/29] cxl/region: Use translated HPA ranges to create
 a region
Message-ID: <Z320C6u_qXz8zQbJ@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-23-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-23-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:10:08PM +0100, Robert Richter wrote:
> To create a region, SPA ranges must be used. With address translation
> the endpoint's HPA range is not the same as the SPA range. Use the
> previously calculated SPA range instead.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Patches 22-25 seem reliant on each other.  Should I expect errors if I
were to test them individually?

The individual changes in 22-24 seem ok, but is spa->* expected to be
correct in the absense of the PRMT translation functions when HPA==SPA?

~Gregory

> ---
>  drivers/cxl/core/region.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 681c26abc26e..e218f0be2409 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3424,7 +3424,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_port *port = cxlrd_to_port(cxlrd);
> -	struct range *hpa = &cxled->cxld.hpa_range;
> +	struct range *spa = &cxled->spa_range;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
>  	struct resource *res;
> @@ -3462,7 +3462,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  		goto err;
>  	}
>  
> -	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
> +	*res = DEFINE_RES_MEM_NAMED(spa->start, range_len(spa),
>  				    dev_name(&cxlr->dev));
>  	rc = insert_resource(cxlrd->res, res);
>  	if (rc) {
> -- 
> 2.39.5
> 
