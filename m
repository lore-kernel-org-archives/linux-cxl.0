Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46591C68AF
	for <linux-cxl@vger.kernel.org>; Tue,  1 Oct 2024 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791099; cv=none; b=dPrpHnGALn2b4Yw8IqBkAMggo+kglIz1nnX2P8jUgKdKrbCbjlBvX/ZGiTgcucgGI7sm3NZ3AaQ4ofXh9LG7+drPRbP/G6OK3MpQn4QX5Wj7xwRBBNURj/sBh7KN0nAbUNAlYVMcr/FTLSfnVacRS9o7sqA60JUoUTlBlMV8Ukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791099; c=relaxed/simple;
	bh=rc+nvspiQjHfxreLGf9oU9F3WFm5fP+uWBobwDg1Rcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yb0MQhS03GLtokeglSi+5MxWoYa2X1Rgujgq55+YMf//qoGhiI/QnA+du4Xc7WoV/wzodyqVfCtBYJ7XsbRuYmUKkCZBIofI4UUE26j6t9zEXZjcL9V94SmJ19BLUVFrShsfxx5pHC3yGl1ssjMciCMpx0leTpOQLyT6JG473b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LUSKyQS7; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LUSKyQS7"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cb37b34a87so39550336d6.0
        for <linux-cxl@vger.kernel.org>; Tue, 01 Oct 2024 06:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1727791097; x=1728395897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+i0gbYDUn3GkO8tIp0Xangb9Cl+RaC/PIK5VDa2+Q3Y=;
        b=LUSKyQS7OzgJTK9aTdCHFwiVukj8akHpjum59irLAf1wOjel9QifZ037Pf2VjqnJEh
         s2twAyCAYb0N01F9sTL/YBSh4KhUIj9oFfgQAtYQTyXy6V4fgfAf7RNG07xPGbH5M+Sc
         mGtLTVu9t/ANplOGegBtYDwt55iZFpIhtst0CXlf+pCp6ewl7mv7Pzlh0xfFgSLOrfd2
         J1/yYCf7VsQ27wD/gV5CR9AHxlwg3zncQKO1gQIMO13Z2XjmURkzu3kS8glXBWKIE1Kn
         n4dUx//W5utZIZudtGj1dyGU/ZA1XNJV9sAwXOw+ML255bwtOMkIIiX+kl5tcSPuWnpH
         SOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727791097; x=1728395897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+i0gbYDUn3GkO8tIp0Xangb9Cl+RaC/PIK5VDa2+Q3Y=;
        b=ULnNH4z5/yMgveDjn7X2XghYpVHPCbf1D+rgs/M1TMnLq12pPE+nHitcRn1YgX7wDu
         DYo00CyPnhFc5QaAf7ZQXe1c9LGncnZv5YDGmqx5CtJqPxox8s/57eH/PBxbpWcEs9J6
         +xajYk+RZIW/8JMUAwX+lbKql3X6AsNyuxkFESAk+vt+0r99M2IBfu2ArVkwQDvqFh2q
         fRmu5MKdAqroPVs/iAxk1550ALyrzUY6w3u0fxK3r4zdnCQONqZQlBn5ex9n5ukIXwvg
         YNyr0CJrd9+XXUsJpbcd66z5sQKqS0vQwBpTBqT8aCQyvKavq3bNdBuLwxOP0rCnl8bF
         94Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUFP2cawXVEcO9+GQzm7OQpQsqLYlZNBDqvu2Y4rAcbX0M1Vn8dVZz31ty0U+fAugf4lu/TdNUlAOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXlqfaNqGPzNqXl3ROYsrefEm/2d4v43u7zM6er2J5cqj/d7q/
	NSBpEFVqwm3tBOJ1aXpr4rLsC0zBU0uJT4nQHCCytf/e4FZMPvIMdZgPphYAgh8=
X-Google-Smtp-Source: AGHT+IHOBNkfKGEIV6JtekGZPNNiErzM64JGbFA5V8wpruRqFBreqhGQUtcdf+nLPW4mVUq0BDmfZA==
X-Received: by 2002:a05:6214:5a08:b0:6c5:afc6:7f42 with SMTP id 6a1803df08f44-6cb3b63d0efmr232727916d6.34.1727791096751;
        Tue, 01 Oct 2024 06:58:16 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b691ab2sm49297086d6.145.2024.10.01.06.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 06:58:16 -0700 (PDT)
Date: Tue, 1 Oct 2024 09:57:47 -0400
From: Gregory Price <gourry@gourry.net>
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [RFC 5/5] cxl: Avoid to create dax regions for type2 accelerators
Message-ID: <Zvv_23tPL_1XZlmv@PC2K9PVX.TheFacebook.com>
References: <20240925024647.46735-1-ying.huang@intel.com>
 <20240925024647.46735-6-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925024647.46735-6-ying.huang@intel.com>

On Wed, Sep 25, 2024 at 10:46:47AM +0800, Huang Ying wrote:
> The memory range of a type2 accelerator should be managed by the type2
> accelerator specific driver instead of the common dax region drivers,
> as discussed in [1].
> 
> [1] https://lore.kernel.org/linux-cxl/66469ff1b8fbc_2c2629427@dwillia2-xfh.jf.intel.com.notmuch/
> 
> So, in this patch, we skip dax regions creation for type2 accelerator
> device memory regions.
> 
> Based on: https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Gregory Price <gourry@gourry.net>

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9c68ec445128..b276752c38da 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3466,6 +3466,14 @@ static int cxl_region_probe(struct device *dev)
>  					p->res->start, p->res->end, cxlr,
>  					is_system_ram) > 0)
>  			return 0;
> +		/*
> +		 * Accelerator regions have specific usage, skip
> +		 * device-dax registration.
> +		 */
> +		if (cxlr->type == CXL_DECODER_ACCEL)
> +			return 0;
> +
> +		/* Expander routes to device-dax */
>  		return devm_cxl_add_dax_region(cxlr);
>  	default:
>  		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
> -- 
> 2.39.2
> 
