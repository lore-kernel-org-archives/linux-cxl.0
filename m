Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC26282EB
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747744065; cv=none; b=RA0HPOhY7kAcUWnjq9nSNs0/p7JOExy8Al80mp16r4h6KYIw3oRg6sCQkXu0k7WiuszzXjmjz2N1OA+VRJO/hAzG09uljMsbbseK68VlpQfB5jXh+KK0CJbfe1B3ku55ihHUmYFaDlzHLROwGJUbVVxgQOZGyTC12tnoDETI0+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747744065; c=relaxed/simple;
	bh=ar4Aqrc1DAg4tl5kOPKoyvHUhE5LSZ6GC0HCc/bg7bo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeuYBqOGwDPeiQ7eJbGtDUX4tpxr4Bl2S4ekPFpZcFTbjbJGvI52pv/iEbpychXy85me0xXi1Z8PwtRy3/eSLdlpvbQPfDPpYC8tt1fxo2bAyj14S9xtmGeMcAg0+PATyomdQlRyCt2wUz84yDDVM1YP7K1mXo0BnC3k7Y3bacw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1tz33RPsz6L5BG;
	Tue, 20 May 2025 20:24:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A590140371;
	Tue, 20 May 2025 20:27:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 May
 2025 14:27:39 +0200
Date: Tue, 20 May 2025 13:27:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<rrichter@amd.com>, <ming.li@zohomail.com>
Subject: Re: [PATCH v2 05/10] cxl: Defer hardware dport->port_id assignment
 and registers probing
Message-ID: <20250520132737.00005b5c@huawei.com>
In-Reply-To: <20250507004310.3536991-6-dave.jiang@intel.com>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
	<20250507004310.3536991-6-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 6 May 2025 17:43:05 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Current implementation only enumerates the dports during the port probe.
> Without an endpoint connected, the dport may not be active during port
> probe. This scheme may prevent a valid hardware dport id to be retrieved
> and MMIO registers to be read when an endpoint is hot-plugged. Move the hw
> dport id assignment and the register probing to behind memdev probe so the
> endpoint is guaranteed to be connected.
> 
> The detection of duplicate dport for add_dport() is removed. The port_id
> is not read from the hw at this point any longer. The port->id will always
> be unique since it's retrieved from an ida. The dup detection thus become
> irrelevant.
> 
> The decoders must also be updated since previously it's all done when all
> the dports are setup and now every time a dport is setup per endpoint, the
> switch target listing need to be updated with new dport.
> 
> Link: https://lore.kernel.org/linux-cxl/20250305100123.3077031-1-rrichter@amd.com/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
A few trivial things inline.

> ---
> v2:
> - Fix spelling error in commit message. (Ming)
> - Move probing to the specific dport. (Ming)
> - Add decoder update.
> - Return errors when setup dports. (Jonathan)
> - Add driver check before setup dport. (Dan)
> - Add comment on why location to do dport update. (Dan)
> ---
>  drivers/cxl/core/core.h |   4 ++
>  drivers/cxl/core/pci.c  |  60 ++++++++++++----
>  drivers/cxl/core/port.c | 152 +++++++++++++++++++++++++++++++++++-----
>  drivers/cxl/cxl.h       |   4 ++
>  drivers/cxl/port.c      |  20 +-----
>  5 files changed, 192 insertions(+), 48 deletions(-)
> 

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 3b84b43ab194..16bd842904e5 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -24,6 +24,52 @@ static unsigned short media_ready_timeout = 60;
>  module_param(media_ready_timeout, ushort, 0644);
>  MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");
>  
> +int cxl_dport_setup(struct cxl_dport *dport)
> +{
> +	struct device *dport_dev = dport->dport_dev;
> +	struct cxl_port *port = dport->port;
> +	struct cxl_register_map map;
> +	struct pci_dev *pdev;
> +	u32 lnkcap, port_num;
> +	int rc;
> +

I assume this is a cxl test thing?  If so maybe throw a comment in
as I at least sometimes forget that exists and wonder how on earth
we got here with something that wasn't a pci device.


> +	if (!dev_is_pci(dport_dev))
> +		return 0;
> +
> +	/*
> +	 * dport->port_id is valid means that dport has been probed and is
> +	 * setup.
> +	 */
> +	if (dport->port_num != CXL_DPORT_NUM_INVALID)
> +		return 0;
> +
> +	pdev = to_pci_dev(dport_dev);
> +	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> +				  &lnkcap))
> +		return -ENODEV;
> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc) {
> +		dev_dbg(&port->dev, "failed to find component registers\n");
> +		return -ENODEV;
> +	}
> +
> +	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);

I'd grab this where you read link cap above, or just before use below.
Here it's not associated with anything in particular so just feels
odd. I'd guess this is down to some code reorg leaving it somewhat
stranded (or a change in a later patch that makes this location an obviou
choice?)


> +	rc = cxl_dport_setup_regs(&port->dev, dport, map.resource);
> +	if (rc)
> +		return rc;
> +
> +	if (map.resource != CXL_RESOURCE_NONE) {
> +		dev_dbg(dport->dport_dev,
> +			"Component Register found for dport: %pa\n",
> +			&map.resource);
> +	}
> +
> +	dport->port_num = port_num;
> +
> +	return 0;
> +}

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 70173d23139c..04e18a102d26 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c


> +static int port_probe_dport(struct cxl_port *port, struct device *dport_dev,
> +			    struct cxl_dport **probed_dport)
> +{
> +	struct cxl_dport *dport;
> +	unsigned long index;
> +	int rc;
> +
> +	device_lock_assert(&port->dev);
> +	xa_for_each(&port->dports, index, dport) {
> +		if (dport->dport_dev == dport_dev) {

Maybe flip?  The code indent isn't huge though so up to you.

		if (!dport->dport_dev != dport_dev)
			continue;

> +			rc = cxl_dport_setup(dport);
> +			if (rc)
> +				return rc;

I'd throw in a blank line here.

> +			*probed_dport = dport;

and here in the interests of minor readability improvement

> +			return 0;
> +		}
> +	}
> +
> +	*probed_dport = NULL;
> +
> +	return -ENODEV;
> +}


> +
> +static int cxl_switch_port_dport_setup(struct cxl_port *port,
> +				       struct device *dport_dev)
> +{
> +	struct cxl_dport *dport;
> +	int rc;
> +
> +	device_lock_assert(&port->dev);
> +
> +	if (!port->dev.driver)
> +		return -ENODEV;
> +
> +	rc = port_probe_dport(port, dport_dev, &dport);
> +	if (rc)
> +		return rc;
> +
> +	cxl_switch_parse_cdat(port);
> +
> +	/* Make sure that no decoders have been allocated before proceeding. */
> +	if (ida_is_empty(&port->decoder_ida))
> +		rc = devm_cxl_port_setup_decoders(port);
> +	else
> +		rc = update_decoders_with_dport(port, dport);
> +	if (rc)
> +		return rc;
> +
> +	return 0;

return rc?  or just return in each branch perhaps.

> +}
> +


