Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FE9C4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Dec 2022 15:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiLPPhO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Dec 2022 10:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiLPPhH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Dec 2022 10:37:07 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9E750D70
        for <linux-cxl@vger.kernel.org>; Fri, 16 Dec 2022 07:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671205026; x=1702741026;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Si23m594hOtmfQ8it1cl3XSAOphRn2jKK1dlb61fThY=;
  b=bLKIAO0WWxzndA4Qvnl7lHtWJB9IsLwEIFxeivzOztRwLsaeI4eVXHhE
   qJnBVX+Z9jp+XPOpBu14aW8EJwdO6eCIFf1ZHpuViSee+N56xkXgtXAl7
   wuEYfgTl7HOQY4vF4YqXuT2h9GkA4MoEWZCaMkzBwjNLD+y89X8L2ssGm
   Uv/0000wsHAtCp0usVabD9ax2G5B2gtgnAfqLJwZ7Zxrb58RzcuIv8gxs
   LE2c/a5GA3dvfNFLmZTbcw9X2zgjiIwUqY3vWAI6Wj45AIMUvM5WoY8ac
   q16qYjj+wSd8XQ2J0roWPeLvGoHxY9Ghbv3opCFNQsns2ykXqUZnExVY7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="298661181"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="298661181"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 07:37:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="718392549"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="718392549"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.209.167.175]) ([10.209.167.175])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 07:37:05 -0800
Message-ID: <8b1a1aea-717e-fcf1-4710-ff4531b01f04@intel.com>
Date:   Fri, 16 Dec 2022 08:37:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH v4] cxl: add RAS status unmasking for CXL
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
References: <167112768345.3343090.11728168471813709343.stgit@djiang5-desk3.ch.intel.com>
 <20221216093629.00000b7b@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221216093629.00000b7b@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 12/16/2022 2:36 AM, Jonathan Cameron wrote:
> On Thu, 15 Dec 2022 11:08:03 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> By default the CXL RAS mask registers bits are defaulted to 1's and
>> suppress all error reporting. If the kernel has negotiated ownership
>> of error handling for CXL then unmask the mask registers by writing 0s.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
> 
> One trivial comment inline that is up to you.

Not a problem. I'll roll that in with changes Dan is asking.

> 
> Dan's suggestion makes sense.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>> ---
>>
>> Based on patch posted by Ira [1] to export CXL native error reporting control.
>>
>> [1]: https://lore.kernel.org/linux-cxl/20221212070627.1372402-2-ira.weiny@intel.com/
>>
>> v4:
>> - Fix masking of RAS register. (Jonathan)
>>
>> v3:
>> - Remove flex bus port status check. (Jonathan)
>> - Only unmask known mask bits. (Jonathan)
>>
>> v2:
>> - Add definition of PCI_EXP_LNKSTA2_FLIT. (Dan)
>> - Return error for cxl_pci_ras_unmask(). (Dan)
>> - Add dev_dbg() for register bits to be cleared. (Dan)
>> - Check Flex Port DVSEC status. (Dan)
>> ---
>>   drivers/cxl/cxl.h             |    1 +
>>   drivers/cxl/pci.c             |   48 +++++++++++++++++++++++++++++++++++++++++
>>   include/uapi/linux/pci_regs.h |    1 +
>>   3 files changed, 50 insertions(+)
>>
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 1b1cf459ac77..31e795c6d537 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -130,6 +130,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>>   #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
>>   #define CXL_RAS_UNCORRECTABLE_MASK_OFFSET 0x4
>>   #define   CXL_RAS_UNCORRECTABLE_MASK_MASK (GENMASK(16, 14) | GENMASK(11, 0))
>> +#define   CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK BIT(8)
>>   #define CXL_RAS_UNCORRECTABLE_SEVERITY_OFFSET 0x8
>>   #define   CXL_RAS_UNCORRECTABLE_SEVERITY_MASK (GENMASK(16, 14) | GENMASK(11, 0))
>>   #define CXL_RAS_CORRECTABLE_STATUS_OFFSET 0xC
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 33083a522fd1..64272db6a3fd 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -419,6 +419,53 @@ static void disable_aer(void *pdev)
>>   	pci_disable_pcie_error_reporting(pdev);
>>   }
>>   
>> +/*
>> + * CXL v3.0 6.2.3 Table 6-4
>> + * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
>> + * mode, otherwise it's 68B flits mode.
>> + */
>> +static bool cxl_pci_flit_256(struct pci_dev *pdev)
>> +{
>> +	u32 lnksta2;
>> +
>> +	pcie_capability_read_dword(pdev, PCI_EXP_LNKSTA2, &lnksta2);
>> +	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
>> +}
>> +
>> +static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>> +{
>> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> +	void __iomem *addr;
>> +	u32 val, mask;
>> +
>> +	if (!cxlds->regs.ras)
>> +		return -ENODEV;
>> +
>> +	/* BIOS has CXL error control */
>> +	if (!host_bridge->native_cxl_error)
>> +		return -EOPNOTSUPP;
>> +
>> +	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
>> +	val = readl(addr);
>> +	dev_dbg(&pdev->dev, "Uncorrectable RAS Errors Mask: %#x\n", val);
>> +
>> +	mask = CXL_RAS_UNCORRECTABLE_MASK_MASK;
>> +	if (!cxl_pci_flit_256(pdev))
>> +		mask &= ~CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
>> +	val &= ~mask;
>> +	writel(val, addr);
>> +	dev_dbg(&pdev->dev, "Unmasked Uncorrectable RAS Errors Mask: %#x\n", val);
>> +
>> +	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
>> +	val = readl(addr);
>> +	dev_dbg(&pdev->dev, "Correctable RAS Errors Mask: %#x\n", val);
>> +	val &= ~CXL_RAS_CORRECTABLE_MASK_MASK;
>> +	writel(val, addr);
>> +	dev_dbg(&pdev->dev, "Unmasked Correctable RAS Errors Mask: %#x\n", val);
> 
> Real nitpick but I'd like a blank line here as the return isn't related to the
> previous block of code.
> 
>> +	return 0;
>> +}
>> +
>>   static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   {
>>   	struct cxl_register_map map;
>> @@ -498,6 +545,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   
>>   	if (cxlds->regs.ras) {
>>   		pci_enable_pcie_error_reporting(pdev);
>> +		cxl_pci_ras_unmask(pdev);
>>   		rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
>>   		if (rc)
>>   			return rc;
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index 82a03ea954af..576ee2ec973f 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -693,6 +693,7 @@
>>   #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
>>   #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
>>   #define PCI_EXP_LNKSTA2		0x32	/* Link Status 2 */
>> +#define  PCI_EXP_LNKSTA2_FLIT		BIT(10) /* Flit Mode Status */
>>   #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x32	/* end of v2 EPs w/ link */
>>   #define PCI_EXP_SLTCAP2		0x34	/* Slot Capabilities 2 */
>>   #define  PCI_EXP_SLTCAP2_IBPD	0x00000001 /* In-band PD Disable Supported */
>>
>>
> 
