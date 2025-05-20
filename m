Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C2D6BB5B
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746700; cv=none; b=X9+smhgN2Q224kj5Sn0FR5eKDeXKaSi5FeQImBVMxiEuANVqwRpTe1YhLrLxQpmLgW5FGTxF0j4Wudt/gZC6lRzv4Qakfp6IeSW4wDeTh3gW9B9/q7mE6eeppX9Ff+bLnm2Lq71nwOD1T3bJk9yjXm3OQkP+DpVa/RhrTQpbBrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746700; c=relaxed/simple;
	bh=sXxg7/sNmfBY6maA5D4jSjHHeIHBSNG18zEirXcpAO8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bY8YGZAMWdrWYxCZW7nqDz6iU9MyyPy6DO4uf+oNNP4J62zlrvgOcn6YjDMnp06BDIW1mJmMxP1Hlrz6UsXWmFj/VSRlurIID1ZgfqQuvXhfigKCAbb6VoAxp1VAn9IoDl91aH1Tlk3kQs9BlLaY9vL1+FicrFpdj32//sjiV4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1w0M5jXcz6L4v1;
	Tue, 20 May 2025 21:10:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 14FDC14050C;
	Tue, 20 May 2025 21:11:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 May
 2025 15:11:33 +0200
Date: Tue, 20 May 2025 14:11:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<rrichter@amd.com>, <ming.li@zohomail.com>
Subject: Re: [PATCH v2 10/10] cxl: Move enumeration of hostbridge ports to
 the memdev probe path
Message-ID: <20250520141131.00003633@huawei.com>
In-Reply-To: <20250507004310.3536991-11-dave.jiang@intel.com>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
	<20250507004310.3536991-11-dave.jiang@intel.com>
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

On Tue, 6 May 2025 17:43:10 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Current enuemration scheme in cxl_acpi module creates the ports under the
> root port by enumerating the hostbridges after the dports under the root
> port is created. However error messages "cxl portN: Couldn't locate the
> CXL.cache and CXL.mem capability array header" is observed when certain
> platform has PCIe hotplug option turned on in BIOS. If the cxl_acpi module
> probe is running before the CXL link between the endpoint device and the
> RP is established, then the platform may not have exposed DVSEC ID 3 and/or
> DVSEC ID 7 blocks which will trigger the error message.

I think we should call out that this bit (unlike port numbers) is valid
under the CXL spec.  Whilst I think that statement in the spec is something
I'd rather wasn't there we should reflect this one isn't a hardware bug
work around (unlike port number which I think is :)


> 
> Setup an association in cxl_port to tie the host bridge device to the
> associated cxl_root. The cxl_root provides a callback that's setup
> by the cxl_acpi probe function in order to create a port per host bridge
> that was previously done during cxl_acpi probe. Add the calling of the
> callback in devm_cxl_enumerate_ports(). The observed behavior is that
> ports that are not connected to endpoint device(s) are no longer
> enumerated. This should also remove any excessive noise of port probe
> failing on those inactive ports.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

This is a fairly fiddly change but it looks reasonable.

Just trivial style comments inline.

J
> ---
>  drivers/cxl/acpi.c      | 136 ++++++++++++++++++++++++----------------
>  drivers/cxl/core/port.c |  58 +++++++++++++++++
>  drivers/cxl/cxl.h       |   2 +
>  3 files changed, 141 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 6f8630e50800..1db4d308b4b7 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -298,8 +298,79 @@ static int cxl_acpi_qos_class(struct cxl_root *cxl_root,
>  	return cxl_acpi_evaluate_qtg_dsm(handle, coord, entries, qos_class);
>  }
>  
> +/* Note, @dev is used by mock_acpi_table_parse_cedt() */
> +struct cxl_chbs_context {
> +	struct device *dev;
> +	unsigned long long uid;
> +	resource_size_t base;
> +	u32 cxl_version;
> +	int nr_versions;
> +	u32 saved_version;
> +};
> +
> +static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
> +			struct cxl_chbs_context *ctx);
> +
> +/*
> + * A host bridge is a dport to a CFMWS decode and it is a uport to the

decoder maybe?

> + * dport (PCIe Root Ports) in the host bridge.
> + */
> +static int cxl_acpi_setup_hostbridge_uport(struct cxl_root *cxl_root,

Pity this doesn't sit in similar place to original add_host_bridge_uport
as we'd get a much nicer diff if it could.
I suppose it would be a bit too ugly to preceded this patch with
a code move patch just for that diff.  Ah well. I'll cope ;)

> +					   struct device *bridge_dev)
> +{
> +	struct cxl_port *root_port = &cxl_root->port;
> +	struct device *host = root_port->dev.parent;
> +	struct acpi_device *hb = ACPI_COMPANION(bridge_dev);
> +	resource_size_t component_reg_phys;
> +	struct acpi_pci_root *pci_root;
> +	struct cxl_chbs_context ctx;
> +	struct cxl_dport *dport;
> +	struct cxl_port *port;
> +	int rc;
> +
> +	pci_root = acpi_pci_find_root(hb->handle);
> +	dport = cxl_find_dport_by_dev(root_port, bridge_dev);
> +	if (!dport) {
> +		dev_dbg(host, "Host bridge expected and not found\n");
> +		return -ENODEV;
> +	}
> +
> +	if (dport->rch) {
> +		dev_info(bridge_dev, "host supports CXL (restricted)\n");
> +		return 0;
> +	}
> +
> +	rc = cxl_get_chbs(&hb->dev, hb, &ctx);
> +	if (rc)
> +		return rc;
> +
> +	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
> +		dev_warn(bridge_dev,
> +			 "CXL CHBS version mismatch, skip port registration\n");
> +		return 0;
> +	}
> +
> +	component_reg_phys = ctx.base;
> +	if (component_reg_phys != CXL_RESOURCE_NONE)
> +		dev_dbg(&hb->dev, "CHBRC found for UID %lld: %pa\n",
> +			ctx.uid, &component_reg_phys);
> +
> +	rc = devm_cxl_register_pci_bus(host, bridge_dev, pci_root->bus);
> +	if (rc && rc != -EBUSY)
> +		return rc;
> +
> +	port = devm_cxl_add_port(host, bridge_dev, component_reg_phys, dport);
> +	if (IS_ERR(port))
> +		return PTR_ERR(port);
> +
> +	dev_info(bridge_dev, "host supports CXL\n");
> +
> +	return 0;
> +}

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index a5a673d789f3..bbecbb04b6be 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1808,6 +1808,60 @@ static int cxl_switch_port_dport_setup(struct cxl_port *port,
>  	return 0;
>  }
>  
> +static int get_hostbridge_port_devices(struct cxl_memdev *cxlmd,
> +				       struct device **uport_dev,
> +				       struct device **dport_dev)
> +{
> +	struct device *dev = &cxlmd->dev;
> +	struct device *iter;
> +
> +	for (iter = dev; iter; iter = grandparent(iter)) {
> +		struct device *ddev = grandparent(iter);
> +		struct device *udev;
> +
> +		udev = ddev->parent;

Odd to have ddev set at declaration and udev set here.
Pick a style - either is fine.

> +		if (is_cxl_hierarchy_head(udev->parent)) {
> +			*uport_dev = udev;
> +			*dport_dev = ddev;
> +			return 0;
> +		}
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static int cxl_hostbridge_port_setup(struct cxl_memdev *cxlmd)
> +{
> +	struct device *uport_dev, *dport_dev;
> +	struct cxl_dport *dport;
> +	struct cxl_port *port;
> +	int rc;
> +
> +	rc = get_hostbridge_port_devices(cxlmd, &uport_dev, &dport_dev);
> +	if (rc)
> +		return -ENODEV;
> +
> +	struct cxl_root *cxl_root __free(put_cxl_root) = cxl_udev_to_root(uport_dev);
> +	if (!cxl_root)
> +		return -ENODEV;
> +
> +	guard(device)(&cxl_root->port.dev);

> +	port = find_cxl_port(dport_dev, &dport);

I vaguely wonder if a __free() make sense on this. It'll autofree the NULL
much later than needed but maybe it's cleaner code?

> +	if (port) {
> +		put_device(&port->dev);
> +		return 0;
> +	}
> +
> +	if (!cxl_root->ops || !cxl_root->ops->setup_hostbridge_uport)
> +		return -EOPNOTSUPP;
> +
> +	rc = cxl_root->ops->setup_hostbridge_uport(cxl_root, uport_dev);
> +	if (rc)
> +		return rc;
> +
> +	return 0;

return cxl_root->ops....

> +}

