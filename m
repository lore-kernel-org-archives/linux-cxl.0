Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E18E5F878
	for <linux-cxl@vger.kernel.org>; Tue, 13 Feb 2024 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841650; cv=none; b=EFtXYmyegBQ8SCpkFp6cgGtVsN3gne2tCPyjZ8jNfREk4YBejfi6aSBWCM33MZmCP7aPyPNvR+WdpiQLIdWWBMC8MGZNqHtSNToj/NWxiknL5U8bnS98PlspniKD940K7mfhXJH3PA8G8EHC+7BG90pHi2bnG1zq8H3aC2k4LDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841650; c=relaxed/simple;
	bh=F0/obdgzOhZk8qGNf9seH86RsYcHLmNo7icHPvIYZIU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVewedwkoa0xs5KVoaYr3ILotVFc7u7edv7hPV2CgGruqSky8gvTELoqU8DEGxvFwooR+zzeytM2tflyl9xMrBXBuX1ovEMMXUvokjstHTspHehC+/LsdYcXztb7eqh+Ti7zgXzoU1DWpzUBHKuORK+33hlaKjTXEHGkg+oc9KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZ67z2N7Zz67KQL;
	Wed, 14 Feb 2024 00:23:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 721B1140D1A;
	Wed, 14 Feb 2024 00:27:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 16:27:24 +0000
Date: Tue, 13 Feb 2024 16:27:23 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 1/2] hw/cxl/type3: add missing flag bit for GMER
Message-ID: <20240213162723.0000514f@Huawei.com>
In-Reply-To: <20240209115417.724638-2-ruansy.fnst@fujitsu.com>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
	<20240209115417.724638-2-ruansy.fnst@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri,  9 Feb 2024 19:54:11 +0800
Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> The "Volatile" should be set if current device is a volatile memory.
> Per CXL Spec r3.0 8.2.9.2.1.1, Table 8-43.

Whilst true, we haven't previously adjusted the injected record
to conform to the device.  I don't think there is anything preventing
you setting this bit in the dpa fields whilst injecting.

I'm not against filling this in automatically but we should be
masking the relevant bits out of what is injected and filling it in based
on the dpa that is provided and which memory that falls within.


> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  hw/mem/cxl_type3.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 52647b4ac7..d8fb63b1de 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1285,6 +1285,9 @@ static const QemuUUID memory_module_uuid = {
>                   0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
>  };
>  
> +#define CXL_GMER_DPA_VOLATILE                           BIT(0)
> +#define CXL_GMER_DPA_NOT_REPAIRABLE                     BIT(1)
> +
>  #define CXL_GMER_VALID_CHANNEL                          BIT(0)
>  #define CXL_GMER_VALID_RANK                             BIT(1)
>  #define CXL_GMER_VALID_DEVICE                           BIT(2)
> @@ -1348,6 +1351,9 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
>      cxl_assign_event_header(hdr, &gen_media_uuid, flags, sizeof(gem),
>                              cxl_device_get_timestamp(&ct3d->cxl_dstate));
>  
> +    if (ct3d->hostvmem) {
> +        dpa |= CXL_GMER_DPA_VOLATILE;
> +    }

The presence of volatile memory isn't sufficient.  You may have a device
with both volatile and persistent memory. It will get even fiddlier with
Dynamic Capacity which will need checking as well once that support is
ready.



>      stq_le_p(&gem.phys_addr, dpa);
>      gem.descriptor = descriptor;
>      gem.type = type;

