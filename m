Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB68C136662
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 23:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706140443; cv=none; b=kNLMXFg7AerxzJzBjqLib3hbhlOoxFU6KnnDBWbUhsMEgUkwtXxYUZoFS0w3Fnyw9oiA6uz+2wDSI60wBrIFGcrkeE9TOLtWNZ9xu6/NvT8swl6jHEbPYog2U6iksI8W5e2OoXJtoBo00APM263XuWVV0AqaeU6MuvtiBK1+668=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706140443; c=relaxed/simple;
	bh=ZPzgneeNKpX1M4YY7NcUxYJUNg71+XEnrhrzh666Wzo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joRo0J7HtU3MB/o0Iy6OumPHFiq1yVYjWEBXsNzb3WKru4/LVGyUg/50zM+/h9uJ9/158P9DE1zfkSAFWlc5vODzEdFtAdf2sn3RZB3dA65HlSD+Fq47Dk8dQm1CuRXH1sFzT6an4Zz9t1KOWR4ZagoDXSHHcoD2wHhxE8O74Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1EnbWmJ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1EnbWmJ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29080973530so3522720a91.1
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 15:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706140441; x=1706745241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u7pyltUvzVFGZNAZxa7Mlyt8rLeSRqqjX7xnAHcOcr0=;
        b=N1EnbWmJi04RYVA3ghTEB47mtLZLocjD/vP77no4pSlClsaUwFLU9fLIjxR3QWkC+z
         IBgJL5CPm02HPpC+ly3N7Oi8Y6KXSIW/wrNjEyNAWSg/oQNkcMKOSHyjW16A/HygzxCb
         icCpLXrcQi89yeDyBwowG/z1wVslwlPyy4I/BisrY21LMWE3YaC1cxDAPAR2v9Jo4JgK
         sarMw0lm5lCfmAwpyDTfzNG6hVPOfiLw6Zd6Nzp0jMKAde6Y2c738AXSw0A9/vo5lumT
         ojo2sQ597QUN7BzD0+EanHBlOtJZLVXUiTFgNB3JnRDbLw6fp1xXXfaoqSonuno/4kuP
         Cd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706140441; x=1706745241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7pyltUvzVFGZNAZxa7Mlyt8rLeSRqqjX7xnAHcOcr0=;
        b=vwRWt0Hx5iUnoscHWlPoYmwhLkRRLxwHfu+PyFxMRfIfT1+TiXY+KHSs2ko6Eb0Ygb
         VcPnEUtLyLB71uBDoiJDue13UxEDwTtMRssPcTyCcaX6T3fOvA8R+fZUJ4OoN4uaPVU0
         rUVHbzSApOwjjBPozN2LOeg1cl/OhgFX5SlKsBxo2WqyJhrnXct7JHJsRcD8/EBL3Per
         IFWIzeeSZn8JQNt6xgsJGG5L4T3SS629tW71CewztgF/2Iyalx9WstJGsK8vv6nwgf0O
         iwX1K2jgU1r49UCf1D+xzSL4jSMxojNPQ2si8TndICODWTKkEqV+p3VL6aW1FpkcNSGh
         5oXw==
X-Gm-Message-State: AOJu0YxSh8J9xGq4uokqVp7nq2vXO4NEqwKxucDpudsjkcy92Vdbt4IL
	ZRMtBw7FI2KQk6yeioR/RLSKd1uWLUv06dsPQm6NI56235nTy5JS
X-Google-Smtp-Source: AGHT+IFfj7f5Cyb6ETziKXIhjRTeU0iGmtCXi0SIOWtQmIrz+8FhPfXpWgpY72O9mvFbjBNwkOTT4Q==
X-Received: by 2002:a17:90a:880a:b0:290:172f:3b1b with SMTP id s10-20020a17090a880a00b00290172f3b1bmr104708pjn.98.1706140441160;
        Wed, 24 Jan 2024 15:54:01 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
        by smtp.gmail.com with ESMTPSA id iz1-20020a170902ef8100b001d72358de29sm8848933plb.287.2024.01.24.15.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 15:54:00 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 15:53:58 -0800
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
Subject: Re: [PATCH 09/12] hw/mem/cxl_type3: Fix potential divide by zero
 reported by coverity
Message-ID: <ZbGjFiKKPhC_uiOF@debian>
References: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
 <20240124124100.8218-10-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124124100.8218-10-Jonathan.Cameron@huawei.com>

On Wed, Jan 24, 2024 at 12:40:57PM +0000, Jonathan Cameron wrote:
> Fixes Coverity ID 1522368.
> 
> Currently error_fatal is set if interleave_ways_dec() is going to return 0
> but we should handle that zero return explicitly.
> 
> Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
> Note this is a stop gap until a more complex HDM decoder verification series.
> ---
>  hw/mem/cxl_type3.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 1b92a065a3..24211703c6 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -794,8 +794,12 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
>          }
>          if (((uint64_t)host_addr < decoder_base) ||
>              (hpa_offset >= decoder_size)) {
> -            dpa_base += decoder_size /
> -                cxl_interleave_ways_dec(iw, &error_fatal);
> +            int decoded_iw = cxl_interleave_ways_dec(iw, &error_fatal);
> +
> +            if (decoded_iw == 0)
> +                return false;
> +
> +            dpa_base += decoder_size / decoded_iw;
>              continue;
>          }
>  
> -- 
> 2.39.2
> 
