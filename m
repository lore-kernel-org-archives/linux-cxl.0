Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5330C433F5
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 17:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2781601FF
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 17:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350310AbhICR51 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:57:27 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3743 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350346AbhICR5Z (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Sep 2021 13:57:25 -0400
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H1QRH6wmlz67jsb;
        Sat,  4 Sep 2021 01:54:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 3 Sep 2021 19:56:23 +0200
Received: from localhost (10.52.121.127) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Fri, 3 Sep 2021
 18:56:22 +0100
Date:   Fri, 3 Sep 2021 18:56:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 13/13] cxl/mem: Enumerate switch decoders
Message-ID: <20210903185623.00007135@Huawei.com>
In-Reply-To: <20210902195017.2516472-14-ben.widawsky@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
        <20210902195017.2516472-14-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.127]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 2 Sep 2021 12:50:17 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Switches work much in the same way as hostbridges. The primary
> difference is that they are enumerated, and probed via regular PCIe
> mechanisms. A switch has 1 upstream port, and n downstream ports.
> Ultimately a memory device attached to a switch can determine if it's in
> a CXL capable subset of the topology if the switch is CXL capable.
> 
> The algorithm introduced enables enumerating switches in a CXL topology.
> It walks up the topology until it finds a root port (which is enumerated
> by the cxl_acpi driver). Once at the top, it walks back down adding all
> downstream ports along the way.
> 
> Note that practically speaking there can be at most 3 levels of switches
> with the current 2.0 spec. This is because there is a max interleave of
> 8 defined in the spec. If there is a single hostbridge and only 1 root
> port was CXL capable, you could have 3 levels of x2 switches, making
> the x8 interleave. However, as far as the spec is concerned, there can
> be infinite number of switches since a x1 switch is allowed, and
> future versions of the spec may allow for a larger total interleave.

Or you could be lazy and rely on the statement in CXL 2.0 that it supports
only a single level of switching (search for "single level" in 1.4.1)
Lots of other reasons it's far from infinite... (number of busses etc).

I'll not speculate on what might be supported in the future.

A few minor comments below.

Jonathan

> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/mem.c | 130 +++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/pci.c |   8 ---
>  drivers/cxl/pci.h |   8 +++
>  3 files changed, 137 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index aba9a07d519f..dc8ca43d5bfc 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -56,6 +56,133 @@ static bool is_cxl_mem_enabled(struct pci_dev *pdev)
>  	return true;
>  }
>  
> +/* TODO: dedeuplicate this from drivers/cxl/pci.c? */

That seems like a question with an obvious answer...

> +static unsigned long get_component_regs(struct pci_dev *pdev)
> +{
> +	unsigned long component_reg_phys = CXL_RESOURCE_NONE;
> +	u32 regloc_size, regblocks;
> +	int regloc, i;
> +
> +	regloc = cxl_pci_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
> +	if (!regloc) {
> +		dev_err(&pdev->dev, "register location dvsec not found\n");
> +		return component_reg_phys;
> +	}
> +
> +	/* Get the size of the Register Locator DVSEC */
> +	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> +	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> +
> +	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
> +	regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
> +
> +	for (i = 0; i < regblocks; i++, regloc += 8) {
> +		u32 reg_lo, reg_hi;
> +		u8 reg_type;
> +		u64 offset;
> +		u8 bar;
> +
> +		pci_read_config_dword(pdev, regloc, &reg_lo);
> +		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
> +
> +		cxl_decode_register_block(reg_lo, reg_hi, &bar, &offset,
> +					  &reg_type);
> +
> +		if (reg_type != CXL_REGLOC_RBI_COMPONENT)
> +			continue;
> +
> +		component_reg_phys = pci_resource_start(pdev, bar) + offset;
> +	}
> +
> +	return component_reg_phys;
> +}
> +
> +static void enumerate_uport(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	/*
> +	 * Parent's parent should be another uport, since we don't have root
> +	 * ports here
> +	 */
> +	if (dev_WARN_ONCE(dev, !dev->parent->parent, "No grandparent port\n"))
> +		return;
> +
> +	if (!is_cxl_port(dev->parent->parent)) {
> +		dev_info(dev, "Parent of uport isn't a CXL port (%s)\n",
> +			 dev_name(dev->parent->parent));
> +		return;
> +	}
> +
> +	devm_cxl_add_port(dev, dev, get_component_regs(pdev),
> +			  to_cxl_port(dev->parent));
> +}
> +
> +static void enumerate_dport(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	u32 port_num, lnkcap;
> +
> +	if (dev_WARN_ONCE(dev, !dev->parent, "No parent port\n"))
> +		return;
> +
> +	if (!is_cxl_port(dev->parent)) {
> +		dev_info(dev, "Uport isn't a CXL port %s\n",
> +			 dev_name(dev->parent));
> +		return;
> +	}
> +
> +	/* TODO: deduplicate from drivers/cxl/acpi.c? */
> +	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> +				  &lnkcap) != PCIBIOS_SUCCESSFUL)
> +		return;
> +	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> +
> +	cxl_add_dport(to_cxl_port(dev->parent), dev, port_num,
> +		      get_component_regs(pdev));
> +}
> +
> +/*
> + * Walk up the topology until we get to the root port (ie. parent is a
> + * cxl port). From there walk back down adding the additional ports. If the
> + * parent isn't a PCIe switch (upstream or downstream port), the downstream
> + * endpoint(s) cannot be CXL enabled.
> + *
> + * XXX: It's possible that cxl_acpi hasn't yet enumerated the root ports, and
> + * so that will rescan the CXL bus, thus coming back here.
> + */
> +static void enumerate_switches(struct device *dev)
> +{
> +	struct pci_dev *pdev;
> +	int type;
> +
> +	if (unlikely(!dev))

Unlikely markings seems unlikely to be necessary. I'm assuming
this is far from a hot path!

> +		return;
> +
> +	if (unlikely(!dev_is_pci(dev)))
> +		return;
> +
> +	pdev = to_pci_dev(dev);
> +
> +	if (unlikely(!pci_is_pcie(pdev)))
> +		return;
> +
> +	if (!is_cxl_mem_enabled(pdev))
> +		return;
> +
> +	type = pci_pcie_type(pdev);
> +
> +	if (type != PCI_EXP_TYPE_UPSTREAM && type != PCI_EXP_TYPE_DOWNSTREAM)
> +		return;
> +
> +	enumerate_switches(dev->parent);
> +
> +	if (type == PCI_EXP_TYPE_UPSTREAM)
> +		enumerate_uport(dev);
> +	if (type == PCI_EXP_TYPE_DOWNSTREAM)
> +		enumerate_dport(dev);
> +}
> +
>  static int cxl_mem_probe(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> @@ -68,7 +195,8 @@ static int cxl_mem_probe(struct device *dev)
>  	if (!is_cxl_mem_enabled(pdev))
>  		return -ENODEV;
>  
> -	/* TODO: if parent is a switch, this will fail. */
> +	enumerate_switches(dev->parent);
> +
>  	port_dev = bus_find_device(&cxl_bus_type, NULL, pdev_parent, port_match);
>  	if (!port_dev)
>  		return -ENODEV;

