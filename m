Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178FAC41513
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Aug 2023 13:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344347AbjHQNGH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Aug 2023 09:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351464AbjHQNGG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Aug 2023 09:06:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E5735BB
        for <linux-cxl@vger.kernel.org>; Thu, 17 Aug 2023 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692277547; x=1723813547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r56D5NgrKovLZTY9o8hoNLzAMaXTLX/s75HwOf5dUF0=;
  b=mQGm4pT/AVa9LCJyJES1Q8gTHYD3hVPtSAMYZoXP6P+NQ9F49tDeFCZM
   zsc4nl+7ZFFjr1Ov+cUGao8H+SKaKZGnCuXn/7gS1MhzTEPoW6VLeAjzZ
   AGoezF8buWnegY27ozCHEK+7Vb/+bsqSiEKRUg2X3TvOYyny4zKAulNgN
   LQpafSkVG1OVmpV3rceE5a2l8CDSAaiO11irKprS3jJ3U0xP5nhQk+3c2
   ehvH3PdBmu7B48auC1ZfCeQumYWNINO5t6ONtd5ozA8kEL2q4wMkmvKeh
   WG5quX4UJDv32Qo1VKu6s6E2RpQ8yPjfTHLpoojlRMiM74z8ozhmyytkV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371709066"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="371709066"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 06:04:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="734656916"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="734656916"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 17 Aug 2023 06:04:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWcfy-00CazN-0u;
        Thu, 17 Aug 2023 16:04:34 +0300
Date:   Thu, 17 Aug 2023 16:04:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     alison.schofield@intel.com
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/mbox: Remove useless cast in
 cxl_mem_create_range_info()
Message-ID: <ZN4a4hJpI33IIAwA@smile.fi.intel.com>
References: <20230815172052.22514-1-alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815172052.22514-1-alison.schofield@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Aug 15, 2023 at 10:20:52AM -0700, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> DEFINE_RES_MEM() is a wrapper around the DEFINE_RES_NAMED() macro
> which already has the (struct resource) for the compound literal.
> The user of the macro should not repeat the cast.

s/repeat/use/


> Cleans up these sparse warnings:
> drivers/cxl/core/mbox.c:1184:18: warning: cast to non-scalar
> drivers/cxl/core/mbox.c:1184:18: warning: cast from non-scalar

With the above fixed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko


