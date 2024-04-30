Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23111EB40
	for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714517435; cv=none; b=BYcSLdbfWtVkb6DInaIl27BvFMm5LkT0iPhI/629BQ/KroSWLu0tfji8EdfzR1ztUgmL6Lym9uKFLQrwg3GH6qbxfMd4ArAVxKt2zmJP4anKzFfnUdBGTct+Ubl4zvd31q8/NVgvg+oqZnQLXc7ivBrCCCIz3bRISSZpDapDFZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714517435; c=relaxed/simple;
	bh=HO2nDCcAuAMXf3PWyoqESKsoJZnPpeuUvBOBNbWkQc4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSQB9KnYrCRipovVWQpeNRpRelG7y6rFmyZqF6cv+rA9YPjql3Dz9BGWTz0HkhKIoBT5soiob9Zwpe/uET/irLkUaQGyp5iaZmVSF0Ob7hLN9Toa/dT0GF3CI8gcyJHIFFAxaf8s2f/D3txwZVTolxFDuRqAnhN2TChlf/NycOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWTwDCVe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWTwDCVe"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e3ca546d40so53945855ad.3
        for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 15:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714517433; x=1715122233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L8gNbXSJJnTyL3jyiK4WQX4aJWwI6g+w6yk3Vg6VWsY=;
        b=KWTwDCVe9w+MS8srlpYJ2SF67tJPtSU59VgdPtGt8STdbDsO4EDRDUI+FlCZoOpXsd
         YO6vHkPPaRUGhuqJR1uzz1mFRHHmHAlAFqxATUHWJjyEh0zbar2Fv2HDnvpcirr/MFbm
         nAYUE95PdWtKELC9fv+OvpkFWG7JeFNIYMtzl6/wS5T0uxlQGMAYUaN4rnKAo8Wb4y7X
         7S0zQW9JRlC81KMYl2k7jhBHDqgsmX/zpgxnWxep6lLvi9Bii7rnsukFTgFLPDM7RJi8
         AM5Rskcoywycwj1ik+DCfJYXKuDcDlhVds6BWokPZnelegGyYsWwhgmpernQ9UWQTnrV
         nTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714517433; x=1715122233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8gNbXSJJnTyL3jyiK4WQX4aJWwI6g+w6yk3Vg6VWsY=;
        b=mXToakojO0JMO0ga5NxfxRXModobqFqjx5HdfW7yFiV0FYzwxjT1nRsFhhLfTqku4g
         JtkCJs91VHghP/S5AT4rsBFhfKJ7CWOXFwYk72JxPnlxF9pW9TtGQHverERt/emweZUZ
         GJSOoggjP7lKYykgRxfu8CjFKp+bq1UYoZmcjueIV3YYHA4mMBVDtEAHj+coQhi6iALP
         1InoZE98sHLLHcn919SQJqqRS05FBSidOZ4HLIj7MYniOpEO2wqIleh19CSQ6vcE+BpA
         v2Ycn3Cg2p8QJIptWnaIiOFp6PRnlhEFffKxhB+VMvV5SMPnu4OiCPPXL9J7LebPncvj
         ac1A==
X-Forwarded-Encrypted: i=1; AJvYcCV/ZEMizwYnZcslYPTwbAQ+X+iQ54gl2ZxD9El7rjOt01eUR06hehzsbsM2frQ3fkZUQhAsVuYQgg+Q0BOT9ze5Av6j3+fP5cxe
X-Gm-Message-State: AOJu0YxTpks8C0nJhlRE+jo4IuliuxfIjIv9wGCH5TCMJ2fUIJnoTJv1
	wuClU61rY8TE6TVAlne0MQYjNum+IufCr30llZa6HFqfd28TSkCr5QNNZw==
X-Google-Smtp-Source: AGHT+IGu1Dko4GoC3RHNx8/AD+zIhhy9Ow5Let1I7wZxm1a+UZzs4VU+/7SvusAWQEI7X7Ctuo9eYg==
X-Received: by 2002:a17:902:e747:b0:1eb:e1b:737a with SMTP id p7-20020a170902e74700b001eb0e1b737amr1013453plf.44.1714517432858;
        Tue, 30 Apr 2024 15:50:32 -0700 (PDT)
Received: from debian ([2601:641:300:14de:9960:3485:279e:a1e0])
        by smtp.gmail.com with ESMTPSA id w15-20020a170902e88f00b001eb6a881b88sm6776396plg.245.2024.04.30.15.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 15:50:32 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 30 Apr 2024 15:50:16 -0700
To: Dan Williams <dan.j.williams@intel.com>
Cc: dave.jiang@intel.com, Li Zhijian <lizhijian@fujitsu.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Convert cxl_pmem_region_alloc to scope-based
 resource management
Message-ID: <ZjF1qGFAl3dbMm5B@debian>
References: <171451430965.1147997.15782562063090960666.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171451430965.1147997.15782562063090960666.stgit@dwillia2-xfh.jf.intel.com>

On Tue, Apr 30, 2024 at 02:59:00PM -0700, Dan Williams wrote:
> A recent bugfix to cxl_pmem_region_alloc() to fix an
> error-unwind-memleak [1], highlighted a use case for scope-based resource
> management.
> 
> Delete the goto for releasing @cxl_region_rwsem, and return error codes
> directly from error condition paths.
> 
> The caller, devm_cxl_add_pmem_region(), is no longer given @cxlr_pmem
> directly it must retrieve it from @cxlr->cxlr_pmem. This retrieval from
> @cxlr was already in place for @cxlr->cxl_nvb, and converting
> cxl_pmem_region_alloc() to return an int makes it less awkward to handle
> no_free_ptr().
> 
> Cc: Li Zhijian <lizhijian@fujitsu.com>
> Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Closes: http://lore.kernel.org/r/20240430174540.000039ce@Huawei.com
> Link: http://lore.kernel.org/r/20240428030748.318985-1-lizhijian@fujitsu.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Hey Dave, this applies on top of Li's fix.
> 
>  drivers/cxl/core/region.c |   43 +++++++++++++++++--------------------------
>  1 file changed, 17 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 812b2948b6c6..e0577d99c4db 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2681,26 +2681,21 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
>  
>  static struct lock_class_key cxl_pmem_region_key;
>  
> -static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
> +static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_nvdimm_bridge *cxl_nvb;
> -	struct cxl_pmem_region *cxlr_pmem;
>  	struct device *dev;
>  	int i;
>  
> -	down_read(&cxl_region_rwsem);
> -	if (p->state != CXL_CONFIG_COMMIT) {
> -		cxlr_pmem = ERR_PTR(-ENXIO);
> -		goto out;
> -	}
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	if (p->state != CXL_CONFIG_COMMIT)
> +		return -ENXIO;
>  
> -	cxlr_pmem = kzalloc(struct_size(cxlr_pmem, mapping, p->nr_targets),
> -			    GFP_KERNEL);
> -	if (!cxlr_pmem) {
> -		cxlr_pmem = ERR_PTR(-ENOMEM);
> -		goto out;
> -	}
> +	struct cxl_pmem_region *cxlr_pmem __free(kfree) = kzalloc(
> +		struct_size(cxlr_pmem, mapping, p->nr_targets), GFP_KERNEL);
> +	if (!cxlr_pmem)
> +		return -ENOMEM;
>  
>  	cxlr_pmem->hpa_range.start = p->res->start;
>  	cxlr_pmem->hpa_range.end = p->res->end;
> @@ -2718,11 +2713,8 @@ static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
>  		 */
>  		if (i == 0) {
>  			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd);
> -			if (!cxl_nvb) {
> -				kfree(cxlr_pmem);
> -				cxlr_pmem = ERR_PTR(-ENODEV);
> -				goto out;
> -			}
> +			if (!cxl_nvb)
> +				return -ENODEV;
>  			cxlr->cxl_nvb = cxl_nvb;
>  		}
>  		m->cxlmd = cxlmd;
> @@ -2733,18 +2725,16 @@ static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
>  	}
>  
>  	dev = &cxlr_pmem->dev;
> -	cxlr_pmem->cxlr = cxlr;
> -	cxlr->cxlr_pmem = cxlr_pmem;
>  	device_initialize(dev);
>  	lockdep_set_class(&dev->mutex, &cxl_pmem_region_key);
>  	device_set_pm_not_required(dev);
>  	dev->parent = &cxlr->dev;
>  	dev->bus = &cxl_bus_type;
>  	dev->type = &cxl_pmem_region_type;
> -out:
> -	up_read(&cxl_region_rwsem);
> +	cxlr_pmem->cxlr = cxlr;
> +	cxlr->cxlr_pmem = no_free_ptr(cxlr_pmem);
>  
> -	return cxlr_pmem;
> +	return 0;
>  }
>  
>  static void cxl_dax_region_release(struct device *dev)
> @@ -2861,9 +2851,10 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>  	struct device *dev;
>  	int rc;
>  
> -	cxlr_pmem = cxl_pmem_region_alloc(cxlr);
> -	if (IS_ERR(cxlr_pmem))
> -		return PTR_ERR(cxlr_pmem);
> +	rc = cxl_pmem_region_alloc(cxlr);
> +	if (rc)
> +		return rc;
> +	cxlr_pmem = cxlr->cxlr_pmem;
>  	cxl_nvb = cxlr->cxl_nvb;
>  
>  	dev = &cxlr_pmem->dev;
> 

LGTM. 

Fan
