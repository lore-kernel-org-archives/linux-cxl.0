Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71562C678D4
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Mar 2023 01:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjCBBQA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 20:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCBBQA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 20:16:00 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330684347D
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 17:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677719759; x=1709255759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2mML6RsAC6bvhaoPqiC+gUeN4bvwDP8JV8z6JOb9TL0=;
  b=i5FYqy3Fr498qLQTbeadeYRitIVqkbCSvMhLUiQlhGUYqofVH8jPNX1S
   z7qTvKLLg9Mks2KkXFaeDFSIs60siTs15SkHk/hj0wiMYhpHSKh+P7dyQ
   FT0HZHZA1tlPYNYkj49SBcsc5TnP17izAXaj0q/1+xLdxt9cnvYeFtH/o
   LtolsLX5DWyDfXuv+oSw38G+6lMnt53Fj6a7pfNNoGtXmAGUm2Yj4TnlV
   hjB3qiaQgQHZMiUHJWG2oOeajLjdFUsDNxMagnLEu9JF+S0eOsiwoFaVa
   j7Xb2ZoMcPhIkcjvtGAyG5sdsHDNqJ/suRJV5xiYF2zE7N+I5wNZ0Vq+2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="318381015"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="318381015"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 17:15:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="798632692"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="798632692"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.252.139.73])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 17:15:58 -0800
Date:   Wed, 1 Mar 2023 17:15:56 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2 0/6] hw/cxl: Poison get, inject, clear
Message-ID: <Y//4zFIjBCN/Qlkz@aschofie-mobl2>
References: <20230227170311.20054-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227170311.20054-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Feb 27, 2023 at 05:03:05PM +0000, Jonathan Cameron wrote:

Hi Jonathan,
Can you share your repo with this support?  How about your qemu cmdline?
I'm more of a 'try it out' type of a reviewer for qemu changes.
Thanks,
Alison

> v2: Thanks to Ira for review and also to Philippe as some of the
>     changes follow through from comments on precusor series.
> 
> - Fixed a bunch of endian issues. Note that QEMU CXL suppport only currently
>   supports platforms that happen to be little endian so these are more
>   theoretical than bugs that can be triggered.
> - Improve handling over mailbox inject poison that overlaps with
>   qmp injected (which can be bigger).
> - Tighter checks on alignment.
> - Add 'Since' entries to qapi docs.
> - Drop the CXLRetCode move out of this series as it isn't needed for this.
>   Will appear in next series I post instead (Ira's event series)
> - Drag down the st24_le_p() patch from Ira's Event series so we can use
>   it in this series.
> 
> Note Alison has stated the kernel series will be post 6.3 material
> so this one isn't quite as urgent as the patches it is based on.
> However I think this series in a good state (plus I have lots more queued
> behind it) hence promoting it from RFC.
> 
> Changes since RFC v2: Thanks to Markus for review.
>  - Improve documentation for QMP interface
>  - Add better description of baseline series
>  - Include precursor refactors around ret_code / CXLRetCode as this is now
>    the first series in suggeste merge order to rely on those.
>  - Include Ira's cxl_device_get_timestamp() function as it was better than
>    the equivalent in the RFC.
> 
> Based on following series (in order)
> 1. [PATCH v4 00/10] hw/cxl: CXL emulation cleanups and minor fixes for upstream
> 2. [PATCH v6 0/8] hw/cxl: RAS error emulation and injection
> 3. [PATCH v2 0/2] hw/cxl: Passthrough HDM decoder emulation
> 4. [PATCH v4 0/2] hw/mem: CXL Type-3 Volatile Memory Support
> 
> Based on: Message-Id: 20230206172816.8201-1-Jonathan.Cameron@huawei.com
> Based-on: Message-id: 20230227112751.6101-1-Jonathan.Cameron@huawei.com
> Based-on: Message-id: 20230227153128.8164-1-Jonathan.Cameron@huawei.com
> Based-on: Message-id: 20230227163157.6621-1-Jonathan.Cameron@huawei.com
> 
> The series supports:
> 1) Injection of variable length poison regions via QMP (to fake real
>    memory corruption and ensure we deal with odd overflow corner cases
>    such as clearing the middle of a large region making the list overflow
>    as we go from one long entry to two smaller entries.
> 2) Read of poison list via the CXL mailbox.
> 3) Injection via the poison injection mailbox command (limited to 64 byte
>    entries)
> 4) Clearing of poison injected via either method.
> 
> The implementation is meant to be a valid combination of impdef choices
> based on what the spec allowed. There are a number of places where it could
> be made more sophisticated that we might consider in future:
> * Fusing adjacent poison entries if the types match.
> * Separate injection list and main poison list, to test out limits on
>   injected poison list being smaller than the main list.
> * Poison list overflow event (needs event log support in general)
> * Connecting up to the poison list error record generation (rather complex
>   and not needed for currently kernel handling testing).
> 
> As the kernel code is currently fairly simple, it is likely that the above
> does not yet matter but who knows what will turn up in future!
> 
> Kernel patches:
>  [PATCH v7 0/6] CXL Poison List Retrieval & Tracing
>  cover.1676685180.git.alison.schofield@intel.com
>  [PATCH v2 0/6] cxl: CXL Inject & Clear Poison
>  cover.1674101475.git.alison.schofield@intel.com
> 
> 
> Ira Weiny (2):
>   hw/cxl: Introduce cxl_device_get_timestamp() utility function
>   bswap: Add the ability to store to an unaligned 24 bit field
> 
> Jonathan Cameron (4):
>   hw/cxl: rename mailbox return code type from ret_code to CXLRetCode
>   hw/cxl: QMP based poison injection support
>   hw/cxl: Add poison injection via the mailbox.
>   hw/cxl: Add clear poison mailbox command support.
> 
>  hw/cxl/cxl-device-utils.c   |  15 ++
>  hw/cxl/cxl-mailbox-utils.c  | 285 ++++++++++++++++++++++++++++++------
>  hw/mem/cxl_type3.c          |  92 ++++++++++++
>  hw/mem/cxl_type3_stubs.c    |   6 +
>  include/hw/cxl/cxl_device.h |  23 +++
>  include/qemu/bswap.h        |  23 +++
>  qapi/cxl.json               |  18 +++
>  7 files changed, 420 insertions(+), 42 deletions(-)
> 
> -- 
> 2.37.2
> 
