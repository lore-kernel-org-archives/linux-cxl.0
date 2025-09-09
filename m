Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D93747F
	for <linux-cxl@vger.kernel.org>; Tue,  9 Sep 2025 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757433413; cv=none; b=tx+t1KnSh9017OEmlI3ZwZqY9JhZMb8N67m78E8cd8V592nRTM4Sba+RDg7jzhEihmKvHYvH/98ZdH2/ED1KUNkg1ilTmmD3sSnWsWAVC1X6DZpMzvGPbVUJDLaDiWQCtAplQfMoPWAtRWhCQsp5lVRa6doJpwifwMdoA/J5AtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757433413; c=relaxed/simple;
	bh=7Oy8R5+cQh3jrDUvl5k+mSlQSUnXzrn4AnZTzG4i0e4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lpfb7DJ5PI0TSl1jPZghvIa/DCNfpwJFBPx+jc6DBxZrc4Sk0YzamNwh/UW2z6QX3H6hx7TgFZB7qHZ5qCcFU85EE+g2rJYcOoRz/ZVBPDOEqIQk0SgD8NIHIZ0N93W30DOqESnAAtGQ0FBl2okdp8d8TBnFE57dPNYwlyLGjCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cLpHW5nDPz6DL1C;
	Tue,  9 Sep 2025 23:52:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 775581400D9;
	Tue,  9 Sep 2025 23:56:47 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 9 Sep
 2025 17:56:46 +0200
Date: Tue, 9 Sep 2025 16:56:45 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH v9 06/10] cxl: Defer dport allocation for switch ports
Message-ID: <20250909165645.0000525d@huawei.com>
In-Reply-To: <20250829180928.842707-7-dave.jiang@intel.com>
References: <20250829180928.842707-1-dave.jiang@intel.com>
	<20250829180928.842707-7-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 29 Aug 2025 11:09:24 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The current implementation enumerates the dports during the cxl_port
> driver probe. Without an endpoint connected, the dport may not be
> active during port probe. This scheme may prevent a valid hardware
> dport id to be retrieved and MMIO registers to be read when an endpoint
> is hot-plugged. Move the dport allocation and setup to behind memdev
> probe so the endpoint is guaranteed to be connected.
> 
> In the original enumeration behavior, there are 3 phases (or 2 if no CXL
> switches) for port creation. cxl_acpi() creates a Root Port (RP) from the
> ACPI0017.N device. Through that it enumerates downstream ports composed
> of ACPI0016.N devices through add_host_bridge_dport(). Once done, it
> uses add_host_bridge_uport() to create the ports that enumerate the PCI
> RPs as the dports of these ports. Every time a port is created, the port
> driver is attached, cxl_switch_porbe_probe() is called and
> devm_cxl_port_enumerate_dports() is invoked to enumerate and probe
> the dports.
> 
> The second phase is if there are any CXL switches. When the pci endpoint
> device driver (cxl_pci) calls probe, it will add a mem device and triggers
> the cxl_mem_probe(). cxl_mem_probe() calls devm_cxl_enumerate_ports()
> and attempts to discovery and create all the ports represent CXL switches.
> During this phase, a port is created per switch and the attached dports
> are also enumerated and probed.
> 
> The last phase is creating endpoint port which happens for all endpoint
> devices.
> 
> The new sequence is instead of creating all possible dports at initial
> port creation, defer port instantiation until a memdev beneath that
> dport arrives. Introduce devm_cxl_create_or_extend_port() to centralize
> the creation and extension of ports with new dports as memory devices
> arrive. As part of this rework, switch decoder target list is amended
> at runtime as dports show up.
> 
> While the decoders are allocated during the port driver probe,
> The decoders must also be updated since previously it's all done when all

it was all done?

> the dports are setup and now every time a dport is setup per endpoint, the
> switch target listing need to be updated with new dport. A
> guard(rwsem_write) is used to update decoder targets. This is similar to
> when decoder_populate_target() is called and the decoder programming
> must be protected.
> 
> Also the port registers are probed the first time when the first dport
> shows up. This ensures that the CXL link is established when the port
> registers are probed.
> 
> Link: https://lore.kernel.org/linux-cxl/20250305100123.3077031-1-rrichter@amd.com/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Hi Dave,

This isn't one of my more confident reviews but I think this looks ok.
Definitely could do with more eyes though. In the ideal world I'd emulate
a bunch of test cases to poke this with, but I'm snowed under for a while
so hopefully testing on the platforms that exhibit the problem will be enough.

One trivial comment inline.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> 
> ---
> v9:
> - Dropped tested-by tag by Robert since significant code changes.
>   Also dropped review tags.
> - Rework iteration loop. (Robert)
> - Dropped possible_ports in 'struct cxl_port' (Robert)
> - Stop the update_decoder_targets() iteration when found. (Robert)
> - Use number of decoders to gate decoder allocation.
> - cxl_port_get_or_add_dport() ->cxl_port_add_dport(). (Robert)
> - Unfold cxl_decoders_dport_update() (Robert)
> - Remove devm_cxl_add_dport_by_uport() (Robert)


> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index fa02366d35f2..9ec288ed39ae 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c

>  struct cxl_walk_context {
>  	struct pci_bus *bus;
>  	struct cxl_port *port;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index f379e4c5121d..fa7ed5d50064 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c

> +static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,
> +					      struct cxl_port *parent_port,
> +					      struct cxl_dport *parent_dport,
> +					      struct device *uport_dev,
> +					      struct device *dport_dev)
> +{
> +	resource_size_t component_reg_phys;
> +
> +	device_lock_assert(&parent_port->dev);
> +	if (!parent_port->dev.driver) {
> +		dev_warn(ep_dev,
> +			 "port %s:%s:%s disabled, failed to enumerate CXL.mem\n",
> +			 dev_name(&parent_port->dev), dev_name(uport_dev),
> +			 dev_name(dport_dev));
> +	}
> +
> +	struct cxl_port *port __free(put_cxl_port) =
> +		find_cxl_port_by_uport(uport_dev);
> +	if (!port) {
> +		component_reg_phys = find_component_registers(uport_dev);
> +		port = devm_cxl_add_port(&parent_port->dev, uport_dev,
> +					 component_reg_phys, parent_dport);
> +		if (IS_ERR(port))
> +			return (struct cxl_dport *)port;

			return ERR_CAST(port);
Just to make it even more obvious what is going on.

> +
> +		/*
> +		 * retry to make sure a port is found. a port device
> +		 * reference is taken.
> +		 */
> +		port = find_cxl_port_by_uport(uport_dev);
> +		if (!port)
> +			return ERR_PTR(-ENODEV);
> +
> +		dev_dbg(ep_dev, "created port %s:%s\n",
> +			dev_name(&port->dev), dev_name(port->uport_dev));
> +	} else {
> +		/*
> +		 * Port was created before right before this function is
> +		 * called. Signal the caller to deal with it.
> +		 */
> +		return ERR_PTR(-EAGAIN);
> +	}
> +
> +	guard(device)(&port->dev);
> +	return cxl_port_add_dport(port, dport_dev);
> +}


