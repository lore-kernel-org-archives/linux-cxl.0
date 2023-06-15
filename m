Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5F0EB64D8
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 00:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjFOA43 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 20:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFOA43 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 20:56:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2368226A4
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 17:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686790588; x=1718326588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bap6avZqho41zqwH6rbl+nOHNpE6PT+Z5OWZb5M+n30=;
  b=NgTXkmLp/1aeADPVHH98zx4wkgQFb6hzgeeyqbeXYCmqoV2MuGy3x9RG
   r6ll1/TVrEk4FUjdw5QDKrzXbqDMRlu5ZJnHr0KzJwlhU27FqZ0+Kiz+s
   jYLv7QjQq8Qv+6oKyRnj80hikvlYRz8a/A/Yrum7TuSjhO9exo2FJkPZY
   /3kq51Ijx9dgQtRaTacn5HQe9R/nsnJerGZrsNdS4LY21lQVAPO54ekd8
   ijqcnb/VqBJUQXShxGvYRFmH0X5Sm46Z4kaByrZfycLbwJxDoVwffbY3+
   /cd8rmzGJWCHKmJq5YCXWW6JPJinez5Foxhvzqan4klxALlcEROdLQjoA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="356269161"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="356269161"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 17:56:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="802142008"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="802142008"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.193.191])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 17:56:27 -0700
Date:   Wed, 14 Jun 2023 17:56:25 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     ira.weiny@intel.com
Cc:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 0/5] cxl/dcd: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <ZIphuWVHQ8rrO28L@aschofie-mobl2>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jun 14, 2023 at 12:16:27PM -0700, Ira Weiny wrote:

Is there a repo you can share?
If not, how about a recipe for applying these to cxl/next?
(Not trying to run, just want to load and view)

Thanks!

> I'm submitting these on behalf of Navneet.  There was a round of
> internal discussion which left a few questions but we want to get the
> public discussion going.  A first public preview was posted by Dan.[1]
> 
> The series has been rebased on the type-2 work posted from Dan.[2]  As
> discussed in the community call, not all of that series is required for
> these patches.  This will get rebased on the subset of those patches he
> is targeting for 6.5.  The series was tested using Fan Ni's Qemu DCD
> series.[3]
> 
> [cover letter]
> 
> A Dynamic Capacity Device (DCD) (CXL 3.0 spec 9.13.3) is a CXL memory
> device that implements dynamic capacity.  Dynamic capacity feature
> allows memory capacity to change dynamically, without the need for
> resetting the device.
> 
> Provide initial patches to enable DCD on non interleaving regions.
> Details:
> 
> - Get the dynamic capacity region information from cxl device and add
>   the advertised DC memory to driver managed resources
> - Get the device dynamic capacity extent list from the device and
>   maintain it in the host and add the preallocated memory to the host
> - Dynamic capacity region support
> - DCD region provisioning via Dax
> - Dynamic capacity event records
>         a. Add capacity Events
> 	b. Release capacity events
> 	c. Add the memory to the host dc region
> 	d. Release the memory from the host dc region
> - Trace Dynamic Capacity events
> - Send add capacity response to device
> - Send release dynamic capacity to device
> 
> Cc: Navneet Singh <navneet.singh@intel.com>
> Cc: Fan Ni <fan.ni@samsung.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-cxl@vger.kernel.org
> 
> [1] https://lore.kernel.org/all/64326437c1496_934b2949f@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> [2] https://lore.kernel.org/all/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/
> [3] https://lore.kernel.org/all/6483946e8152f_f1132294a2@iweiny-mobl.notmuch/
> 
> ---
> Navneet Singh (5):
>       cxl/mem : Read Dynamic capacity configuration from the device
>       cxl/region: Add dynamic capacity cxl region support.
>       cxl/mem : Expose dynamic capacity configuration to userspace
>       cxl/mem: Add support to handle DCD add and release capacity events.
>       cxl/mem: Trace Dynamic capacity Event Record
> 
>  drivers/cxl/Kconfig       |  11 +
>  drivers/cxl/core/core.h   |   7 +
>  drivers/cxl/core/hdm.c    | 234 ++++++++++++++++++--
>  drivers/cxl/core/mbox.c   | 540 +++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/core/memdev.c |  72 +++++++
>  drivers/cxl/core/port.c   |  18 ++
>  drivers/cxl/core/region.c | 337 ++++++++++++++++++++++++++++-
>  drivers/cxl/core/trace.h  |  68 +++++-
>  drivers/cxl/cxl.h         |  32 ++-
>  drivers/cxl/cxlmem.h      | 146 ++++++++++++-
>  drivers/cxl/pci.c         |  14 +-
>  drivers/dax/bus.c         |  11 +-
>  drivers/dax/bus.h         |   5 +-
>  drivers/dax/cxl.c         |   4 +
>  14 files changed, 1453 insertions(+), 46 deletions(-)
> ---
> base-commit: 034a16d0165be3e092d60685be7b1b05e6f3059b
> change-id: 20230604-dcd-type2-upstream-0cd15f6216fd
> 
> Best regards,
> -- 
> Ira Weiny <ira.weiny@intel.com>
> 
