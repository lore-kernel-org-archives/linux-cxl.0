Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F025E3BB27
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T8db90DDjz67FVn;
	Wed, 10 Jan 2024 01:44:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EFCE3140B2A;
	Wed, 10 Jan 2024 01:45:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Jan
 2024 17:45:51 +0000
Date: Tue, 9 Jan 2024 17:45:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>, "Michael
 S . Tsirkin" <mst@redhat.com>, <linux-cxl@vger.kernel.org>,
	<qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 2/4] hw/cxl/device: read from register values in
 mdev_reg_read()
Message-ID: <20240109174550.00000f6c@Huawei.com>
In-Reply-To: <20231222090051.3265307-3-42.hyeyoo@gmail.com>
References: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
	<20231222090051.3265307-3-42.hyeyoo@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 22 Dec 2023 18:00:49 +0900
Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:

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
> Fixes: commit 25a52959f99d ("hw/cxl: Add support for device sanitation")
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

I've applied this one to my tree.  (I'll push that out in a day or two after
tidying up some other outstanding stuff). 

Sometime in next week or so I'll send out a set bundling together various
fixes and cleanup with the intent for getting it applied.

Thanks,

Jonathan

> ---
>  hw/cxl/cxl-device-utils.c   | 17 +++++++++++------
>  include/hw/cxl/cxl_device.h |  4 +++-
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 29de298117..ba3f80e6e7 100644
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
> +    return cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
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
> +    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = memdev_status_reg;
> +}
>  
>  void cxl_device_register_init_t3(CXLType3Dev *ct3d)
>  {
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index b2cb280e16..b318d94b36 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -408,7 +408,9 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
>  {
>      uint64_t dev_status_reg;
>  
> -    dev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val);
> +    dev_status_reg = cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
> +    dev_status_reg = FIELD_DP64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS,
> +                                val);
>      cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = dev_status_reg;
>  }
>  #define cxl_dev_disable_media(cxlds)                    \

