Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617BE1AC78C;
	Thu, 20 Jun 2024 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888973; cv=none; b=Rk2IFmh+hpPyhxYC3aDDFbPEAIm2+FjubJGILfpiJIWwF+zEpYkH60zBwIY+tGdOp9iSPsIZBTvxAwPMIVRlqyxRLUkL1FbvLCyTiV0Pi28x/lvmGzC7IS/Pjtaj9wQ8HYi+lNA75By8iVP9pzovc2EH9cBJXQmvArA/OlDuNlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888973; c=relaxed/simple;
	bh=d9Eu+SZ3bAdSXNa3pHJ49p3tp1YO7TgnuWMIowORRRI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBZyEDMRhn8zKPbzDeMUCPdQPcUoT4W1DGYuwBkL1ANz+zfP7k138r4pksnjNvOTBa2MR/Dd38oMEQlZYZbVou8LRusDJWRS28x2qdB5SPpZOAQ/9a5goNFPJrAxPqlSzY42PICWfDqzxZ062qO5EsjcSo6FmWlvvBDBVYqCEN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4gn24lNHz6JBd6;
	Thu, 20 Jun 2024 21:09:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 951FA140C9C;
	Thu, 20 Jun 2024 21:09:28 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 14:09:28 +0100
Date: Thu, 20 Jun 2024 14:09:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Yazen.Ghannam@amd.com>,
	<Robert.Richter@amd.com>
Subject: Re: [RFC PATCH 7/9] cxl/pci: Add atomic notifier callback for CXL
 PCIe port AER internal errors
Message-ID: <20240620140926.000029d2@Huawei.com>
In-Reply-To: <20240617200411.1426554-8-terry.bowman@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
	<20240617200411.1426554-8-terry.bowman@amd.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 17 Jun 2024 15:04:09 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL root ports, CXL downstream switch ports, and CXL upstream switch
> ports are bound to the PCIe port bus driver, portdrv. portdrv provides
> an atomic notifier chain for reporting PCIe port device AER
> correctable internal errors (CIE) and AER uncorrectable internal
> errors (UIE).
> 
> CXL PCIe port devices use AER CIE/UIE to report CXL RAS.[1]
> 
> Add a cxl_pci atomic notification callback for handling the portdrv's
> AER UIE/CIE notifications.
> 
> Register the atomic notification callback in the cxl_pci module's
> load. Unregister the callback in the cxl_pci driver's unload.
> 
> Implement the callback to check if the device parameter is a valid
> CXL PCIe port. If it is valid then make the notification callback call
> __cxl_handle_cor_ras() or __cxl_handle_ras() depending on the AER
> type.
> 
> [1] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>              Upstream Switch Ports
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Hi Terry,

Some comments inline.  Mostly this comes down to earlier question of whether
this notifier should be registered per device or globally. 
I think I still prefer per device, but attaching the handler will be trickier
and I'm guessing there may be some locking/lifetime issues doing that which
are avoided by a global notifier.

Jonathan

> ---
>  drivers/cxl/core/core.h |  4 ++
>  drivers/cxl/core/pci.c  | 97 ++++++++++++++++++++++++++++++++++++++---
>  drivers/cxl/core/port.c |  6 +--
>  drivers/cxl/cxl.h       |  5 +++
>  drivers/cxl/cxlpci.h    |  2 +
>  drivers/cxl/pci.c       | 19 +++++++-
>  6 files changed, 123 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index bc5a95665aa0..69bef1db6ee0 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -94,4 +94,8 @@ int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
>  				       enum access_coordinate_class access);
>  bool cxl_need_node_perf_attrs_update(int nid);
>  
> +struct cxl_dport *find_dport(struct cxl_port *port, int id);
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport);
> +
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 59a317ab84bb..e630eccb733d 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -689,7 +689,6 @@ EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
>  static void __cxl_handle_cor_ras(struct device *dev,
>  				 void __iomem *ras_base)
>  {
> -	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	void __iomem *addr;
>  	u32 status;
>  
> @@ -698,10 +697,17 @@ static void __cxl_handle_cor_ras(struct device *dev,
>  
>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +

Blank line probably not wanted as we want to group the status
check with the read (it's kind of an error check).

> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
> +		return;
> +
> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +	if (is_cxl_memdev(dev)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +
>  		trace_cxl_aer_correctable_error(cxlmd, status);
As below - don't bother with local cxlmd variable.

> -	}
> +	} else if (dev_is_pci(dev))
> +		trace_cxl_port_aer_correctable_error(dev, status);
>  }
>  
>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
> @@ -733,7 +739,6 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>  static bool __cxl_handle_ras(struct device *dev,
>  			     void __iomem *ras_base)
>  {
> -	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>  	void __iomem *addr;
>  	u32 status;
> @@ -759,7 +764,13 @@ static bool __cxl_handle_ras(struct device *dev,
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
> +	if (is_cxl_memdev(dev)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
Just use this inline.
		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev),
						  status, fe, hl);

> +
> +		trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
> +	} else if (dev_is_pci(dev))
> +		trace_cxl_port_aer_uncorrectable_error(dev, status);

As before, why no fe or hl?  I'm sure I'm missing some spec subtlty
but a comment would help me and others avoid that.

> +
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
>  	return true;
> @@ -882,6 +893,80 @@ static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>  	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
>  }
>  
> +static int match_uport(struct device *dev, void *data)
> +{
> +	struct device *uport_dev = (struct device *)data;
> +	struct cxl_port *port;
> +
> +	if (!is_cxl_port(dev))
> +		return 0;
> +
> +	port = to_cxl_port(dev);
> +
> +	return (port->uport_dev == uport_dev);
() doesn't add much so I'd drop them.

> +}
> +
> +static struct cxl_port *pci_to_cxl_uport(struct pci_dev *pdev)
> +{
> +	struct cxl_dport *dport;
> +	struct device *port_dev;
> +	struct cxl_port *port;
> +
> +	port = find_cxl_port(pdev->dev.parent, &dport);
> +	if (!port)
> +		return NULL;
> +	put_device(&port->dev);
I'm confused on the lifetimes. Doesn't it make more sense
to hold this until after you've stopped using it? So move the
put after device_find_child(...)

> +
> +	port_dev = device_find_child(&port->dev, &pdev->dev, match_uport);
> +	if (!port_dev)
> +		return NULL;
> +	put_device(port_dev);
> +
> +	port = to_cxl_port(port_dev);
> +
> +	return port;

	return to_cxl_port(port_dev);

> +}
> +
> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
> +{
> +	void __iomem *ras_base = NULL;
Don't initialize and...
> +
> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
> +		struct cxl_dport *dport;
> +
> +		find_cxl_port(&pdev->dev, &dport);
> +		ras_base = dport ? dport->regs.ras : NULL;
		if (dport)
			return dport->regs.ras;
> +	} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
> +		struct cxl_port *port = pci_to_cxl_uport(pdev);
> +
> +		ras_base = port ? port->regs.ras : NULL;
		if (port)
			return port->regs.ras;
> +	}
return NULL;
> +
> +	return ras_base;
> +}
> +
> +int port_internal_err_cb(struct notifier_block *unused,
> +			 unsigned long event, void *ptr)
> +{
> +	struct pci_dev *pdev = (struct pci_dev *)ptr;

I think you can use this notifier for other types of device in future?
If it's going to be global definitely want to check here that we
actually have a CXL port of some type.

It may be that via the various calls any non CXL device
will result in a safe error. However that's not obvious, so an
upfront check makes sense (or a per device notifier registration!)

> +	void __iomem *ras_base;
> +
> +	if (!pdev)
> +		return 0;
> +
> +	if (event == AER_CORRECTABLE) {
> +		ras_base = cxl_pci_port_ras(pdev);
> +		__cxl_handle_cor_ras(&pdev->dev, ras_base);

as below - one line should be fine for this.

> +	} else if ((event == AER_FATAL) || (event == AER_NONFATAL)) {
> +		ras_base = cxl_pci_port_ras(pdev);
> +		__cxl_handle_ras(&pdev->dev, ras_base);

		__cxl_handle_ras(&pdev->dev, cxl_pci_port_ras(pdev));

> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(port_internal_err_cb, CXL);
> +
>  /*
>   * Copy the AER capability registers using 32 bit read accesses.
>   * This is necessary because RCRB AER capability is MMIO mapped. Clear the
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 887ed6e358fb..d0f95c965ab4 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1027,7 +1027,7 @@ void put_cxl_root(struct cxl_root *cxl_root)
>  }
>  EXPORT_SYMBOL_NS_GPL(put_cxl_root, CXL);
>  
> -static struct cxl_dport *find_dport(struct cxl_port *port, int id)
> +struct cxl_dport *find_dport(struct cxl_port *port, int id)
>  {
>  	struct cxl_dport *dport;
>  	unsigned long index;
> @@ -1336,8 +1336,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>  	return NULL;
>  }
>  
> -static struct cxl_port *find_cxl_port(struct device *dport_dev,
> -				      struct cxl_dport **dport)
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport)
>  {
>  	struct cxl_find_port_ctx ctx = {
>  		.dport_dev = dport_dev,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 7cee678fdb75..04725344393b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -11,6 +11,7 @@
>  #include <linux/log2.h>
>  #include <linux/node.h>
>  #include <linux/io.h>
> +#include "../pci/pcie/portdrv.h"

Why add the include?  Maybe only needed in c files/

>  
>  /**
>   * DOC: cxl objects
> @@ -760,11 +761,15 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  #ifdef CONFIG_PCIEAER_CXL
>  void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
>  void cxl_setup_parent_uport(struct device *host, struct cxl_port *port);
> +int port_internal_err_cb(struct notifier_block *unused,
> +			 unsigned long event, void *ptr);
>  #else
>  static inline void cxl_setup_parent_dport(struct device *host,
>  					  struct cxl_dport *dport) { }
>  static inline void cxl_setup_parent_uport(struct device *host,
>  					  struct cxl_port *port) { }
> +static inline int port_internal_err_cb(struct notifier_block *unused,
> +				unsigned long event, void *ptr) { return 0; }
>  #endif
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 93992a1c8eec..6044955e1c48 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -130,4 +130,6 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +int port_err_nb_cb(struct notifier_block *unused,
> +		   unsigned long event, void *ptr);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 2ff361e756d6..f4183c5aea38 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -926,6 +926,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	return rc;
>  }
>  
> +struct notifier_block port_internal_err_nb = {
> +	.notifier_call = port_internal_err_cb,
> +};
> +
>  static const struct pci_device_id cxl_mem_pci_tbl[] = {
>  	/* PCI class code for CXL.mem Type-3 Devices */
>  	{ PCI_DEVICE_CLASS((PCI_CLASS_MEMORY_CXL << 8 | CXL_MEMORY_PROGIF), ~0)},
> @@ -974,6 +978,19 @@ static struct pci_driver cxl_pci_driver = {
>  	},
>  };
>  
> -module_pci_driver(cxl_pci_driver);
> +static int __init cxl_pci_init(void)
> +{
> +	atomic_notifier_chain_register(&portdrv_aer_internal_err_chain, &port_internal_err_nb);

Long line that you can easily break.

> +	return pci_register_driver(&cxl_pci_driver);
> +}
> +module_init(cxl_pci_init);
> +
> +static void __exit cxl_pci_exit(void)
> +{
> +	atomic_notifier_chain_unregister(&portdrv_aer_internal_err_chain, &port_internal_err_nb);

Long line that you can easily break.

> +	pci_unregister_driver(&cxl_pci_driver);
> +}
> +module_exit(cxl_pci_exit);
> +
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(CXL);

