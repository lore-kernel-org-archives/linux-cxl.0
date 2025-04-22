Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B07281532
	for <linux-cxl@vger.kernel.org>; Tue, 22 Apr 2025 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745342126; cv=none; b=g89/rFB88t9gFebMBBdtXkmxeam1o+6Yj380uhpA24/sNVhdfviVkUL6bnkWoNnVuqjjB4vwJqMBCYqrqcZJU3PfBT5NgMH9kNkID0vdsrVDObOKs1/Rlvo3t7Z8qUVSpobK8Yq3dkn2ObZMp3vGaEZcCEONX69455HmgtfcVJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745342126; c=relaxed/simple;
	bh=KHmaZchjp10S4Js/kJBa0n7DuuPAoVHA2ua/gpSfQXY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WaUdycCGu2P0tE5ZavXNwnHrB0Gkf8ApkRfx1lcsTgoyCIR60BZG9Pw6iOyi64tB346f5D394r7vxY/HDkas81QpwYL8u7AuUWwjv3z4bGk8avSh4MWi8OVYiUh2NubnAy8zlokXa/ywF8gfGa1HFHx1QfRoXVbtBBgbyjwi3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZhpfJ2cttz6K9Wm;
	Wed, 23 Apr 2025 01:10:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 27CAF1402ED;
	Wed, 23 Apr 2025 01:15:20 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Apr
 2025 19:15:19 +0200
Date: Tue, 22 Apr 2025 18:15:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<rrichter@amd.com>, <ming.li@zohomail.com>
Subject: Re: [PATCH 3/4] cxl: Add late host bridge uport mapping update
Message-ID: <20250422181518.00004cd9@huawei.com>
In-Reply-To: <20250404230049.3578835-4-dave.jiang@intel.com>
References: <20250404230049.3578835-1-dave.jiang@intel.com>
	<20250404230049.3578835-4-dave.jiang@intel.com>
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

On Fri, 4 Apr 2025 15:57:35 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Error message "cxl portN: Couldn't locate the CXL.cache and CXL.mem
> capability array header" is reported through testing when a platform is

Maybe call out this is 'a specific' platform rather than necessarily being
a general thing.

> enabled with PCIe hotplug. The cxl_acpi module is responsible for
> enumerating the host bridges through ACPI objects. During the enumeration
> of the host bridge upstream ports (uports), the root port (RP) registers
> are mapped. The enumeration can happen as soon as the cxl_acpi module
> probe() function is called. However if the CXL link between the endpoint
> device and the RP is not established before the enumeration happens,
> the platform may not expose DVSEC ID 3 and/or DVSEC ID 7 blocks which
> triggers the error message.
> 
> Add an attempt to map the register block under the memdev probe() port
> enumeration. When the PCI probe of the device endpoint is called, the
> driver is now communicating with the CXL device and the CXL link is
> considered established. Doing the register block mapping at that point
> guarantees that the mandatory DVSEC blocks are present.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

It's always challenging to get the balance right but I think it might
be worth a precursor patch to factor out some of the code you then reuse
here so that we can see how that is changed more easily.

> ---
>  drivers/cxl/acpi.c      | 17 +++++++++-
>  drivers/cxl/core/port.c | 72 +++++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/cxl.h       |  4 +++
>  drivers/cxl/port.c      | 19 ++---------
>  4 files changed, 93 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index cb14829bb9be..3c8f04bee9a3 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -662,9 +662,24 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	if (rc)
>  		return rc;
>  
> -	port = devm_cxl_add_port(host, bridge, component_reg_phys, dport);
> +	/*
> +	 * While there is a chance the uport gets mapped when the probe
> +	 * function gets called, it is not a guarantee due to acpi driver
> +	 * can be probed before the root port has established the CXL
> +	 * connection to the endpoint device. Bypass mapping during
> +	 * port creation by pass in CXL_RESOURCE_NONE for the

by passing in

> +	 * component_reg_phys parameter. After, set the 'resource'
> +	 * parameter of port->map to allow a setup via the endpoint
> +	 * memdev probe.
> +	 */
> +	port = devm_cxl_add_port(host, bridge, CXL_RESOURCE_NONE, dport);
>  	if (IS_ERR(port))
>  		return PTR_ERR(port);
> +	port->reg_map = (struct cxl_register_map) {
> +		.host = host,
> +		.reg_type = CXL_REGLOC_RBI_EMPTY,
> +		.resource = component_reg_phys,
> +	};
>  
>  	dev_info(bridge, "host supports CXL\n");
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1c772c516dbe..8c29db214d60 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c

> @@ -1565,6 +1571,57 @@ static resource_size_t find_component_registers(struct device *dev)
>  	return map.resource;
>  }
>  
> +int devm_cxl_decoders_setup(struct cxl_port *port)
> +{
> +	struct cxl_dport *dport;
> +	struct cxl_hdm *cxlhdm;
> +	unsigned long index;
> +	int dports = 0;
> +
> +	/* Make sure that no decoders have been allocated before proceeding. */
> +	if (!ida_is_empty(&port->decoder_ida))
> +		return 0;
> +
> +	cxlhdm = devm_cxl_setup_hdm(port, NULL);
> +	if (!IS_ERR(cxlhdm))
> +		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
> +
> +	if (PTR_ERR(cxlhdm) != -ENODEV) {
> +		dev_err(&port->dev, "Failed to map HDM decoder capability\n");
> +		return PTR_ERR(cxlhdm);
> +	}
> +
> +	xa_for_each(&port->dports, index, dport)
> +		dports++;
> +
> +	if (dports == 1) {
> +		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
> +		return devm_cxl_add_passthrough_decoder(port);
> +	}
> +
> +	dev_err(&port->dev, "HDM decoder capability not found\n");
> +	return -ENXIO;
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_decoders_setup, "CXL");

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 0e61b76f5c13..b27e9d3306fe 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -906,6 +906,10 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  			     struct access_coordinate *c2);
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> +int devm_cxl_decoders_setup(struct cxl_port *port);
> +bool dev_is_cxl_root_child(struct device *dev);
> +int cxl_port_setup_regs(struct cxl_port *port,
> +			resource_size_t component_reg_phys);
>  
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 30c0335089b9..dc532ee9065f 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -59,7 +59,6 @@ static int discover_region(struct device *dev, void *root)
>  
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
> -	struct cxl_hdm *cxlhdm;
>  	int rc;
>  
>  	/* Cache the data early to ensure is_visible() works */
> @@ -69,22 +68,10 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  	if (rc < 0)
>  		return rc;
>  
I'd consider factoring out the bulk of this as a precursor patch so we
can clearly see the functional changes in this one as well as the
reuse.

Maybe pass in the dports for that refactor and switch to the xa_for_each()
in this patch.


> -	cxlhdm = devm_cxl_setup_hdm(port, NULL);
> -	if (!IS_ERR(cxlhdm))
> -		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
> +	if (dev_is_cxl_root_child(&port->dev))
> +		return 0;
>  
> -	if (PTR_ERR(cxlhdm) != -ENODEV) {
> -		dev_err(&port->dev, "Failed to map HDM decoder capability\n");
> -		return PTR_ERR(cxlhdm);
> -	}
> -
> -	if (rc == 1) {
> -		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
> -		return devm_cxl_add_passthrough_decoder(port);
> -	}
> -
> -	dev_err(&port->dev, "HDM decoder capability not found\n");
> -	return -ENXIO;
> +	return devm_cxl_decoders_setup(port);
>  }
>  
>  static int cxl_endpoint_port_probe(struct cxl_port *port)

