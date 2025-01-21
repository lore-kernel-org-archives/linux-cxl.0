Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C43E54F81
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jan 2025 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737471505; cv=none; b=sJXbHPXGvrIJMPenkrbClQCqJ6evf59tKlwdsCppUETLXxo1xsryfdrV6IufzDnKO0ZLQEPMm8yY4PJgCiQ35cGHel8i8W0b++SZTl4DIC+q0pTzAhB7sUuU8gqV8czXU4G6LWl4+0CWUXVvIERBRtnQqG/9ieTxwaVTrQlHVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737471505; c=relaxed/simple;
	bh=Y6bOaUjrT2u5BWPjKpPqsLb+mjF+TA2HdhGSubDU9aQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sl4pP7ygmyhI1ufrnLRJ/OXr6WVnF+3/wEkpR8p9ZdfbrSd2uCyNmOCR6YHkHFIfM75kwAHU2/IgOABIN4U5jth63/r/e1wIvDRIZOSsOSuu4XAi2Du9mRe/1iMEKG5uAJL7meu90ARduVTxdXgbCiKlSj4EF79eBASGChDdCac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ycr1441kcz6K9JV;
	Tue, 21 Jan 2025 22:58:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CE4D9140B33;
	Tue, 21 Jan 2025 22:58:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 21 Jan
 2025 15:58:13 +0100
Date: Tue, 21 Jan 2025 14:58:12 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Zhijian <lizhijian@fujitsu.com>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] hw/mem/cxl_type3: Fix special_ops memory leak on
 msix_init_exclusive_bar() failure
Message-ID: <20250121145812.00004c63@huawei.com>
In-Reply-To: <20250120030947.254930-2-lizhijian@fujitsu.com>
References: <20250120030947.254930-1-lizhijian@fujitsu.com>
	<20250120030947.254930-2-lizhijian@fujitsu.com>
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

On Mon, 20 Jan 2025 11:09:46 +0800
Li Zhijian <lizhijian@fujitsu.com> wrote:

> Address a memory leak issue by ensuring `regs->special_ops` is freed when
> `msix_init_exclusive_bar()` encounters an error during CXL Type3 device
> initialization.
> 
> Additionally, this patch renames err_address_space_free to err_msix_uninit
> for better clarity and logical flow
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Hi.

The need to reorder the cleanup calls made me look more
closely at this patch. Either the order was wrong here or in the previous
patch. I think the issue is here.

Jonathan

> ---
>  hw/mem/cxl_type3.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 9dad250f56d5..9eb3d0979cf5 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -885,7 +885,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      /* MSI(-X) Initialization */
>      rc = msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4, NULL);
>      if (rc) {
> -        goto err_address_space_free;
> +        goto err_free_special_ops;
>      }
>      for (i = 0; i < CXL_T3_MSIX_VECTOR_NR; i++) {
>          msix_vector_use(pci_dev, i);
> @@ -899,7 +899,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
>      cxl_cstate->cdat.private = ct3d;
>      if (!cxl_doe_cdat_init(cxl_cstate, errp)) {
> -        goto err_free_special_ops;
> +        goto err_msix_uninit;
>      }
>  
>      pcie_cap_deverr_init(pci_dev);
> @@ -936,9 +936,9 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>  err_release_cdat:
>      cxl_doe_cdat_release(cxl_cstate);
>  err_free_special_ops:
> -    msix_uninit_exclusive_bar(pci_dev);
>      g_free(regs->special_ops);
> -err_address_space_free:
> +err_msix_uninit:
> +    msix_uninit_exclusive_bar(pci_dev);

This reorder doesn't look correct.

Should end up I think as
err_release_cdata:
    cxl_doe_cdata_release(cxl_cstate);
err_msix_uninit:
    msix_uninit_eclusive_bar(pci_dev);
err_free_special_ops:
    g_free(regs->special_ops)
err_address_space_free:
etc.

>      if (ct3d->dc.host_dc) {
>          cxl_destroy_dc_regions(ct3d);
>          address_space_destroy(&ct3d->dc.host_dc_as);

