Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6543715CD75
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jul 2024 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790266; cv=none; b=iNv8U7uWV0Dj9Dbgj2A1w1krTr9uBOD/vjt2rqtYBddL6JPggyYgzrggsXSX+KDW7MQlipJeyk5fpsvKqvss55bnw7M0cg+MCfzBJJxEcKGrQrXbnn8y7Fvr6AXMKENIq13JblODwYDwwLbj6LXTzQNGO5cFI0QClis7j+aSJVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790266; c=relaxed/simple;
	bh=lUaXoOmbpmUi3gzbBfBsgp2SU+aVfv19+wFXU4IfF3Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0+B3qIV1bBqyChRSalwwziQhSabtS4e4vzKMqHJWP1CwvI0GsCjgrspPArDrq2ESxZiQJZXimObfBl6e20ua9FSKDamuX52zeEr9xhEMwQ209GZqi+2xJ6go+lPpVx12GqZCJn5/AAZ1sWm6TSzG2KK0ZEnJylvab4Qk5ABQHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WLBtc2zChz67ClN;
	Fri, 12 Jul 2024 21:16:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 89A59140C72;
	Fri, 12 Jul 2024 21:17:40 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Jul
 2024 14:17:38 +0100
Date: Fri, 12 Jul 2024 14:17:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>,
	<linuxarm@huawei.com>
CC: <shiju.jose@huawei.com>, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v6 4/4] hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS
 control feature
Message-ID: <20240712141723.000067d8@huawei.com>
In-Reply-To: <20240705123039.963781-5-Jonathan.Cameron@huawei.com>
References: <20240705123039.963781-1-Jonathan.Cameron@huawei.com>
	<20240705123039.963781-5-Jonathan.Cameron@huawei.com>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 5 Jul 2024 13:30:38 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub (ECS)
> control feature.

Hi Michael / all,

Silly stray white space issue inline that checkpatch will catch.

> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index dda35f2528..222db7032d 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -829,6 +829,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      uint8_t *pci_conf = pci_dev->config;
>      unsigned short msix_num = 6;
>      int i, rc;
> +    uint16_t count;
>  
>      QTAILQ_INIT(&ct3d->error_list);
>  
> @@ -901,6 +902,19 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>                             CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT |
>                             (CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT << 8);
>      ct3d->patrol_scrub_attrs.scrub_flags = CXL_MEMDEV_PS_ENABLE_DEFAULT;
> +    

Sorry - stray whitespace here.  I'll not send a new version for just this though.


> +    /* Set default value for DDR5 ECS read attributes */
> +    for (count = 0; count < CXL_ECS_NUM_MEDIA_FRUS; count++) {
> +        ct3d->ecs_attrs[count].ecs_log_cap =
> +                            CXL_ECS_LOG_ENTRY_TYPE_DEFAULT;
> +        ct3d->ecs_attrs[count].ecs_cap =
> +                            CXL_ECS_REALTIME_REPORT_CAP_DEFAULT;
> +        ct3d->ecs_attrs[count].ecs_config =
> +                            CXL_ECS_THRESHOLD_COUNT_DEFAULT |
> +                            (CXL_ECS_MODE_DEFAULT << 3);
> +        /* Reserved */
> +        ct3d->ecs_attrs[count].ecs_flags = 0;
> +    }
>  
>      return;
>  

