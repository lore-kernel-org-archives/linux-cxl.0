Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A292913541D
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 23:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706139969; cv=none; b=DdRW+xzjGzIDvO3AtWsCkC6IlQXuWE8w/rQ2T65gezJPKV8xmj4+XcdYHlC5H8orUa+tZqhqsr3nqBPtKPSpiy/9V1o2wGvzEJLQENxXT8wSPm8jPNdKd7Qw6+he9VC012RNJUn6YC7i+iU2Q1RvJtDB1JCdRozUw2PkYulgyFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706139969; c=relaxed/simple;
	bh=ZisvUykrTsawXu1FTI3O4WURgN3hdTzOwuUOhetVzZw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qx7mZrYzGxE6NW4unfDrqQkfC2KacVp2NsDTy9qxzHnRZLi3MpKY6vgiNTGP5lW0Cg8bzBFbxF9YpGjPubA/fO8fkflXwqpRHd4wrsvAk2sWDQD0Oq4BGrSMYCrUPmMyWyfoVL1zfnQXSIYU49jH2bd63pc3pX/J+gkjD1CWmc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBqXRgN5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBqXRgN5"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ddc1fad6ddso721880b3a.0
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 15:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706139967; x=1706744767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=he2KEP2HM2IJJa5SoOBxLONvQh8hQtu1DQYEA4eCTE0=;
        b=KBqXRgN5QKTct8/QI9jejViqkZcwTOQH3rQM985sQQJEtlsmGDinAVXRSOY8IWzVgd
         Yol+mBWkGoHWcRkDYju2raD/xJSLd6mIA3yzctrSt0lOCiY9qzpfv+4b4be+zhhGa5SZ
         edNpd/pzrTArGgGBlUzoTKpnbnDOzpmXTUD0yLXoKtiMlNKlow93A8IsIp1qHKPtTN7F
         lpepP7SAYtOyc+YXS0KKyu2sTP4UIKloqEJva/OB7hj0PjCEj0nZvJM9JMm3G2qMQNCb
         zWcggzpuf5z8RNXiqKvGzdlNYu1SRTDB0W0KudZE0U6ckjf43sxsyGvwBc5DhFiTdUUg
         ZfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706139967; x=1706744767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=he2KEP2HM2IJJa5SoOBxLONvQh8hQtu1DQYEA4eCTE0=;
        b=ZqQUZ4f23n32m5i0u67DEt3vyj97z4++ocCvcmDYhstsyl1ZRZqCnn+aqJHzwEqC/a
         RKaZNJeA2l4I5M5Vhen0Pq9EVV3fKG23tZVTWwidFSkPI1cS1rV65GnGaSyNFxFtD4lp
         9hxMB2+AqAVYB2lsn6fzHpFejTY9NYs5W+CJzaZi9A4RVmWIKfU1/SQTL1sb6E0hK6As
         pASot4kBusoDCKj1RM4lwG7rEy/J6FReDo7yJGXpERET++45oiyARWAzUHhTP7YAWWyT
         Ff+yin0Plat7b5oD+jEq+x6EXAgw76Uzph/8MKLEq/WRsEI1fqTWNDkKsu1zu0viej3T
         1oWQ==
X-Gm-Message-State: AOJu0Yyna23Mzx6OGWzOFJB0hXvEp9rNtSW+x6EGjdGRgjkUG1+xuEhL
	7DM4twgU1XS2GtaYjiggvsWSdDzM/tKJs0QTlJCzCP6jBxNew69S
X-Google-Smtp-Source: AGHT+IEFp2stuPVEumm3xFBOnpfpRQTE1qiBs/EKyk20iJhoJG/Rgqut73EXKM7vZ31fzH2XWMKWFg==
X-Received: by 2002:a05:6a00:3499:b0:6da:9ab2:d933 with SMTP id cp25-20020a056a00349900b006da9ab2d933mr7400pfb.20.1706139966904;
        Wed, 24 Jan 2024 15:46:06 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
        by smtp.gmail.com with ESMTPSA id fk19-20020a056a003a9300b006db87354a8fsm14260226pfb.119.2024.01.24.15.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 15:46:06 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 15:46:04 -0800
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
Subject: Re: [PATCH 07/12] hw/cxl: Pass CXLComponentState to cache_mem_ops
Message-ID: <ZbGhPIfJgzWlnsDS@debian>
References: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
 <20240124124100.8218-8-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124124100.8218-8-Jonathan.Cameron@huawei.com>

On Wed, Jan 24, 2024 at 12:40:55PM +0000, Jonathan Cameron wrote:
> From: Li Zhijian <lizhijian@fujitsu.com>
> 
> cache_mem_ops.{read,write}() interprets opaque as
> CXLComponentState(cxl_cstate) instead of ComponentRegisters(cregs).
> 
> Fortunately, cregs is the first member of cxl_cstate, so their values are
> the same.
> 
> Fixes: 9e58f52d3f8 ("hw/cxl/component: Introduce CXL components (8.1.x, 8.2.5)")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  hw/cxl/cxl-component-utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 29d477492b..9dfde6c0b3 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -199,7 +199,7 @@ void cxl_component_register_block_init(Object *obj,
>      /* io registers controls link which we don't care about in QEMU */
>      memory_region_init_io(&cregs->io, obj, NULL, cregs, ".io",
>                            CXL2_COMPONENT_IO_REGION_SIZE);
> -    memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cregs,
> +    memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cxl_cstate,
>                            ".cache_mem", CXL2_COMPONENT_CM_REGION_SIZE);
>  
>      memory_region_add_subregion(&cregs->component_registers, 0, &cregs->io);
> -- 
> 2.39.2
> 
