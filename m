Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD95A3EA76
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651807; cv=none; b=T/vGmEsCJMbmROXVQDgUgTHr0JVxS8N3pSNyke57xyyX4/8b1olBsboRMDC6usTm/VZz23bkJMCoABlOAGR5cCP+y1PDndmS76R7xX9gKt2QoFHsslcPD6Co62JZrry04Gj8x7pV+CtR9aq4g99rhTNsD3h53JKZqYfzjb/SGoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651807; c=relaxed/simple;
	bh=ztN/zT0af6jBYa8ujiE9lZ7gHhWSOi/m7ewYrflsZb0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlyTGsgMLSbtFKV15NpSJp9laRaALqaHHWLl81EQtVXq9pDiO2C5784D3WBBVQEzQJVWUZepxeCYrooR1SG8e3n6Dk2+BPWgToQ8xsWm1f07YiOih1ddgbgoWjW+dsPpX185iKnEfHQibxJKnRTfYszUDDfpgmU5Ramcz6y62SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf6fY4NK8z67Kdt;
	Fri, 24 Jan 2025 01:01:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0383D140736;
	Fri, 24 Jan 2025 01:03:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 18:03:21 +0100
Date: Thu, 23 Jan 2025 17:03:20 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 0/19] cxl: Add CXL feature commands support via fwctl
Message-ID: <20250123170320.0000709f@huawei.com>
In-Reply-To: <20250122235159.2716036-1-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 22 Jan 2025 16:50:31 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> v1:
> - Create a CXL features driver to handle all feature command related bits
>   including FWCTL support. (Dan)
> - Tested against CXL CLI unit tests for FWCTL.
> - See individual patches for detailed changes from RFC v2.
> 
> RFC v2:
> - Dropped 1/13 and 2/13 from previous version. Merged upstream already.
> - Combined changes from Shiju for "get supported features"
> - Addressed comments from Jonathan and Jason
> - See specific changes in individual patch revision history
> - Added hardware command info to FWCTL
> - Added filtering to set feature command
> - Added documentation
> 
> This series add support for CXL feature commands using the FWCTL framework [1].
> The code has been tested with CXL CLI unit tests for FWCTL.
> 
> Patches 1-7 are shared with EDAC series [1] and there will be an immuable branch
> once accepted post review.

Looks like immutable should be maybe 3-8?  Perhaps reorder for next version
as odd to have middle of series in an immutable branch.

> 
> A CXL features driver is created to handle all CXL mailbox feature commands related
> functionalities as suggested by Dan. The 3 mailbox commands "Get Supported Features",
> "Get Feature", and "Set Feature" are implemented. The "get" commands under the
> FWCTL_RPC_CONFIGURATION policy, the "set" command checks the policy depending
> on the effect of the feature. All mailbox commands for CXL provides an effects
> table that describes the effects of a command when performed on the device.
> For CXL features, there is also an effects field that describes the effects
> a feature write operation has on the device per feature. The security policy
> is checked against this feature specific effects field. Looking for discussion
> on matching the CXL spec defined effects with the FWCTL security policy.
> 
> The code is based off of v3 of FWCTL series [2] posted by Jason and rebased on top of
> v6.13-rc5.
> 
> [1]: https://lore.kernel.org/linux-cxl/20250106121017.1620-1-shiju.jose@huawei.com/T/#t
> [2]: https://lore.kernel.org/linux-cxl/0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com/#r
> ---
> 
> Dave Jiang (17):
>       cxl: Refactor user ioctl command path from mds to mailbox
>       cxl: Add skeletal features driver
>       cxl: Enumerate feature commands
>       cxl: Add Get Supported Features command for kernel usage
>       cxl: Add features driver attribute to emit number of features supported
>       cxl/test: Add Get Supported Features mailbox command support
>       cxl: Setup exclusive CXL features that are reserved for the kernel
>       cxl: Add FWCTL support to the CXL features driver
>       cxl: Add support for get driver information
>       cxl: Move cxl_mem.h under uapi to cxl exclusive directory
>       cxl: Move cxl feature command structs to user header
>       cxl: Add support for fwctl RPC command to enable CXL feature commands
>       cxl: Add support to handle user feature commands for get feature
>       cxl: Add support to handle user feature commands for set feature
>       cxl/test: Add Get Feature support to cxl_test
>       cxl/test: Add Set Feature support to cxl_test
>       fwctl/cxl: Add documentation to FWCTL CXL
> 
> Shiju Jose (2):
>       cxl/mbox: Add GET_FEATURE mailbox command
>       cxl/mbox: Add SET_FEATURE mailbox command
> 
>  Documentation/userspace-api/fwctl/fwctl-cxl.rst |  81 +++++++
>  Documentation/userspace-api/fwctl/index.rst     |   1 +
>  drivers/cxl/Kconfig                             |   9 +
>  drivers/cxl/Makefile                            |   3 +
>  drivers/cxl/core/Makefile                       |   1 +
>  drivers/cxl/core/core.h                         |   7 +-
>  drivers/cxl/core/features.c                     | 287 +++++++++++++++++++++++
>  drivers/cxl/core/mbox.c                         | 143 ++++++++----
>  drivers/cxl/core/memdev.c                       |  22 +-
>  drivers/cxl/core/port.c                         |   3 +
>  drivers/cxl/cxl.h                               |   3 +
>  drivers/cxl/cxlmem.h                            |  45 +---
>  drivers/cxl/features.c                          | 558 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/pci.c                               |  19 ++
>  include/cxl/features.h                          |  75 ++++++
>  include/cxl/mailbox.h                           |  46 +++-
>  include/uapi/cxl/features.h                     | 135 +++++++++++
>  include/uapi/{linux/cxl_mem.h => cxl/mem.h}     |   0
>  include/uapi/fwctl/cxl.h                        |  60 +++++
>  include/uapi/fwctl/fwctl.h                      |   1 +
>  tools/testing/cxl/Kbuild                        |   1 +
>  tools/testing/cxl/test/mem.c                    | 194 +++++++++++++++
>  22 files changed, 1597 insertions(+), 97 deletions(-)

