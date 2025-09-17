Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93B234BA22
	for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126770; cv=none; b=UhA8gFfgDGvs8cxtYpf9E1G1HbJVhCO4f8mM+/JxI0MeLeF7kOMrmvPmAqVen7FKWp70itCET2UABlZwrl4LIsHIg2Tzw/d0EGY/KHj6O/MXITfLQbc4IlAt/PS5eZxI5vygbW38QIyncuhYTuWA0XwpwJFCP0LZuy2zaD7r1sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126770; c=relaxed/simple;
	bh=fRhKcBqfX4UZPifAWDIbk06jqG1ZAQ/G5Ed+zV2c8NU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DtTgQFZYu8FO2gBc7wOPx6QLYFHjlufVPLaymwmWScOfNoEFcd6gmJTZtAiKWBDyCaZk6YXND/pS1mDVWqM06k/h917Qzb0nVhjvKQFYpgg1JO8yYmbn0ILZ5qtMDKbcbNYUjT+vcO/ilyqShuAdO7aNhUFC1pNHNxvdfUJypHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cRkkq6BFwz6M5JM;
	Thu, 18 Sep 2025 00:29:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id ACB3814020A;
	Thu, 18 Sep 2025 00:32:44 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Sep
 2025 18:32:43 +0200
Date: Wed, 17 Sep 2025 17:32:42 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: wangyuquan <wangyuquan1236@phytium.com.cn>
CC: <fan.ni@samsung.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
	<rad@semihalf.com>, <peter.maydell@linaro.org>,
	<leif.lindholm@oss.qualcomm.com>, <graf@amazon.com>,
	<claudio.fontana@huawei.com>, <philmd@linaro.org>,
	<richard.henderson@linaro.org>, <chenbaozi@phytium.com.cn>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC QEMU PATCH v4 1/2] hw/pxb-cxl: Rename the pxb cxl host
 bridge
Message-ID: <20250917173242.00004009@huawei.com>
In-Reply-To: <20250807105910.240070-2-wangyuquan1236@phytium.com.cn>
References: <20250807105910.240070-1-wangyuquan1236@phytium.com.cn>
	<20250807105910.240070-2-wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 7 Aug 2025 18:59:09 +0800
wangyuquan <wangyuquan1236@phytium.com.cn> wrote:

> This renames some descriptions and definitions of pxb cxl host
> bridge, since the original names can be confusing.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

This is fine with me - sorry for my lack of attention on this series.
I'm not set up to test SBSA and for me it's not a focus, but I don't
want to get in your way! 

Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>

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

