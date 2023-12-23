Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94DD171BE
	for <linux-cxl@vger.kernel.org>; Sat, 23 Dec 2023 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fh1oA4/+"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5944d1ce0c7so717475eaf.0
        for <linux-cxl@vger.kernel.org>; Sat, 23 Dec 2023 11:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703359831; x=1703964631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BW5SJgYiWj5GPp0EoV45v3zGQooeIvbpDKo/O+otySo=;
        b=Fh1oA4/++0PE4zer/fYk5+VzBDW5+NEr1DRYB2l2a4y27yWcuQp60096l1QPKdJnVQ
         Pidv1iGB+OwcaWts1ndoYVrj+sq8yNjeDFZMImT8rasKHpWrp3LbY2ZCuD287Q6WrJLC
         Tqzyq/YxCohHbf+Hf8l/brUPApqT+lCtNnfECYkw+RYixnQh/5XZoOhjqdbk+qaBTM3T
         ja7//7OUESwQ+jdO07hnSCQkOFoQkjTmzcvOHfg6vt/SLh+aNDIefsmA69Rl1f5VB4Fa
         PFNl8CCyqjE6z/Wg55L4YrjQchOMzY42Xs0ACVCyPu17MmJ3riA3u2Em2+lMBp/GD9gW
         VWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703359831; x=1703964631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BW5SJgYiWj5GPp0EoV45v3zGQooeIvbpDKo/O+otySo=;
        b=YTNYtnjW0YfrXx0g7IMV5cUi4p1UnfbjpTdWReS1Bq6YmiCJf2a9DpYEDlYfyFc4Hy
         ZawJ4ylnh2nrj9sT73AE15CvMZ3ZLHEpNiqt38hRUrg2GwbOO3UQg8NlWkYr6dw7j0sa
         Eb1fuyQ+WP3QhDLl3gO+/ezKwZA+ddoRnCQXIygTLTQWqbUM1rhsOg8w05TYSHcpDbpr
         cpFzM/m27n03ymLcrowbdk8GH5wrYNdyXUOUBwPocSYhm5XVmsfHiWh0VavR4mCuFGRI
         p7TnOjdTvdvWDc7vJ1bT/LWJ8OfXp+TD1ROIEOxw6axwusUJSqklcjVjpje5tF0OLSRE
         zQoQ==
X-Gm-Message-State: AOJu0YzHKyiAu1197hncbGqU3Z+qg6vjyL41AChscPuo6Csjtv9sMQ3F
	o9SW6PbgsQXwRqb+T4r0X9c=
X-Google-Smtp-Source: AGHT+IE8HAeEnhPPlmFQjWCeuuuCamqTNaPIKxByo27H/YLFXrFCM2mvJwEURPVDJlDFKIAj0vEKzg==
X-Received: by 2002:a05:6359:29d:b0:172:bcef:bc75 with SMTP id ek29-20020a056359029d00b00172bcefbc75mr2529684rwb.26.1703359831474;
        Sat, 23 Dec 2023 11:30:31 -0800 (PST)
Received: from debian ([2601:642:4c01:bbb:d356:cf92:29ae:5af2])
        by smtp.gmail.com with ESMTPSA id ss11-20020a17090b2ecb00b0028a69db1f51sm6905374pjb.30.2023.12.23.11.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 11:30:31 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Sat, 23 Dec 2023 11:30:26 -0800
To: alison.schofield@intel.com
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3] cxl/region: Add dev_dbg() detail on failure to
 allocate HPA space
Message-ID: <ZYc1Utr_4rGWXdga@debian>
References: <20231223004740.1401858-1-alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223004740.1401858-1-alison.schofield@intel.com>

On Fri, Dec 22, 2023 at 04:47:40PM -0800, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When the region driver fails while allocating HPA space for a
> new region it can be because the parent resource, the CXL Window,
> has no more available space.
> 
> In that case, the debug user sees this message:
> cxl_core:alloc_hpa:555: cxl region2: failed to allocate HPA: -34
> 
> Expand the message like this:
> cxl_core:alloc_hpa:555: cxl region8: HPA allocation error (-34) for size:0x20000000 in CXL Window 0 [mem 0xf010000000-0xf04fffffff flags 0x200]
> 
> Now the debug user can examine /proc/iomem and consider actions
> like removing other allocations in that space or reducing the
> size of their region request.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> 
> Changes in v3:
> - Add parens around error number (Vishal, Dan)
> - Link to v2: https://lore.kernel.org/linux-cxl/20231129003953.1252985-1-alison.schofield@intel.com/
> 
> 
>  drivers/cxl/core/region.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 56e575c79bb4..a7b695db5dfc 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -552,8 +552,9 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  	res = alloc_free_mem_region(cxlrd->res, size, SZ_256M,
>  				    dev_name(&cxlr->dev));
>  	if (IS_ERR(res)) {
> -		dev_dbg(&cxlr->dev, "failed to allocate HPA: %ld\n",
> -			PTR_ERR(res));
> +		dev_dbg(&cxlr->dev,
> +			"HPA allocation error (%ld) for size:%#llx in %s %pr\n",
> +			PTR_ERR(res), size, cxlrd->res->name, cxlrd->res);
>  		return PTR_ERR(res);
>  	}
>  
> 
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> -- 
> 2.37.3
> 
