Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569A0BA53
	for <linux-cxl@vger.kernel.org>; Sun, 29 Dec 2024 05:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735450935; cv=pass; b=KCFrO52ENBQ5qtey699Oup6Uke/Na0H9WcMuI/uEgHrfS9iNunpqoluK2DkpouuyVTESurdZ9otoVWX/klJIRvfp23yOwVrLP/LQYIhTGJ6Cf2szPOl8hgQ6cLbANw2peDhBu/q/9Q0hYbuzytKXnJfbbBPDhgzI8OdtqJDng8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735450935; c=relaxed/simple;
	bh=WU5N06lmb8Ao+B/9oueDArZpim2i9IVPPLQxLRaACc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avBA5MnGSrz1NqqQH8lkfQh7YkIcryVlpiKb3N/jIayuKVEStnP5478h1D2a/Dtakh6CZTfok4ySa4ZZUQ/b2fwb9aZ3H+kMdrYhCsUzbj5KRsMgi8eufV0prf+1yxZjW418YB8Ko5+Z5tqoxy41mijpEi4x45nnofqA2sLMVkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=UrtlRgmL; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="UrtlRgmL"
ARC-Seal: i=1; a=rsa-sha256; t=1735450916; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y9QYD4fY6aMY2ubEa9OgfB4bsCJbydZXaMQr1671emEy+ihCdIshHAavhkX79D8awjDORBeEpHNPlh55Yw1cBEypYZn9K2IYaLp1BU0Br4I/7o0Cy4X8A/Mr3KMdC5rn2Jg17bV8borJLoSBS8pDJpqSqRb/AK/eSQRjUcO2e4E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1735450916; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Y+gFyuCyzHvgqrnehZKbYjS+l/KILMpoP1g9yzoeZWQ=; 
	b=HD2dJdRiAEjjVFFJnfrt1hkdA3dTIkbK1Zb3v7AlciMdlVMCHRhtVPBZczxnMrJH/oZVNgsdWlp1njSQ8AsitmxA6//CBkxQ5/IregZKZmssxi15F7R78pEjTfiXiCCLIGH5q1sDo7DuGXWoa+pjIKqpJ7TspOY0jxI+k7/3UsY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1735450916;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Y+gFyuCyzHvgqrnehZKbYjS+l/KILMpoP1g9yzoeZWQ=;
	b=UrtlRgmLzPh3K2MifhLHrVOOL0GE0/s5rXCRsQQBTYjyW0sdQ0rj3bV1Bel1MITl
	tenEh01CDqoRBw0thYCoUXpMrUYZiUiYtMestsRukmo3QrJw1/p7hO0rW0C82/9sQFq
	dsVxyqinDcjIQZx+g+CrcMl+vZsrTyMu755iblfE=
Received: by mx.zohomail.com with SMTPS id 1735450914656450.8650290425667;
	Sat, 28 Dec 2024 21:41:54 -0800 (PST)
Message-ID: <24cb5a57-ec6d-4171-9f85-b1165b5c20db@zohomail.com>
Date: Sun, 29 Dec 2024 13:41:52 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] cxl/core/regs: Refactor out functions to count
 regblocks of given type
To: "Ye, Huaisheng" <huaisheng.ye@intel.com>,
 "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>
Cc: "Jia, Pei P" <pei.p.jia@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "Du, Fan" <fan.du@intel.com>
References: <20241225083539.2230150-1-huaisheng.ye@intel.com>
 <2d7a78c5-8544-4dfc-822c-bae8677c1703@zohomail.com>
 <SA3PR11MB7461C9DEDF29160B40D5F21F9F0D2@SA3PR11MB7461.namprd11.prod.outlook.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <SA3PR11MB7461C9DEDF29160B40D5F21F9F0D2@SA3PR11MB7461.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227d96e928a9691c8e753c80a660000dbbea096ca927f485640465c4f10773c02d09ebb396b39d4f3:zu080112273579e56d3a646bfaaa568796000064c1ad6f2e6390fe1d3646b27494de737e591b3128697002b5:rf0801122d37de838e4b754f1e663854e100003154d0084177f06d1cbb6953578d788c94626a6406c8a48deb2b9211224ddb:ZohoMail
X-ZohoMailClient: External

On 12/26/2024 2:20 PM, Ye, Huaisheng wrote:
> From: Li Ming <ming.li@zohomail.com>
> Sent: Thursday, December 26, 2024 10:11 AM
>> On 12/25/2024 4:35 PM, Huaisheng Ye wrote:
>>> In commit d717d7f3df18494baafd9595fb4bcb9c380d7389, cxl_count_regblock
>>> was added for counting regblocks of a given RBI (Register Block
>> Identifier).
>>> It is workable, but has two drawbacks that can be improved.
>>>
>>> 1. In order to get the count of instances, cxl_count_regblock has to
>>> tentatively repeat the call of cxl_find_regblock_instance by
>>> increasing index from 0. It will not stop until an error value is
>>> returned. Actually, It needs to search for Register Blocks in dvsec
>>> again every time by taking a start from the head. This is a bit
>> inefficient.
>>> For example, to determine if PMU1 exists, cxl_find_regblock_instance
>>> must check all Register Blocks by the type and index from RB1 to RB4.
>>> If there are more RBs of the same type in the future, the situation will
>> be even worse.
>>> 16 81 00 23		PCIe extended Capability Header
>>> 02 c0 1e 98		Header 1
>>> 00 00 00 08		Header 2
>>> --------------------------------------
>>> 00 00 01 00		RB 1 - Offset Low	Component
>>> 00 00 00 00		RB 1 - Offset High
>>> --------------------------------------
>>> 00 00 03 02		RB 2 - Offset Low	Device Register
>>> 00 00 00 00		RB 2 - Offset High
>>> --------------------------------------
>>> 00 01 04 02		RB 3 - Offset Low	PMU0
>>> 00 00 00 00		RB 3 - Offset High
>>> --------------------------------------
>>> 00 02 04 02		RB 4 - Offset Low	PMU1
>>> 00 00 00 00		RB 4 - Offset High
>>>
>>> RB: Register Block
>>>
>>> 2. cxl_count_regblock blocks the opportunity to get error codes from
>>> cxl_find_regblock_instance. cxl_pci_probe has error code checking for
>>> almost all function calls. This is a good behavior, but
>> cxl_count_regblock couldn't.
>>> With this patch, only need to add two lines of code in
>>> cxl_find_regblock_instance, which can return the count of regblocks by
>>> given RBI in just one call. It is more effective than before. Besides,
>>> the error code could be obtained by the called function, here is
>> cxl_pci_probe.
>>> Based on the above reasons, cxl_count_regblock could be considered to
>> remove.
>>> This patch is tested by ndctl cxl_test and physical CXL expander card
>>> with v6.12.
>> I think the description about how you tested the patch should be included
>> in cover-letter rather than patch's changelog.
>>
> Hi Ming,
>
> Many thanks for your comments.
>
> This is a single patch, so I haven't prepared cover-letter, but your suggestion
> is correct I should provide a more detailed introduction for how to test. I will
> expand them in next version.
>
> 1. Ndctl CXL test suite v80 could pass with this patch applied. 
>
> $ meson test -C build --suite cxl
> ninja: Entering directory `/home/work/source/ndctl/build'
> [1/48] Generating version.h with a custom command
>  1/11 ndctl:cxl / cxl-topology.sh               OK               3.29s
>  2/11 ndctl:cxl / cxl-region-sysfs.sh           OK               2.50s
>  3/11 ndctl:cxl / cxl-labels.sh                 OK               1.64s
>  4/11 ndctl:cxl / cxl-create-region.sh          OK               3.29s
>  5/11 ndctl:cxl / cxl-xor-region.sh             OK               1.72s
>  6/11 ndctl:cxl / cxl-events.sh                 OK               1.45s
>  7/11 ndctl:cxl / cxl-sanitize.sh               OK               4.47s
>  8/11 ndctl:cxl / cxl-destroy-region.sh         OK               1.84s
>  9/11 ndctl:cxl / cxl-qos-class.sh              OK               2.52s
> 10/11 ndctl:cxl / cxl-poison.sh                 OK               2.81s
> 11/11 ndctl:cxl / cxl-security.sh               OK               0.79s
>
> Ok:                 11
> Expected Fail:      0
> Fail:               0
> Unexpected Pass:    0
> Skipped:            0
> Timeout:            0
>
> Full log written to /home/work/source/ndctl/build/meson-logs/testlog.txt
>
>
> 2. Test patch with Qemu x4 switch topology:
>
>                        ACPI0017:00 [root0]
>                            |
>                          HB_0 [port1]
>                         /             \
>                      RP_0             RP_1
>                       |                 |
>                 USP [port2]          
>             /    /    \    \      
>           DSP   DSP   DSP   DSP   
>            |     |     |     |     
>           mem1  mem0  mem2  mem3  
>
> Every card has 2 PMU RBs, here are the pmu_mem devices.
>
> $ ls /sys/bus/cxl/devices/pmu_mem* -lh
> lrwxrwxrwx. 1 root root 0 Dec 26 12:59 /sys/bus/cxl/devices/pmu_mem0.0 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:01.0/0000:10:00.0/pmu_mem0.0
> lrwxrwxrwx. 1 root root 0 Dec 26 12:59 /sys/bus/cxl/devices/pmu_mem0.1 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:01.0/0000:10:00.0/pmu_mem0.1
> lrwxrwxrwx. 1 root root 0 Dec 26 12:59 /sys/bus/cxl/devices/pmu_mem1.0 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:00.0/0000:0f:00.0/pmu_mem1.0
> lrwxrwxrwx. 1 root root 0 Dec 26 12:59 /sys/bus/cxl/devices/pmu_mem1.1 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:00.0/0000:0f:00.0/pmu_mem1.1
> lrwxrwxrwx. 1 root root 0 Dec 26 12:59 /sys/bus/cxl/devices/pmu_mem2.0 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:02.0/0000:11:00.0/pmu_mem2.0
> lrwxrwxrwx. 1 root root 0 Dec 26 12:59 /sys/bus/cxl/devices/pmu_mem2.1 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:02.0/0000:11:00.0/pmu_mem2.1
> lrwxrwxrwx. 1 root root 0 Dec 26 12:59 /sys/bus/cxl/devices/pmu_mem3.0 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:03.0/0000:12:00.0/pmu_mem3.0
> lrwxrwxrwx. 1 root root 0 Dec 26 12:59 /sys/bus/cxl/devices/pmu_mem3.1 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:03.0/0000:12:00.0/pmu_mem3.1
>
>>> Signed-off-by: Huaisheng Ye <huaisheng.ye@intel.com>
>>> ---
>>>  drivers/cxl/core/regs.c | 32 +++++++-------------------------
>>>  drivers/cxl/cxl.h       |  2 +-
>>>  drivers/cxl/pci.c       |  7 ++++++-
>>>  3 files changed, 14 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c index
>>> e1082e749c69..d6b882a334d5 100644
>>> --- a/drivers/cxl/core/regs.c
>>> +++ b/drivers/cxl/core/regs.c
>>> @@ -290,17 +290,19 @@ static bool cxl_decode_regblock(struct pci_dev
>>> *pdev, u32 reg_lo, u32 reg_hi,  }
>>>
>>>  /**
>>> - * cxl_find_regblock_instance() - Locate a register block by type /
>>> index
>>> + * cxl_find_regblock_instance() - Locate a register block or count
>>> + instances by type / index
>>>   * @pdev: The CXL PCI device to enumerate.
>>>   * @type: Register Block Indicator id
>>>   * @map: Enumeration output, clobbered on error
>>>   * @index: Index into which particular instance of a regblock wanted in
>> the
>>>   *	   order found in register locator DVSEC.
>>>   *
>>> - * Return: 0 if register block enumerated, negative error code
>>> otherwise
>>> + * Return: 0 if register block enumerated, non-negative if counting
>>> + instances,
>>> + * negative error code otherwise
>>>   *
>>>   * A CXL DVSEC may point to one or more register blocks, search for
>> them
>>>   * by @type and @index.
>>> + * Use CXL_INSTANCES_COUNT for @index if counting instances by @type.
>>>   */
>>>  int cxl_find_regblock_instance(struct pci_dev *pdev, enum
>> cxl_regloc_type type,
>>>  			       struct cxl_register_map *map, int index) @@ -
>> 341,6 +343,9
>>> @@ int cxl_find_regblock_instance(struct pci_dev *pdev, enum
>> cxl_regloc_type type,
>>>  		}
>>>  	}
>>>
>>> +	if (index == CXL_INSTANCES_COUNT)
>>> +		return instance;
>>> +
>> Above return will skip below 'map->resource = CXL_RESOURCE_NONE'. is it
>> expected?
>>
> Yes, when counting regblocks we don't need to return register_map, we only want to know the number of the given RBI.
> So, skipping 'map->resource = CXL_RESOURCE_NONE' and 'return -ENODEV' is okay.

My understanding is that you should reset 'map->resource' to 'CXL_RESOURCE_NONE' in the case of no available register_map returned. Because the register_map has been used in cxl_decoder_regblock(), reset 'map->resource' to avoid some potential issues on caller side.

[snip]


