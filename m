Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2672F47A4C
	for <linux-cxl@vger.kernel.org>; Tue,  6 Aug 2024 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722962692; cv=none; b=tY3Hkdcdz9uW50sezqD40AwcxnXFOCYZKHY93cPNs//yu53cqJ9tZIE2eBERySGCt/DpMZHuon3fu6mLYjTDenoacHzkAyyxygIKVjbpInTHN7yVBQ79AJFSCNx6S2zOWiR3dKd2oI55gfqagx6taGtpWAw3Me9X8pQhN6l1QjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722962692; c=relaxed/simple;
	bh=OQc2Cz0D/H+isoloEW0zRt8CLnjsk8nDzb1ZMOFCCNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwX6YG5tZXj0m5XKMDsG36/m0ZXP6f2zLgKYIvW26tU8J3DNt1GK/jy+oaTMWzjnEWC3kIfZfJ4zJz3tYV1aL7Rrqbq9Qj5POaVVj52Tn4/UMoYO4AbKyB2mUg1DHvPtjwzBWqNRkuri1FwOYSt4/wC+emfN9Tjp+CrG1hz8CcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1jFhZyC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1jFhZyC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722962690; x=1754498690;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OQc2Cz0D/H+isoloEW0zRt8CLnjsk8nDzb1ZMOFCCNI=;
  b=n1jFhZyCSPq+bUtGobNJl9FZ+CZnm48/ahr3pNlIn7IQkGSj7puu+FQC
   nCrwy4CYz82dgHddlY2j6Zr+jhUxnG5j/YA0EbLfRDMXD054SxdzwatQp
   im+8iWKH+ADdeTqmZI0Ifl0EoOmx7AITQUXWTsUHdLcWb47bL0zL1bnrO
   29DHUpXpogD4jU8xaH+reLe6lCTpXKSbNeuEhL/aXRXTGORPpTgFKUpr3
   LNMRFZw+wF6dTtou8kXQenhJcxKPgOMWOqGeEQh8MFLqSp+SUw/MWiBJG
   LjvSkiNZ2B6k2p7nbcJqXpU3Cx91gbD4s29V6ADZ32+G+xLeCcyNm8GmK
   w==;
X-CSE-ConnectionGUID: dCmkxQxUT3qVwPRIEWhqfg==
X-CSE-MsgGUID: 3loVLo4NQuy/XpIpF+4l/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="31663390"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="31663390"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 09:44:32 -0700
X-CSE-ConnectionGUID: 3Msq+TV2SeGyds7x7itcQA==
X-CSE-MsgGUID: WYObGMdUTvqbPDIN0/1Utg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61392601"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.111.83]) ([10.125.111.83])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 09:44:31 -0700
Message-ID: <89bd36e0-85b1-4a81-8e53-3f610223b273@intel.com>
Date: Tue, 6 Aug 2024 09:44:30 -0700
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

I didn't see Shiju's patches until I created the RFC. For v1 I just wanted to post upstream to show intent and get some discussion going. I did let Shiju know that I'll pull in his code in a later rev. I expect a lot of churn with this code as we discuss.

It does seem like we may need a per feature (write) list/mask that is exclusive to kernel such as scrub? Also it looks like I need to find a different cxl spec defined feature to use for testing fwctl. 

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
> 
