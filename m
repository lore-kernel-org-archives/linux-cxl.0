Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20086F06B
	for <linux-cxl@vger.kernel.org>; Thu, 21 Nov 2024 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732214312; cv=none; b=L3Vn71FuCsDE/KayHxUUvis0U2MNCCcqcjt7khGIgS32nu6F+xa5l7uxgCeT6eod9fo7qQJGcsTswmtXHQA6lTJcyfGYHHDAW0IMtf0dVJyDDb/z2rek7SygfTmUFsJ4nQg1L5OAhYPA50RV8/zyV1Fvw8gB1rME9XnZOKUcbBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732214312; c=relaxed/simple;
	bh=ek78oshRXKbSGRQ0fy5NMrDu+sQwOT0kyfGjOQrGeBE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZBm6GUBbZDyHZG97Jo20mShY4v3rkqHN/3EGe4VmkQlIv+6MnLeUC8HLPVoLheImbdn3OYhITUBOEez3loSK/8X/AkKOcOmNjnWjbHeVnLYQ4ei3RQ5UCSM58eVMnbXS4leyD3xuuHtXBRTr4XCwnDiAutzxOmq0CjxNRoLpuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvRjR5JqVz6K6Dw;
	Fri, 22 Nov 2024 02:34:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 107C61400F4;
	Fri, 22 Nov 2024 02:38:27 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 19:38:26 +0100
Date: Thu, 21 Nov 2024 18:38:25 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 0/20] fwctl/cxl: Add CXL feature commands support
 via fwctl
Message-ID: <20241121183825.00000f38@huawei.com>
In-Reply-To: <20241120185720.GG876522@nvidia.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241120185720.GG876522@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 20 Nov 2024 14:57:20 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Nov 15, 2024 at 02:25:33PM -0700, Dave Jiang wrote:
> > v2:
> > - Dropped 1/13 and 2/13 from previous version. Merged upstream already.
> > - Combined changes from Shiju for "get supported features"
> > - Addressed comments from Jonathan and Jason
> > - See specific changes in individual patch revision history
> > - Added hardware command info to FWCTL
> > - Added filtering to set feature command
> > - Added documentation  
> 
> I looked through it, and I think it is good enough that the next
> posting should not be RFC from my perspective..
> 
> The amount of CXL core patches has reduced quite a lot, it would be good to
> order the patches so CXL was grouped together at the start, that would
> make it easier to create a shared branch down the road
> 
> For instance very roughly something like:
> 
> >       cxl: Refactor user ioctl command path from mds to mailbox
> >       cxl: Add Get Supported Features command for kernel usage
> >       cxl/mbox: Add GET_FEATURE mailbox command
> >       cxl: Add Get Feature command support for user submission
> >       cxl/mbox: Add SET_FEATURE mailbox command

Some of these are common to the EDAC RAS features set which
I'm really hoping finally lands next cycle.

So we will need to be a little careful in how we merge things.

Going to need to be careful how we handle this.  Maybe Dave should
pick up the feature stuff as an immutable branch after rc1 and
both series get rebuilt on top of that.  Need to discuss if
Borislav is happy with that for potential merge of the RAS
features series (EDAC).

Anyhow, time up for me today. I'll look at the rest of the series
tomorrow.

Jonathan

> >       cxl: Add Set Feature command support for user submission
> >       cxl: Move cxl_driver related bits to be usable by external drivers
> >       cxl: Save Command Effects Log (CEL) effects for enabled commands
> >       cxl: Move defines and error codes from cxlmem.h to cxl/mailbox.h
> >       cxl/test: Add Get Supported Features mailbox command support
> >       cxl/test: Add Get Feature support to cxl_test
> >       cxl/test: Add Set Feature support to cxl_test  
> 
> >       fwctl: FWCTL_HW_INFO to return hardware information
> >       fwctl/cxl: Add driver for CXL mailbox for handling CXL features commands
> >       fwctl/cxl: Add support for get driver information
> >       fwctl/cxl: Add hw_info callback
> >       fwctl/cxl: Add support for fwctl RPC command to enable CXL feature commands
> >       fwctl/cxl: Add support to filter exclusive features
> >       fwctl/cxl: Add documentation to FWCTL CXL  
> 
> Thanks,
> Jason

