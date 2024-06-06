Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851642BAF1
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682424; cv=none; b=prJwuBMrAJ8G0qqTgzUm5NMaKajvHeUoXb20PFjFgi3OpF6z41P4XFaHRyGmJcSEiuuyZ/DZRXtw1kiV15lXHEfGksIeWuJZ06BbgPqaGyZtfob2LjhgzXbnBhnmacEwxZsCL11a0z4Zf17Jx5dWcHeZsYRm20Vt3+NYmo8v+zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682424; c=relaxed/simple;
	bh=nLO0Pe8Qpw2C8E91fERjuRFM3RhFqXOj3VS/jYDJgKk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8+wvBAS6Whdi9KvsNDrqNNeOR+jimDqfTk7RobOrAD3Abz2NJzmGJ8o4bnYczSAW6lbt99BfYMXsxJBQM1yXaexITmQGDI9EvhJNxDSXKz4ZzX/X3fb95vroFUzodxtD0mgriY6hQzmZnCLG5UKK3+uSN4MH/Dkz4KbF0g9DJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vw5Xn0b3cz6D9Bv;
	Thu,  6 Jun 2024 21:59:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 966C3140CB1;
	Thu,  6 Jun 2024 22:00:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 15:00:13 +0100
Date: Thu, 6 Jun 2024 15:00:12 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
CC: <kobayashi.da-06@jp.fujitsu.com>, <linux-cxl@vger.kernel.org>,
	<y-goto@fujitsu.com>, <mj@ucw.cz>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v8 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
Message-ID: <20240606150012.00005b6c@Huawei.com>
In-Reply-To: <20240606074814.5633-3-kobayashi.da-06@fujitsu.com>
References: <20240606074814.5633-1-kobayashi.da-06@fujitsu.com>
	<20240606074814.5633-3-kobayashi.da-06@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu,  6 Jun 2024 16:48:14 +0900
"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:

> Add sysfs attribute for CXL 1.1 device link status to the cxl pci device.
> 
> In CXL1.1, the link status of the device is included in the RCRB mapped to
> the memory mapped register area. Critically, that arrangement makes the
> link status and control registers invisible to existing PCI user tooling.
> 
> Export those registers via sysfs with the expectation that PCI user
> tooling will alternatively look for these sysfs files when attempting to
> access to these CXL 1.1 endpoints registers.
> 
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> ---
>  drivers/cxl/pci.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2ff361e756d6..e157959dffc2 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -786,6 +786,96 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	return 0;
>  }
>  
> +static u32 get_rcd_pcie_caps(struct device *dev, u16 offset)
> +{
> +	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct device *endpoint_parent;
> +	struct cxl_dport *dport;
> +	struct cxl_port *port;
> +	resource_size_t rcrb;
> +	void __iomem *addr;
> +	u32 ret;
> +
> +	port = cxl_mem_find_port(cxlmd, &dport);
> +	if (!port)
> +		return 0;
> +
> +	endpoint_parent = port->uport_dev;
> +	if (!endpoint_parent)
> +		return 0;
> +
> +	guard(device)(endpoint_parent);
> +	if (!endpoint_parent->driver)
> +		return 0;
> +
> +	rcrb = dport->rcrb.base;
> +	if (!request_mem_region(rcrb, SZ_4K, "CXL RCRB"))

I was assuming we would find the address of the capability only once
and map the relevant cap in for all the time the driver is
bound, as is done for aer_cap.

I'd be worried that this might race with other accesses to rcrb
in the future.

I suspect best option is to keep the capability always mapped
in similar fashion to cxl_dport_map_rch_aer() does it for
the aer registers.



> +		return 0;
> +	addr = ioremap(rcrb, SZ_4K);
> +	if (!addr) {
> +		dev_err(dev, "Failed to map region %pr\n", addr);
> +		release_mem_region(rcrb, SZ_4K);
> +		return 0;
> +	}
> +
> +	ret = readl(addr + dport->rcrb.rcd_pcie_cap + offset);
> +	release_mem_region(rcrb, SZ_4K);
> +	return ret;
> +}
> +
> +static ssize_t rcd_link_cap_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	u32 linkcap = get_rcd_pcie_caps(dev, PCI_EXP_LNKCAP);
> +
> +	return sysfs_emit(buf, "%x\n", linkcap);
> +}
> +static DEVICE_ATTR_RO(rcd_link_cap);
> +
> +static ssize_t rcd_link_ctrl_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	u16 linkctl = get_rcd_pcie_caps(dev, PCI_EXP_LNKCTL);
> +
> +	return sysfs_emit(buf, "%x\n", linkctl);
> +}
> +static DEVICE_ATTR_RO(rcd_link_ctrl);
> +
> +static ssize_t rcd_link_status_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	u16 linksta = get_rcd_pcie_caps(dev, PCI_EXP_LNKSTA);
> +
> +	return sysfs_emit(buf, "%x\n", linksta);

Local variable doesn't add to readability as the PCI_EXP_LNKSTA
makes it pretty obvious what is being queried.

	return sysfs_emit(buf, "%x\n",
			  get_rcd_pcie_caps(dev, PCI_EXP_LNKSTA));

> +}
> +static DEVICE_ATTR_RO(rcd_link_status);
> +
> +static struct attribute *cxl_rcd_attrs[] = {
> +		&dev_attr_rcd_link_cap.attr,
> +		&dev_attr_rcd_link_ctrl.attr,

Indent one less tab.

> +		&dev_attr_rcd_link_status.attr,
> +		NULL
> +};

