Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674A5297A5F
	for <linux-cxl@vger.kernel.org>; Tue, 22 Apr 2025 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745341515; cv=none; b=d+d9mLkBj/69WxQi3W1Y15qKWASP98nWwCxQcY+PlK6jxLeawPBUcGVRlM7/+U1U4+Zcolu6SuEr4BdQFdaUReDFXgAE/ouewY/9EDJNpQJ9Ko6BdaOXZzbE8RMSPHj4vDfHjZ6T5MyyPXvq36MsTEoZ2yiCRtDLAO99KKaD2lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745341515; c=relaxed/simple;
	bh=qQGTbXpj0mkrrAye7WWrkJGXXBBQevBnwZ9aX+9C7RY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D16ZvoWqusIyLdj69EdjfjfkU5c7vFhhJArG3MBt7NMY/hh0WuhmEEsltocNTCIufgG7Yx97BaXnDWiaVmAsPji+q+0OMPrGWp2SboyUYw4/NobN7v7Zv/ItOipKWtbjA2pZNoFyA4h2C8SGVh0WwefFP9fEZDlu21q8w7X8t88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZhpQy6Wnkz6L6qT;
	Wed, 23 Apr 2025 01:00:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 22BDF1402A5;
	Wed, 23 Apr 2025 01:05:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Apr
 2025 19:05:06 +0200
Date: Tue, 22 Apr 2025 18:05:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<rrichter@amd.com>, <ming.li@zohomail.com>
Subject: Re: [PATCH 2/4] cxl: Defer hardware dport->port_id assignment and
 registers probing
Message-ID: <20250422180505.0000036a@huawei.com>
In-Reply-To: <20250404230049.3578835-3-dave.jiang@intel.com>
References: <20250404230049.3578835-1-dave.jiang@intel.com>
	<20250404230049.3578835-3-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 4 Apr 2025 15:57:34 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Current implementation only enuemrates the dports dupring the port probe.
> Without an endpoint connected, the dport may not be active during port
> probe. This scheme may prevent a valid hardware dport id to be retrieved
> and MMIO registers to be read when an endpoint is hot-plugged. Move the hw
> dport id assignment and the register probing to behind memdev probe so the
> endpoint is guaranteed to be connected.
A few additional comments from me.


Can we point at anything in the PCI spec to say whether those IDs not being
valid is allowed or not?  I always like to know whether to grump at hardware
folk or not if it they manage to duplicate something unexpected :)


> 
> The detection of duplicate dport for add_dport() is removed. The port_id
> is not read from the hw at this point any longer. The port->id will always
> be unique since it's retrieved from an ida. The dup detection thus become
> irrelevant.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/core.h |  4 ++
>  drivers/cxl/core/pci.c  | 74 ++++++++++++++++++++++++++++------
>  drivers/cxl/core/port.c | 88 ++++++++++++++++++++++-------------------
>  drivers/cxl/cxl.h       |  1 +
>  drivers/cxl/port.c      |  2 -
>  5 files changed, 114 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 15699299dc11..e2822ead6a67 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -134,4 +134,8 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		    u16 *return_code);
>  #endif
>  
> +int cxl_dport_probe(struct cxl_dport *dport, resource_size_t component_reg_phys,
> +		    resource_size_t rcrb);
> +void cxl_port_probe_dports(struct cxl_port *port);
> +
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 96fecb799cbc..a47dd032abd7 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -24,6 +24,66 @@ static unsigned short media_ready_timeout = 60;
>  module_param(media_ready_timeout, ushort, 0644);
>  MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");
>  
> +static int probe_dports(struct cxl_dport *dport)

Given return value is always ignored, maybe don't return anything?

> +{
> +	struct device *dport_dev = dport->dport_dev;
> +	struct cxl_port *port = dport->port;
> +	struct cxl_register_map map;
> +	struct pci_dev *pdev;
> +	u32 lnkcap, port_num;
> +	int rc;
> +
> +	if (!dev_is_pci(dport_dev))
> +		return 0;
> +
> +	/*
> +	 * dport->port_id is valid means that dport has been probed and is
> +	 * setup.
> +	 */
> +	if (dport->port_id != CXL_PORT_ID_INVALID)
> +		return 0;
> +
> +	pdev = to_pci_dev(dport_dev);
> +	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> +				  &lnkcap))
> +		return 0;

I'd be tempted to return an error that means come back later and eat it
at next level up if possible (though currently you eat all errors so
that is fine ;)

> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc) {
> +		dev_dbg(&port->dev, "failed to find component registers\n");
> +		return 0;

Likewise. Something called probe_dports() to me should be returning an erorr
if this happens and caller be responsible for ignoring that or not rather
than errors being eaten down here.

> +	}
> +
> +	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> +	rc = cxl_dport_probe(dport, map.resource, CXL_RESOURCE_NONE);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * port_id is only set if the register block is also probed
> +	 * successfully.
> +	 */
> +	dport->port_id = port_num;
> +	cxl_switch_parse_cdat(port);
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_port_probe_dports - probe downstream ports of the upstream port
> + * @port: cxl_port whose ->uport_dev is the upstream of dports to be probed
> + *

Bonus blank line doesn't add anything.

> + */
> +void cxl_port_probe_dports(struct cxl_port *port)
> +{
> +	struct cxl_dport *dport;
> +	unsigned long index;
> +
> +	device_lock_assert(&port->dev);
> +	xa_for_each(&port->dports, index, dport)
> +		probe_dports(dport);
> +}

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e90e55bc11ac..1c772c516dbe 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c

> @@ -1120,6 +1111,45 @@ static void cxl_dport_unlink(void *data)
>  	sysfs_remove_link(&port->dev.kobj, link_name);
>  }
>  
> +int cxl_dport_probe(struct cxl_dport *dport, resource_size_t component_reg_phys,
> +		    resource_size_t rcrb)
> +{
> +	struct device *dport_dev = dport->dport_dev;
> +	struct cxl_port *port = dport->port;
> +	int rc;
> +
> +	if (rcrb == CXL_RESOURCE_NONE) {
> +		rc = cxl_dport_setup_regs(&port->dev, dport,
> +					  component_reg_phys);
> +		if (rc)
> +			return rc;
> +	} else {
> +		dport->rcrb.base = rcrb;
> +		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
> +							 CXL_RCRB_DOWNSTREAM);
> +		if (component_reg_phys == CXL_RESOURCE_NONE) {
> +			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
> +			return -ENXIO;
> +		}
> +
> +		/*
> +		 * RCH @dport is not ready to map until associated with its
> +		 * memdev
> +		 */
> +		rc = cxl_dport_setup_regs(NULL, dport, component_reg_phys);
> +		if (rc)
> +			return rc;
> +
> +		dport->rch = true;
> +	}
> +
> +	if (component_reg_phys != CXL_RESOURCE_NONE)
> +		dev_dbg(dport_dev, "Component Registers found for dport: %pa\n",
> +			&component_reg_phys);
> +
> +	return 0;
> +}
> +
>  static struct cxl_dport *
>  __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  		     int port_id, resource_size_t component_reg_phys,
> @@ -1162,40 +1192,12 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	dport->port = port;
>  	dport->id = id;
> 

Maybe do this factoring out as a precursor patch?

> -	if (rcrb == CXL_RESOURCE_NONE) {
> -		rc = cxl_dport_setup_regs(&port->dev, dport,
> -					  component_reg_phys);
> -		if (rc) {
> -			ida_free(&port->dport_ida, id);
> -			return ERR_PTR(rc);
> -		}
> -	} else {
> -		dport->rcrb.base = rcrb;
> -		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
> -							 CXL_RCRB_DOWNSTREAM);
> -		if (component_reg_phys == CXL_RESOURCE_NONE) {
> -			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
> -			ida_free(&port->dport_ida, id);
> -			return ERR_PTR(-ENXIO);
> -		}
> -
> -		/*
> -		 * RCH @dport is not ready to map until associated with its
> -		 * memdev
> -		 */
> -		rc = cxl_dport_setup_regs(NULL, dport, component_reg_phys);
> -		if (rc) {
> -			ida_free(&port->dport_ida, id);
> -			return ERR_PTR(rc);
> -		}
> -
> -		dport->rch = true;
> +	rc = cxl_dport_probe(dport, component_reg_phys, rcrb);
> +	if (rc) {
> +		ida_free(&port->dport_ida, id);
> +		return ERR_PTR(rc);
>  	}
>
