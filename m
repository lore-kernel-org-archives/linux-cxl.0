Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AFE1F426B
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jan 2025 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737471604; cv=none; b=kNXBhJe45NLIKu5rWytYCTgG+eiN309D8Lr0dvXE1HXwanr9iGGqqC0vQHWXhABZO/ASxF9Ckzt24VtbIoh/eqN8wH5DSZ8YffxwSAX6NxeHMatHt7TdzoyX3nN2P2sJw02nxb2oTpx76zd01DziH3D6+SJsdm/6mbMPqexg2oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737471604; c=relaxed/simple;
	bh=Q0KvauRIKuqCRY6MbZhmt9IB5LY1PuPVo3yyE5mbKGU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0tW7CPPfpGl4iZjhDpLWD1qmJegnVvdLAsl0XrSO5IA5hhA57rNUsH8k8c0hbzMf9I7U2ALrLvmsEaGXEKDq0HZXVMcARDK0IyzuImFiNHd9OXyYnRp2Oig8CcG0jXVt9V+LMLB52g3Ef8NvoA0vh6z50KAQEvJPBNBryUSdl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ycr176cf8z6M4ZV;
	Tue, 21 Jan 2025 22:58:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 33151140A70;
	Tue, 21 Jan 2025 22:59:58 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 21 Jan
 2025 15:59:57 +0100
Date: Tue, 21 Jan 2025 14:59:56 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Zhijian <lizhijian@fujitsu.com>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] hw/mem/cxl_type3: Ensure errp is set on realization
 failure
Message-ID: <20250121145956.00007e66@huawei.com>
In-Reply-To: <20250120030947.254930-3-lizhijian@fujitsu.com>
References: <20250120030947.254930-1-lizhijian@fujitsu.com>
	<20250120030947.254930-3-lizhijian@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 20 Jan 2025 11:09:47 +0800
Li Zhijian <lizhijian@fujitsu.com> wrote:

> Simply pass the errp to its callee which will set errp if needed, to
> enhance error reporting for CXL Type 3 device initialization by setting
> the errp when realization functions fail.
> 
> Previously, failing to set `errp` could result in errors being overlooked,
> causing the system to mistakenly treat failure scenarios as successful and
> potentially leading to redundant cleanup operations in ct3_exit().
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Looks good to me so just that reordering issue in patch 2.

Thanks for fixing this up.

Jonathan

> ---
>  hw/mem/cxl_type3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 9eb3d0979cf5..c3b6a1d6a612 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -883,7 +883,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>                       &ct3d->cxl_dstate.device_registers);
>  
>      /* MSI(-X) Initialization */
> -    rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, NULL);
> +    rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, errp);
>      if (rc) {
>          goto err_free_special_ops;
>      }
> @@ -904,7 +904,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>  
>      pcie_cap_deverr_init(pci_dev);
>      /* Leave a bit of room for expansion */
> -    rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, NULL);
> +    rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, errp);
>      if (rc) {
>          goto err_release_cdat;
>      }

