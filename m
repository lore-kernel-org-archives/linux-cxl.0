Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6C114D431;
	Tue, 23 Jul 2024 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721754052; cv=none; b=bEjAV3ozkrUi747TzLz2taScGpzhPTmi82ftXubUSfs7dhSoawU62arPR1oohY4PY4VH17K+JkOMJyiKVvIffnzE3WTs/lWQJoZfIo0yJgcOGLVrDgXDVnhpzk6zGusYxrs22xJJE1gkUg5fVwHx8PxQUOmFyQ2FLrU8qvxSXI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721754052; c=relaxed/simple;
	bh=iFGHrRa1AJpd3vUksRvo9/chRGhjVJipRgmSeu6mZTw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChMxPQZg77UnGd5axxkb5lZ2KiMzHIym0tb1Ugl+9JgI6TBmXTpSDfz/C+B+PlmlPQGEhP5hxCmBeTAZ7O2PR7yo0VDaSsO2lYd8qBmmuyeQY1UQu6QI5opPUpGP558Q+3uHMMyNhsVNTDcvumkdcOWSvh5YBFoi17bu3S241Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+ODue+w; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+ODue+w"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0857a11862so5257968276.1;
        Tue, 23 Jul 2024 10:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721754049; x=1722358849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWJZVKsTjOlmkxuJxxuw1YxCmrjhrUkB6LnBXgLWtjU=;
        b=D+ODue+wegHlM7RD45zpH4PKzHXhzhM/yTuTPRTsDd28DMm1kHPprLP1gqEQyvFpP8
         HCXE7eesleK9GrRZmdGKLEOz+tpQLeb4jdBC5dH2+nclpQEd3GAgDrJz3TuKqrC/YH9Y
         XH3U+raRuvEtr+uG0eJlV6ohB00663EeIOiwcLPPVAOnnTnw6nMIu9YEYYebUMMdU+Z3
         dV7ucwZ6cBThCoU2kPwTiKaZ3KwPooRqiQ75y9Datqth4xFr0JliuEb7nc12RIw191so
         Cgm42J/9m1SiuPjepZYaPl5cXaA6xTjSF5Egsguz9LxrWDLIwVdqYtuEqk10VPqPw0OB
         zstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721754049; x=1722358849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWJZVKsTjOlmkxuJxxuw1YxCmrjhrUkB6LnBXgLWtjU=;
        b=lE/x3tx8oZqnEED1GXyzMVKBF1U+J2ns2+tjh1mdW5+TWe23nCmNMqTUgFPoMDrMAf
         9xJK5xUbPIoUAAxnRdV/HY3ytZX6TGD9GED6w9r5Do1NsRaNRP5gb7xc156gjDnxFMGh
         QOXo0RcxfhgW1soCtTpSm1cgGzAx3xCRASkmiiVXFwvTmQAcHat6nUiMs5Vp1+EDohKu
         ukmzh2ahx/zkCHBFBRnph23bGUud9M8SykxLGPfgZ4FhXvdb+WK53O90jcHhYhak825I
         wBv/wic3J+HUmellqGf4aK/veCOBny36i8wyZlb/EEkY6OFBzPMxkl5ZKe53TnE1BHjL
         m5yA==
X-Forwarded-Encrypted: i=1; AJvYcCUujfNJb/mzGImc903vejBYd1dFpUywxYEESrnXdZcML+zGVOb0Mxmlxk3/4dYfKP8g62pzqVrzMcFmhb2CnMEA0VzLFBm1r+G/gkHexnR/WnvWlQFYtQr52IzoX1pLeqfniV50/53x
X-Gm-Message-State: AOJu0Yxgon8d1xar/THi5os565Fk8yJhhA169/H/2Eg+10fkiIxjo24B
	6Vxv6D+9uV8p8nSnPtmU1YEuF8OkKR61oUZlpTitjwVSCQFTF/zR
X-Google-Smtp-Source: AGHT+IGIjD6wNy3JDyYcWxCKOqG4sXHYKOI4GVAHxO1DR0/dqcCY+wqTyan38FlrIecnroLRmveF6w==
X-Received: by 2002:a25:d086:0:b0:e02:50f2:784d with SMTP id 3f1490d57ef6-e0b0972a64amr572746276.21.1721754042357;
        Tue, 23 Jul 2024 10:00:42 -0700 (PDT)
Received: from gpd ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e086096a347sm1944336276.1.2024.07.23.10.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 10:00:42 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@gpd>
Date: Tue, 23 Jul 2024 10:00:15 -0700
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bharata B Rao <bharata@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 1/3] cxl/region: Fix a race condition in memory
 hotplug notifier
Message-ID: <Zp_hn8ExJEXeVGtb@gpd>
References: <20240618084639.1419629-1-ying.huang@intel.com>
 <20240618084639.1419629-2-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618084639.1419629-2-ying.huang@intel.com>

On Tue, Jun 18, 2024 at 04:46:37PM +0800, Huang Ying wrote:
> In the memory hotplug notifier function of the CXL region,
> cxl_region_perf_attrs_callback(), the node ID is obtained by checking
> the host address range of the region. However, the address range
> information is not available when the region is registered in
> devm_cxl_add_region(). Additionally, this information may be removed
> or added under the protection of cxl_region_rwsem during runtime. If
> the memory notifier is called for nodes other than that backed by the
> region, a race condition may occur, potentially leading to a NULL
> dereference or an invalid address range.
> 
> The race condition is addressed by checking the availability of the
> address range information under the protection of cxl_region_rwsem. To
> enhance code readability and use guard(), the relevant code has been
> moved into a newly added function: cxl_region_nid().
> 
> Fixes: 067353a46d8c ("cxl/region: Add memory hotplug notifier for cxl region")
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/region.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3c2b6144be23..51aeef2c012c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2304,14 +2304,25 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>  	return true;
>  }
>  
> +static int cxl_region_nid(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_decoder *cxld;
> +
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	cxled = p->targets[0];
> +	if (!cxled)
> +		return NUMA_NO_NODE;
> +	cxld = &cxled->cxld;
> +	return phys_to_target_node(cxld->hpa_range.start);
> +}
> +
>  static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>  					  unsigned long action, void *arg)
>  {
>  	struct cxl_region *cxlr = container_of(nb, struct cxl_region,
>  					       memory_notifier);
> -	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_endpoint_decoder *cxled = p->targets[0];
> -	struct cxl_decoder *cxld = &cxled->cxld;
>  	struct memory_notify *mnb = arg;
>  	int nid = mnb->status_change_nid;
>  	int region_nid;
> @@ -2319,7 +2330,7 @@ static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
>  	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
>  		return NOTIFY_DONE;
>  
> -	region_nid = phys_to_target_node(cxld->hpa_range.start);
> +	region_nid = cxl_region_nid(cxlr);
>  	if (nid != region_nid)
>  		return NOTIFY_DONE;
>  
> -- 
> 2.39.2
> 
