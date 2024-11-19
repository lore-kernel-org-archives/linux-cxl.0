Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD751CEAB8
	for <linux-cxl@vger.kernel.org>; Tue, 19 Nov 2024 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031931; cv=none; b=jfSxyK7WSm4dTW+amI7icim9dhvBzoeG4mP3p+e8L3K/Z7Gn2YpxqMkXGIYhOnHJsOUvkhMdb+bR4ZnMvjkI5fNZ5XO+4CSaStErJXssTxykRCcZGL1YzY1FWhxd5Qc5UYal/9BcDG8XDCiULRWCDAie7gHXeAki6fkc6+12t7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031931; c=relaxed/simple;
	bh=mf/WzZ52jyvjkJ2o77V6cq3+YOW81JzFgkRSDVjXiQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uikzFZF8NcJ1USE+EIjOrsORaJtyeFLaownvrWSmQSg2dulGsT764PCbI49Y7RkZf0UQT48zhu9/qZkKQVK1jkHTf14nb1NaKnjxfvZ+vLrN+3xOAgOTrKlMnGG3kNBbF+u2Cjd7zHFwxwo5Buwq+IAeZ3r7QepiAaKGeDQZZMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DRTFa/KW; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DRTFa/KW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732031930; x=1763567930;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mf/WzZ52jyvjkJ2o77V6cq3+YOW81JzFgkRSDVjXiQQ=;
  b=DRTFa/KWp6X8Xv5md8eNbXv+mJHcyS95xiXm02MLpHsl9n/5j3dAbwRR
   Ld079WpObPKZHKcci756l0WH0Vg/yiv5JdsuujH5hpXzEfIGYh7qf+J+p
   M6eVXCnpbuGmLFJb1U4Aa108Z9q3EXSqTDZIWMSdxL7nY72KrknQl7cj6
   WzZ0+VTKWnoelsMVUtetXJn/RspwLgaaaaeJ2CXhrhR8mZDbshcRtfM88
   lhlwJ8i0iRoGRAP0KSIBmc09+8/BmKp4/BuAnYl6J9QP29CFvbllONSvl
   wSPGUNbijaRCNao9VIyhpJixTws46xkf7B6PsbyTp/qVlPeg40u2OgBso
   Q==;
X-CSE-ConnectionGUID: /X3ymul1QMuiH1v8yfLnMA==
X-CSE-MsgGUID: cJ9Z0o0RRPOs921hXQtFNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="43426431"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="43426431"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 07:58:49 -0800
X-CSE-ConnectionGUID: ep9RoI8wQniCPEhVD2Iq+w==
X-CSE-MsgGUID: hgdzXgVrRD+UuGagxPZCdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="90417012"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.91]) ([10.125.109.91])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 07:58:48 -0800
Message-ID: <9d5a3615-ff0f-4615-882b-430221928a51@intel.com>
Date: Tue, 19 Nov 2024 08:58:47 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/13] fwctl/cxl: Add CXL feature commands support via
 fwctl
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com, Borislav Petkov <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter <rric@kernel.org>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <20240729130528.0000139b@Huawei.com>
 <91a093f4-5975-48da-b9a4-5ee31153c1b2@intel.com>
 <20241119114304.000031a4@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241119114304.000031a4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/19/24 4:43 AM, Jonathan Cameron wrote:
> On Tue, 12 Nov 2024 17:17:11 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> On 7/29/24 5:05 AM, Jonathan Cameron wrote:
>>> On Thu, 18 Jul 2024 14:32:18 -0700
>>> Dave Jiang <dave.jiang@intel.com> wrote:
>>>   
>>>> This series add support for CXL feature commands using the FWCTL framework [1].
>>>> The code is untested and I'm looking for architectural and implementation feedback.
>>>> While CXL currently has a chardev for user ioctls to send some mailbox
>>>> commands to a memory device, the fwctl framework provides more security policies
>>>> that can be a potential vehicle to move CXL ioctl path to that.
>>>>
>>>> For this RFC, the mailbox commands "Get Supported Features", "Get Feature", and
>>>> "Set Feature" commands are implemented. The "get" commands under the
>>>> FWCTL_RPC_DEBUG_READ_ONLY policy, the "set" command checks the policy depending
>>>> on the effect of the feature. All mailbox commands for CXL provides an effects
>>>> table that describes the effects of a command when performed on the device.
>>>> For CXL features, there is also an effects field that describes the effects
>>>> a feature write operation has on the device per feature. The security policy
>>>> is checked against this feature specific effects field. Looking for discussion
>>>> on matching the CXL spec defined effects with the FWCTL security policy.  
>>>
>>> Hi Dave,
>>>
>>> Great to have this code.
>>>
>>> My main concern is that, once a feature is exposed by fwctl, it becomes ABI.
>>> Even with the taint, does that mean we can't remove it later? We
>>> may well have userspace code using fwctl that will break kernel driver
>>> support.  
>>
>> Maybe we can sanitize the return of the get features command on the kernel side and block what we don't want the user to see. That way we can theoretically "remove" things that's within the kernel's control right? 
> 
> Hmm. That sort of works, though I think it still would conventionally be
> ABI breakage if we made a feature disappear between kernel versions.
> 
> Hopefully we are find doing that in the corner case that we don't have
> visibility of a future need to remove a feature from what get feature
> reports.

Please take a look at the implementation in v2 and see if that would work. To me given that the features are discovery based and we filter the output of "get supported features" command via the kernel, user app should only issue command after verified via discovery and not hard code support.

> 
> J
>>
>> DJ
>>
>>
>>>
>>> As you probably know, for the scrub control you are using as an example,
>>> there is an ongoing effort to generalize that across multiple subsystems.
>>> It's a convenient test as a simple get/set feature in CXL, so maybe
>>> I'm reading too much into that choice.
>>>
>>> One piece of good feedback we got on that generalization effort was that
>>> this sort of RAS control should all be in one place (we were proposing
>>> a RAS control subsystem at the times, separate from EDAC). The key reason
>>> being to ensure it gets sufficient review by experts in the RAS aspects
>>> (rather than CXL or other implementation).
>>>
>>> Shiju's latest series puts it all in /sys/bus/edac/
>>> https://lore.kernel.org/linux-cxl/20240726160556.2079-1-shiju.jose@huawei.com/T/#t
>>>
>>> Even if we make the driver safe to someone else messing with the state under it
>>> (so basically make it stateless) we can't make the same guarantees for any
>>> user space code on top of that interface.  Can we rely on only one path ever
>>> being used? I'm not sure.
>>>
>>> We could in theory decide to expose all the stuff proposed for the EDAC / rascontrol
>>> as fwctl only, but that's going to get nasty as next set of features we plan to
>>> implement are memory repair related and in at least some cases those require the
>>> memory to be offlined if you don't want nasty side effects. I don't think there
>>> will be appetite for that sort of thing via fwctl.
>>>
>>> There are a bunch of other get/set features in the CXL spec and I expect to see
>>> more over time so I think this will be an ongoing discussion.
>>>
>>> Jonathan
>>>
>>> +CC Edac maintainers etc, as they may have views on using fwctl for this stuff.
>>>
>>>
>>>   
>>>>
>>>> The code is based off of the latest FWCTL series [1] posted by Jason on top of v6.10.
>>>>
>>>> [1]: https://lore.kernel.org/linux-cxl/20240624161802.1b7c962d@kernel.org/T/#t
>>>>
>>>> ---
>>>>
>>>> Dave Jiang (13):
>>>>       cxl: Move mailbox related bits to the same context
>>>>       cxl: Fix comment regarding cxl_query_cmd() return data
>>>>       cxl: Refactor user ioctl command path from mds to mailbox
>>>>       cxl: Add Get Supported Features command for kernel usage
>>>>       cxl/test: Add Get Supported Features mailbox command support
>>>>       cxl: Add Get Feature command support
>>>>       cxl: Add Set Feature command support
>>>>       fwctl/cxl: Add driver for CXL mailbox for handling CXL features commands
>>>>       fwctl/cxl: Add support for get driver information
>>>>       fwctl/cxl: Add support for fwctl RPC command to enable CXL feature commands
>>>>       fwctl/cxl: Add query commands software command for ->fw_rpc()
>>>>       cxl/test: Add Get Feature support to cxl_test
>>>>       cxl/test: Add Set Feature support to cxl_test
>>>>
>>>>  MAINTAINERS                  |   8 +
>>>>  drivers/cxl/core/core.h      |   9 +-
>>>>  drivers/cxl/core/mbox.c      | 607 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
>>>>  drivers/cxl/core/memdev.c    |  78 +++++---
>>>>  drivers/cxl/cxlmem.h         | 141 +++------------
>>>>  drivers/cxl/pci.c            |  68 ++++---
>>>>  drivers/cxl/pmem.c           |  10 +-
>>>>  drivers/cxl/security.c       |  18 +-
>>>>  drivers/fwctl/Kconfig        |   9 +
>>>>  drivers/fwctl/Makefile       |   1 +
>>>>  drivers/fwctl/cxl/Makefile   |   4 +
>>>>  drivers/fwctl/cxl/cxl.c      | 274 ++++++++++++++++++++++++++++
>>>>  include/linux/cxl/mailbox.h  | 175 ++++++++++++++++++
>>>>  include/uapi/fwctl/cxl.h     |  92 ++++++++++
>>>>  include/uapi/fwctl/fwctl.h   |   1 +
>>>>  include/uapi/linux/cxl_mem.h |   3 +
>>>>  tools/testing/cxl/test/mem.c | 292 +++++++++++++++++++++++++++++-
>>>>  17 files changed, 1515 insertions(+), 275 deletions(-)  
>>>   
>>
>>
> 

