Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A33680027
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jul 2024 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455852; cv=none; b=GXO/1uwxbRBIHkyixx+w6YLYIefJd9IUJ6OO7iDy3NZ5skkx/ReBTWuh0NwsTBSF1Y8qjkw2hSvKoutwOfXNtei9GkKAMU0BI7ycqELXAZjaaJa7QY7srRaepZ1b61NYyxxrpB8r++IoUcUOlGohlTC+G0RGlO2tllViQi9uxP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455852; c=relaxed/simple;
	bh=D+vI1L6WyBjJSmhTvxi6htcncE8qp4PJlhvWMy7WAko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5akyOLmzF3tpeuOjm+JTg3+5o349phrhWzmq/XfcDkxP8oyNNYXeeQX9S2KTNeWw+WTuLtO2Op3ewruA1lva2gUuz6P62VVMM7lYdpmVcyTmZatiT2GHSaMmPBhWbBVXSHW9KzfRCvgnEWCBeZvok7KEfe+ZukZ6Vd9ulcwMqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PxKJhTGU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PxKJhTGU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720455850; x=1751991850;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D+vI1L6WyBjJSmhTvxi6htcncE8qp4PJlhvWMy7WAko=;
  b=PxKJhTGUHPsDSnYF+OQQ3DNnz+vkigBzVdj0cARMDbeKZgphVkbmBm/I
   OnA3l0CyPXbVzjEUerP6HmM+LYqgOAoGCnnuteBsT3SWg9yosMZskOPA6
   tsCVfXLc5iVnWxFey7XJWCtxm3UgxF/PHwQSyuNtJJCRjhmyTYqTIVuTU
   5kgJx5Ha/nIkrV4trADcdMej44g8L/4tyogCoz9siDvXoatZd0mDwddeN
   lqltsd5yt2ik/0A1UGz6bgCwDl2dUDMOUQyk7Ol4jwHjiIkQ6nlhl5rLw
   mODPUaataMtGR25JgQqCWuMA9Zf7H6smAReI2n5adchhPo+TJV+eyoDQI
   Q==;
X-CSE-ConnectionGUID: AH9wHILtRLSqbO64tlhQIA==
X-CSE-MsgGUID: 96ava2LiSSicxnJOPNRZNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="21480729"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="21480729"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 09:23:56 -0700
X-CSE-ConnectionGUID: iQb4Cy4mSLe0UOIQUY94Rg==
X-CSE-MsgGUID: QhkS5asjR7GIDBJOSSyIZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="48289959"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.108.203]) ([10.125.108.203])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 09:23:56 -0700
Message-ID: <4059688d-968b-4efe-a1fc-f12d2ca148e7@intel.com>
Date: Mon, 8 Jul 2024 09:23:55 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/2] Export cxl1.1 device link status register value
 to pci device sysfs.
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Cc: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>, "mj@ucw.cz" <mj@ucw.cz>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
References: <20240618042941.96893-1-kobayashi.da-06@fujitsu.com>
 <OSAPR01MB71825385034CD33C732EB878BADA2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <OSAPR01MB71825385034CD33C732EB878BADA2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/7/24 8:05 PM, Daisuke Kobayashi (Fujitsu) wrote:
> 
> Kobayashi Daisuke wrote:
>> CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards, the link
>> status can be output in the same way as traditional PCIe.
>> However, unlike devices from CXL2.0 onwards, CXL1.1 requires a different
>> method to obtain the link status from traditional PCIe.
>> This is because the link status of the CXL1.1 device is not mapped in the
>> configuration space (as per cxl3.0 specification 8.1).
>> Instead, the configuration space containing the link status is mapped to the
>> memory mapped register region (as per cxl3.0 specification 8.2, Table 8-18).
>> Therefore, the current lspci has a problem where it does not display the link
>> status of the CXL1.1 device.
>> Solve these issues with sysfs attributes to export the status registers hidden in
>> the RCRB.
>>
>> The procedure is as follows:
>> First, obtain the RCRB address within the cxl driver, then access the
>> configuration space. Next, output the link status information from the
>> configuration space to sysfs. Ultimately, the expectation is that this sysfs file
>> will be consumed by PCI user tools to utilize link status information.
>>
>>
>> Changes
>> v1[1] -> v2:
>> - Modified to perform rcrb access within the CXL driver.
>> - Added new attributes to the sysfs of the PCI device.
>> - Output the link status information to the sysfs of the PCI device.
>> - Retrieve information from sysfs as the source when displaying information in
>> lspci.
>>
>> v2[2] -> v3:
>> - Fix unnecessary initialization and wrong types (Bjohn).
>> - Create a helper function for getting a PCIe capability offset (Bjohn).
>> - Move platform-specific implementation to the lib directory in pciutils
>> (Martin).
>>
>> v3[3] -> v4:
>> - RCRB register values are read once and cached.
>> - Added a new attribute to the sysfs of the PCI device.
>> - Separate lspci implementation from this patch.
>>
>> v4[4] -> v5:
>> - Use macros for bitwise operations
>> - Fix RCRB access to use cxl_memdev
>>
>> v5[5] -> v6:
>> - Add and use masks for RCRB register values
>>
>> v6[6] -> v7:
>> - Fix comments on white space inline
>>
>> v7[7] -> v8:
>> - Change the cache value to offset
>> - Access memory map area in rcd_*_show() functions
>>
>> v8[8] -> v9:
>> - Map the pcie cap in for all the time the driver is bound to the device.
>> - Add mapping the pcie cap in cxl_rcd_component_reg_phys().
>>
>> v9[9] -> v10:
>> - Change a utility function for getting PCIe capability.
>> - Fix tab alignment issue, error handling, and apply suggestions from Jonathan.
>>
>> v10[10] -> v11:
>> - Add functions to have one function do only one thing.
>> - Add a size parameter to utility function arguments and consolidated them into
>> one.
>>
>> v11[11] -> v12:
>> - Fix the error handling in cxl_pci_setup_regs().
>> - Fix and clean up some details.
>>
>> v12[12] -> v13:
>> - Fix and clean up some details.
>>
>> v13[13] -> v14:
>> - Fix and clean up some details.
>>
>> [1]
>> https://lore.kernel.org/linux-cxl/20231220050738.178481-1-kobayashi.da-06
>> @fujitsu.com/
>> [2]
>> https://lore.kernel.org/linux-cxl/20240227083313.87699-1-kobayashi.da-06@
>> fujitsu.com/
>> [3]
>> https://lore.kernel.org/linux-cxl/20240312080559.14904-1-kobayashi.da-06@
>> fujitsu.com/
>> [4]
>> https://lore.kernel.org/linux-cxl/20240409073528.13214-1-kobayashi.da-06@
>> fujitsu.com/
>> [5]
>> https://lore.kernel.org/linux-cxl/20240412070715.16160-1-kobayashi.da-06@
>> fujitsu.com/
>> [6]
>> https://lore.kernel.org/linux-cxl/20240424050102.26788-1-kobayashi.da-06@
>> fujitsu.com/
>> [7]
>> https://lore.kernel.org/linux-cxl/20240510073710.98953-1-kobayashi.da-06@
>> fujitsu.com/
>> [8]
>> https://lore.kernel.org/linux-cxl/20240606074814.5633-1-kobayashi.da-06@f
>> ujitsu.com/
>> [9]
>> https://lore.kernel.org/linux-cxl/20240610082222.22772-1-kobayashi.da-06@
>> fujitsu.com/
>> [10]
>> https://lore.kernel.org/linux-cxl/20240611055254.61203-1-kobayashi.da-06@
>> fujitsu.com/
>> [11]
>> https://lore.kernel.org/linux-cxl/20240612075940.92500-1-kobayashi.da-06@
>> fujitsu.com/
>> [12]
>> https://lore.kernel.org/linux-cxl/20240614045611.58658-1-kobayashi.da-06@
>> fujitsu.com/
>> [13]
>> https://lore.kernel.org/linux-cxl/20240617043702.62028-1-kobayashi.da-06@
>> fujitsu.com/
>>
>> Kobayashi,Daisuke (2):
>>   cxl/core/regs: Add rcd_pcie_cap initialization
>>   cxl/pci: Add sysfs attribute for CXL 1.1 device link status
>>
>>  drivers/cxl/core/core.h |  6 +++
>>  drivers/cxl/core/regs.c | 61 ++++++++++++++++++++++++++++
>>  drivers/cxl/cxl.h       |  9 +++++
>>  drivers/cxl/pci.c       | 89
>> ++++++++++++++++++++++++++++++++++++++++-
>>  4 files changed, 163 insertions(+), 2 deletions(-)
>>
>> --
>> 2.44.0
> 
> Can you merge this patch into the next kernel?
> It has been reviewed and I believe it is ready to be merged.
> If it is already in process, please let me know as it is my fault for not checking thoroughly.

I'm waiting on review tags from Dan for this series. As I recall he had some previous comments. 
> 
