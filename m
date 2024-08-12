Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772C139597;
	Mon, 12 Aug 2024 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723496424; cv=none; b=lFYvYgDolo8bZVx1WOsQCdh5uslZzZs9navTACWJvbxEZgkOztm9AD7zqmkmWQbgW59Ze3lh+kgLvU+XDBuQwbMIYt9WpYuRPAxjSi2SaeK1FsxHITwnLnTKgnMxElXyebi05kcCLjIKNvzGYe/nhpUWLZXwIOwP+QzAVbW77Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723496424; c=relaxed/simple;
	bh=WWW02AUSI0eXCVWjgfczKyiQP5qxxvVPYadB12v0Qm4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZRgwD0d/euc/elI4V+Sz78nWDpYJ9qepBgzUDjlXvZ/yWbGeGYRRhTV6MJdRxGuAbTO+LecEgu4yMwU3D4oVZnzPndg1Ry5Ks/ZLkox7lMHbNTKyZXj4Oa7YK4XyQ9J2hvTLEKmrlIlP5Ya/fSXJuP8VrMcHQtuIJlrRXoRy0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivGlF1w8; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivGlF1w8"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-690b6cbce11so47258357b3.2;
        Mon, 12 Aug 2024 14:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723496422; x=1724101222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LUwqS9B586lnCc1g9I7eeMpeFDZS/vl82qcdWj7s7RU=;
        b=ivGlF1w8HEBwNYBRLZziF5BA/bKl3RxWYx+reNZOn+0cFeu5eVVxyQ4gsEW63vG0yS
         SnnYANWjA7UGNv0GEcEqm7lJxFbC6eK70sZRK2LzkqAhfCHuAjaWNunHb06x0xV8FPEK
         L8ZC5XVG7Wo/6YZfzhwEnVzc4HFxD2rBbxErvX3+11xrkbAaYgzz7vyavfNl7u2EmxAF
         /4kGBq/0VOZRuWKW7lvsZrjr1ymrHqjcSXx9uiu6/SbOP4IxC48KvlzvkQuJeGCNdsY7
         oNCpDuduAcrbkEXdML7JGOrPmg10wVYBExNqXsCpQdxU0Ca/2kXMU+vfHBODOXHgcDZ4
         rtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723496422; x=1724101222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUwqS9B586lnCc1g9I7eeMpeFDZS/vl82qcdWj7s7RU=;
        b=kC/VXJSS3EnzQXXgPAyB62aw0uTG+hmZ61JslOBdb5DwfWk0boxjdT5jJsvxTxqSvX
         nK80EmYNtlpvrrUEye8MxJqE6JUsRl82DzsqNLGc/5GWl9X740kkbjk//x55vCYlmBEG
         RaFfW2dUbE1Q0XIP9tOBUXIdFrG0w4JLhqvxjbQk2xmDM8sFW1pbNRSPSiTQ2j9gMxG7
         55jAVgeuGcHjfbuArhKlhSk/aDB7NI83jPQ9qqY9eI9bi0mHzfGRf/OU/bGYRcg8nroN
         HBQzG5y0tJkA7Gtor1byQCm/MUDPkoFjjutQIp3fpxxIbWj95oCkfVvC70WoqmsLg7Md
         1cMw==
X-Forwarded-Encrypted: i=1; AJvYcCX5/ZJGyzgXicS0KSkEsyVqIeQFGVi8vE0Rz+XWaTcXZxjjfFPAPzpg7+ZO6raidx5M+nLN1u0GluVmIX0XSsBYTNnxFZcNfVskPxRi7T3OYYVPzZ/pXhqDiY/WjtV1Y3k9B41//r2Q
X-Gm-Message-State: AOJu0YyBOhev0qk97iY+3vsZ4K4IyOYqzaRXJJp7Ta8DjlBRjS1uN2bR
	Ef7o6mStcvsT13e/iLnjR1HACgSbUbEcjgfYpeJoKmNRuNy4GgLN
X-Google-Smtp-Source: AGHT+IGB3pGiLYKEpdZiJny3J0FzIJ4Bn5b5VjFTu3SkpMdPJRI/pObAy7LpkAxw8QGEh1F+1r4Qlg==
X-Received: by 2002:a05:690c:4286:b0:65f:8209:3ede with SMTP id 00721157ae682-6a9759b95a9mr15777237b3.44.1723496422133;
        Mon, 12 Aug 2024 14:00:22 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a91de8e70bsm2045707b3.30.2024.08.12.14.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 14:00:21 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 12 Aug 2024 14:00:19 -0700
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH 2/3] cxl: Set target type of region with that of root
 decoder
Message-ID: <Zrp343_GAfQsdFvE@fan>
References: <20240729084611.502889-1-ying.huang@intel.com>
 <20240729084611.502889-3-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729084611.502889-3-ying.huang@intel.com>

On Mon, Jul 29, 2024 at 04:46:10PM +0800, Huang Ying wrote:
> Now, the target type of region is hard-coded to HOSTONLYMEM, because
> only type3 expanders are supported.  To support type2 accelerators,
> set the target type of region root decoder with that of the root
> decoder.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/region.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 21ad5f242875..9a483c8a32fd 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2545,7 +2545,8 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>  		return ERR_PTR(-EBUSY);
>  	}
>  
> -	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
> +	return devm_cxl_add_region(cxlrd, id, mode,
> +				   cxlrd->cxlsd.cxld.target_type);
>  }
>  
>  static ssize_t create_pmem_region_store(struct device *dev,
> -- 
> 2.39.2
> 
