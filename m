Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B98F1AAE02
	for <linux-cxl@vger.kernel.org>; Tue, 24 Sep 2024 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188094; cv=none; b=W7hNI1O+iBVbDNYumOqZu8fJmiApDCYTRg5WywbjGheRJ8goOR4zmXCknawhxn4HMnCZtKJDpJNYJjS928cB/Whk7CXJjXxbakpKlEbY3nKgWFI8sylMakeFIlaSOq9Gp9DHSmZVCIXIACT/mCzfP0JbrYCQ65CMtE+LMmd4gk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188094; c=relaxed/simple;
	bh=K3iERf3En3R4mwBoEO8Lr/qVuWmIIJAgSicP06Of5+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HiTKn+PRvT7CBrIsf2xu30fzVHzowfrtClKsPGLl6MeQngUFaagP3SSDxjMC6ZUvfYzfMUT/pk/+3dJfJvrUs7Nd/CzW3QqqGnigg3JMWaWqZ3yrxBWiS+p+yzXNA1HV0aHWHXZe7gaOvm6XUY1ZUd95tplZzmbsCNCSmDtYs4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vxf8BYLB; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vxf8BYLB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727188093; x=1758724093;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K3iERf3En3R4mwBoEO8Lr/qVuWmIIJAgSicP06Of5+w=;
  b=Vxf8BYLBDVW4CIvx69cwb7c40lKiz5kJNpQ6ewy9crZdrDFx1JCYELV8
   weA7qlTpbdMQMWO71qmgn+YpRpK8uibmL8SJDRhKh+SJyu0AWoLSvLMys
   lYQONEiGbzoAEvniVSsaWyzez0W5gvl0BjdPn/C94W6Dw/xwXLX2BZZJ0
   wc5ziPCEDdQDHK7JXBtC5fE1oTUvNpyx2uHWLPqld6EjyDwJdXQ0RweID
   PDnJ0niWcZ15wUPnXZhw8AuuiOWYbIw7hyhXshCyViHN0TvAWsTHU+OjK
   2qody99+4peoMfslJT+CcB5ZJWi4BDk0oRfsUAESj+BQhJLIkxxrONX6k
   w==;
X-CSE-ConnectionGUID: iztZd1aUQ/Sowz2z4Xl/7Q==
X-CSE-MsgGUID: gl/IZeE9Qwie8tyLqj/dRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="36752675"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="36752675"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 07:28:12 -0700
X-CSE-ConnectionGUID: I/bDFqrVQ0+D1IsG7jJREA==
X-CSE-MsgGUID: fg7y0m4DSyWtDsodFSDhZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="72268861"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.111.11]) ([10.125.111.11])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 07:28:12 -0700
Message-ID: <e4b76403-2e1e-4c5b-ae02-e09d97384c0a@intel.com>
Date: Tue, 24 Sep 2024 07:28:10 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 0/2] Export cxl1.1 device link status register value
 to pci device sysfs.
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Cc: "mj@ucw.cz" <mj@ucw.cz>
References: <20240903025915.270521-1-kobayashi.da-06@fujitsu.com>
 <OSAPR01MB71827E711822FF4DD30C8A58BA682@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <OSAPR01MB71827E711822FF4DD30C8A58BA682@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/24/24 12:36 AM, Daisuke Kobayashi (Fujitsu) wrote:
> Hi, Dan. Could you please review this patch?
> I think I've fixed the issues you mentioned.

Hi Daisuke,
In the mean time can you please respin and fix these two kbot issues?
https://lore.kernel.org/linux-cxl/202409040011.kaajNuCb-lkp@intel.com/
https://lore.kernel.org/linux-cxl/202409040010.afyGcWUe-lkp@intel.com/

> 
> Thank you.
> 
> Kobayashi Daisuke wrote:
>> Subject: [PATCH v17 0/2] Export cxl1.1 device link status register value to pci
>> device sysfs.
>>
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
>> This patch series relies on the functions defined in the following patches.
>> https://lore.kernel.org/linux-cxl/20240830013138.2256244-1-ming4.li@intel.c
>> om/
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
>> v14[14] -> v15:
>> - Change dport lookup to be done only once.
>> - Fix the visibility of cxl_rcrb_to_linkcap().
>>
>> v15[15] -> v16:
>> - Fix the port leak bug by introduce a new scope-based-free handler
>> - Improve the variable names.
>>
>> v16[16] -> v17:
>> - Change used function for making struct cxl_port *port
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
>> [14]
>> https://lore.kernel.org/linux-cxl/20240618042941.96893-1-kobayashi.da-06@
>> fujitsu.com/
>> [15]
>> https://lore.kernel.org/linux-cxl/20240716042540.89639-1-kobayashi.da-06@
>> fujitsu.com/
>> [16]
>> https://lore.kernel.org/linux-cxl/20240815005510.220835-1-kobayashi.da-06
>> @fujitsu.com/
>>
>> Kobayashi,Daisuke (2):
>>   cxl/core/regs: Add rcd_pcie_cap initialization
>>   cxl/pci: Add sysfs attribute for CXL 1.1 device link status
>>
>>  drivers/cxl/core/core.h |   5 ++
>>  drivers/cxl/core/regs.c |  56 ++++++++++++++++++++
>>  drivers/cxl/cxl.h       |   9 ++++
>>  drivers/cxl/pci.c       | 110
>> +++++++++++++++++++++++++++++++++++-----
>>  4 files changed, 167 insertions(+), 13 deletions(-)
>>
>> --
>> 2.45.0
> 
> 

