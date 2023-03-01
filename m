Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E94EC678D4
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Mar 2023 22:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCAWRb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 17:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCAWRa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 17:17:30 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8001521FA
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 14:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677709034; x=1709245034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XfNA/4z6+t5E/p0Yk3iSqZpGucyFe5Alb2KtbeinTxY=;
  b=DWUH1BYOSXK9lyozz8AM5QlLA3GTEXi6untCGn9qYL5DJpjnWchZA+em
   Pc662gQVyx8fE3d5M1yf3KMwoxDStaCWlIE47nTULGLSgyy99iXgg2oag
   nVerv9NbCKzdTGFwsIx0cWyW0a+kHzGC6m8Bm8oYI6wBVSAIwvA14SZIv
   SrUq6C7VC1zCkOOlVTTN7RuUL4arlINwv7zpAUp7lXmOspkl0qTltrIoH
   VHNjyMV941MsqAUJBqooGJ5PdSNY45UxLPTB46azU+uaaMeiF6ojEf4nE
   wR0I2w0ZAj9IXK8XGYJibOy+1lBELV9RUwxiyYrL1nhF2/rLVxUN8knsM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="318337630"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="318337630"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 14:16:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="817728297"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="817728297"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.70.38])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 14:16:41 -0800
Date:   Wed, 1 Mar 2023 14:16:39 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 6/8] tools/testing/cxl: Add a sysfs attr to test
 poison injection limits
Message-ID: <Y//Ox4bpD0oPBlv5@aschofie-mobl2>
References: <cover.1677704994.git.alison.schofield@intel.com>
 <976a71944b9403d057bc1d4607210daa89ac1568.1677704994.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <976a71944b9403d057bc1d4607210daa89ac1568.1677704994.git.alison.schofield@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 01, 2023 at 01:36:31PM -0800, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices may report a maximum number of addresses that a device
> allows to be poisoned using poison injection. When cxl_test creates
> mock CXL memory devices, it defaults to MOCK_INJECT_DEV_MAX==88 for
 
oops...MOCK_INJECT_DEV_MAX==8  (not 88)

> all mocked memdevs.
> 
> Add a sysfs attribute, poison_inject_max to module cxl_mock_mem so
> that users can set a custom device injection limit. Fail, and return
> -EBUSY, if the mock poison list is not empty.
> 
> /sys/bus/platform/drivers/cxl_mock_mem/poison_inject_max
> 
> A simple usage model is to set the attribute before running a test in
> order to emulate a device's poison handling.
> 
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  tools/testing/cxl/test/mem.c | 52 +++++++++++++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 9658d95236b7..5c3b3e5a3b4b 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -19,6 +19,8 @@
>  #define MOCK_INJECT_DEV_MAX 8
>  #define MOCK_INJECT_TEST_MAX 128
>  
snip

