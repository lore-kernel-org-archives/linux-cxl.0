Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F275A12C532
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 23:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706140295; cv=none; b=fvq+qGEzsc/OZtUJM07QcDoN6sHGvm5qeH+kspvaVp/Fb7mB7CLa/yGLd6iuojIbnRkCTqaJpOZMDTU/4ywFKTS2kqHc/nFRA3e7NlF+XNnQQfgbEAiPeJVJi2/cp7HUstckmAU+CUaunqwIa1dg6NceO5vh21aH/iEXQfpGQ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706140295; c=relaxed/simple;
	bh=ax1BE9/Ebd+ikv+ObSQXnkh/+RCkLYDa4RIIrVpA5ls=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uut+f1KNDJ+al+9SslHMPjSJTYCgW1LVgXRlEGJ+Q0Ah9UOqm8NC3zKwPlBvjoJYSJ+jAsGnsA+u2/iwY877C0DPW/fa0LZ0cHhTrU0liUq2zCNfL6rkpPAYY2Uip2n0uv5xE0ItOGcwwimejxvXOQKs/rALos4F3OJU0Y+hxEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTnts41x; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTnts41x"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d7431e702dso29834675ad.1
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 15:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706140293; x=1706745093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KYzTic2jRsgywGr1ttQI+Aww2cwwhruAURzwniXtwKk=;
        b=RTnts41xVksy/D552B0sw35z8191VZzycL20lVjY9fk9g1inA4sV/omHNGVGZf+Dgl
         Oyy27SR6ulQOIt9Qk84zRai4HhR5iW6iGE85ZRKrZdd7NZkYeVm1i8rf2OZHjMDMn8Kb
         RuQsIJ8rX3gKTgyPIGiDnUIO3DwThhGo5Ql8x4T+jbwctYpKeZojPgZpDn//Tak4cHHx
         +xu7LPvd2Ek3SgbJebRSQE0QBdR7z5g3tKE7Cah11WiaqJXgwmfVrU3tLEbdF+NxE0hp
         INRnkOxA5OKmU3xSUsIq6BHu/k5Ku9Q+TbMbYhna5SVcSIuS1AzhliFJy9H9udgKe9J9
         4gOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706140293; x=1706745093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYzTic2jRsgywGr1ttQI+Aww2cwwhruAURzwniXtwKk=;
        b=AT932e8ABn6Q+XFFbayESyI3bjqBxkcn3Fbl1+sR/T3xU+1S2oqhpWlc7zqSggnr4X
         CIojQQwb8OXxhO7HvEMCMDKJ4x8CVXwT64Mqxpdq2tLnQjKM2KnFyg+r2YgRKBHUUEwv
         GsTfnpcFCOp89VQuiZYiSTKwUEyiy7ii/T3IlZmFTINfVtWnG+9RNxMbP7ZTr91p3NM+
         4PYXZH+oZlGg+IIacoQREVKaGZNw8bSrJpkts+YD8a8vjF6clrZgqWiwqCFInB6zXAaM
         +bfT8sP8XQFyVDuko1hOOjORkvGE7RFLcCsqLxLnZXBS53YyZJj4khig+oTmDbIL5ysG
         tpIw==
X-Gm-Message-State: AOJu0YzIgIfUr5eoFJQuPgZWbaQ/+3cbuKl9ma2SbKxHvR4f3N9exN6s
	RRqIuREP1yVm1nUg8FWXLq8a11O9Xxi5R1wKVSXJmQvhuO7/tOlp
X-Google-Smtp-Source: AGHT+IG6eQZrsqh/a2qdic52mZp9UwTKi9IL1hqrBRngvYk9a/N7/I2GqBYdJTSI7v0ZvLmut+zmNQ==
X-Received: by 2002:a05:6a20:42a1:b0:19a:4f9b:3bf0 with SMTP id o33-20020a056a2042a100b0019a4f9b3bf0mr259226pzj.0.1706140293095;
        Wed, 24 Jan 2024 15:51:33 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902b70500b001d74c285b55sm5803504pls.67.2024.01.24.15.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 15:51:32 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 15:51:30 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
	Dave Jiang <dave.jiang@intel.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Stefan Hajnoczi <stefanha@gmail.com>, linuxarm@huawei.com,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 08/12] hw/cxl: Pass NULL for a NULL MemoryRegionOps
Message-ID: <ZbGigs0ymWgjB0Lm@debian>
References: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
 <20240124124100.8218-9-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124124100.8218-9-Jonathan.Cameron@huawei.com>

On Wed, Jan 24, 2024 at 12:40:56PM +0000, Jonathan Cameron wrote:
> From: Li Zhijian <lizhijian@fujitsu.com>
> 
> a NULL parameter is enough for a NULL MemoryRegionOps
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-component-utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 9dfde6c0b3..5ddd47ed8d 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -197,7 +197,7 @@ void cxl_component_register_block_init(Object *obj,
>                         CXL2_COMPONENT_BLOCK_SIZE);
>  
>      /* io registers controls link which we don't care about in QEMU */
> -    memory_region_init_io(&cregs->io, obj, NULL, cregs, ".io",
> +    memory_region_init_io(&cregs->io, obj, NULL, NULL, ".io",
>                            CXL2_COMPONENT_IO_REGION_SIZE);
>      memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cxl_cstate,
>                            ".cache_mem", CXL2_COMPONENT_CM_REGION_SIZE);
> -- 
> 2.39.2
> 
