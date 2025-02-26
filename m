Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE19621C9FE
	for <linux-cxl@vger.kernel.org>; Wed, 26 Feb 2025 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740585754; cv=none; b=FBookTO1OVu0D3gF0tqQJEGWzLfHd33DFF4jnQSj6yJYR34TGeXevr4aGrmXWgmj+Rf4CD9gU20ITXgkjiRjuSDlx4qfv7/rS2FkbwYZq8dxITDj7q5IBIfeMLyYDjqf4ZoSxOmF8l8qXKzD6U9muo/O9+oOabTLZosvF3wasTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740585754; c=relaxed/simple;
	bh=oARPGgYZd2exHc93IezVPWCliZuH/XHFCD3pQ+e1NUw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cc0WXbmaDRRM3IXC2DYJ4XvEh5Ab6Wt+l37pcSljIUo4TdwmJC9+xVY5fX8NhyEgKSb8E4BJIXrJK04oSh5qmOtWKNyFJbA8Wu3ZY9+NTJ50JN9FiB2UG1aOHEc4d+eTYoDi5jQ+0KA2HTN6m1xIDyeT2aILnrnmiG8BVQfH14c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gs4ZGGZ2; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gs4ZGGZ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740585753; x=1772121753;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=oARPGgYZd2exHc93IezVPWCliZuH/XHFCD3pQ+e1NUw=;
  b=Gs4ZGGZ2GdGU6nmKObtJs/b/cmf/CcRCKLifGEi8H7ALZ8jHmOyVROMo
   1WKoaLcXtdpPX2QRCzb7bs4LD8pZTrmP8YtuG3cVgm40k7HIMSYcXXvEH
   qTxwX+L5uNSotuknfHi757ver9Gpjw96WFvoIsBhC7PusAPhiwO5w8xxh
   c6Q/oYTf8nfZxQqJOFtD/jNjAXyEuPuASDGVgDtbLPCe4VaS/FyNiATle
   zaqjiG1jU/6A6kxliWgxYo856BV8ryHj3VBjbIzJuD2uwdiL60Ka+fMJv
   xvb7j24eQQMcL5o6kXxJveieV8tQeCcg+lJNytFxQ5jSbZkJTzFXb+vnd
   A==;
X-CSE-ConnectionGUID: wpAqlpW7RrC3olSsIRwiRA==
X-CSE-MsgGUID: 9wSOnaRdROuu3nICvjCq2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="63907078"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="63907078"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 08:02:32 -0800
X-CSE-ConnectionGUID: ocSLsCttRnSBOtRzN3k1aA==
X-CSE-MsgGUID: TYzytnNDQZK5bktCeCKIHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="116751356"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.108.7]) ([10.125.108.7])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 08:02:31 -0800
Message-ID: <9549ae4c-f38d-4647-ad98-054f848f2d10@intel.com>
Date: Wed, 26 Feb 2025 09:02:30 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/14] cxl: Add CXL feature commands support via fwctl
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250220194438.2281088-1-dave.jiang@intel.com>
 <7950d8fc-886d-4895-a2b7-53453eca20cf@intel.com>
Content-Language: en-US
In-Reply-To: <7950d8fc-886d-4895-a2b7-53453eca20cf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/25/25 10:54 AM, Dave Jiang wrote:
> 
> 
> On 2/20/25 12:42 PM, Dave Jiang wrote:
>> v7:
>> - Move the flex array bits to where it is used. (Jonathan)
>> - Use uuid from defined struct instead of cast from byte stream. (Jonathan)
> 
> Patches 1-6 have been merged into cxl/next:
> 0f5f03069721 Merge branch 'for-6.15/features' into cxl-for-next

58c3faeba550

A doc error needed to be fixed, reported by linux-next
> 
> Patches 7-14 will be picked up by Jason with his fwctl PR
> Thanks Jason.
> 
>>
>> v6:
>> - Drop info callback. (Saeed)
>> - Embed hw operation in the input payload. (Saeed)
>> - Move set_features check bits to the set_features enabling patch. (Saeed)
>> - Update user example in documentation to support embedded operation in payload
>> - See individual patches for detailed changes from v5.
>>
>> v5:
>> - Add devm action to fwctl. (Dan)
>> - Fix return of NULL instead of ERR_PTR() for get features. (Ming)
>> - Make cxl_get/set_feature() internal to cxl/core (Dan)
>> - Add missing NULL check for cxl_set_feature() (Dan)
>> - Remove cxlmd back pointer from fwctl. (Dan)
>> - Add missing CONFIG_FWCTL dependency to Kconfig.
>> - Fix index of for loop for fwctl get features. (Ming)
>> - See individual patches for detailed changes from v4.
>>
>> v4:
>> - Rebase to FWCTL series v4 based on v6.14-rc1
>> - Merge patch 1/16 from v3 into cxl/next ahead. (Jonathan)
>> - Move everything to core/features.c and behind CONFIG_CXL_FEATURES. (Dan)
>> - Split the registration of features into 2 parts. Do the registration in
>>   PCI probe. One before memdev enumeration to enable kernel feature support,
>>   and one after memdev enumeration to support FWCTL. (Dan)
>> - Fix incrememt of pointer after copying feature data. (Ming)
>> - Add check for no immediate change effect and no reset change effects. (Dan, Jonathan)
>> - Remove IDs and use opcodes directly. (Dan)
>> - See individual patches for detailed changes from v3.
>>
>> v3:
>> - Rearrange code and shift code forward to reduce diffs. (Jonathan)
>> - Use struct_size() in appropriate locations. (Jonathan)
>> - Remove usage of __weak and refactor accordingly. (Jason)
>> - Return NULL for allocation functions. (Jonathan)
>> - See individual patches for detailed changes from v2.
>>
>> v2:
>> - Drop features device and driver. Move features enabling to cxl_memdev. (Dan)
>> - Drop sysfs attribute of number of features. (Dan)
>> - Drop moving of include/uapi/linux/cxl_mem.h. (Dan)
>> - Set get driver info ioctl to return reserved 32bit. Set behavior of issue
>>   ioctl successful as indicating Feature commands supported.
>> - Set 'Set Feature Size' to 0 for kernel exclusive Features.
>> - See individual patches for detailed changes from v1.
>> - Hide FWCTL bits behind CONFIG_CXL_FWCTL. (Dan)
>>
>> v1:
>> - Create a CXL features driver to handle all feature command related bits
>>   including FWCTL support. (Dan)
>> - Tested against CXL CLI unit tests for FWCTL.
>> - See individual patches for detailed changes from RFC v2.
>>
>> RFC v2:
>> - Dropped 1/13 and 2/13 from previous version. Merged upstream already.
>> - Combined changes from Shiju for "get supported features"
>> - Addressed comments from Jonathan and Jason
>> - See specific changes in individual patch revision history
>> - Added hardware command info to FWCTL
>> - Added filtering to set feature command
>> - Added documentation
>>
>> This series add support for CXL feature commands using the FWCTL framework [1].
>> The code has been tested with CXL CLI unit tests for FWCTL.
>>
>> Patches 1-6 are shared with EDAC series [1] and there will be an immutable branch
>> once accepted post review.
>>
>> CXL Features support is added behind the CXL mem driver. The 3 mailbox commands
>> "Get Supported Features", "Get Feature", and "Set Feature" are implemented. The
>> "Get" commands are under the FWCTL_RPC_CONFIGURATION policy, the "Set" command
>> checks the policy depending on the set effects of the feature defined by the
>> device via the Feature set effects field. All mailbox commands for CXL provides
>> an effects table that describes the effects of a command when performed on the
>> device.  For CXL features, there is also an effects field that describes the
>> effects a feature set operation has on the device per feature. The security
>> policy is checked against this feature specific effects field. 
>>
>> The code is based off of v4 of FWCTL series [2] posted by Jason and rebased on top of
>> v6.14-rc1 plus 1 patch in
>> cxl/next 43ca2463df9d ("cxl: Refactor user ioctl command path from mds to mailbox").
>> A kernel branch [3] is provided for convience of testing and review.
>>
>> [1]: https://lore.kernel.org/linux-cxl/20250106121017.1620-1-shiju.jose@huawei.com/T/#t
>> [2]: https://lore.kernel.org/linux-cxl/0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com/#r
>> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl/fwctl
>>
>> ---
>> Dave Jiang (12):
>>       cxl: Enumerate feature commands
>>       cxl: Add Get Supported Features command for kernel usage
>>       cxl/test: Add Get Supported Features mailbox command support
>>       cxl: Setup exclusive CXL features that are reserved for the kernel
>>       cxl: Add FWCTL support to CXL
>>       cxl: Move cxl feature command structs to user header
>>       cxl: Add support for fwctl RPC command to enable CXL feature commands
>>       cxl: Add support to handle user feature commands for get feature
>>       cxl: Add support to handle user feature commands for set feature
>>       cxl/test: Add Get Feature support to cxl_test
>>       cxl/test: Add Set Feature support to cxl_test
>>       fwctl/cxl: Add documentation to FWCTL CXL
>>
>> Shiju Jose (2):
>>       cxl/mbox: Add GET_FEATURE mailbox command
>>       cxl/mbox: Add SET_FEATURE mailbox command
>>
>>  Documentation/userspace-api/fwctl/fwctl-cxl.rst | 144 +++++++++
>>  Documentation/userspace-api/fwctl/index.rst     |   1 +
>>  MAINTAINERS                                     |   1 +
>>  drivers/cxl/Kconfig                             |  12 +
>>  drivers/cxl/core/Makefile                       |   1 +
>>  drivers/cxl/core/core.h                         |  11 +
>>  drivers/cxl/core/features.c                     | 710 ++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/core/mbox.c                         |  36 ++-
>>  drivers/cxl/cxlmem.h                            |   7 +
>>  drivers/cxl/pci.c                               |   8 +
>>  include/cxl/features.h                          |  91 ++++++
>>  include/cxl/mailbox.h                           |   3 +
>>  include/uapi/cxl/features.h                     | 128 ++++++++
>>  include/uapi/fwctl/cxl.h                        |  55 ++++
>>  include/uapi/fwctl/fwctl.h                      |   1 +
>>  tools/testing/cxl/Kbuild                        |   1 +
>>  tools/testing/cxl/test/mem.c                    | 185 ++++++++++++
>>  17 files changed, 1394 insertions(+), 1 deletion(-)
>>
> 
> 

