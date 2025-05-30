Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C017BD3
	for <linux-cxl@vger.kernel.org>; Fri, 30 May 2025 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748611129; cv=none; b=ajiuwYjSGveZUAS6jM93XHRf/Sl4u2XViCFaflpmTvh2cTWvmwp24ESVMEgUGHvcu7CxfACLUOJCNDHo7RRawEf/cxgj7wqIrEDjWbDCv55idVt/F8vxSQ5sQ6bU0LHUhzRlIigxXSIckQ8paW2tIyhA0HXqGcqqMD9G0PFhOrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748611129; c=relaxed/simple;
	bh=hCieJB2bDgNqnUrDwsxrKIvr+h97cslTDb4Z1u1WaHI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0ovynl3X3dBnzjbBP8pFxihyQz5YRp8piRCDrGPKpGla/VvQFW5rDzkmM9+M+WwW2QRpS0+ZxfNjTkGgZIPxtwpH2+oLfxH648BbH9nnzmUj11BQS7EQdxPT+ztnWpmhTOKcSPK6s1QMSa03sNRqwtarjNFYvS2/7/dBI5lmjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b83ht4WL4z6M4Vm;
	Fri, 30 May 2025 21:18:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F95E1404FC;
	Fri, 30 May 2025 21:18:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 May
 2025 15:18:43 +0200
Date: Fri, 30 May 2025 14:18:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
	<linuxarm@huawei.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH qemu] hw/cxl: Fix register block locator size
Message-ID: <20250530141822.000067b6@huawei.com>
In-Reply-To: <20250529134828.403049-1-Jonathan.Cameron@huawei.com>
References: <20250529134828.403049-1-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 29 May 2025 14:48:28 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> This has been wrong from day 1.  For now we only have
> two entries (component and device registers).
> 
> The wrong size could lead to arbitrary data off the stack being presented
> in PCIe config space.

As noted in reply to Zhijian, this whole patch is garbage.
A fixed 'larger' size is fine as it will be 0 filled and that
is valid under the spec. 

Sorry for the noise.

Jonathan

> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/hw/cxl/cxl_pci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
> index d0855ed78b..3bb882ce89 100644
> --- a/include/hw/cxl/cxl_pci.h
> +++ b/include/hw/cxl/cxl_pci.h
> @@ -31,7 +31,7 @@
>  #define PCIE_CXL3_FLEXBUS_PORT_DVSEC_LENGTH 0x20
>  #define PCIE_CXL3_FLEXBUS_PORT_DVSEC_REVID  2
>  
> -#define REG_LOC_DVSEC_LENGTH 0x24
> +#define REG_LOC_DVSEC_LENGTH 0x1C
>  #define REG_LOC_DVSEC_REVID  0
>  
>  enum {

