Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA03B28FFE3;
	Wed,  7 May 2025 20:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746651035; cv=none; b=Rj7t5cA7bhpiNa7yHW+lIEyFMztQLjLDEM2Y6G47nwDeJeQMJgHIKOdRiRczFqDrIFP5jm9Z674Zy2oqfEYXR4TbFQI44Zjr5e/XEmtkUEZ08EFGHKnZXNc+Ky+xzD12xPIl16ZVzbSmid7jQ69yJay4gJEMrXbQIYWbsctcbMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746651035; c=relaxed/simple;
	bh=VVAUvEKOj4HzPswBGkWvbXVdFAWer/MiE6UZpiyua84=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSChpr6nMWidbxht0IZwXWEsSnPZp/+H1m4tCkoqx1YGYKTu+2qcDwXpaN5LLzmbg7CZyHJEYD1U+VMKd6vpumPj/xc+wTyLufQxowigw/pocIBR1o/Ko9mjWH+6AIU6fAWn429mOao72cupuX1/a4pjh6Z3HvTlNFOjINU1SLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8qwNE3b; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8qwNE3b"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e7297c3ce7aso307237276.0;
        Wed, 07 May 2025 13:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746651031; x=1747255831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NM4IVw9+0nh7z3R4MUSvKyjqgkfNUou+WJBeL6F7WaI=;
        b=N8qwNE3b6uVKHuQPtr+SJKWvHKakmXNdv7+TMZofqKDF6Jvpx75e+R3atTEQudm8yf
         6S3/KPxWZWCbrJt9RPFRcPAd+0rxmzLjxeWnC3kI30ITBtRS3TpK4epf7rVFmcCqYO/z
         nf/TmBsT/8+swNyflScchFuv+KMa7jteopFj+w9JWr/N5U8ZHV0QCWmd/ZPY1xSTGI49
         BjBDe0bU0GrSyXNT9IYZRkwOudeSuX/CXavaA8YE/fl7N/ycXRdaeRBk7vETZ8FqLKOF
         BIFAliLODGc66yli3cQo0mZWvlL/nIBbG58nTqy2sLDUx6l+dkwE6GO8UA0lzgC+hmPy
         XIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746651031; x=1747255831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NM4IVw9+0nh7z3R4MUSvKyjqgkfNUou+WJBeL6F7WaI=;
        b=aU0DUn+2nyi7kKYydWc4cfx9df06e4tp6t0+hnJ4+jR+pHN2fz4+GSZF6evUzEYuei
         3MCGoZwpwulmpp12OmkXpcbr9QMR+m6r2F/DSJwbp3zwMO2FCff3t4Pd3JMeN96ddd1j
         Mq5mo8tfJzTC7JDSu97QTb3MaBEiAGg1yYQ9eMuhUWeUK71S/2eY4QbtbZomdVZK5ydE
         U+tZnVoIYrvUU+1A6mSkK/JBY+KvxinstmiCz+Wa/AxtFGMWZKX5eTXJlNea+0mMyBtP
         VEeyC0rzCsyG8xrlrfjSYUsKa8yz+IsynBhQugRNxbjxZtLDqSR8Pz2lD/0KfiXnVzj5
         olHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKxiaJOWwZ8iLYgTDsvJTfuKZBYsc5B+tWJyyIuZjRiKkZIenQdBxgvaAWBiIY3kBs6AE/zq6O7cO5/OMq@vger.kernel.org, AJvYcCXn58kl0a1mY+gN2GF2hfNbuMzS8AJHnDyxKEcHUrVnmYtGXTnYRvFLnOcnZ+vWkdoUoa1Zdv5CHrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaC/rp0h95GwZwjVrIQduWAh6KVrG18bX3Z9KRx6NkzrjvdltY
	/ETFGwvIeRdQYYlCDGDxnsklJwOtoeS6rMfLXU02Q42qRtO5YcZX
X-Gm-Gg: ASbGncsbq7lmJxqEbaYpu5qDApIRpew+ozGYPTM7jW4dOP8PXwmP9s1e23oMEiR5ET2
	XFsfvtQLjj26bCz/ZlUowiPZkR06GOLJ/TckR4viLBqvfLZNczSlua8IykKvyflJlIOcNqHJvNx
	18TEOLOH+IMfRc/dlkPzxjgEaZfXPsXqMkdljzqITMjcJ4BdU1EJczJvSEC6bWBrWLA8xApIIoN
	udiWMkTuPo+4S/4VRhUcmkMPAmRDkN0f3Tft9JKi0bypmy/ylkBQ16Y647AKlO0z/Y5Bkl8yInt
	xsaH0HSvPUGvYP7Fb8Sw4IMm
X-Google-Smtp-Source: AGHT+IFlv62TQWmywdTvpNRB/hUPMt8yXEwE4S9/0ZxmW9Uoc6lzDYTUSgvknQqrQ8+kVJ31POV57g==
X-Received: by 2002:a05:6902:248d:b0:e73:520:ab49 with SMTP id 3f1490d57ef6-e78810e73c8mr6562863276.26.1746651031649;
        Wed, 07 May 2025 13:50:31 -0700 (PDT)
Received: from lg ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e78ee3f4c0dsm190768276.31.2025.05.07.13.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 13:50:31 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 7 May 2025 13:50:28 -0700
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 06/19] cxl/port: Add 'dynamic_ram_a' to endpoint
 decoder mode
Message-ID: <aBvHlE9QgxMZrfy4@lg>
References: <20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com>
 <20250413-dcd-type2-upstream-v9-6-1d4911a0b365@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250413-dcd-type2-upstream-v9-6-1d4911a0b365@intel.com>

On Sun, Apr 13, 2025 at 05:52:14PM -0500, Ira Weiny wrote:
> Endpoints can now support a single dynamic ram partition following the
> persistent memory partition.
> 
> Expand the mode to allow a decoder to point to the first dynamic ram
> partition.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
> Changes:
> [iweiny: completely re-written]
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 18 +++++++++---------
>  drivers/cxl/core/port.c                 |  4 ++++
>  2 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 2b59041bb410..b2754e6047ca 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -358,22 +358,22 @@ Description:
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/mode
> -Date:		May, 2022
> -KernelVersion:	v6.0
> +Date:		May, 2022, May 2025
> +KernelVersion:	v6.0, v6.16 (dynamic_ram_a)
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
>  		translates from a host physical address range, to a device
>  		local address range. Device-local address ranges are further
> -		split into a 'ram' (volatile memory) range and 'pmem'
> -		(persistent memory) range. The 'mode' attribute emits one of
> -		'ram', 'pmem', or 'none'. The 'none' indicates the decoder is
> -		not actively decoding, or no DPA allocation policy has been
> -		set.
> +		split into a 'ram' (volatile memory) range, 'pmem' (persistent
> +		memory), and 'dynamic_ram_a' (first Dynamic RAM) range. The
> +		'mode' attribute emits one of 'ram', 'pmem', 'dynamic_ram_a' or
> +		'none'. The 'none' indicates the decoder is not actively
> +		decoding, or no DPA allocation policy has been set.
>  
>  		'mode' can be written, when the decoder is in the 'disabled'
> -		state, with either 'ram' or 'pmem' to set the boundaries for the
> -		next allocation.
> +		state, with either 'ram', 'pmem', or 'dynamic_ram_a' to set the
> +		boundaries for the next allocation.
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 0fd6646c1a2e..e98605bd39b4 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -125,6 +125,7 @@ static DEVICE_ATTR_RO(name)
>  
>  CXL_DECODER_FLAG_ATTR(cap_pmem, CXL_DECODER_F_PMEM);
>  CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
> +CXL_DECODER_FLAG_ATTR(cap_dynamic_ram_a, CXL_DECODER_F_RAM);
>  CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
>  CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
>  CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
> @@ -219,6 +220,8 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
>  		mode = CXL_PARTMODE_PMEM;
>  	else if (sysfs_streq(buf, "ram"))
>  		mode = CXL_PARTMODE_RAM;
> +	else if (sysfs_streq(buf, "dynamic_ram_a"))
> +		mode = CXL_PARTMODE_DYNAMIC_RAM_A;
>  	else
>  		return -EINVAL;
>  
> @@ -324,6 +327,7 @@ static struct attribute_group cxl_decoder_base_attribute_group = {
>  static struct attribute *cxl_decoder_root_attrs[] = {
>  	&dev_attr_cap_pmem.attr,
>  	&dev_attr_cap_ram.attr,
> +	&dev_attr_cap_dynamic_ram_a.attr,
>  	&dev_attr_cap_type2.attr,
>  	&dev_attr_cap_type3.attr,
>  	&dev_attr_target_list.attr,
> 
> -- 
> 2.49.0
> 

-- 
Fan Ni
