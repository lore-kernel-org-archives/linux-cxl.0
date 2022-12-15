Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8417BC4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Dec 2022 17:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiLORVw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Dec 2022 12:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiLORVw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Dec 2022 12:21:52 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A5FE0BE
        for <linux-cxl@vger.kernel.org>; Thu, 15 Dec 2022 09:21:50 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NXzTt1Yvwz688Z6;
        Fri, 16 Dec 2022 01:18:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 17:21:48 +0000
Date:   Thu, 15 Dec 2022 17:21:47 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v3] cxl: add RAS status unmasking for CXL
Message-ID: <20221215172147.00004378@Huawei.com>
In-Reply-To: <167106195154.3243163.16808927634384563321.stgit@djiang5-desk3.ch.intel.com>
References: <167106195154.3243163.16808927634384563321.stgit@djiang5-desk3.ch.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 14 Dec 2022 16:52:31 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> By default the CXL RAS mask registers bits are defaulted to 1's and
> suppress all error reporting. If the kernel has negotiated ownership
> of error handling for CXL then unmask the mask registers by writing 0s.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> 
> Based on patch posted by Ira [1] to export CXL native error reporting control.
> 
> [1]: https://lore.kernel.org/linux-cxl/20221212070627.1372402-2-ira.weiny@intel.com/
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
>  drivers/cxl/pci.c             |   48 +++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/pci_regs.h |    1 +
>  3 files changed, 50 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1b1cf459ac77..31e795c6d537 100644
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
> index 33083a522fd1..9cbec159c57b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -419,6 +419,53 @@ static void disable_aer(void *pdev)
>  	pci_disable_pcie_error_reporting(pdev);
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
> +	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
> +}
> +
> +static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> +{
> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	void __iomem *addr;
> +	u32 val, mask;
> +
> +	if (!cxlds->regs.ras)
> +		return -ENODEV;
> +
> +	/* BIOS has CXL error control */
> +	if (!host_bridge->native_cxl_error)
> +		return -EOPNOTSUPP;
> +
> +	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
> +	val = readl(addr);
> +	dev_dbg(&pdev->dev, "Uncorrectable RAS Errors Mask: %#x\n", val);
> +
> +	mask = CXL_RAS_UNCORRECTABLE_MASK_MASK;
> +	if (!cxl_pci_flit_256(pdev))
> +		mask &= ~CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
> +	val ^= mask;

End of day so I might have this completely wrong.

Whilst that 'works' because the default is all 1s. I'd like this code
not to assume that, particularly as we don't set them back to masked on exit.

Imagine calling it twice.  Second time around val is
~CXL_RAS_UNCORRECTABLE_MASK_MASK which is then xored with CXL_RAS_UNCORRECTABLE_MASK_MASK
resulting in use masking them all again. 


> +	writel(val, addr);
> +	dev_dbg(&pdev->dev, "Unmasked Uncorrectable RAS Errors Mask: %#x\n", val);
> +
> +	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
> +	val = readl(addr);
> +	dev_dbg(&pdev->dev, "Correctable RAS Errors Mask: %#x\n", val);
> +	val ^= CXL_RAS_CORRECTABLE_MASK_MASK;
> +	writel(val, addr);
> +	dev_dbg(&pdev->dev, "Unmasked Correctable RAS Errors Mask: %#x\n", val);
> +	return 0;
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
> @@ -498,6 +545,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	if (cxlds->regs.ras) {
>  		pci_enable_pcie_error_reporting(pdev);
> +		cxl_pci_ras_unmask(pdev);
>  		rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
>  		if (rc)
>  			return rc;
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 82a03ea954af..576ee2ec973f 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -693,6 +693,7 @@
>  #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
>  #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
>  #define PCI_EXP_LNKSTA2		0x32	/* Link Status 2 */
> +#define  PCI_EXP_LNKSTA2_FLIT		BIT(10) /* Flit Mode Status */
>  #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x32	/* end of v2 EPs w/ link */
>  #define PCI_EXP_SLTCAP2		0x34	/* Slot Capabilities 2 */
>  #define  PCI_EXP_SLTCAP2_IBPD	0x00000001 /* In-band PD Disable Supported */
> 
> 

