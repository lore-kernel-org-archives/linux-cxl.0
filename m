Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D3B77111
	for <linux-cxl@vger.kernel.org>; Fri, 25 Jul 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753456584; cv=none; b=X04v49eebrPnPd2aW132LkuoAD2HMK6SMoPQOY9ET3gloxm/8OaqLhEPJkxsrLd1961iOuyyN0jOyf4qbkS5ZB6tw4C1Rb5kHFrqqYAMmxRY/cKsLRe+p4p+40a6ARAOJHmOb30xHZAwFhhfsfVlFSQQlbsX2OVPNNwa5xmwmHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753456584; c=relaxed/simple;
	bh=i1N2YS7o2qAhwr2pVdARyiSPE+FaneNDUB1ls07pWzQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDkUWBVIAFLKsMLSOPPxF8kXOFXTY8gwk1kaZXR4KSHEMmJhcYxCj3f2d3pMtjvmMijHqkv5tH6eUECbBZFwLEVdNn+QGgiAOsezLR0LlsejJBDQhn5zqG0T2geomWDPnv5Pd4O+cmFhSNHguIs8mp5+OAG7iSwW6rNKcIAw5Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bpWct5J7Fz6L5G3;
	Fri, 25 Jul 2025 23:14:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 93AF01400C8;
	Fri, 25 Jul 2025 23:16:18 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Jul
 2025 17:16:18 +0200
Date: Fri, 25 Jul 2025 16:16:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: wangyuquan <wangyuquan1236@phytium.com.cn>
CC: <fan.ni@samsung.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH v3 1/2] hw/pxb-cxl: Rename the pxb cxl host bridge
Message-ID: <20250725161616.00007f09@huawei.com>
In-Reply-To: <20250617040649.81303-2-wangyuquan1236@phytium.com.cn>
References: <20250617040649.81303-1-wangyuquan1236@phytium.com.cn>
	<20250617040649.81303-2-wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 17 Jun 2025 12:06:48 +0800
wangyuquan <wangyuquan1236@phytium.com.cn> wrote:

> This renames some descriptions and definitions of pxb cxl host
> bridge, since the original names can be confusing.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Fair enough.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  hw/pci-bridge/pci_expander_bridge.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 3a29dfefc2..bd637786d0 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -201,7 +201,7 @@ static void pxb_cxl_realize(DeviceState *dev, Error **errp)
>  }
>  
>  /*
> - * Host bridge realization has no means of knowning state associated
> + * PXB Host bridge realization has no means of knowning state associated
>   * with a particular machine. As such, it is nececssary to delay
>   * final setup of the host bridge register space until later in the
>   * machine bring up.
> @@ -240,7 +240,7 @@ static void pxb_cxl_host_class_init(ObjectClass *class, const void *data)
>   * This is a device to handle the MMIO for a CXL host bridge. It does nothing
>   * else.
>   */
> -static const TypeInfo cxl_host_info = {
> +static const TypeInfo pxb_cxl_host_info = {
>      .name          = TYPE_PXB_CXL_HOST,
>      .parent        = TYPE_PCI_HOST_BRIDGE,
>      .instance_size = sizeof(CXLHost),
> @@ -522,7 +522,7 @@ static void pxb_cxl_dev_class_init(ObjectClass *klass, const void *data)
>       * vendor, device, class, etc. ids are intentionally left out.
>       */
>  
> -    dc->desc = "CXL Host Bridge";
> +    dc->desc = "PXB CXL Host Bridge";
>      device_class_set_props(dc, pxb_cxl_dev_properties);
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  
> @@ -549,7 +549,7 @@ static void pxb_register_types(void)
>      type_register_static(&pxb_pcie_bus_info);
>      type_register_static(&pxb_cxl_bus_info);
>      type_register_static(&pxb_host_info);
> -    type_register_static(&cxl_host_info);
> +    type_register_static(&pxb_cxl_host_info);
>      type_register_static(&pxb_dev_info);
>      type_register_static(&pxb_pcie_dev_info);
>      type_register_static(&pxb_cxl_dev_info);

