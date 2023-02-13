Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3D0C6379F
	for <linux-cxl@archiver.kernel.org>; Mon, 13 Feb 2023 20:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjBMUne (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 13 Feb 2023 15:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjBMUnc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 13 Feb 2023 15:43:32 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF641E9D6
        for <linux-cxl@vger.kernel.org>; Mon, 13 Feb 2023 12:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676321007; x=1707857007;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Ce7xVagwEY5ldD2YbJtuqTk7Kda3WiQEru44VWcHmW0=;
  b=R8Z8wO5qJLBcyfzQRsdozDHZX2DAtNII339cd7bXiKAVBwEkfnvR1bFY
   KDMfJIHQD9l1oXvZZdahckaecQilza586f5W7dz6BAGH+eLmrPLQCBqRz
   jHT6+/5Yp8LBmwzCFepaxTngm58JZWL8mBJb3iOhD/pgo8oGVx2aISAS8
   mUwPHT2lkBe+I/tpfZbM0ud8KXTpjniSohVWL1KYa9cF5qK23sqf7kt/d
   n2hnTD/ImgONq7HSwMO5evmGrBPUDvs7cSFnX+vysiBiHNGdtLL/KhtEJ
   n2JNCTfBHidLvF37b2L9aMGzk2Z4qVkX4fIfKreTwkeItd+L8ppZKONkP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="358402335"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="358402335"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 12:43:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="914472133"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="914472133"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.99.85]) ([10.212.99.85])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 12:43:26 -0800
Message-ID: <dc7a068b-1497-5e05-9cca-a1c963fe358b@intel.com>
Date:   Mon, 13 Feb 2023 13:43:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v7] cxl: add RAS status unmasking for CXL
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, bhelgaas@google.com, ira.weiny@intel.com,
        lukas@wunner.de
References: <167632033967.4153635.2596647333624343145.stgit@djiang5-mobl3.local>
In-Reply-To: <167632033967.4153635.2596647333624343145.stgit@djiang5-mobl3.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/13/23 1:32 PM, Dave Jiang wrote:
> By default the CXL RAS mask registers bits are defaulted to 1's and
> suppress all error reporting. If the kernel has negotiated ownership
> of error handling for CXL then unmask the mask registers by writing 0s.
> 
> PCI_EXP_DEVCTL capability is checked to see uncorrectable or correctable
> errors bits are set before unmasking the respective errors.
> 
> CXL RAS CE and UE masks are checked against PCI_EXP_AER_FLAGS before
> unmasking.

Grrrrr cross eyed. Deleted the first paragraph but somehow missed this one.

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
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
>   drivers/cxl/cxl.h             |    1 +
>   drivers/cxl/pci.c             |   65 +++++++++++++++++++++++++++++++++++++++++
>   include/uapi/linux/pci_regs.h |    1 +
>   3 files changed, 67 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b3964149c77b..d640fe61b893 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -130,6 +130,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>   #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
>   #define CXL_RAS_UNCORRECTABLE_MASK_OFFSET 0x4
>   #define   CXL_RAS_UNCORRECTABLE_MASK_MASK (GENMASK(16, 14) | GENMASK(11, 0))
> +#define   CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK BIT(8)
>   #define CXL_RAS_UNCORRECTABLE_SEVERITY_OFFSET 0x8
>   #define   CXL_RAS_UNCORRECTABLE_SEVERITY_MASK (GENMASK(16, 14) | GENMASK(11, 0))
>   #define CXL_RAS_CORRECTABLE_STATUS_OFFSET 0xC
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index c87340095a8a..4218581d14b7 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -637,6 +637,67 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>   	return 0;
>   }
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
>   static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   {
>   	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> @@ -728,6 +789,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (rc)
>   		return rc;
>   
> +	rc = cxl_pci_ras_unmask(pdev);
> +	if (rc)
> +		dev_warn(&pdev->dev, "No RAS reporting unmasked\n");
> +
>   	pci_save_state(pdev);
>   
>   	return rc;
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 85ab1278811e..dc2000e0fe3a 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -693,6 +693,7 @@
>   #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
>   #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
>   #define PCI_EXP_LNKSTA2		0x32	/* Link Status 2 */
> +#define  PCI_EXP_LNKSTA2_FLIT		0x0400 /* Flit Mode Status */
>   #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x32	/* end of v2 EPs w/ link */
>   #define PCI_EXP_SLTCAP2		0x34	/* Slot Capabilities 2 */
>   #define  PCI_EXP_SLTCAP2_IBPD	0x00000001 /* In-band PD Disable Supported */
> 
> 
