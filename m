Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E593017BD0
	for <linux-cxl@vger.kernel.org>; Sat, 13 Jan 2024 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjxIkuCg"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78350871784so57397485a.1
        for <linux-cxl@vger.kernel.org>; Sat, 13 Jan 2024 14:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705184233; x=1705789033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoQlO4MKUIvweMwdVro8g0ITgnHI1IyT1pBZzi+Gnv4=;
        b=GjxIkuCgmjRu00nG9Sa3xX7mmaBqq+njNtqPu1W7Agr0kGZTpEfNb9dc3qu1GTZTBy
         RM886mx2cHN+jYWEzZtvoXtox1u9plbIRMlxGkAJdqV7cS354tk2MFOjov612xFK/L3x
         ou2Lx17CHOEHyHAxoGH2bvEs1dI05LeuCYfTyhIDB06A+q/cVr1v7A6SZVBL31IYS3pl
         MZz3V7lHixjZiVRcgmqysCaigqxaBm4PvKfCGOPZlZFf6ipJMWRm2/Jw+UaqHedQdhvN
         eLY5HHFBohvKWuCgNNX1cP0W5DEwpPqI/4oa9oQRKX8bsZXh5Uo7E53GHg5eblqTsLMj
         UWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705184233; x=1705789033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PoQlO4MKUIvweMwdVro8g0ITgnHI1IyT1pBZzi+Gnv4=;
        b=xL3vGvuQz7t5L4rs2hLfcv5UEOYaFPtcITvENwL6ozedc576sitMeIoZ1tvmRYdjF/
         2KXlLgFHttVRkIadvKTEKQn6a2ZgW3AmwQfiNiSrIJVKRt5EeClXrXsxg5Rzli/+KUS6
         sg1wS+uLhcwG75Vw9ii4uvILmB1JggfoD28cRLPsSGuJ2x2CeHsC7mWC5oIpA7TJAWD3
         fG6H+0GCNtn+/6Z9IsrxUAiY9UhdGwTehRUw70z+tTfyLz74ibFEwWcA5czMdyo0ahUa
         Pr7XE6UYCV2gP4/9XUgYAY6yNwi5HEMutaL9TeIohZxmmOGUlpeCpLIHHZZLSKD//aBd
         s2LQ==
X-Gm-Message-State: AOJu0YxeZ4KcGjTyUfLKNvcOMq6SIlNTi/+AwMJlNA96wh3haUrKsKMS
	sXtw9W+M8f5SPYRPk91Tsj9W7WT5HPCi7vqiglTTkIv7h11wQw==
X-Google-Smtp-Source: AGHT+IHsK+p/V02eOSPdiecI6IrJhpKWVGzdV/UL9ZxwDqGmqwc2mYi/Sm/DUXLr0kD5qxnanSxnaoLLUWV4GrYzHxY=
X-Received: by 2002:a05:620a:1245:b0:783:2c23:271e with SMTP id
 a5-20020a05620a124500b007832c23271emr3929034qkl.138.1705184232667; Sat, 13
 Jan 2024 14:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111145905.19797-1-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240111145905.19797-1-Jonathan.Cameron@huawei.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Sat, 13 Jan 2024 17:16:59 -0500
Message-ID: <CAB=+i9SMSYHX_YTOOreJNikHiNmDxdPAuyBYPh_=1c97gjN55g@mail.gmail.com>
Subject: Re: [PATCH v2 qemu] hw/cxl/device: read from register values in mdev_reg_read()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org, 
	Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 9:59=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
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
> Link: https://lore.kernel.org/r/20231222090051.3265307-3-42.hyeyoo@gmail.=
com
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> --
>
> Hyeonggon - I've kept your sign-off. Let me know if this is ok.

Yeah, it's fine!

I either missed that it overwrites the mailbox capability register,
thank you so much for noticing. the new version looks fine to me.

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
> @@ -353,8 +356,10 @@ static inline void __toggle_media(CXLDeviceState *cx=
l_dstate, int val)
>  {
>      uint64_t dev_status_reg;
>
> -    dev_status_reg =3D FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val)=
;
> -    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] =3D dev_status_reg;
> +    dev_status_reg =3D cxl_dstate->memdev_status;
> +    dev_status_reg =3D FIELD_DP64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA=
_STATUS,
> +                                val);
> +    cxl_dstate->memdev_status =3D dev_status_reg;
>  }
>  #define cxl_dev_disable_media(cxlds)                    \
>          do { __toggle_media((cxlds), 0x3); } while (0)
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 61a3c4dc2e..40b619ffd9 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -229,12 +229,9 @@ static void mailbox_reg_write(void *opaque, hwaddr o=
ffset, uint64_t value,
>
>  static uint64_t mdev_reg_read(void *opaque, hwaddr offset, unsigned size=
)
>  {
> -    uint64_t retval =3D 0;
> -
> -    retval =3D FIELD_DP64(retval, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
> -    retval =3D FIELD_DP64(retval, CXL_MEM_DEV_STS, MBOX_READY, 1);
> +    CXLDeviceState *cxl_dstate =3D opaque;
>
> -    return retval;
> +    return cxl_dstate->memdev_status;
>  }
>
>  static void ro_reg_write(void *opaque, hwaddr offset, uint64_t value,
> @@ -371,7 +368,15 @@ static void mailbox_reg_init_common(CXLDeviceState *=
cxl_dstate)
>      cxl_dstate->mbox_msi_n =3D msi_n;
>  }
>
> -static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
> +static void memdev_reg_init_common(CXLDeviceState *cxl_dstate)
> +{
> +    uint64_t memdev_status_reg;
> +
> +    memdev_status_reg =3D FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, 1=
);
> +    memdev_status_reg =3D FIELD_DP64(memdev_status_reg, CXL_MEM_DEV_STS,
> +                                   MBOX_READY, 1);
> +    cxl_dstate->memdev_status =3D memdev_status_reg;
> +}
>
>  void cxl_device_register_init_t3(CXLType3Dev *ct3d)
>  {
> --
> 2.39.2
>
