Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601B51AED5C
	for <linux-cxl@vger.kernel.org>; Thu, 24 Apr 2025 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745492117; cv=none; b=kbO2Cqfp+d84EZ7mXtMQRQ36kOQiTdLvjTrnnEHisc11WNOE6deya0k/TkFJldSXh1+giNE++/IVGemb/ED8dxA78XloSa2by6a7pL72/OJYy6+FE5+u2s2sVfndi9AvAjSZJouig/h6z29glx9/f5/WIHcTsud3/7k9AgPcIh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745492117; c=relaxed/simple;
	bh=GnF7E2WnJcVWhW3OBLq1K8hB9OfUc7Fu2Zs3PyYAsDw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3DDp9uhR9gW11LNJ1JsYaMhEGk9gDReo/zfp2S4iwpQCNexjbv5VFgVYU5mcQDzThE9gHXdor6nNUn5voky0zo0jOwuDC0/M7iXVrp73jhNXos2FwZwwxvFQThQkzAuTpuYOoFBcyv8Qng5xk73FDEvWeJZvzwHtjjfasY17Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zjt9y0QNvz6L5bt;
	Thu, 24 Apr 2025 18:53:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A27514025A;
	Thu, 24 Apr 2025 18:55:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Apr
 2025 12:55:10 +0200
Date: Thu, 24 Apr 2025 11:55:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 5/9] cxl_events.h: move definition for
 dynamic_capacity_uuid and enum for DC event types
Message-ID: <20250424115509.00007cc5@huawei.com>
In-Reply-To: <20250317164204.2299371-6-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
	<20250317164204.2299371-6-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 17 Mar 2025 16:31:32 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> move definition for dynamic_capacity_uuid and enum for DC event types to

Move

> cxl_events.h from cxl_type3.c for shared use in next patch
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/mem/cxl_type3.c          | 15 ---------------
>  include/hw/cxl/cxl_events.h | 15 +++++++++++++++
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 452a0c101a..ac74e62875 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1977,21 +1977,6 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>      }
>  }
>  
> -/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
> -static const QemuUUID dynamic_capacity_uuid = {
> -    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
> -                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
> -};
> -
> -typedef enum CXLDCEventType {
> -    DC_EVENT_ADD_CAPACITY = 0x0,
> -    DC_EVENT_RELEASE_CAPACITY = 0x1,
> -    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
> -    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
> -    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
> -    DC_EVENT_CAPACITY_RELEASED = 0x5,
> -} CXLDCEventType;
> -
>  /*
>   * Check whether the range [dpa, dpa + len - 1] has overlaps with extents in
>   * the list.
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index 38cadaa0f3..758b075a64 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -184,4 +184,19 @@ typedef struct CXLEventDynamicCapacity {
>      uint32_t tags_avail;
>  } QEMU_PACKED CXLEventDynamicCapacity;
>  
> +/* CXL r3.1 Table 8-50: Dynamic Capacity Event Record */
> +static const QemuUUID dynamic_capacity_uuid = {
> +    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
> +                 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
> +};
> +
> +typedef enum CXLDCEventType {
> +    DC_EVENT_ADD_CAPACITY = 0x0,
> +    DC_EVENT_RELEASE_CAPACITY = 0x1,
> +    DC_EVENT_FORCED_RELEASE_CAPACITY = 0x2,
> +    DC_EVENT_REGION_CONFIG_UPDATED = 0x3,
> +    DC_EVENT_ADD_CAPACITY_RSP = 0x4,
> +    DC_EVENT_CAPACITY_RELEASED = 0x5,
> +} CXLDCEventType;
> +
>  #endif /* CXL_EVENTS_H */

