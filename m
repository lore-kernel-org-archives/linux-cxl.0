Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E317C3DA7D
	for <linux-cxl@archiver.kernel.org>; Thu,  5 Jan 2023 16:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjAEQx6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 5 Jan 2023 11:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjAEQx5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 5 Jan 2023 11:53:57 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CB4200D
        for <linux-cxl@vger.kernel.org>; Thu,  5 Jan 2023 08:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672937636; x=1704473636;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v49bJvgvVuJGzTO7tM9n0gFQeX5hFTjBo0jNbUvJvVk=;
  b=UjvvwxEYdfay6C4AC97Q4NuNIOrFC1PgA3Jg95NQNpBgbol6N7vB5tuI
   bvbdemt1p/fB+54BiN1dp3dth15vbrLVj3bmiBSp247Vlubi2sR1CZ58Z
   SRFqenSJmBth/gpRGDcvZNLLhdPB51nWMZrW/7WWqX5OTnock6rKIl4Zc
   1CEAWflPWfkk3lWEi0I2SjqnwfuxgIskDchp+GmzfFBjMUGFaBDFGHQ4n
   oiXDbNA0ysvIiw8LqNUC8zTR9g1iyAbJbHDpn3VFtdOh3W5UkDEXcwD6D
   pRA1c6WdtGWtwFO1jv61Q9bs2g77VG0EsoxxV78anw9HednMf0736afbP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="301957605"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="301957605"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 08:53:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="763196279"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="763196279"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.74.92]) ([10.212.74.92])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 08:53:54 -0800
Message-ID: <ceb29dc5-3347-2f62-c297-143541fc7d56@intel.com>
Date:   Thu, 5 Jan 2023 09:53:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v5] cxl: add RAS status unmasking for CXL
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, Bjorn Helgaas <bhelgaas@google.com>
References: <167120700197.3444116.12992018879314163331.stgit@djiang5-desk3.ch.intel.com>
 <20221217175204.0000170a@huawei.com> <20221217180550.00004ea2@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221217180550.00004ea2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 12/17/22 11:05 AM, Jonathan Cameron wrote:
> On Sat, 17 Dec 2022 17:52:04 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
>> On Fri, 16 Dec 2022 09:10:02 -0700
>> Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>> By default the CXL RAS mask registers bits are defaulted to 1's and
>>> suppress all error reporting. If the kernel has negotiated ownership
>>> of error handling for CXL then unmask the mask registers by writing 0s.
>>>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.
>> +CC Bjorn for a question on the AER control element of this.
>>
>> I realized that adding this patch still only enables error because
>> I didn't check the PCIe spec when writing the QEMU emulation. I had changed
>> the value of  "Correctable Internal Error Mask" to default to unmasked.
>> PCIe 6.0 says it defaults to masked.  For some reason I thought these
>> masks were impdef (should have checked ;)
>>
>> I'll drop that change in QEMU, but upshot is that if we want the correctable
>> ones to be delivered, we'll need to clear that bit as well as the ones you
>> do in this patch.
>>
>> This got me thinking about why I never saw the same issue for UNC
>> errors.  Upshot, QEMU never sets the UNCOR mask so defaults to everything on
>> (it also doesn't allow anyone to write the register). Curiously it has
>> the code that uses the mask even though there was no means to set any
>> bits in it.
>> I'll fix that (draft patch below) + we should update lspci to cover more of these AER
>> flags as it's a PITA debugging by reading the hex dumps!
>>
>> Bjorn, is there any convention on drivers enabling these 'default' masked
>> AER errors?  Or is expectation that this is policy and userspace should
>> be dealing with it?
>>
>> Dave, if you want to test on QEMU in meantime revert:
>> hw/mem/cxl_type3: Set mask to signal Correct Internal Errors.
> 
> If you want to have some pre holidays fun, it's instructive to
> inject a whole bunch of errors in a row (just paste a bunch of json entries in QMP telnet settions all
> at once - this might happen on single errors, but that's how I'm triggering it) I've had several
> crashes in the recovery path after resets.  E.g.

Hi Jonathan,
Just saw this now. Are you injecting a bunch of UE in a row? How many? 
Do you hit it consistently? I'll try to reproduce. Thanks!

> 
> pcieport 0000:0e:00.0: AER: Downstream Port link has been reset (0)
> cxl_pci 0000:0f:00.0: mem1: restart CXL.mem after slot reset
> cxl_pci 0000:0f:00.0: mem1: error resume successful
> pcieport 0000:0e:00.0: AER: device recovery successful
> pcieport 0000:0c:00.0: AER: Uncorrected (Fatal) error received: 0000:0f:00.0
> cxl_pci 0000:0f:00.0: AER: PCIe Bus Error: severity=Uncorrected (Fatal), type=Inaccessible, (Unregistered Agent ID)
> cxl_pci 0000:0f:00.0: mem1: frozen state error detected, disable CXL.mem
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000358
> 
> ....
> 
> [  133.722701] Call trace:
> [  133.723627]  cxl_pmem_ctl+0x74/0x244 [cxl_pmem]
> [  133.724974]  nvdimm_init_nsarea+0xb8/0xdc
> [  133.727026]  nvdimm_probe+0xc0/0x1d0
> [  133.728639]  nvdimm_bus_probe+0x90/0x200
> [  133.730141]  really_probe+0xc8/0x3e0
> [  133.731422]  __driver_probe_device+0x84/0x190
> [  133.732616]  driver_probe_device+0x44/0x120
> [  133.734395]  __device_attach_driver+0xc4/0x160
> [  133.735723]  bus_for_each_drv+0x80/0xe0
> [  133.736732]  __device_attach+0xa4/0x1c4
> [  133.737876]  device_initial_probe+0x1c/0x30
> [  133.740066]  bus_probe_device+0xa4/0xb0
> [  133.742216]  device_add+0x404/0x920
> [  133.743158]  nd_async_device_register+0x20/0x70
> [  133.745009]  async_run_entry_fn+0x3c/0x154
> [  133.746433]  process_one_work+0x200/0x474
> [  133.748023]  worker_thread+0x74/0x43c
> [  133.749899]  kthread+0x110/0x114
> [  133.751393]  ret_from_fork+0x10/0x20
> 
> I did see something the other day that looked similar when manually probing
> drivers in a particular order but haven't chased that one down yet.
> 
> Our test teams love sending bug reports on what happens when you get the following
> N errors all at once.  Often reveal entertainingly complex bugs.
> 
> Jonathan
> 
>>
>> and make this change to qemu:
>>
>>  From b0f37bafcc734fe15022c47a2da7f8326b1593c2 Mon Sep 17 00:00:00 2001
>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Date: Sat, 17 Dec 2022 17:43:38 +0000
>> Subject: [PATCH] hw/pci/aer: Implement PCI_ERR_UNCOR_MASK register
>>
>> This register in AER should be both writeable and should
>> have a default value with a couple of the errors masked
>> including the Uncorrectable Internal Error used by CXL for
>> it's error reporting.
>>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   hw/pci/pcie_aer.c          | 4 ++++
>>   include/hw/pci/pcie_regs.h | 3 +++
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
>> index 00ef4b5601..935fbc57b5 100644
>> --- a/hw/pci/pcie_aer.c
>> +++ b/hw/pci/pcie_aer.c
>> @@ -122,6 +122,10 @@ int pcie_aer_init(PCIDevice *dev, uint8_t cap_ver, uint16_t offset,
>>
>>       pci_set_long(dev->w1cmask + offset + PCI_ERR_UNCOR_STATUS,
>>                    PCI_ERR_UNC_SUPPORTED);
>> +    pci_set_long(dev->config + offset + PCI_ERR_UNCOR_MASK,
>> +                 PCI_ERR_UNC_MASK_DEFAULT);
>> +    pci_set_long(dev->wmask + offset + PCI_ERR_UNCOR_MASK,
>> +                 PCI_ERR_UNC_SUPPORTED);
>>
>>       pci_set_long(dev->config + offset + PCI_ERR_UNCOR_SEVER,
>>                    PCI_ERR_UNC_SEVERITY_DEFAULT);
>> diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
>> index 963dc2e170..6ec4785448 100644
>> --- a/include/hw/pci/pcie_regs.h
>> +++ b/include/hw/pci/pcie_regs.h
>> @@ -155,6 +155,9 @@ typedef enum PCIExpLinkWidth {
>>                                            PCI_ERR_UNC_ATOP_EBLOCKED |    \
>>                                            PCI_ERR_UNC_TLP_PRF_BLOCKED)
>>
>> +#define PCI_ERR_UNC_MASK_DEFAULT        (PCI_ERR_UNC_INTN | \
>> +                                         PCI_ERR_UNC_TLP_PRF_BLOCKED)
>> +
>>   #define PCI_ERR_UNC_SEVERITY_DEFAULT    (PCI_ERR_UNC_DLP |              \
>>                                            PCI_ERR_UNC_SDN |              \
>>                                            PCI_ERR_UNC_FCP |              \
>> --
>> 2.37.2
>>
>> I'm testing the kernel side with:
>>
>>  From a5da67af2d2b4e792de2d88c74a68da3a17d2872 Mon Sep 17 00:00:00 2001
>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Date: Sat, 17 Dec 2022 17:46:45 +0000
>> Subject: [PATCH] HACK: Enable the AER internal errors
>>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/pci.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index bfdf92a9aef6..ef7a6ab41eb7 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -778,7 +778,18 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>                  return rc;
>>
>>          if (cxlds->regs.ras) {
>> +               u32 mask;
>> +               printk("trying to unmask\n");
>>                  pci_enable_pcie_error_reporting(pdev);
>> +               pci_read_config_dword(pdev, pdev->aer_cap + PCI_ERR_COR_MASK, &mask);
>> +               mask &= ~PCI_ERR_COR_INTERNAL;
>> +               printk("unamsking cor\n");
>> +               pci_write_config_word(pdev, pdev->aer_cap + PCI_ERR_COR_MASK, mask);
>> +
>> +               pci_read_config_dword(pdev, pdev->aer_cap + PCI_ERR_UNCOR_MASK, &mask);
>> +               mask &= ~PCI_ERR_UNC_INTN;
>> +               printk("unmasking uncor\n");
>> +               pci_write_config_dword(pdev, pdev->aer_cap + PCI_ERR_UNCOR_MASK, mask);
>>                  cxl_pci_ras_unmask(pdev);
>>                  rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
>>                  if (rc)
>> --
>> 2.37.2
>>
>>
>>
>>>
>>> ---
>>>
>>> Based on patch posted by Ira [1] to export CXL native error reporting control.
>>>
>>> [1]: https://lore.kernel.org/linux-cxl/20221212070627.1372402-2-ira.weiny@intel.com/
>>>
>>> v5:
>>> - Add single debug out to show mask changing. (Dan)
>>>
>>> v4:
>>> - Fix masking of RAS register. (Jonathan)
>>>
>>> v3:
>>> - Remove flex bus port status check. (Jonathan)
>>> - Only unmask known mask bits. (Jonathan)
>>>
>>> v2:
>>> - Add definition of PCI_EXP_LNKSTA2_FLIT. (Dan)
>>> - Return error for cxl_pci_ras_unmask(). (Dan)
>>> - Add dev_dbg() for register bits to be cleared. (Dan)
>>> - Check Flex Port DVSEC status. (Dan)
>>> ---
>>>   drivers/cxl/cxl.h             |    1 +
>>>   drivers/cxl/pci.c             |   49 +++++++++++++++++++++++++++++++++++++++++
>>>   include/uapi/linux/pci_regs.h |    1 +
>>>   3 files changed, 51 insertions(+)
>>>
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index 1b1cf459ac77..31e795c6d537 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -130,6 +130,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>>>   #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
>>>   #define CXL_RAS_UNCORRECTABLE_MASK_OFFSET 0x4
>>>   #define   CXL_RAS_UNCORRECTABLE_MASK_MASK (GENMASK(16, 14) | GENMASK(11, 0))
>>> +#define   CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK BIT(8)
>>>   #define CXL_RAS_UNCORRECTABLE_SEVERITY_OFFSET 0x8
>>>   #define   CXL_RAS_UNCORRECTABLE_SEVERITY_MASK (GENMASK(16, 14) | GENMASK(11, 0))
>>>   #define CXL_RAS_CORRECTABLE_STATUS_OFFSET 0xC
>>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>>> index 33083a522fd1..1e5fc69bcc4d 100644
>>> --- a/drivers/cxl/pci.c
>>> +++ b/drivers/cxl/pci.c
>>> @@ -419,6 +419,54 @@ static void disable_aer(void *pdev)
>>>   	pci_disable_pcie_error_reporting(pdev);
>>>   }
>>>   
>>> +/*
>>> + * CXL v3.0 6.2.3 Table 6-4
>>> + * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
>>> + * mode, otherwise it's 68B flits mode.
>>> + */
>>> +static bool cxl_pci_flit_256(struct pci_dev *pdev)
>>> +{
>>> +	u32 lnksta2;
>>> +
>>> +	pcie_capability_read_dword(pdev, PCI_EXP_LNKSTA2, &lnksta2);
>>> +	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
>>> +}
>>> +
>>> +static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>> +{
>>> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>>> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>> +	void __iomem *addr;
>>> +	u32 orig_val, val, mask;
>>> +
>>> +	if (!cxlds->regs.ras)
>>> +		return -ENODEV;
>>> +
>>> +	/* BIOS has CXL error control */
>>> +	if (!host_bridge->native_cxl_error)
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
>>> +	orig_val = readl(addr);
>>> +
>>> +	mask = CXL_RAS_UNCORRECTABLE_MASK_MASK;
>>> +	if (!cxl_pci_flit_256(pdev))
>>> +		mask &= ~CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
>>> +	val = orig_val & ~mask;
>>> +	writel(val, addr);
>>> +	dev_dbg(&pdev->dev, "Uncorrectable RAS Errors Mask: %#x -> %#x\n",
>>> +		orig_val, val);
>>> +
>>> +	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
>>> +	orig_val = readl(addr);
>>> +	val = orig_val & ~CXL_RAS_CORRECTABLE_MASK_MASK;
>>> +	writel(val, addr);
>>> +	dev_dbg(&pdev->dev, "Correctable RAS Errors Mask: %#x -> %#x\n",
>>> +		orig_val, val);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>   static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>   {
>>>   	struct cxl_register_map map;
>>> @@ -498,6 +546,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>   
>>>   	if (cxlds->regs.ras) {
>>>   		pci_enable_pcie_error_reporting(pdev);
>>> +		cxl_pci_ras_unmask(pdev);
>>>   		rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
>>>   		if (rc)
>>>   			return rc;
>>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>>> index 82a03ea954af..576ee2ec973f 100644
>>> --- a/include/uapi/linux/pci_regs.h
>>> +++ b/include/uapi/linux/pci_regs.h
>>> @@ -693,6 +693,7 @@
>>>   #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
>>>   #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
>>>   #define PCI_EXP_LNKSTA2		0x32	/* Link Status 2 */
>>> +#define  PCI_EXP_LNKSTA2_FLIT		BIT(10) /* Flit Mode Status */
>>>   #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x32	/* end of v2 EPs w/ link */
>>>   #define PCI_EXP_SLTCAP2		0x34	/* Slot Capabilities 2 */
>>>   #define  PCI_EXP_SLTCAP2_IBPD	0x00000001 /* In-band PD Disable Supported */
>>>
>>>
>>
> 
