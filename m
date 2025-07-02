Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DE522FF59
	for <linux-cxl@vger.kernel.org>; Wed,  2 Jul 2025 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451530; cv=none; b=rj6eN/dOcMupb8sgE8mJh3hdwIrZApfUbkKtOBLNBDCgzPKZ1icbrIoPFy1vBlFLOgkIi8Sx5GyWt/iW0VpeJtifS23c1Do5ze2BOcUSe6y3sTAX7NvPQB2Pf1Ml1OYV1eBq5YkjxykcAVuaxhUUPm95NFoESyBDH0dkafrsaFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451530; c=relaxed/simple;
	bh=rJJM3Qk85S0PsvbU0FT58/WUubhtiyZ2IBo59X1z0SA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcrSiqDQOXNnG5fqBhFZMTaTXIQOrJ/O29XeN7MGgnhP8lFo8Xl0rakVIiubG01Jf2Ylp4h0ZionpGwa6IVnUEstuN+yPrQl5gr2JS3xzCRchVbVHVDIY6+bnlOi+uLABUn0B369/wJNhPU8xkVkPT02SbOlDq2z3RhjrfqP2kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXG4d6q7Yz6L5Sr;
	Wed,  2 Jul 2025 18:15:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D938B1400D9;
	Wed,  2 Jul 2025 18:18:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 2 Jul
 2025 12:18:38 +0200
Date: Wed, 2 Jul 2025 11:18:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH v4 4/9] cxl: Defer dport allocation for switch ports
Message-ID: <20250702111837.000032c5@huawei.com>
In-Reply-To: <69efff01-1fff-488c-8bea-496a56cb057d@intel.com>
References: <20250624213916.1665889-1-dave.jiang@intel.com>
	<20250624213916.1665889-5-dave.jiang@intel.com>
	<20250701121022.000035d1@huawei.com>
	<69efff01-1fff-488c-8bea-496a56cb057d@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 1 Jul 2025 13:18:16 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 7/1/25 4:10 AM, Jonathan Cameron wrote:
> > On Tue, 24 Jun 2025 14:39:11 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> >> The current implementation enumerates the dports during the cxl_port
> >> driver probe. Without an endpoint connected, the dport may not be
> >> active during port probe. This scheme may prevent a valid hardware
> >> dport id to be retrieved and MMIO registers to be read when an endpoint
> >> is hot-plugged. Move the dport allocation and setup to behind memdev
> >> probe so the endpoint is guaranteed to be connected.
> >>
> >> In the original enumeration behavior, there are 3 phases (or 2 if no CXL
> >> switches) for port creation. cxl_acpi() creates a Root Port (RP) from the
> >> ACPI0017.N device. Through that it enumerate downstream ports composed
> >> of ACPI0016.N devices through add_host_bridge_dport(). Once done, it
> >> use add_host_bridge_uport() to create the ports that enumerates the PCI
> >> RPs as the dports of these ports. Every time a port is created, the port
> >> driver is attached and drv->probe() is called and
> >> devm_cxl_port_enumerate_dports() is envoked to enumerate and probe
> >> the dports.
> >>
> >> The second phase is if there are any CXL switches. When the pci endpoint
> >> device driver (cxl_pci) calls probe, it will add a mem device and triggers
> >> the cxl_mem->probe(). cxl_mem->probe() calls devm_cxl_enumerate_ports()
> >> and attempts to discovery and create all the ports represent CXL switches.
> >> During this phase, a port is created per switch and the attached dports
> >> are also enumerated and probed.
> >>
> >> The last phase is creating endpoint port which happens for all endpoint
> >> devices.
> >>
> >> In this commit, the port create and its dport probing in cxl_acpi is not
> >> changed. That will be handled in a different patch later on. The behavior
> >> change is only for CXL switch ports. Only the dport that is part of the
> >> path for an endpoint device to the RP will be probed. This happens
> >> naturally by the code walking up the device hierarchy and identifying the
> >> upstream device and the downstream device.
> >>
> >> There are two points where the interception of dport creation happens
> >> during the devm_cxl_enumerate_ports() path. The first location is right
> >> before the function calls add_port_attch_ep() where it does the dport  
> > 
> > attach_ep()
> >   
> >> allocation for the RP. Once the dport is allocated, the iteration path
> >> is reset to the beginning to try again. The second location happens
> >> in add_port_attach_ep() after the location where either the port is
> >> discovered or allocated new if it does not exist.
> >>
> >> Locking of port device during __cxl_port_add_dport() protects modifications
> >> against the port and its dports while multiple endpoints can be probing at
> >> the same time and the same port is being modified concurrently.
> >>
> >> While the decoders are allocated during the port driver probe,
> >> The decoders must also be updated since previously it's all done when all
> >> the dports are setup and now every time a dport is setup per endpoint, the
> >> switch target listing need to be updated with new dport. A
> >> guard(rwsem_write) is used to update decoder targets. This is similar to
> >> when decoder_populate_target() is called and the decoder programming
> >> must be protected.
> >>
> >> Link: https://lore.kernel.org/linux-cxl/20250305100123.3077031-1-rrichter@amd.com/
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >> ---
> >> v4:
> >> - Allocate dport when they are found via endpoint probe. (Robert)  
> > 
> > A few comments inline. 
> >   
> >> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> >> index b50551601c2e..6e9b5ab69de0 100644
> >> --- a/drivers/cxl/core/pci.c
> >> +++ b/drivers/cxl/core/pci.c
> >> @@ -24,6 +24,44 @@ static unsigned short media_ready_timeout = 60;
> >>  module_param(media_ready_timeout, ushort, 0644);
> >>  MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");  
> >   
> >>  struct cxl_walk_context {
> >>  	struct pci_bus *bus;
> >>  	struct cxl_port *port;
> >> @@ -1169,3 +1207,53 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
> >>  
> >>  	return 0;
> >>  }
> >> +
> >> +static int match_dport(struct pci_dev *pdev, void *data)
> >> +{
> >> +	struct cxl_walk_context *ctx = data;
> >> +	int type = pci_pcie_type(pdev);
> >> +
> >> +	if (pdev->bus != ctx->bus)
> >> +		return 0;
> >> +	if (!pci_is_pcie(pdev))
> >> +		return 0;
> >> +	if (type != ctx->type)  
> > 
> > I'm lost.  How would bus have matched, but type not?
> > Add a comment.  
> 
> I don't follow. It could be PCI bus but not the right device type (i.e. not a downstream port or root port). Or do you mean explain that? Sure. 

Miss read. I'd confused bus and subordinate though
even that would not be enough as might be a usp.

So this is fine, ignore me :)




> 
> >   
> >> +		return 0;
> >> +
> >> +	ctx->count++;
> >> +	return 0;
> >> +}
> >> +
> >> +int cxl_port_get_total_dports(struct cxl_port *port)  
> > 
> > See comment below on renaming this given it doesn't return
> > the number.
> >   
> >> +{
> >> +	struct pci_bus *bus = cxl_port_to_pci_bus(port);
> >> +	struct cxl_walk_context ctx;
> >> +	int type;
> >> +
> >> +	if (!bus) {
> >> +		dev_err(&port->dev, "No PCI bus found for port %s\n",
> >> +			dev_name(&port->dev));
> >> +		return -ENXIO;
> >> +	}
> >> +
> >> +	if (pci_is_root_bus(bus))
> >> +		type = PCI_EXP_TYPE_ROOT_PORT;
> >> +	else
> >> +		type = PCI_EXP_TYPE_DOWNSTREAM;
> >> +
> >> +	ctx = (struct cxl_walk_context) {
> >> +		.bus = bus,
> >> +		.type = type,
> >> +	};
> >> +	pci_walk_bus(bus, match_dport, &ctx);
> >> +
> >> +	port->total_dports = ctx.count;
> >> +	if (port->total_dports == 0) {
> >> +		dev_warn(&port->dev, "No dports found for port %s on bus %s\n",
> >> +			 dev_name(&port->dev), bus->name);
> >> +		return -ENXIO;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(cxl_port_get_total_dports, "CXL");
> >> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> >> index 9691da831224..3872638c439b 100644
> >> --- a/drivers/cxl/core/port.c
> >> +++ b/drivers/cxl/core/port.c
> >> @@ -1551,6 +1551,134 @@ static resource_size_t find_component_registers(struct device *dev)
> >>  	return map.resource;
> >>  }  
> > 
> > 
> >   
> >> +
> >> +static int devm_cxl_add_dport_by_uport(struct device *uport_dev,
> >> +				       struct device *dport_dev,
> >> +				       struct cxl_dport **dport)
> >> +{
> >> +	*dport = NULL;
> >> +	struct cxl_port *port __free(put_cxl_port) =
> >> +		find_cxl_port_by_uport(uport_dev);
> >> +	if (!port)
> >> +		return -ENODEV;
> >> +
> >> +	guard(device)(&port->dev);
> >> +	return devm_cxl_port_add_dport(port, dport_dev, dport);
> >> +}
> >> +
> >> +static int devm_cxl_add_dport_for_rp(struct device *uport_dev,
> >> +				     struct device *dport_dev,
> >> +				     struct cxl_dport **dport)  
> > 
> > That this sets *dport = NULL lead me to get confused at the caller.
> > Perhaps instead these could return a dport *, NULL or ERR_PTR()
> > instead?  
> 
> Yeah I went back and forth a bit on this one. I needed a way to
distinguish between returning an existing dport vs a newly allocated dport.
I suppose I could return PTR_ERR(-EEXIST) and then try to retrieve that dport again. Thoughts?

Using assignment or not after reporting success on something called 'add' is a rather non intuitive.
I was thinking NULL but -EEXIST is more explicit so agreed that
would work and doesn't look like the handling will be too bad

	dport = devm_cxl_add_dport_for_rp(uport_dev, dport_dev);
	if (!IS_ERR(dport)) /* Added dport so restart enumeration */
		goto retry;
	if (PTR_ERR(dport != -EEXIST))
		return PTR_ERR(dport);

or something along those lines.



