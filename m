Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F242594
	for <linux-cxl@vger.kernel.org>; Wed, 13 Nov 2024 00:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457036; cv=none; b=IL+xpb8WqjIbnVaj954FkQIy1evA4ECf6arTqwVEoj4GkM3pm1EIuZhdOZDu5t1mItunPk44HifvoekxOqlY9CEbpd1ef0qltRj+25WfiXUWOIu7HBmduFPvWaZo1dkXeLl0ZWtn3RETaRknbn2AOzjXBe7vdCB7cxfNFb56Lyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457036; c=relaxed/simple;
	bh=fI17NgdxNyypxeDq+e4JoiW2omlyuN9dmIaDK/9i4Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XP0fBLUW+8m3Ddnja7ZNwyJ2Oh35T/Xn4ysqXWNdf7gr/4PpR0QKxBFVcOptx/qdjkqveQYuBYqiB/gPaHAFFut9FCXNro5qQ+nwPHqNycM0VzmMiS44SZGuhLoCoAF6hg1RdQ+wBNDrySjeJwzYLlkNWucZmrpO3JRBSNux+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALp9fp/H; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALp9fp/H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731457035; x=1762993035;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fI17NgdxNyypxeDq+e4JoiW2omlyuN9dmIaDK/9i4Dc=;
  b=ALp9fp/HecLk9ypIA9alR2SlYoSFcnjLhppOpfjAO4CRacfP7bLqyX7C
   dlTyn96jVvuHjF71vMKhbrOaT/pODr4WTV9NtqAjGL9ZzMogzLrM574a9
   IJZ6fH/8H9p2h0lshVHnYiE2AQ18zGsO9fYyICD58kaIHA1iYty+vYLqB
   SeHhYNRGVyJhe2JUQeVzw9ekxQe5zCHP+xcDtavO+e1ptYesJFA+MVZdz
   s1uXjaLVak0tbKbnAIEvvOp8Wpevy6UDJVcWzCYHpds34G9IiJrFNSK7J
   EbIpkUrMo05Ns4bisaSOBmORiHwL4k3/SddCFCL/VYL2RaB4CRs599wa0
   Q==;
X-CSE-ConnectionGUID: F1LIwv4bRC+219hIbSXeNw==
X-CSE-MsgGUID: +ST1kh0cRKabmmfMMeWfoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="18937792"
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="18937792"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 16:17:14 -0800
X-CSE-ConnectionGUID: 2lAyjEW7RA+4V9lgPc/2sw==
X-CSE-MsgGUID: QURoZlFrRmCUXSFjaZ9q8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,149,1728975600"; 
   d="scan'208";a="92471096"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.111.142]) ([10.125.111.142])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 16:17:13 -0800
Message-ID: <91a093f4-5975-48da-b9a4-5ee31153c1b2@intel.com>
Date: Tue, 12 Nov 2024 17:17:11 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/13] fwctl/cxl: Add CXL feature commands support via
 fwctl
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com, Borislav Petkov <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter <rric@kernel.org>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <20240729130528.0000139b@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240729130528.0000139b@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/29/24 5:05 AM, Jonathan Cameron wrote:
> On Thu, 18 Jul 2024 14:32:18 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> This series add support for CXL feature commands using the FWCTL framework [1].
>> The code is untested and I'm looking for architectural and implementation feedback.
>> While CXL currently has a chardev for user ioctls to send some mailbox
>> commands to a memory device, the fwctl framework provides more security policies
>> that can be a potential vehicle to move CXL ioctl path to that.
>>
>> For this RFC, the mailbox commands "Get Supported Features", "Get Feature", and
>> "Set Feature" commands are implemented. The "get" commands under the
>> FWCTL_RPC_DEBUG_READ_ONLY policy, the "set" command checks the policy depending
>> on the effect of the feature. All mailbox commands for CXL provides an effects
>> table that describes the effects of a command when performed on the device.
>> For CXL features, there is also an effects field that describes the effects
>> a feature write operation has on the device per feature. The security policy
>> is checked against this feature specific effects field. Looking for discussion
>> on matching the CXL spec defined effects with the FWCTL security policy.
> 
> Hi Dave,
> 
> Great to have this code.
> 
> My main concern is that, once a feature is exposed by fwctl, it becomes ABI.
> Even with the taint, does that mean we can't remove it later? We
> may well have userspace code using fwctl that will break kernel driver
> support.

Maybe we can sanitize the return of the get features command on the kernel side and block what we don't want the user to see. That way we can theoretically "remove" things that's within the kernel's control right? 

DJ


> 
> As you probably know, for the scrub control you are using as an example,
> there is an ongoing effort to generalize that across multiple subsystems.
> It's a convenient test as a simple get/set feature in CXL, so maybe
> I'm reading too much into that choice.
> 
> One piece of good feedback we got on that generalization effort was that
> this sort of RAS control should all be in one place (we were proposing
> a RAS control subsystem at the times, separate from EDAC). The key reason
> being to ensure it gets sufficient review by experts in the RAS aspects
> (rather than CXL or other implementation).
> 
> Shiju's latest series puts it all in /sys/bus/edac/
> https://lore.kernel.org/linux-cxl/20240726160556.2079-1-shiju.jose@huawei.com/T/#t
> 
> Even if we make the driver safe to someone else messing with the state under it
> (so basically make it stateless) we can't make the same guarantees for any
> user space code on top of that interface.  Can we rely on only one path ever
> being used? I'm not sure.
> 
> We could in theory decide to expose all the stuff proposed for the EDAC / rascontrol
> as fwctl only, but that's going to get nasty as next set of features we plan to
> implement are memory repair related and in at least some cases those require the
> memory to be offlined if you don't want nasty side effects. I don't think there
> will be appetite for that sort of thing via fwctl.
> 
> There are a bunch of other get/set features in the CXL spec and I expect to see
> more over time so I think this will be an ongoing discussion.
> 
> Jonathan
> 
> +CC Edac maintainers etc, as they may have views on using fwctl for this stuff.
> 
> 
> 
>>
>> The code is based off of the latest FWCTL series [1] posted by Jason on top of v6.10.
>>
>> [1]: https://lore.kernel.org/linux-cxl/20240624161802.1b7c962d@kernel.org/T/#t
>>
>> ---
>>
>> Dave Jiang (13):
>>       cxl: Move mailbox related bits to the same context
>>       cxl: Fix comment regarding cxl_query_cmd() return data
>>       cxl: Refactor user ioctl command path from mds to mailbox
>>       cxl: Add Get Supported Features command for kernel usage
>>       cxl/test: Add Get Supported Features mailbox command support
>>       cxl: Add Get Feature command support
>>       cxl: Add Set Feature command support
>>       fwctl/cxl: Add driver for CXL mailbox for handling CXL features commands
>>       fwctl/cxl: Add support for get driver information
>>       fwctl/cxl: Add support for fwctl RPC command to enable CXL feature commands
>>       fwctl/cxl: Add query commands software command for ->fw_rpc()
>>       cxl/test: Add Get Feature support to cxl_test
>>       cxl/test: Add Set Feature support to cxl_test
>>
>>  MAINTAINERS                  |   8 +
>>  drivers/cxl/core/core.h      |   9 +-
>>  drivers/cxl/core/mbox.c      | 607 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
>>  drivers/cxl/core/memdev.c    |  78 +++++---
>>  drivers/cxl/cxlmem.h         | 141 +++------------
>>  drivers/cxl/pci.c            |  68 ++++---
>>  drivers/cxl/pmem.c           |  10 +-
>>  drivers/cxl/security.c       |  18 +-
>>  drivers/fwctl/Kconfig        |   9 +
>>  drivers/fwctl/Makefile       |   1 +
>>  drivers/fwctl/cxl/Makefile   |   4 +
>>  drivers/fwctl/cxl/cxl.c      | 274 ++++++++++++++++++++++++++++
>>  include/linux/cxl/mailbox.h  | 175 ++++++++++++++++++
>>  include/uapi/fwctl/cxl.h     |  92 ++++++++++
>>  include/uapi/fwctl/fwctl.h   |   1 +
>>  include/uapi/linux/cxl_mem.h |   3 +
>>  tools/testing/cxl/test/mem.c | 292 +++++++++++++++++++++++++++++-
>>  17 files changed, 1515 insertions(+), 275 deletions(-)
> 

