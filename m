Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D772F213E82
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738690983; cv=none; b=Og0WUrhqKWrb/uZrwVIbxpFSC7lFn6SBgjMQr6CRip5HWYRjVum8kVZ11cr2bfyorewFbGks6mD4ipjpAwm8DJ6axm/CQa9VHDZHtSbq1FI7RDtNMWBAneAmYe3k65rmTHaxP7ADCQD3jE8GuQ62tfVOY9HW4iAGjyI5LVYvydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738690983; c=relaxed/simple;
	bh=hK5LsfTFZQdI6v6Hfh3t+MlwcyTGsOJDAJ9j/UJjVms=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D55GXO6eF3gF/q7G2LHZkra4GlPK+v56LdffMjwHbKUKxc+cdQsWPEpkRmW0kv/4SJI3895lvFCKD3ye9LkdNafESQXbolettzC6p2/ODD4mdNbB/d70Zx8xwwDsKRTQF9tFArkAGdhAfZJZLqPo/YDtFYKuf1rGX9Mx6dtBEG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0uthQKI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0uthQKI"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21654fdd5daso103161295ad.1
        for <linux-cxl@vger.kernel.org>; Tue, 04 Feb 2025 09:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738690981; x=1739295781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=syKKlyHhY5uxCetz4jcpWcX/DWAWeYF7DAULQ0B9EoM=;
        b=l0uthQKIVtqYhGmq70hGwcMc4Wv+YMGCcjw4lTPW65QxIxBW/ZlotKjzaIM5IslAja
         tK7zISuFWah7n2LrKrmDz7EJ1aOnU4J9uI3X5XXX9XFXYbH+7XOAw2iRrCXWJKPI0h60
         eslX6MN366l9GZk3vMHW/h1JHU3Fq61JlbuWAaVGvuA7rLvUmh+AgSOeN2jhDzzxF9Qm
         cpR5QCH8LbXSvVCp5JqTrQDRZaFMH7Rs50gj/YXf/eGaPEI3oWr2USeKA64Ha5fyGFKW
         LCcfpjfnUrcFmQ3ohlv9TpoYN2WDaT9xGZOpbH1amY05f/ALdSoxJj9ubc77AlQRWz3Y
         eqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738690981; x=1739295781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syKKlyHhY5uxCetz4jcpWcX/DWAWeYF7DAULQ0B9EoM=;
        b=twRyTwgaTon8IftjByBdh1pmLn7+no9OE3YHtpY6HE3Pj4mBVsVcqpLBs0F5PQ86Gd
         GVORPiodZ+wJCggAUtMGuCJh+arZLSphM6u25E5aXfk86UE/I3giVvX30G+6eiUyBhPL
         1X8ruaEFK5mBa0rlxGNhzSAWoiq9Wy95IEHSnYfCAnH27uaLx3UMewbvPUWXNgWH8EI5
         2+Kg4Xw9zZK8GraAKLePwBSGGTXI1Kq6r4lyaagmPTad+vCookYP2wQ7Fwf3w236WJCG
         64HAe3ibeENk659i3Dxf6USli0JenVkNwk2syzHxk8AQXMZZ2QUE34dJM9lm+DlpTJqc
         9o0w==
X-Gm-Message-State: AOJu0YzNAffZTadq4qW48mSvnIZXCgxeQCWqUFavWLrPUKjdWX4bRMiM
	P6bPg6ia/WvzwLn0hsl6pcNMZtVADN2VyjdMs0A+bPFcGE8HZra9
X-Gm-Gg: ASbGncvyH4letuuPXGnlXxIiLSUSlKSrI94etB1s1wpHA8uZHCBxTh7GdSo9lHoLRj0
	gFuht8ZwpNriKIoZvbGQvcW05NZu+27j/dyR8FGUVUGPMSi0LWhQ7VoawAGRTuZS0/+2agNgshj
	t4meUYdkyPuhwIGuRiCHAObBWKifpCnl35D6fn/a+C+Pd4ImmMnJgS8/h1T4wKRgzk7ci9iNeJr
	gpYKcZPd+46Ygj8tayfKwkMNy/4+VsKvH0z4ehB/jZiE/N2Dwr6Y+Ec3xLNzCr6efennRY0ohqw
	pjgF
X-Google-Smtp-Source: AGHT+IEmsUgvSHy4gl58cq0UrUNMyayrIGLuwlpZ0II9pgsOzsyIGfi+66SGIHpRxMKElciWPgZK0A==
X-Received: by 2002:a17:903:166d:b0:215:acb3:3786 with SMTP id d9443c01a7336-21dd7c4e940mr412828565ad.19.1738690980929;
        Tue, 04 Feb 2025 09:43:00 -0800 (PST)
Received: from fan ([2601:646:8f03:9fee:3af:557f:e46f:e624])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de33032dbsm99058425ad.191.2025.02.04.09.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:43:00 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 4 Feb 2025 09:42:56 -0800
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alejandro Lucero <alucerop@amd.com>,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 1/6] cxl: Remove the CXL_DECODER_MIXED mistake
Message-ID: <Z6JRoGZGGpxVr9wJ@fan>
References: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
 <173864304660.668823.17000888505587850279.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173864304660.668823.17000888505587850279.stgit@dwillia2-xfh.jf.intel.com>

On Mon, Feb 03, 2025 at 08:24:06PM -0800, Dan Williams wrote:
> CXL_DECODER_MIXED is a safety mechanism introduced for the case where
> platform firmware has programmed an endpoint decoder that straddles a
> DPA partition boundary. While the kernel is careful to only allocate DPA
> capacity within a single partition there is no guarantee that platform
> firmware, or anything that touched the device before the current kernel,
> gets that right.
> 
> However, __cxl_dpa_reserve() will never get to the CXL_DECODER_MIXED
> designation because of the way it tracks partition boundaries. A
> request_resource() that spans ->ram_res and ->pmem_res fails with the
> following signature:
> 
>     __cxl_dpa_reserve: cxl_port endpoint15: decoder15.0: failed to reserve allocation
> 
> CXL_DECODER_MIXED is dead defensive programming after the driver has
> already given up on the device. It has never offered any protection in
> practice, just delete it.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  drivers/cxl/core/hdm.c    |    6 +++---
>  drivers/cxl/core/region.c |   12 ------------
>  drivers/cxl/cxl.h         |    4 +---
>  3 files changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 50e6a45b30ba..b7f6a2d69f78 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -332,9 +332,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	else if (resource_contains(&cxlds->ram_res, res))
>  		cxled->mode = CXL_DECODER_RAM;
>  	else {
> -		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
> -			 port->id, cxled->cxld.id, cxled->dpa_res);
> -		cxled->mode = CXL_DECODER_MIXED;
> +		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
> +			 port->id, cxled->cxld.id, res);
> +		cxled->mode = CXL_DECODER_NONE;
>  	}
>  
>  	port->hdm_end++;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e8d11a988fd9..34aa3d45fafa 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2738,18 +2738,6 @@ static int poison_by_decoder(struct device *dev, void *arg)
>  	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
>  		return rc;
>  
> -	/*
> -	 * Regions are only created with single mode decoders: pmem or ram.
> -	 * Linux does not support mixed mode decoders. This means that
> -	 * reading poison per endpoint decoder adheres to the requirement
> -	 * that poison reads of pmem and ram must be separated.
> -	 * CXL 3.0 Spec 8.2.9.8.4.1
> -	 */
> -	if (cxled->mode == CXL_DECODER_MIXED) {
> -		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
> -		return rc;
> -	}
> -
>  	cxlmd = cxled_to_memdev(cxled);
>  	if (cxled->skip) {
>  		offset = cxled->dpa_res->start - cxled->skip;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index bbbaa0d0a670..9fd1524ed150 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -380,7 +380,6 @@ enum cxl_decoder_mode {
>  	CXL_DECODER_NONE,
>  	CXL_DECODER_RAM,
>  	CXL_DECODER_PMEM,
> -	CXL_DECODER_MIXED,
>  	CXL_DECODER_DEAD,
>  };
>  
> @@ -390,10 +389,9 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
>  		[CXL_DECODER_NONE] = "none",
>  		[CXL_DECODER_RAM] = "ram",
>  		[CXL_DECODER_PMEM] = "pmem",
> -		[CXL_DECODER_MIXED] = "mixed",
>  	};
>  
> -	if (mode >= CXL_DECODER_NONE && mode <= CXL_DECODER_MIXED)
> +	if (mode >= CXL_DECODER_NONE && mode < CXL_DECODER_DEAD)
>  		return names[mode];
>  	return "mixed";
>  }
> 

-- 
Fan Ni
