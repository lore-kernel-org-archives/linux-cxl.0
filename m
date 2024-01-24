Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9294E12A15D
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120777; cv=none; b=KMjgsLSt7YuT7FnfJ2lvw9rkJ4y8VJk4tnLfamAznZBKp456EM4Yqh2t1+qAt18y7d2I5lD2zTeQSDIWNJyTkLG4azogmvno/RfW2yNNBgx8uIQLhpwHH/ZmR15qrW512vdU7l4NXaoMqhxraV2qZsOChcPT5vmInPPT9huNfUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120777; c=relaxed/simple;
	bh=H07EuRSvvvT4cxUcjQkyydLqC8ttjfCIDkEO7/9jr1g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cN9H27ifnHDSuyDQKguyg9ub4xUJxZT2yWYUGIgh2CHbZnyhSJtAzm6g0AFc6E7vncJ/CCr+8O0HxUQx+wYUeLdz5NTNVAlLxn4YcoYzvrPukPvJK+xEE70ImEgi2GYnMSTUvv1LwG6CIs+C8VU2Hi4dW+WVrbw3q52eQ8ZzWpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxZr+uMG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxZr+uMG"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d746856d85so22338755ad.0
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 10:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706120775; x=1706725575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C4yZxOJffiW/TvBI4CtO7xaQ0Fri7dVAm/5G1HU++eU=;
        b=fxZr+uMGHhrx6SOUwg0vXJyV1yGX03p3g4R03h6H0fpTja1YGOZCdzQ1ySiKBKgjNj
         hOBiM5EebQ6Bv+WuGBQEhG6EVemVu1z744482VGBOpINHy0u6+LmPAzPThDZhCTJu7mc
         Gk7KBfA6NKrmOiljJm81g/V00OIj6sSl7dcNFO2Sc4YPV69hHxBiaf+xw53ks1KFQh13
         +XpX3/ApN/ukk4XWfnx8QCg87fSXBncBfXFDW0/BQOxmVyVRvnwimdooxRTiUSlAUNOu
         kq8Gm0MF8UpzNOA8f6RCd3CHjDNa8Ye6/SLhNycmf90YGLXJSMtjVx58I+yyMEP6k4fm
         1vhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120775; x=1706725575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4yZxOJffiW/TvBI4CtO7xaQ0Fri7dVAm/5G1HU++eU=;
        b=VS/Ek0HalyVAflqanvgcVk1IJE/ZY1XO+FnR3bBVWWh1lmcgdGExSVnmAjNa8pBvTW
         4YVTmNGQvVSvOvdTsBdLgo0hQesOLZV9uM+cTmCEimy0NAzdrnHSnbL2zQVOFuroQVSb
         7sKIKIszyKNrIEl4d89/NYuEhMN2E1uNW/w1LFxgZKPwBHONuhrEFlErpovb25oDFhN7
         ItYADUKNRUF/HmFBZveWx/dpMeJvX/c1Sq4TPlVXXJlfrwID7j6OFdgpDX97zrK0O/Eu
         JiogdFkc9ZnYVO6dCjFoGA8Il/F2Mw8FAhPqsc76P2/mJB5KpkT9CMVW0/oPqVuVrKa0
         +XYA==
X-Gm-Message-State: AOJu0YxF4ISjjRfC75gNzROLcfNChgKcpAPIk6bcLka2gUYeiugpW+Yf
	S9b/4ITvmemptY+aEk3c+KSEowvAdmPZP14FfRVFt4smYLIW1yc9
X-Google-Smtp-Source: AGHT+IG+8Ttg6fWlzmaQGo3N6weH119gLL2JY4A3Ep74ZZdpNQVK98VGuAJC3lBV7mAu1+Rcxd/tKA==
X-Received: by 2002:a17:903:32c4:b0:1d7:1df6:4505 with SMTP id i4-20020a17090332c400b001d71df64505mr1178689plr.30.1706120774742;
        Wed, 24 Jan 2024 10:26:14 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902d64400b001d7465c213bsm5869238plh.197.2024.01.24.10.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:26:14 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 10:26:11 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linuxarm@huawei.com,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 3/5] hw/cxl: Update RAS Capability Definitions for
 version 3.
Message-ID: <ZbFWQ1rEOZ8LUXh9@debian>
References: <20240124134814.8717-1-Jonathan.Cameron@huawei.com>
 <20240124134814.8717-4-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124134814.8717-4-Jonathan.Cameron@huawei.com>

On Wed, Jan 24, 2024 at 01:48:12PM +0000, Jonathan Cameron wrote:
> Part of bringing all of CXL emulation inline with CXL r3.1.
> No functional changes.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/hw/cxl/cxl_component.h | 5 ++++-
>  hw/cxl/cxl-component-utils.c   | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index 2c7631bd1e..b5da72b789 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -60,8 +60,9 @@ CXLx_CAPABILITY_HEADER(SNOOP, 0x14)
>   * implements. Some of these are specific to certain types of components, but
>   * this implementation leaves enough space regardless.
>   */
> -/* 8.2.5.9 - CXL RAS Capability Structure */
>  
> +/* CXL r3.1 Section 8.2.4.17: CXL RAS Capability Structure */
> +#define CXL_RAS_CAPABILITY_VERSION 3
>  /* Give ample space for caps before this */
>  #define CXL_RAS_REGISTERS_OFFSET 0x80
>  #define CXL_RAS_REGISTERS_SIZE   0x58
> @@ -95,6 +96,8 @@ REG32(CXL_RAS_COR_ERR_STATUS, CXL_RAS_REGISTERS_OFFSET + 0xc)
>  REG32(CXL_RAS_COR_ERR_MASK, CXL_RAS_REGISTERS_OFFSET + 0x10)
>  REG32(CXL_RAS_ERR_CAP_CTRL, CXL_RAS_REGISTERS_OFFSET + 0x14)
>      FIELD(CXL_RAS_ERR_CAP_CTRL, FIRST_ERROR_POINTER, 0, 6)
> +    FIELD(CXL_RAS_ERR_CAP_CTRL, MULTIPLE_HEADER_RECORDING_CAP, 9, 1)
> +    FIELD(CXL_RAS_ERR_POISON_ENABLED, POISON_ENABLED, 13, 1)
>  REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
>  #define CXL_RAS_ERR_HEADER_NUM 32
>  /* Offset 0x18 - 0x58 reserved for RAS logs */
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index a55cf5a036..848bfa20f1 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -325,7 +325,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
>                         CXL_##reg##_REGISTERS_OFFSET);                         \
>      } while (0)
>  
> -    init_cap_reg(RAS, 2, 2);
> +    init_cap_reg(RAS, 2, CXL_RAS_CAPABILITY_VERSION);
>      ras_init_common(reg_state, write_msk);
>  
>      init_cap_reg(LINK, 4, 2);
> -- 
> 2.39.2
> 
