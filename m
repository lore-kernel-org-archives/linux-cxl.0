Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B881272DA
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119753; cv=none; b=sqBD43O4nUtOHP72WlZ3S6tqsCs7VyFUtuivyiawfMtibp+sixf7aYxdDA3rmvzAa1AlavMBEex5r+R7NTdW104OM49a1mO07FdW4aT8oq0IrBhlv9NMzpwiKS6Tp20LoSDDsl+VJyfTUKeaDmcNRR6yZlWMV4D6jcbqlgpyr6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119753; c=relaxed/simple;
	bh=aJLM85TYHnoN0BN0e600v+pVzyFMYu76zd8ULNGvxFU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrXyqozZWR51guaAhEjsDlrqFe5jycDmSw4mW+x/w2U3UACOB5hUkTKjfzurlQtgxzAMAtcC9i5vd0Kdcy4o8Gv9RVl5bLUstrWGrcVCa/KvejUfeCXpc/XtdFWgxH5KTYW1U8dJw7+2s+pLP2NmATZdWP/V1pAUqva+X+cUUvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVnvoQO6; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVnvoQO6"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so968931a12.3
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 10:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706119751; x=1706724551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hhadsUTDszaOgv4nbkvtCwW/W6GdDZinn9LINS1tLz4=;
        b=XVnvoQO6pn8n8ToKHNMLZMiy8Q1TvFbv2ypsgMHeVDkIDpCM2ufbrknyoHVxWQRul1
         uYSI3e+WZ8zC+bJWuRp01G/z54YrvmHOGiPZsm5aNVLIz4qrmZQ+OFUqgtMFccEaTwj5
         bD5bcwLpUDmFZfTG/sds+d46hF6oU2Sgfi52NiBSEWqencUaiN10C8TXeA6Bn5qF9gET
         WWH/XfGUY52FyCfWl2ZOnSvw5m6GZQnmRiIC/dFLoLNldhXyY990VDiOjH0zINm/Vd6s
         9+fJ8+zatNehnvKMX+foRDsDJIKg1kv0TCxDaA5wFCnpeyhMjJS541Glv345syeUadHx
         w8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706119751; x=1706724551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhadsUTDszaOgv4nbkvtCwW/W6GdDZinn9LINS1tLz4=;
        b=TIPnXqHwVZQE8vsMEkmhnwPZhRxBiDU0yv9rJv2oIAq5TK7NwCZ3Fmtc8q7IsUeIdd
         mbvpAmVST+6hGdKLY0IJ5rMcc6cUEQ2/cK6G+83GgBziYOU0MZcUY1nYZz7l2QKYxdEt
         1+Q8u8ueMig0gL+tyryQY3EClWQg5b5m2xtACRvrQPIjo6xCSgzPl9vpzlLLyBtdZaOY
         p7AJfteDIC+48T2RQorkx8Wmgyw/Y3bgQsbGy1ug25H/EB5GHIseANshvtshGEZf/hU0
         /nhokNj9XgKIapf8+xxnrwUOWFilXCusQLA65jnLJ7v+CRB5VYCGF4sodcRqfvbM9XcD
         J0kA==
X-Gm-Message-State: AOJu0YzPAgq6yFYfQwdyMrtf2hFo0pejT7mBaAaJhqNHuyKoqceUWXUf
	oGGQucdw4PJnq8lgOpCzksBrfNRZ5OaoPYUSnvcLreedanzgcnit
X-Google-Smtp-Source: AGHT+IGGTFyU9LI7CxgLzI60Jb//l0sAUlHKejdVbua4DcMmVOM+AqKIz/hxmZV2pm1h027V6bUstA==
X-Received: by 2002:a05:6a21:789a:b0:19c:6383:c404 with SMTP id bf26-20020a056a21789a00b0019c6383c404mr935101pzc.12.1706119751150;
        Wed, 24 Jan 2024 10:09:11 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
        by smtp.gmail.com with ESMTPSA id ey9-20020a056a0038c900b006d70b0d4639sm14160191pfb.107.2024.01.24.10.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:09:10 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 10:08:50 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linuxarm@huawei.com,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/5] hw/cxl: Update HDM Decoder capability to version 3
Message-ID: <ZbFSMtnkEug8q_6Q@debian>
References: <20240124134814.8717-1-Jonathan.Cameron@huawei.com>
 <20240124134814.8717-2-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124134814.8717-2-Jonathan.Cameron@huawei.com>

On Wed, Jan 24, 2024 at 01:48:10PM +0000, Jonathan Cameron wrote:
> Part of standardizing the QEMU code on CXL r3.1.
> No fuctional changes as everything added is optional and
> it is set as not implemented.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/hw/cxl/cxl_component.h | 16 ++++++++++++++--
>  hw/cxl/cxl-component-utils.c   | 10 +++++++++-
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index 5227a8e833..7d3edef1bf 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -109,8 +109,9 @@ REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
>      (CXL_SEC_REGISTERS_OFFSET + CXL_SEC_REGISTERS_SIZE)
>  #define CXL_LINK_REGISTERS_SIZE   0x38
>  
> -/* 8.2.5.12 - CXL HDM Decoder Capability Structure */
> -#define HDM_DECODE_MAX 10 /* 8.2.5.12.1 */
> +/* CXL r3.1 Section 8.2.4.20: CXL HDM Decoder Capability Structure */
> +#define HDM_DECODE_MAX 10 /* Maximum decoders for Devices */
> +#define CXL_HDM_CAPABILITY_VERSION 3
>  #define CXL_HDM_REGISTERS_OFFSET \
>      (CXL_LINK_REGISTERS_OFFSET + CXL_LINK_REGISTERS_SIZE)
>  #define CXL_HDM_REGISTERS_SIZE (0x10 + 0x20 * HDM_DECODE_MAX)
> @@ -133,6 +134,11 @@ REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
>              FIELD(CXL_HDM_DECODER##n##_CTRL, COMMITTED, 10, 1)                 \
>              FIELD(CXL_HDM_DECODER##n##_CTRL, ERR, 11, 1)                       \
>              FIELD(CXL_HDM_DECODER##n##_CTRL, TYPE, 12, 1)                      \
> +            FIELD(CXL_HDM_DECODER##n##_CTRL, BI, 13, 1)                        \
> +            FIELD(CXL_HDM_DECODER##n##_CTRL, UIO, 14, 1)                       \
> +            FIELD(CXL_HDM_DECODER##n##_CTRL, UIG, 16, 4)                       \
> +            FIELD(CXL_HDM_DECODER##n##_CTRL, UIW, 20, 4)                       \
> +            FIELD(CXL_HDM_DECODER##n##_CTRL, ISP, 24, 4)                       \
>    REG32(CXL_HDM_DECODER##n##_TARGET_LIST_LO,                                   \
>          CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x24)                          \
>    REG32(CXL_HDM_DECODER##n##_TARGET_LIST_HI,                                   \
> @@ -148,6 +154,12 @@ REG32(CXL_HDM_DECODER_CAPABILITY, CXL_HDM_REGISTERS_OFFSET)
>      FIELD(CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_256B, 8, 1)
>      FIELD(CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 9, 1)
>      FIELD(CXL_HDM_DECODER_CAPABILITY, POISON_ON_ERR_CAP, 10, 1)
> +    FIELD(CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 11, 1)
> +    FIELD(CXL_HDM_DECODER_CAPABILITY, 16_WAY, 12, 1)
> +    FIELD(CXL_HDM_DECODER_CAPABILITY, UIO, 13, 1)
> +    FIELD(CXL_HDM_DECODER_CAPABILITY, UIO_DECODER_COUNT, 16, 4)
> +    FIELD(CXL_HDM_DECODER_CAPABILITY, MEMDATA_NXM_CAP, 20, 1)
> +    FIELD(CXL_HDM_DECODER_CAPABILITY, SUPPORTED_COHERENCY_MODEL, 21, 2)
>  REG32(CXL_HDM_DECODER_GLOBAL_CONTROL, CXL_HDM_REGISTERS_OFFSET + 4)
>      FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, POISON_ON_ERR_EN, 0, 1)
>      FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, HDM_DECODER_ENABLE, 1, 1)
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 5ddd47ed8d..a55cf5a036 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -243,6 +243,14 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_4K, 1);
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
>                       POISON_ON_ERR_CAP, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> +                     UIO_DECODER_COUNT, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, MEMDATA_NXM_CAP, 0);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
> +                     SUPPORTED_COHERENCY_MODEL, 0); /* Unknown */
>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
>                       HDM_DECODER_ENABLE, 0);
>      write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
> @@ -326,7 +334,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
>          return;
>      }
>  
> -    init_cap_reg(HDM, 5, 1);
> +    init_cap_reg(HDM, 5, CXL_HDM_CAPABILITY_VERSION);
>      hdm_init_common(reg_state, write_msk, type);
>  
>      if (caps < 5) {
> -- 
> 2.39.2
> 
