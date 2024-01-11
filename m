Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428383A1B7
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jan 2024 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF4bTtd/"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d9bba6d773so5157464b3a.1
        for <linux-cxl@vger.kernel.org>; Thu, 11 Jan 2024 15:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705015019; x=1705619819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RNPCSOWv/u1Jtplu9z7EWUMPQ6AEzJHAYRX1DmebeZA=;
        b=VF4bTtd/eW30E+j14wKVSNDiGKl+x+AUrF/JmIRgaxv4fzPpofBFvqeJ7Q5YpWLVzG
         un+rggKJWboVDhiY8Mdz0ssr2yWvN6gQXuKK7zKNEoQailfP6ponXYkAA1satKKspldd
         939jKUIBZcTcsYefOrmxbufLn6nDdZNbX8X2zncDs3A34EnorvavvyjOEM72lYRW4E1V
         HuVhIBwcugt7Hof1jLhj8FB50X7CY1ZEOP76GpMxuYS/qU3lHq6DpoMahEX2ECwo8Rd4
         QO4Q4ECJn3KrmEvDF4ynKTJrHVhDXA43//ExsikMkFunl940QxR8pEu/fcpPObAoxgaW
         xXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705015019; x=1705619819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNPCSOWv/u1Jtplu9z7EWUMPQ6AEzJHAYRX1DmebeZA=;
        b=MBcE6UMpOro0ZrCeqzGb+vnonUorWMtWCwBhvWyOIShJb1F5Fa6/B/dyT2J82eyI+b
         8raFDdplphmtJeilEIITBnCV3SG5GlgjO4pod0JNuxNgmCDS2ZeSt5pnDWK/dDwL4Oqe
         dvz0y3DXHA+fa1AJCV6PusuV02gDxf15aW9wk3USthdTqAjlUA8NeXdGDbT5UzeDlLL1
         UAib4X1VEYEavlZcmU9x9EwgHaYmMXVmBr+SLdhGW4L0GCH2fx6jJ1XxjTMI1Of78gXt
         4XBtneuMm0fhAH4VNs+miu3oG9S/Pe8+fSA4I5TjGVc5lceEx2B/lJ+cRbIGqBrxLrlU
         I8bw==
X-Gm-Message-State: AOJu0YzzyFmQ+IC/wJElhPqmTduAv7L6IoQLKssIXXJhBNllnAodtXcN
	++p4fTpAiiVVT692R9/B/7Y=
X-Google-Smtp-Source: AGHT+IHv5O/5kI6GqoB6sQ2gkZAPNz0D6rhBhuYsr+xFddwJuBDeJ0R5aKFjCR//yTg9ONQp0ylmjg==
X-Received: by 2002:a62:ce83:0:b0:6d9:8453:e040 with SMTP id y125-20020a62ce83000000b006d98453e040mr73888pfg.1.1705015019397;
        Thu, 11 Jan 2024 15:16:59 -0800 (PST)
Received: from debian (c-71-202-83-215.hsd1.ca.comcast.net. [71.202.83.215])
        by smtp.gmail.com with ESMTPSA id y187-20020a62cec4000000b006dab86e675esm1798768pfg.185.2024.01.11.15.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 15:16:58 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 11 Jan 2024 15:16:42 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Fan Ni <fan.ni@samsung.com>,
	linuxarm@huawei.com
Subject: Re: [PATCH v2 qemu] hw/cxl/device: read from register values in
 mdev_reg_read()
Message-ID: <ZaB22v-pqAYFfJMS@debian>
References: <20240111145905.19797-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111145905.19797-1-Jonathan.Cameron@huawei.com>

On Thu, Jan 11, 2024 at 02:59:05PM +0000, Jonathan Cameron wrote:
> From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> In the current mdev_reg_read() implementation, it consistently returns
> that the Media Status is Ready (01b). This was fine until commit
> 25a52959f99d ("hw/cxl: Add support for device sanitation") because the
> media was presumed to be ready.
> 
> However, as per the CXL 3.0 spec "8.2.9.8.5.1 Sanitize (Opcode 4400h)",
> during sanitation, the Media State should be set to Disabled (11b). The
> mentioned commit correctly sets it to Disabled, but mdev_reg_read()
> still returns Media Status as Ready.
> 
> To address this, update mdev_reg_read() to read register values instead
> of returning dummy values.
> 
> Note __toggle_media() was overwriting the mailbox capability
> register, but nothing was reading that after this so that bug had no
> obvious effect unless the driver was reloaded.
> 
> Fixes: commit 25a52959f99d ("hw/cxl: Add support for device sanitation")
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Link: https://lore.kernel.org/r/20231222090051.3265307-3-42.hyeyoo@gmail.com
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> --
> 
> Hyeonggon - I've kept your sign-off. Let me know if this is ok.
> Dropped RBs etc as this has changed quite a bit.
> 
> I plan to send out a group of fixes including this soon, but given
> I've been pointing out the original fix didn't work thought I'd send
> this one out for early review!
> 
> ---
>  include/hw/cxl/cxl_device.h |  9 +++++++--
>  hw/cxl/cxl-device-utils.c   | 17 +++++++++++------
>  2 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index befb5f884b..31d2afcd3d 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -202,6 +202,9 @@ typedef struct cxl_device_state {
>          };
>      };
>  
> +    /* Stash the memory device status value */
> +    uint64_t memdev_status;
> +
>      struct {
>          bool set;
>          uint64_t last_set;
> @@ -353,8 +356,10 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
>  {
>      uint64_t dev_status_reg;
>  
> -    dev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val);
> -    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = dev_status_reg;
> +    dev_status_reg = cxl_dstate->memdev_status;
> +    dev_status_reg = FIELD_DP64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS,
> +                                val);
> +    cxl_dstate->memdev_status = dev_status_reg;
>  }
>  #define cxl_dev_disable_media(cxlds)                    \
>          do { __toggle_media((cxlds), 0x3); } while (0)
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 61a3c4dc2e..40b619ffd9 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -229,12 +229,9 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
>  
>  static uint64_t mdev_reg_read(void *opaque, hwaddr offset, unsigned size)
>  {
> -    uint64_t retval = 0;
> -
> -    retval = FIELD_DP64(retval, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
> -    retval = FIELD_DP64(retval, CXL_MEM_DEV_STS, MBOX_READY, 1);
> +    CXLDeviceState *cxl_dstate = opaque;
>  
> -    return retval;
> +    return cxl_dstate->memdev_status;
>  }
>  
>  static void ro_reg_write(void *opaque, hwaddr offset, uint64_t value,
> @@ -371,7 +368,15 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
>      cxl_dstate->mbox_msi_n = msi_n;
>  }
>  
> -static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
> +static void memdev_reg_init_common(CXLDeviceState *cxl_dstate)
> +{
> +    uint64_t memdev_status_reg;
> +
> +    memdev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
> +    memdev_status_reg = FIELD_DP64(memdev_status_reg, CXL_MEM_DEV_STS,
> +                                   MBOX_READY, 1);
> +    cxl_dstate->memdev_status = memdev_status_reg;
> +}
>  
>  void cxl_device_register_init_t3(CXLType3Dev *ct3d)
>  {
> -- 
> 2.39.2
> 
