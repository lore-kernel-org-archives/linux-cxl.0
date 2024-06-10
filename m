Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC68B14D705
	for <linux-cxl@vger.kernel.org>; Mon, 10 Jun 2024 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718016375; cv=none; b=ofN0OX6102QiKax7i59Nnohp1z6HCe8HPv3M6v8W5q0UTvfsQrvq/6TscUXqw2OezqIHZlx/4LnVbyKRoMdW8uJXDIhrRCVWgT7azOBKvoHmldAPYLdvabtWKKo2xl2YvtpjCG/uURpzc+sw+RJAC4h8SQKd8gisyq1XiA0kzOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718016375; c=relaxed/simple;
	bh=3VcD/VdreGqXsTuPXI5z8Rf7vF5xkN+t7Egbuyw+V3U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EInumlVOynPAmI3fIDWPr1JlbI49kEDD8Ox8SekyMQm4mZ83tIr/zrOqaGOyyVGkz3oxxZTIVw2slz9QuFXUYVvDr694bKQQvoEp/+IPb+McWNR2hIC0fHbmNW3jMxHWbrcyoUutQsluH+uwMrNHlCaxj0R0bRyUa+o0d6CeJMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VySz55bLxz6JB6D;
	Mon, 10 Jun 2024 18:41:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F6BF140B2A;
	Mon, 10 Jun 2024 18:46:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 10 Jun
 2024 11:46:09 +0100
Date: Mon, 10 Jun 2024 11:46:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
CC: <kobayashi.da-06@jp.fujitsu.com>, <linux-cxl@vger.kernel.org>,
	<y-goto@fujitsu.com>, <mj@ucw.cz>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v9 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
Message-ID: <20240610114608.00000d55@Huawei.com>
In-Reply-To: <20240610082222.22772-3-kobayashi.da-06@fujitsu.com>
References: <20240610082222.22772-1-kobayashi.da-06@fujitsu.com>
	<20240610082222.22772-3-kobayashi.da-06@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 10 Jun 2024 17:22:22 +0900
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
Hi

Thanks for quick turn around.  A few follow up comments inline.

Jonathan

> ---
>  drivers/cxl/pci.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2ff361e756d6..0a09d1250f1d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -786,6 +786,78 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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
> +	return readl(dport->regs.rcd_pcie_cap + offset);

I'd sanity check if dport->regs.rcd_pcie_cap == NULL
Maybe we have broken hardware which is an RCD but this cap is missing.
If that happens, return -EINVAL or similar here.

 
> +}
> +
> +static ssize_t rcd_link_cap_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%x\n",
> +					  get_rcd_pcie_caps(dev, PCI_EXP_LNKCAP));

Alignment issue.  Tabs need to be same length as 8 spaces for kernel code.


Also you cast in all other cases which seems odd.

> +}
> +static DEVICE_ATTR_RO(rcd_link_cap);
> +
> +static ssize_t rcd_link_ctrl_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%x\n",
> +					  (u16)get_rcd_pcie_caps(dev, PCI_EXP_LNKCTL));
> +}
> +static DEVICE_ATTR_RO(rcd_link_ctrl);
> +
> +static ssize_t rcd_link_status_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%x\n",
> +					  (u16)get_rcd_pcie_caps(dev, PCI_EXP_LNKSTA));
> +}
> +static DEVICE_ATTR_RO(rcd_link_status);

