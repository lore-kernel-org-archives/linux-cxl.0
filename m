Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DA8C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 15:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE3D61103
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 15:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349579AbhICPXA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Sep 2021 11:23:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3738 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbhICPXA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Sep 2021 11:23:00 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H1M1J09ndz67b23;
        Fri,  3 Sep 2021 23:20:20 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 3 Sep 2021 17:21:57 +0200
Received: from localhost (10.52.121.127) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Fri, 3 Sep 2021
 16:21:56 +0100
Date:   Fri, 3 Sep 2021 16:21:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Bjorn Helgaas" <bjorn@helgaas.com>
Subject: Re: [PATCH 07/13] cxl/memdev: Determine CXL.mem capability
Message-ID: <20210903162157.00000a43@Huawei.com>
In-Reply-To: <20210902195017.2516472-8-ben.widawsky@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
        <20210902195017.2516472-8-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.121.127]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 2 Sep 2021 12:50:11 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> If the "upstream" port of the endpoint is an enumerated downstream CXL
> port, and the device itself is CXL capable and enabled, the memdev
> driver can bind. This binding useful for region configuration/creation
> because it provides a clean way for the region code to determine if the
> memdev is actually CXL capable.
> 
> A memdev/hostbridge probe race is solved with a full CXL bus rescan at
> the end of ACPI probing (see comment in code for details). Switch
> enumeration will be done as a follow-on patch. As a result, if a switch
> is in the topology the memdev driver will not bind to any devices.
> 
> CXL.mem capability is checked lazily at the time a region is bound.
> This is in line with the other configuration parameters.
> 
> Below is an example (mem0, and mem1) of CXL memdev devices that now
> exist on the bus.
> 
> /sys/bus/cxl/devices/
> ├── decoder0.0 -> ../../../devices/platform/ACPI0017:00/root0/decoder0.0
> ├── mem0 -> ../../../devices/pci0000:34/0000:34:01.0/0000:36:00.0/mem0
> ├── mem1 -> ../../../devices/pci0000:34/0000:34:00.0/0000:35:00.0/mem1
> ├── pmem0 -> ../../../devices/pci0000:34/0000:34:01.0/0000:36:00.0/mem0/pmem0
> ├── pmem1 -> ../../../devices/pci0000:34/0000:34:00.0/0000:35:00.0/mem1/pmem1
> ├── port1 -> ../../../devices/platform/ACPI0017:00/root0/port1
> └── root0 -> ../../../devices/platform/ACPI0017:00/root0
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

+CC Bjorn.  Given we are moving the (nearly) generic DVSEC lookup routine, perhaps now
is time to move it into PCI core code?

> ---
>  drivers/cxl/acpi.c        | 27 +++++++-----------
>  drivers/cxl/core/bus.c    | 60 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/memdev.c |  6 ++++
>  drivers/cxl/cxl.h         |  2 ++
>  drivers/cxl/cxlmem.h      |  2 ++
>  drivers/cxl/mem.c         | 55 ++++++++++++++++++++++++++++++++++-
>  drivers/cxl/pci.c         | 23 ---------------
>  drivers/cxl/pci.h         |  7 ++++-
>  8 files changed, 141 insertions(+), 41 deletions(-)
> 

...

> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 256e55dc2a3b..56f57302d27b 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c

...

> @@ -596,6 +625,37 @@ int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld)
>  }
>  EXPORT_SYMBOL_GPL(cxl_decoder_autoremove);
>  
> +/**
> + * cxl_pci_dvsec - Gets offset for the given DVSEC id
> + * @pdev: PCI device to search for the DVSEC
> + * @dvsec: DVSEC id to look for
> + *
> + * Return: offset within the PCI header for the given DVSEC id. 0 if not found
> + */
> +int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
> +{
> +	int pos;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
> +	if (!pos)
> +		return 0;
> +
> +	while (pos) {
> +		u16 vendor, id;
> +
> +		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vendor);
> +		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2, &id);
> +		if (vendor == PCI_DVSEC_VENDOR_ID_CXL && dvsec == id)
> +			return pos;
> +
> +		pos = pci_find_next_ext_capability(pdev, pos,
> +						   PCI_EXT_CAP_ID_DVSEC);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cxl_mem_dvsec);

That's not going to work. (pci/mem)  + Can we move this to the PCI core now?
Wasn't done originally because there were several copies in various different
trees that needed to all come together. Oddly only this one seems to have
made it in though.  


> +
>  /**
>   * __cxl_driver_register - register a driver for the cxl bus
>   * @cxl_drv: cxl driver structure to attach
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index c9dd054bd813..0068b5ff5f3e 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -337,3 +337,9 @@ void cxl_memdev_exit(void)
>  {
>  	unregister_chrdev_region(MKDEV(cxl_mem_major, 0), CXL_MEM_MAX_DEVS);
>  }
> +
> +bool is_cxl_mem_capable(struct cxl_memdev *cxlmd)
> +{

This feels like it needs a comment to say why that's a valid check to use
to find out if it is mem capable.

> +	return !!cxlmd->dev.driver;
> +}
> +EXPORT_SYMBOL_GPL(is_cxl_mem_capable);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b48bdbefd949..a168520d741b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -283,8 +283,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>  				   resource_size_t component_reg_phys,
>  				   struct cxl_port *parent_port);
>  
> +bool is_cxl_port(struct device *dev);
>  int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
>  		  resource_size_t component_reg_phys);
> +struct cxl_dport *find_dport_by_dev(struct cxl_port *port, const struct device *dev);
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 811b24451604..88264204c4b9 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -51,6 +51,8 @@ static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_mem *cxlm);
>  
> +bool is_cxl_mem_capable(struct cxl_memdev *cxlmd);
> +
>  /**
>   * struct cxl_mbox_cmd - A command to be submitted to hardware.
>   * @opcode: (input) The command set and command submitted to hardware.
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 978a54b0a51a..b6dc34d18a86 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -2,8 +2,10 @@
>  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/pci.h>
>  
>  #include "cxlmem.h"
> +#include "pci.h"
>  
>  /**
>   * DOC: cxl mem
> @@ -17,9 +19,60 @@
>   * components.
>   */
>  
> +static int port_match(struct device *dev, const void *data)
> +{
> +	struct cxl_port *port;
> +
> +	if (!is_cxl_port(dev))
> +		return 0;
> +
> +	port = to_cxl_port(dev);
> +
> +	if (find_dport_by_dev(port, (struct device *)data))
Why the cast?

If this isn't modified in later patches

	return find_dport_by_dev(port, data);


> +		return 1;
> +
> +	return 0;
> +}
> +
> +static bool is_cxl_mem_enabled(struct pci_dev *pdev)
> +{
> +	int pcie_dvsec;
> +	u16 dvsec_ctrl;
> +
> +	pcie_dvsec = cxl_pci_dvsec(pdev, PCI_DVSEC_ID_PCIE_DVSEC_CXL_DVSEC_ID);
> +	if (!pcie_dvsec) {
> +		dev_info(&pdev->dev, "Unable to determine CXL protocol support");
> +		return false;
> +	}
> +
> +	pci_read_config_word(pdev,
> +			     pcie_dvsec + PCI_DVSEC_ID_CXL_PCIE_CTRL_OFFSET,
> +			     &dvsec_ctrl);
> +	if (!(dvsec_ctrl & CXL_PCIE_MEM_ENABLE)) {
> +		dev_info(&pdev->dev, "CXL.mem protocol not supported on device");

In the ctrl field that indicates it's not on, rather than not supported.
Hence I think the dev_info message is wrong.

> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int cxl_mem_probe(struct device *dev)
>  {
> -	return -EOPNOTSUPP;
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_mem *cxlm = cxlmd->cxlm;
> +	struct device *pdev_parent = cxlm->dev->parent;
> +	struct pci_dev *pdev = to_pci_dev(cxlm->dev);
> +	struct device *port_dev;
> +
> +	if (!is_cxl_mem_enabled(pdev))
> +		return -ENODEV;
> +
> +	/* TODO: if parent is a switch, this will fail. */
> +	port_dev = bus_find_device(&cxl_bus_type, NULL, pdev_parent, port_match);
> +	if (!port_dev)
> +		return -ENODEV;
> +
> +	return 0;
>  }
>  
>  static void cxl_mem_remove(struct device *dev)

...

> diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> index 8c1a58813816..d6b9978d05b0 100644
> --- a/drivers/cxl/pci.h
> +++ b/drivers/cxl/pci.h
> @@ -11,7 +11,10 @@
>   */
>  #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
>  #define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
> -#define PCI_DVSEC_ID_CXL		0x0
> +
> +#define PCI_DVSEC_ID_PCIE_DVSEC_CXL_DVSEC_ID	0x0

Why the rename to this?  DVSEC x3???  Can we get away with something like...

> +#define PCI_DVSEC_ID_CXL_PCIE_CTRL_OFFSET	0xC
> +#define   CXL_PCIE_MEM_ENABLE			BIT(2)
>  
>  #define PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID	0x8

Mind you I'm not clear why this one has DVSEC twice either...

>  #define PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET	0xC

This one has nothing to do with DVSEC ID... 

> @@ -29,4 +32,6 @@
>  
>  #define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
>  
> +int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec);
> +
>  #endif /* __CXL_PCI_H__ */

