Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F027A12C532
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706139710; cv=none; b=MrGfz1PNk4LdS42Zm2ZSksSdu8qB6YcBfhc86HvAxSIWHD4HERwW78O8DZX70PyCDyADrMr5L7sNb+qjnlTmGwgyDR2FyEQvgG4gMo5Urv1UrAe1UbldxUCbv5feqzK3SGDwTa7FtX38IZMh207kXZ1VO0x7VMdpc6eb4eJAjo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706139710; c=relaxed/simple;
	bh=LpBL0RPlQQQaC4a9aXLqQH66BTb9ohcbpcrS3jXko9c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=If1+eJ0XbSMhesg3+A6+meia1JkbUvapL2G8Vi5tUd/juW7XfRPvtlJZRAFxmHnz98HyZU659ycfh6dH1e40eQDqpvk2u+nQWM2PtGt/80iFKHxj88O6G8W/OoHf8t0RGxaYO/7rXugAPcFGa8tn4xxx8FsXQd0uf1jzxI1gPvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0JwJS1P; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0JwJS1P"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6db0fdd2b8fso3214317b3a.2
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 15:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706139708; x=1706744508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gaSatxmH+joCu/w8PnCw+KneNZItml6/XeGG6dTffFY=;
        b=f0JwJS1PXFplOu++WlC/K0Tu9p9fP0CHKFLFzTM072gVYlcAYdqQNBdZYtGOmpBtP4
         ICgP478EplJclnvVsuOt73Y4Gp5ct+itiHunWoZo9en5Co2NZKyxNn3yWoSp/z3nKJEB
         6E+m0MY0CLcp0yu8aUHXCawKMr1z9rnIJNAM25IvR2sDoPfrH7A1R37yB35j50cvGWWz
         EnOj3ylgzvLB+9jHPx5r7j0qjQe19zWkwyEm0x86LgeYwGGoKv/mlgWIGWnV0RXcup/X
         bxHJZowgwMVMR2JZpAoOBj+9nl1xQM2Qg3iHiSYdCSWOcEQ3Z7dp6ZJ0g3FcPp59/m3V
         hXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706139708; x=1706744508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaSatxmH+joCu/w8PnCw+KneNZItml6/XeGG6dTffFY=;
        b=FzKBtnCRSRPKJJyZ6E9hFwWNYVyeBPRaehg2u4RusB4HknTpOJLgJjyJV1tK5p+3c0
         MlYIhATpeuFunfNVQznAfPwLSu+2u9DBxeKW249wgSCVPiEB1PGetAddLvMmHHK4s96K
         /J4fC9fWDOUPACl8UdqtzNehgAAPD/2OnoSTpYwDl5lRku/NcpN6kTws7GFky1OVQrQ9
         h5UUs9yepd/wW4FJHencblEEAOeACbmfnnSV0I1BmmFBr7H/G7wzX/Jp/gq2NXtzcNHU
         52OIBNqm8l5BHExVG20I6KFST+7QZJJ9oaRv/o5psIYQOGv7eOFXuBK1k4i6/0Y2vaTs
         pn3Q==
X-Gm-Message-State: AOJu0YwFp76lejZjvscxRnxU9+B2SnZqy9EteuUyVs7bccydM90brSe/
	AhD4o2dhjv7CPjyQ5gONmWMcyVpnfiqCXMrfqg2dnsnKzYhOMuNI
X-Google-Smtp-Source: AGHT+IHVe9lTVakJVs+F5MIJosRAJv06fJmfY4gFLfd0qojOcZiL4TdrioGI5uwOyIKDgl47EPPBxA==
X-Received: by 2002:a05:6a00:2194:b0:6d9:ac99:316b with SMTP id h20-20020a056a00219400b006d9ac99316bmr358593pfi.50.1706139708121;
        Wed, 24 Jan 2024 15:41:48 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
        by smtp.gmail.com with ESMTPSA id i3-20020aa78b43000000b006d9be279432sm14352504pfd.2.2024.01.24.15.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 15:41:47 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 15:41:45 -0800
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
Subject: Re: [PATCH 05/12] hw/cxl/mbox: Remove dead code
Message-ID: <ZbGgOR1zTEp17_F7@debian>
References: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
 <20240124124100.8218-6-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124124100.8218-6-Jonathan.Cameron@huawei.com>

On Wed, Jan 24, 2024 at 12:40:53PM +0000, Jonathan Cameron wrote:
> From: Davidlohr Bueso <dave@stgolabs.net>
> 
> Two functions were reported to have dead code, remove the bogus
> branches altogether, as well as a misplaced qemu_log call.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  hw/cxl/cxl-mailbox-utils.c | 43 +++++++++++++-------------------------
>  1 file changed, 15 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 6eff56fb1b..dc42850767 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1001,15 +1001,8 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
>  
>      cxl_dev_disable_media(&ct3d->cxl_dstate);
>  
> -    if (secs > 2) {
> -        /* sanitize when done */
> -        return CXL_MBOX_BG_STARTED;
> -    } else {
> -        __do_sanitization(ct3d);
> -        cxl_dev_enable_media(&ct3d->cxl_dstate);
> -
> -        return CXL_MBOX_SUCCESS;
> -    }
> +    /* sanitize when done */
> +    return CXL_MBOX_BG_STARTED;
>  }
>  
>  static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
> @@ -1387,27 +1380,21 @@ static void bg_timercb(void *opaque)
>  
>          cci->bg.complete_pct = 100;
>          cci->bg.ret_code = ret;
> -        if (ret == CXL_MBOX_SUCCESS) {
> -            switch (cci->bg.opcode) {
> -            case 0x4400: /* sanitize */
> -            {
> -                CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> -
> -                __do_sanitization(ct3d);
> -                cxl_dev_enable_media(&ct3d->cxl_dstate);
> -            }
> +        switch (cci->bg.opcode) {
> +        case 0x4400: /* sanitize */
> +        {
> +            CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +
> +            __do_sanitization(ct3d);
> +            cxl_dev_enable_media(&ct3d->cxl_dstate);
> +        }
> +        break;
> +        case 0x4304: /* TODO: scan media */
> +            break;
> +        default:
> +            __builtin_unreachable();
>              break;
> -            case 0x4304: /* TODO: scan media */
> -                break;
> -            default:
> -                __builtin_unreachable();
> -                break;
> -            }
>          }
> -
> -        qemu_log("Background command %04xh finished: %s\n",
> -                 cci->bg.opcode,
> -                 ret == CXL_MBOX_SUCCESS ? "success" : "aborted");
>      } else {
>          /* estimate only */
>          cci->bg.complete_pct = 100 * now / total_time;
> -- 
> 2.39.2
> 
