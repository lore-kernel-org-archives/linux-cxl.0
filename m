Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D9F1862A
	for <linux-cxl@vger.kernel.org>; Tue, 11 Jun 2024 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718120413; cv=none; b=MIQCDa3OdIUos9aLLOd1+sH0bWpi449vwaV2ptzHaMOYYNNtcMtRRnhNvVlPvGZ/tQTIyYDyYEay7LymaqXENOyxMNU8CxNoLJIuIZH29sbDtPZzftBhuqj+/qXmM5XbDZdzJl7ZX+c59+3+1OHaYxOc1LLou6REjjsVPaIz88w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718120413; c=relaxed/simple;
	bh=W7eARgywU2KZrxGCyCW0s3177cYYjCTWLoT4Bc6P4rE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYUa4r3Pc0hsQ6RbrZuEqhjTwcIqi/2SB6beh6sUdvSW5dQsVLVNN+G3EyUgZblruszYXVkzxYEOFgzUa7Z0OdGyUR2BhzRBY8K/ktXnX2zIKDF9TvI8GvmN/iuR5txqUCN3hhlD1114/u8y7NHCalmxCesvLUwA5Pbm/PlZI5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VzCWX15GKz6H8bN;
	Tue, 11 Jun 2024 23:38:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 33C59140B2A;
	Tue, 11 Jun 2024 23:40:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Jun
 2024 16:40:07 +0100
Date: Tue, 11 Jun 2024 16:40:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
CC: <kobayashi.da-06@jp.fujitsu.com>, <linux-cxl@vger.kernel.org>,
	<y-goto@fujitsu.com>, <mj@ucw.cz>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v10 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
Message-ID: <20240611164006.000059b9@Huawei.com>
In-Reply-To: <20240611055254.61203-3-kobayashi.da-06@fujitsu.com>
References: <20240611055254.61203-1-kobayashi.da-06@fujitsu.com>
	<20240611055254.61203-3-kobayashi.da-06@fujitsu.com>
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

On Tue, 11 Jun 2024 14:52:54 +0900
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
Hi. 

Can go one step further without hurting readability much.

Jonathan

> ---
>  drivers/cxl/pci.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2ff361e756d6..655616a16892 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -786,6 +786,103 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	return 0;
>  }
>  
> +static ssize_t rcd_pcie_cap_emitl(struct device *dev, u16 offset, char *buf)
> +{
> +	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct device *endpoint_parent;
> +	struct cxl_dport *dport;
> +	struct cxl_port *port;
> +
> +	port = cxl_mem_find_port(cxlmd, &dport);
> +	if (!port)
> +		return -EINVAL;
> +
> +	endpoint_parent = port->uport_dev;
> +	if (!endpoint_parent)
> +		return -ENXIO;
> +
> +	guard(device)(endpoint_parent);
> +	if (!endpoint_parent->driver)
> +		return -ENXIO;
> +
> +	if (dport->regs.rcd_pcie_cap == NULL)
> +		return -EINVAL;
> +
> +	return sysfs_emit(buf, "%x\n", readl(dport->regs.rcd_pcie_cap + offset));

I'd create an extra function called form both of these called from these with
a size parameter that select between the last two lines.

rcd_pcie_cap_emit(struct device *dev, u16 offset, char *buf, size_t width)
{
....
	switch (width) {
	case 2:
		return sysfs_emit(buf, "%x\n",
				  readw(dport->regs.rcd_pcie_cap + offset));
	case 4:
		return sysfs_emit(buf, "%x\n",
				  readl(dport->regs.rcd_pcie_cap + offset));
	default:
		return -EINVAL;
	} 
}
Then call that from the wrappers with appropriate size parameter.

> +}
> +
> +static ssize_t rcd_pcie_cap_emitw(struct device *dev, u16 offset, char *buf)
> +{
> +	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct device *endpoint_parent;
> +	struct cxl_dport *dport;
> +	struct cxl_port *port;
> +
> +	port = cxl_mem_find_port(cxlmd, &dport);
> +	if (!port)
> +		return -EINVAL;
> +
> +	endpoint_parent = port->uport_dev;
> +	if (!endpoint_parent)
> +		return -ENXIO;
> +
> +	guard(device)(endpoint_parent);
> +	if (!endpoint_parent->driver)
> +		return -ENXIO;
> +
> +	if (dport->regs.rcd_pcie_cap == NULL)
> +		return -EINVAL;
> +
> +	return sysfs_emit(buf, "%x\n", readw(dport->regs.rcd_pcie_cap + offset));
> +}
> +
> +static ssize_t rcd_link_cap_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	return rcd_pcie_cap_emitl(dev, PCI_EXP_LNKCAP, buf);
> +}
> +static DEVICE_ATTR_RO(rcd_link_cap);
> +
> +static ssize_t rcd_link_ctrl_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	return rcd_pcie_cap_emitw(dev, PCI_EXP_LNKCTL, buf);
> +}
> +static DEVICE_ATTR_RO(rcd_link_ctrl);
> +
> +static ssize_t rcd_link_status_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	return rcd_pcie_cap_emitw(dev, PCI_EXP_LNKSTA, buf);
> +}
> +static DEVICE_ATTR_RO(rcd_link_status);
> +
> +static struct attribute *cxl_rcd_attrs[] = {
> +	&dev_attr_rcd_link_cap.attr,
> +	&dev_attr_rcd_link_ctrl.attr,
> +	&dev_attr_rcd_link_status.attr,
> +	NULL
> +};
> +
> +static umode_t cxl_rcd_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (is_cxl_restricted(pdev))
> +		return a->mode;
> +
> +	return 0;
> +}
> +
> +static struct attribute_group cxl_rcd_group = {
> +	.attrs = cxl_rcd_attrs,
> +	.is_visible = cxl_rcd_visible,
> +};
> +__ATTRIBUTE_GROUPS(cxl_rcd);
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> @@ -969,6 +1066,7 @@ static struct pci_driver cxl_pci_driver = {
>  	.id_table		= cxl_mem_pci_tbl,
>  	.probe			= cxl_pci_probe,
>  	.err_handler		= &cxl_error_handlers,
> +	.dev_groups		= cxl_rcd_groups,
>  	.driver	= {
>  		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
>  	},

