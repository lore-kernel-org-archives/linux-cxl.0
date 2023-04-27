Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1106FC77B73
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Apr 2023 04:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjD0EGr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Apr 2023 00:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjD0EGq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Apr 2023 00:06:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E934B2101
        for <linux-cxl@vger.kernel.org>; Wed, 26 Apr 2023 21:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682568405; x=1714104405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EABF0ITUVeZD7Z16MRr0Nw+ZyaRLTcbx2wEPS1pjlAo=;
  b=VCqlWpSLOJG7unxTqZTHMi/tDNrq5PALL+VFY7+sIMBSuDZ/ZkU2IQch
   3WukvORPKr2zrjUZPCBBXT8L96xpI65ed2/9K5tZGVk4z1IOp0Wi5QLFc
   Lza0t0L62pqvNI7DHNpFt8+MlJ/MqUi9QlOl6bYnnujtOb7mcxHsV4PGa
   8lQP1vN0ONP+vwTxpxeSnOIhxytGQUcxSuWJPtmJ/PDru8I3cbZyJhB04
   9sZcHe1p9LmZRwjzWVJ6VevuD9/DWq4cXjdNSBy+k88GS0IdoeWBzNWEM
   ARWNC4Wlj9MhI7mlszpB/mzN50rQi705Sk1vTgJU6gTYs6vK9HdSHpL4O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="412646669"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="412646669"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 21:03:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="805788611"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="805788611"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.211.65])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 21:03:31 -0700
Date:   Wed, 26 Apr 2023 21:03:30 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com
Subject: Re: [PATCH] cxl: Add warning comment to cxl_root_decoder
Message-ID: <ZEn0EmlHN5u016os@aschofie-mobl2>
References: <168255005846.53394.2779436232786699829.stgit@djiang5-mobl3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168255005846.53394.2779436232786699829.stgit@djiang5-mobl3>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Apr 26, 2023 at 04:00:58PM -0700, Dave Jiang wrote:

Perhaps more content in the commit message, like:
cxl: Warn of flexible array in struct cxl_root_decoder

> The 'cxl_switch_decoder' member in 'cxl_root_decoder' must be the last
> element due to 'cxl_switch_decoder' has a flexible array at the
> end of the struct. Any variables placed after will be corrupted.
> Add a warning comment to 'cxl_root_decoder'.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/cxl.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 044a92d9813e..999c0aa5ed54 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -419,6 +419,7 @@ struct cxl_root_decoder {
>  	cxl_calc_hb_fn calc_hb;
>  	void *platform_data;
>  	struct mutex range_lock;
> +	/* This must be the last member of the struct. It contains a flexible array */

Can this comment fit within 80 chars?

>  	struct cxl_switch_decoder cxlsd;
>  };
>  
> 
> 
