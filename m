Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F18C636D4
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Feb 2023 20:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBMUvR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 13 Feb 2023 15:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBMUvQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 13 Feb 2023 15:51:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF88C1F4B4
        for <linux-cxl@vger.kernel.org>; Mon, 13 Feb 2023 12:51:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F62B612D8
        for <linux-cxl@vger.kernel.org>; Mon, 13 Feb 2023 20:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E4BC433D2;
        Mon, 13 Feb 2023 20:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676321474;
        bh=nqZWeawetCZUiBZJqvZpswADTuDYnXkbQnTUDWGQKjQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=myZB+Gr70wHhOH4e1GmdOPLnUKINlCY1NIx/e1OikPaPjHN5ZmusGIfMgO0A8WROV
         VrZB8MwD8iwWg37Q1cqN6GBgdC1JLhLMrWVT9YUpWg0pTGne5BRf/gbri3Gyz4PcXS
         5nnT8oAPyPZjbJggKIqzR+4QK+UaLo1cMPajJvFMcvKEJgXBod/yrkM+o18Qf0gja5
         gkjOkvH7dpb2dOMxloDKAGQsRzxfIzvGBTjZm+t/4pL0YdNQdHPrd835tVuvrpmXuH
         Yfdf8uOo1QrAyfLzAHzhjpxdWluOBI89xMjd5qx/VHmgVvneTPmfjNGZkFmv/48z8S
         bFz6oZ5DU80mQ==
Date:   Mon, 13 Feb 2023 14:51:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, bhelgaas@google.com, ira.weiny@intel.com,
        lukas@wunner.de
Subject: Re: [PATCH v7] cxl: add RAS status unmasking for CXL
Message-ID: <20230213205113.GA2930045@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167632033967.4153635.2596647333624343145.stgit@djiang5-mobl3.local>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Feb 13, 2023 at 01:32:21PM -0700, Dave Jiang wrote:
> By default the CXL RAS mask registers bits are defaulted to 1's and
> suppress all error reporting. If the kernel has negotiated ownership
> of error handling for CXL then unmask the mask registers by writing 0s.
> 
> PCI_EXP_DEVCTL capability is checked to see uncorrectable or correctable
> errors bits are set before unmasking the respective errors.
> 
> CXL RAS CE and UE masks are checked against PCI_EXP_AER_FLAGS before
> unmasking.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

One register size issue below, and 

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_regs.h

> ---
> Patch based on top of:
> ttps://lore.kernel.org/linux-cxl/167632012093.4153151.5360778069735064322.stgit@djiang5-mobl3.local/T/#u
> 
> v7:
> - Check PCI_EXP_DEVCTL to enable related RAS errors.
> v6:
> - Call cxl_pci_ras_unmask() based on return of pci_enable_pcie_error_reporting()
> - Check PCI_EXP_DEVCTL for UE and CE bit before unmasking the respective error reporting.
> 
> v5:
> - Add single debug out to show mask changing. (Dan)
> 
> v4:
> - Fix masking of RAS register. (Jonathan)
> 
> v3:
> - Remove flex bus port status check. (Jonathan)
> - Only unmask known mask bits. (Jonathan)
> 
> v2:
> - Add definition of PCI_EXP_LNKSTA2_FLIT. (Dan)
> - Return error for cxl_pci_ras_unmask(). (Dan)
> - Add dev_dbg() for register bits to be cleared. (Dan)
> - Check Flex Port DVSEC status. (Dan)
> ---
>  drivers/cxl/cxl.h             |    1 +
>  drivers/cxl/pci.c             |   65 +++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/pci_regs.h |    1 +
>  3 files changed, 67 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b3964149c77b..d640fe61b893 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -130,6 +130,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
>  #define CXL_RAS_UNCORRECTABLE_MASK_OFFSET 0x4
>  #define   CXL_RAS_UNCORRECTABLE_MASK_MASK (GENMASK(16, 14) | GENMASK(11, 0))
> +#define   CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK BIT(8)
>  #define CXL_RAS_UNCORRECTABLE_SEVERITY_OFFSET 0x8
>  #define   CXL_RAS_UNCORRECTABLE_SEVERITY_MASK (GENMASK(16, 14) | GENMASK(11, 0))
>  #define CXL_RAS_CORRECTABLE_STATUS_OFFSET 0xC
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index c87340095a8a..4218581d14b7 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -637,6 +637,67 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	return 0;
>  }
>  
> +/*
> + * CXL v3.0 6.2.3 Table 6-4
> + * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
> + * mode, otherwise it's 68B flits mode.
> + */
> +static bool cxl_pci_flit_256(struct pci_dev *pdev)
> +{
> +	u32 lnksta2;
> +
> +	pcie_capability_read_dword(pdev, PCI_EXP_LNKSTA2, &lnksta2);

PCI_EXP_LNKSTA2 is a 16-bit register.

> +	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
> +}
> +
> +static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> +{
> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	void __iomem *addr;
> +	u32 orig_val, val, mask;
> +	u16 cap;
> +	int rc;
> +
> +	if (!cxlds->regs.ras) {
> +		dev_dbg(&pdev->dev, "No RAS registers.\n");
> +		return 0;
> +	}
> +
> +	/* BIOS has CXL error control */
> +	if (!host_bridge->native_cxl_error)
> +		return -EOPNOTSUPP;
> +
> +	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
> +	if (rc)
> +		return rc;
> +
> +	if (cap & PCI_EXP_DEVCTL_URRE) {
> +		addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
> +		orig_val = readl(addr);
> +
> +		mask = CXL_RAS_UNCORRECTABLE_MASK_MASK;
> +		if (!cxl_pci_flit_256(pdev))
> +			mask &= ~CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
> +		val = orig_val & ~mask;
> +		writel(val, addr);
> +		dev_dbg(&pdev->dev,
> +			"Uncorrectable RAS Errors Mask: %#x -> %#x\n",
> +			orig_val, val);
> +	}
> +
> +	if (cap & PCI_EXP_DEVCTL_CERE) {
> +		addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
> +		orig_val = readl(addr);
> +		val = orig_val & ~CXL_RAS_CORRECTABLE_MASK_MASK;
> +		writel(val, addr);
> +		dev_dbg(&pdev->dev, "Correctable RAS Errors Mask: %#x -> %#x\n",
> +			orig_val, val);
> +	}
> +
> +	return 0;
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> @@ -728,6 +789,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_pci_ras_unmask(pdev);
> +	if (rc)
> +		dev_warn(&pdev->dev, "No RAS reporting unmasked\n");
> +
>  	pci_save_state(pdev);
>  
>  	return rc;
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 85ab1278811e..dc2000e0fe3a 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -693,6 +693,7 @@
>  #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
>  #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
>  #define PCI_EXP_LNKSTA2		0x32	/* Link Status 2 */
> +#define  PCI_EXP_LNKSTA2_FLIT		0x0400 /* Flit Mode Status */
>  #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x32	/* end of v2 EPs w/ link */
>  #define PCI_EXP_SLTCAP2		0x34	/* Slot Capabilities 2 */
>  #define  PCI_EXP_SLTCAP2_IBPD	0x00000001 /* In-band PD Disable Supported */
> 
> 
