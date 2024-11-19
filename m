Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EF41CACED
	for <linux-cxl@vger.kernel.org>; Tue, 19 Nov 2024 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016591; cv=none; b=SfdpckukVChQ8WM59XYD2NCyfJPy5oV9f0mSyBG6qVfPRdFcII2MZpIu3G3NZ5Ka8uW2HYepjFZytwkT3a6cCCwlGLMOAdS8yPGBavkYd7adtZL8yUXzClRZ1nW2KyyeUCldaPFFZFCov7wk6ItWOaNRYMPvMcVeGPdtogcKyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016591; c=relaxed/simple;
	bh=RwyJuCL/of/eSm/dxd4uiJybd8o2Hj1UvNRo/hpUm8E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Obe2ao60e9Wqwxx5dMrnllXbLI12huWxEs5lSv7q32YGfk1+LRV8JEJ6q3q7855zFzu09425pdsPkG++X6YCK4XNsRG+ddMiBKQL6xtGBFtW3jiytVD91VBiZtsxAvEx4ZpdOU/g6WAW8m8fr8Vs0b7jZC0+WrllhE3klrinZbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xt2bG0wC0z6K6m4;
	Tue, 19 Nov 2024 19:39:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 156AF140B18;
	Tue, 19 Nov 2024 19:43:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Nov
 2024 12:43:05 +0100
Date: Tue, 19 Nov 2024 11:43:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, Mauro Carvalho
 Chehab <mchehab@kernel.org>, "Robert Richter" <rric@kernel.org>
Subject: Re: [RFC PATCH 0/13] fwctl/cxl: Add CXL feature commands support
 via fwctl
Message-ID: <20241119114304.000031a4@huawei.com>
In-Reply-To: <91a093f4-5975-48da-b9a4-5ee31153c1b2@intel.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
	<20240729130528.0000139b@Huawei.com>
	<91a093f4-5975-48da-b9a4-5ee31153c1b2@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Nov 2024 17:17:11 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 7/29/24 5:05 AM, Jonathan Cameron wrote:
> > On Thu, 18 Jul 2024 14:32:18 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> >> This series add support for CXL feature commands using the FWCTL framework [1].
> >> The code is untested and I'm looking for architectural and implementation feedback.
> >> While CXL currently has a chardev for user ioctls to send some mailbox
> >> commands to a memory device, the fwctl framework provides more security policies
> >> that can be a potential vehicle to move CXL ioctl path to that.
> >>
> >> For this RFC, the mailbox commands "Get Supported Features", "Get Feature", and
> >> "Set Feature" commands are implemented. The "get" commands under the
> >> FWCTL_RPC_DEBUG_READ_ONLY policy, the "set" command checks the policy depending
> >> on the effect of the feature. All mailbox commands for CXL provides an effects
> >> table that describes the effects of a command when performed on the device.
> >> For CXL features, there is also an effects field that describes the effects
> >> a feature write operation has on the device per feature. The security policy
> >> is checked against this feature specific effects field. Looking for discussion
> >> on matching the CXL spec defined effects with the FWCTL security policy.  
> > 
> > Hi Dave,
> > 
> > Great to have this code.
> > 
> > My main concern is that, once a feature is exposed by fwctl, it becomes ABI.
> > Even with the taint, does that mean we can't remove it later? We
> > may well have userspace code using fwctl that will break kernel driver
> > support.  
> 
> Maybe we can sanitize the return of the get features command on the kernel side and block what we don't want the user to see. That way we can theoretically "remove" things that's within the kernel's control right? 

Hmm. That sort of works, though I think it still would conventionally be
ABI breakage if we made a feature disappear between kernel versions.

Hopefully we are find doing that in the corner case that we don't have
visibility of a future need to remove a feature from what get feature
reports.

J
> 
> DJ
> 
> 
> > 
> > As you probably know, for the scrub control you are using as an example,
> > there is an ongoing effort to generalize that across multiple subsystems.
> > It's a convenient test as a simple get/set feature in CXL, so maybe
> > I'm reading too much into that choice.
> > 
> > One piece of good feedback we got on that generalization effort was that
> > this sort of RAS control should all be in one place (we were proposing
> > a RAS control subsystem at the times, separate from EDAC). The key reason
> > being to ensure it gets sufficient review by experts in the RAS aspects
> > (rather than CXL or other implementation).
> > 
> > Shiju's latest series puts it all in /sys/bus/edac/
> > https://lore.kernel.org/linux-cxl/20240726160556.2079-1-shiju.jose@huawei.com/T/#t
> > 
> > Even if we make the driver safe to someone else messing with the state under it
> > (so basically make it stateless) we can't make the same guarantees for any
> > user space code on top of that interface.  Can we rely on only one path ever
> > being used? I'm not sure.
> > 
> > We could in theory decide to expose all the stuff proposed for the EDAC / rascontrol
> > as fwctl only, but that's going to get nasty as next set of features we plan to
> > implement are memory repair related and in at least some cases those require the
> > memory to be offlined if you don't want nasty side effects. I don't think there
> > will be appetite for that sort of thing via fwctl.
> > 
> > There are a bunch of other get/set features in the CXL spec and I expect to see
> > more over time so I think this will be an ongoing discussion.
> > 
> > Jonathan
> > 
> > +CC Edac maintainers etc, as they may have views on using fwctl for this stuff.
> > 
> > 
> >   
> >>
> >> The code is based off of the latest FWCTL series [1] posted by Jason on top of v6.10.
> >>
> >> [1]: https://lore.kernel.org/linux-cxl/20240624161802.1b7c962d@kernel.org/T/#t
> >>
> >> ---
> >>
> >> Dave Jiang (13):
> >>       cxl: Move mailbox related bits to the same context
> >>       cxl: Fix comment regarding cxl_query_cmd() return data
> >>       cxl: Refactor user ioctl command path from mds to mailbox
> >>       cxl: Add Get Supported Features command for kernel usage
> >>       cxl/test: Add Get Supported Features mailbox command support
> >>       cxl: Add Get Feature command support
> >>       cxl: Add Set Feature command support
> >>       fwctl/cxl: Add driver for CXL mailbox for handling CXL features commands
> >>       fwctl/cxl: Add support for get driver information
> >>       fwctl/cxl: Add support for fwctl RPC command to enable CXL feature commands
> >>       fwctl/cxl: Add query commands software command for ->fw_rpc()
> >>       cxl/test: Add Get Feature support to cxl_test
> >>       cxl/test: Add Set Feature support to cxl_test
> >>
> >>  MAINTAINERS                  |   8 +
> >>  drivers/cxl/core/core.h      |   9 +-
> >>  drivers/cxl/core/mbox.c      | 607 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
> >>  drivers/cxl/core/memdev.c    |  78 +++++---
> >>  drivers/cxl/cxlmem.h         | 141 +++------------
> >>  drivers/cxl/pci.c            |  68 ++++---
> >>  drivers/cxl/pmem.c           |  10 +-
> >>  drivers/cxl/security.c       |  18 +-
> >>  drivers/fwctl/Kconfig        |   9 +
> >>  drivers/fwctl/Makefile       |   1 +
> >>  drivers/fwctl/cxl/Makefile   |   4 +
> >>  drivers/fwctl/cxl/cxl.c      | 274 ++++++++++++++++++++++++++++
> >>  include/linux/cxl/mailbox.h  | 175 ++++++++++++++++++
> >>  include/uapi/fwctl/cxl.h     |  92 ++++++++++
> >>  include/uapi/fwctl/fwctl.h   |   1 +
> >>  include/uapi/linux/cxl_mem.h |   3 +
> >>  tools/testing/cxl/test/mem.c | 292 +++++++++++++++++++++++++++++-
> >>  17 files changed, 1515 insertions(+), 275 deletions(-)  
> >   
> 
> 

