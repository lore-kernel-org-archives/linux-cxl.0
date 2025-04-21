Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2737F1D5CF2
	for <linux-cxl@vger.kernel.org>; Mon, 21 Apr 2025 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745250079; cv=none; b=rE6lTc/V2C0Xli9W8lDGVvWHfM20u1WccpYdt/clp5gRfYuz/k3ta0JSKh+qhT++mTeNrSyCIeok84bYxJL3UxX8be7ogvxNGWTkOQoS081OWO/oftaUkbDOBW0qq0A2qtf5I33sxVjaS67vFGO/4zwwsg/MEOlVYaRC73a+Wx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745250079; c=relaxed/simple;
	bh=TZkYtvAnbW0rAUB3UTKIF6BEsddz+3MGasPFK4AmhCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8SXJLKCpTS304+OSgs3qGV3A98tcx0CcShhsnPewsYSQoUImXDWmDbvRICZ+ne9ZgLAmwypsf7iEvw6A+poq2RBxeDBR/LL3BMi8sbDY8UaV+INHcn7wVHw2GszyRCwn8CYfSyyoXBO/JuEmc4vG5bCbVvHn1VK26M4Ri5LEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=a7MVk4kr; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="a7MVk4kr"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f0cfbe2042so44034436d6.1
        for <linux-cxl@vger.kernel.org>; Mon, 21 Apr 2025 08:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745250076; x=1745854876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pdyTPsWFY5MtuQCjcezK9f9howJswTIWUpgsS1wT9Wg=;
        b=a7MVk4krFlliNqF6xqR6gtXOR24S23NMQwN6NW7vMzvMc/K3i2y7F3ohn3CkUZBN1e
         thTNGpxmYGcrwI+fpYpC2JsaBUgzNyc8l+ZONQIlMl+om7maERsLKXcCSc7BgYIA7Ehc
         9nSKVDJgngvYGTcjpTSMWnb6ChzBfVf/4OaI0DkEKpxx2YhBoutTkiInMHEJoMp/aJwf
         oWkFbLZ0YqYCsAQ9NGXHy1J5tXh5a26rTCHkNn6RjRU1q6XX/wvvsmZAm3Pw5LJWV032
         XLexkWBZiNXMiCD9jbv+0KQfBHrAFIjIUMerh12vNkz6TKfbWADrIjwW6ZlnhyQoEBLg
         mJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745250076; x=1745854876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdyTPsWFY5MtuQCjcezK9f9howJswTIWUpgsS1wT9Wg=;
        b=pTEXx4ci8fqdqqqdd+opmKx5D6hKHbDp6HGZBzHn9uJ5jXtvGHr6yuyzZew/W+pVIG
         HPsnI+8F6qemSh4ahU49jUIdswpYICLEpzNGIlpX3BOafVsQPK4ueXovA4eWaWSH9Wiq
         Tmy9I5A44P6t+MdpJlkrMwGBpZ4Q7eBKldWlYfwPPWKJqfWWqQdRsa3lT6LGpa/4XppY
         BdYD3N8JEkC6xteC9jNKzqYGAOu5DQ36P2nx8eKwIJX5gVPH5+v1Mho0NtX17kN6yYqD
         Lgtxk8rEvkQsHhAnZgK5NMApJorZ3kc2cESJxTFScSHrAAtF7AT2rHGNAd8rWOOiPwVa
         brIg==
X-Forwarded-Encrypted: i=1; AJvYcCVJQrQ8G6esd48nwdAQsnlLgIRRV1FJo41GhmjVOIJRA6JS/lPRfrZDvT9b7pl8DStR1zszP9kuKKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFKt6fZbRNwggtYGCkku0KRiqSlMMC+pbESDKw/RWDfPMb21N4
	JaCRep4qu+XSSHBQnj6mhej7qbNhzS/4219SiUIrxTZIhCVRKcvC/7q/kv3Nf/A=
X-Gm-Gg: ASbGnctd9WDxhlGBYP0F5tdvKE8X6jYNbNHKVz8S7fcROh1J6HVJHplLWePDabTRBNW
	P/751XfkdyXieyIxWuTEPx+GnCBNiXJjPKe5ykamjA+PgChJ0aWRrfOsxsWCrNxLWpZj/kPIOKI
	cnOmc+E2pHd6SwjdxLjrQ3eL18tRruJF7nhX12OLgSqWdxa3k8XUxaX9IxD5Voh8i7vfvR3avn2
	uIn2RnzttIwixeBX+eG4LZ+nK1jxP04iTh+KP0GAr9r1mI/lYxYokWS6G3DuwKV1iSCglmes9JW
	qQUKO55kkDRQmrMkJscCqXuLvXy6cFz6KirQIuwGVilTo547y+nEYv1W7SkfizhGNylgCptAYxs
	pwzbof2flA/72HPV10GUdYdM=
X-Google-Smtp-Source: AGHT+IGF+LAkUFbmnxnehWcc+xd6slRE1zOVmThwONU+nZGyCUWYHSGtySygUNijYDwjpSnYOhZnxw==
X-Received: by 2002:a05:6214:3211:b0:6ea:ee53:5751 with SMTP id 6a1803df08f44-6f2c27d0d1cmr224544946d6.21.1745250076062;
        Mon, 21 Apr 2025 08:41:16 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af1278sm45218366d6.12.2025.04.21.08.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 08:41:15 -0700 (PDT)
Date: Mon, 21 Apr 2025 11:41:13 -0400
From: Gregory Price <gourry@gourry.net>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, ming.li@zohomail.com,
	huang.ying.caritas@gmail.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl: core: Initialize eiw and eig to fix potential
 uninitialized use
Message-ID: <aAZnGTdN4lyZ9aaC@gourry-fedora-PF4VCD3F>
References: <20250419203530.45594-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419203530.45594-1-purvayeshi550@gmail.com>

On Sun, Apr 20, 2025 at 02:05:30AM +0530, Purva Yeshi wrote:
> Fix Smatch-detected issue:
> 
> drivers/cxl/core/region.c:1292 check_interleave_cap()
> error: uninitialized symbol 'eiw'.
> drivers/cxl/core/region.c:1297 check_interleave_cap()
> error: uninitialized symbol 'eig'.
> drivers/cxl/core/region.c:1299 check_interleave_cap()
> error: uninitialized symbol 'eig'.
> 
> Smatch reports possible uninitialized usage of these variables if
> the helper functions ways_to_eiw() or granularity_to_eig() fail to
> assign values under certain conditions.
> 
> Initialize the eiw and eig variables to zero when they are declared
> in check_interleave_cap() to prevent potential use of uninitialized
> values.
> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  drivers/cxl/core/region.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c3f4dc244df7..edf8636f190a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1266,8 +1266,8 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
>  	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
>  	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>  	unsigned int interleave_mask;
> -	u8 eiw;
> -	u16 eig;
> +	u8 eiw = 0;
> +	u16 eig = 0;
>  	int high_pos, low_pos;
>  
>  	if (!test_bit(iw, &cxlhdm->iw_cap_mask))
> -- 
> 2.34.1
> 
