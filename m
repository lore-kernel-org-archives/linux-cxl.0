Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1262522EEB
	for <linux-cxl@vger.kernel.org>; Mon, 13 Nov 2023 23:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2EBaEg6"
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3F5D48
	for <linux-cxl@vger.kernel.org>; Mon, 13 Nov 2023 15:14:08 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-4af5ea40b7bso947626e0c.2
        for <linux-cxl@vger.kernel.org>; Mon, 13 Nov 2023 15:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699917247; x=1700522047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhShDJzQQW9QIQOfcf+fc8sG3b5kDEZDTPLHNIis7gI=;
        b=Y2EBaEg66A4p422uexN0NIFzcY7AKEekZGrJaEhUxGG/9Q/WMvCk2awxJ4Ski97NKI
         DiKOb8zbQUCq+zBw3QWp6ZyH53hLTCB8ZjlP+iZh+kv/e/XnhcWus0Tw2ACp1qJw3xdT
         sf37JtwoQWsKnmlSGGWUiLn16qjFfdLs4uAKEiRNBubs3gM1rAuz+gM7Rck4rJxaehyT
         fs0FmkZlWb5a1eBfsa8pvyth7aHMLfo4NcZvMUaFhD3q9YezaEJvTTx30bp7k3WgyTlx
         WF60Rlik7T7UgwAzCsLzlAqJIjK8PQRO6ikU0LHZCoH2eRWbvYRvntdlTtuE+nGAUJRW
         PkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699917247; x=1700522047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhShDJzQQW9QIQOfcf+fc8sG3b5kDEZDTPLHNIis7gI=;
        b=i6YsUPoqY4A51KKA3b9eUVOwFTfcSNc8IyAVtMpFnn/NQuzYagTqpyqUGaqKaoe1v1
         gHlLeyHM+N8iGMsn6mjFVN70S21HuXoHaYSM7rIQD3oLCyNCLUt4MgNx3tM0fOizmvU3
         FNcLQEHklCe5su4ppmM2yhl/FyUeMUwOGeBiOnWDXYJ66wos8yM59lHtJsQnkQ6FQyPN
         Z852eRU3ckupPLsLuCzhBze3svk0bFGV3EQznBajLfwTn5ab0/bZWvgGU3/ZMAI6ZmDG
         zDaaWbh8rhgVawNUwugWexwDETGBQvR4etCIQwnAhBFva61pwqd3QWGQtXLBVtXLxBGE
         e/RQ==
X-Gm-Message-State: AOJu0YyMTTjxFEPevrT5KKsdFxlfdCni6YWeFyDxabnwzZYqWw8Z/9Rw
	3HVvAAB3boq9s1+8wfOezD2MY26sUIimTP76IrA=
X-Google-Smtp-Source: AGHT+IEb9wazkprNN1f0rb5OY12kboYafKPwTAd7cPjvBSmnb3HjY2ges0UJw1sp9U0uw2LF0evw4WM+P0/S6QuOq2A=
X-Received: by 2002:a05:6122:1d13:b0:49a:36e4:5565 with SMTP id
 gc19-20020a0561221d1300b0049a36e45565mr8559174vkb.16.1699917246997; Mon, 13
 Nov 2023 15:14:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023160806.13206-1-Jonathan.Cameron@huawei.com> <20231023160806.13206-14-Jonathan.Cameron@huawei.com>
In-Reply-To: <20231023160806.13206-14-Jonathan.Cameron@huawei.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Tue, 14 Nov 2023 08:13:55 +0900
Message-ID: <CAB=+i9T3YUkU1L_yoJHiRkzQsUv0aJLLCrNb2ajLVGLh7mKe1g@mail.gmail.com>
Subject: Re: [PATCH v2 13/17] hw/cxl: Add support for device sanitation
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, 
	Michael Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, linuxarm@huawei.com, 
	Fan Ni <fan.ni@samsung.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Gregory Price <gregory.price@memverge.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Klaus Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 1:14=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> From: Davidlohr Bueso <dave@stgolabs.net>
>
> Make use of the background operations through the sanitize command, per C=
XL
> 3.0 specs. Traditionally run times can be rather long, depending on the
> size of the media.
>
> Estimate times based on:
>          https://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/hw/cxl/cxl_device.h |  17 +++++
>  hw/cxl/cxl-mailbox-utils.c  | 140 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |  10 +++
>  3 files changed, 167 insertions(+)
>
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 2a813cdddd..70aca9024c 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -343,6 +343,23 @@ REG64(CXL_MEM_DEV_STS, 0)
>      FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
>      FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
>
> +static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
> +{
> +    uint64_t dev_status_reg;
> +
> +    dev_status_reg =3D FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val)=
;
> +    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] =3D dev_status_reg;
> +}
> +#define cxl_dev_disable_media(cxlds)                    \
> +        do { __toggle_media((cxlds), 0x3); } while (0)
> +#define cxl_dev_enable_media(cxlds)                     \
> +        do { __toggle_media((cxlds), 0x1); } while (0)

Before this patch, it is assumed that "Media Status" and "Mailbox
Interface Ready" were always 1,
thus mdev_reg_read() always returns 1 for both of them regardless of
register values.

I think changes like below are needed as now the assumption is broken?
Please note that it's only build-tested :)

Thanks,
Hyeonggon

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 61a3c4dc2e..b6ada2fd6a 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -229,12 +229,9 @@ static void mailbox_reg_write(void *opaque,
hwaddr offset, uint64_t value,

 static uint64_t mdev_reg_read(void *opaque, hwaddr offset, unsigned size)
 {
-    uint64_t retval =3D 0;
-
-    retval =3D FIELD_DP64(retval, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
-    retval =3D FIELD_DP64(retval, CXL_MEM_DEV_STS, MBOX_READY, 1);
+    CXLDeviceState *cxl_dstate =3D opaque;

-    return retval;
+    return cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
 }

 static void ro_reg_write(void *opaque, hwaddr offset, uint64_t value,
@@ -371,7 +368,13 @@ static void
mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
     cxl_dstate->mbox_msi_n =3D msi_n;
 }

-static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
+static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) {
+    uint64_t memdev_status_reg;
+
+    memdev_status_reg =3D FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
+    memdev_status_reg =3D FIELD_DP64(memdev_status_reg,
CXL_MEM_DEV_STS, MBOX_READY, 1);
+    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] =3D memdev_status_reg;
+}

 void cxl_device_register_init_t3(CXLType3Dev *ct3d)
 {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 61b7f897f7..61f8f83ddf 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -351,9 +351,9 @@ REG64(CXL_MEM_DEV_STS, 0)

 static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
 {
-    uint64_t dev_status_reg;
+    uint64_t dev_status_reg =3D cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV=
_STS];

-    dev_status_reg =3D FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val);
+    dev_status_reg =3D FIELD_DP64(dev_status_reg, CXL_MEM_DEV_STS,
MEDIA_STATUS, val);
     cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] =3D dev_status_reg;
 }
 #define cxl_dev_disable_media(cxlds)                    \
