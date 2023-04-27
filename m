Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D839C77B73
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Apr 2023 19:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244039AbjD0TDF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Apr 2023 15:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244527AbjD0TDD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Apr 2023 15:03:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DD571FEC
        for <linux-cxl@vger.kernel.org>; Thu, 27 Apr 2023 12:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682622178; x=1714158178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iVWs8unfRTAmo/6XeGXBgTGRakcn+9aqcGIhb+2NUYI=;
  b=FZdHEPcSbXGEqNFisJp4WAgLl2C8u2/2yl5hbEcSrVKD1KvvxD8xNGiD
   VyxVNAgesJgvQvw+CnvYQ53Ibc9kjprU1oj7249Zfztsjkcbm8PPRAWZ3
   nWeWZ+abCbP8lhSzEdjoMhK/6j2q+HTYsndSocFhGkOPYgU0UjMFjbAPV
   ook1PMSWToufOD9tFEjsWc5RmwkYGlr0tR++/mp8jfjjCT0J150nRWEIa
   Ez0KfxgQoJrYQ0z/0uDonLo1wV3UrRtzZGV7sL0b37v0Ac/fti959us4x
   IsaN67tv/JC3S0ic1/UFCcH/XCMvhkGBhs5a8yQIDk0KGWTk9FUooIH7G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="350429831"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="350429831"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP; 27 Apr 2023 12:02:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="783890681"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="783890681"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.57.248])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:02:23 -0700
Date:   Thu, 27 Apr 2023 12:02:21 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com
Subject: Re: [RESEND PATCH v2] cxl: Warn of flexible array in struct
 cxl_root_decoder
Message-ID: <ZErGvfsHRFkdO4pT@aschofie-mobl2>
References: <168261044311.369593.10950998135160952191.stgit@djiang5-mobl3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168261044311.369593.10950998135160952191.stgit@djiang5-mobl3>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Apr 27, 2023 at 08:47:23AM -0700, Dave Jiang wrote:
> The 'cxl_switch_decoder' member in 'cxl_root_decoder' must be the last
> element due to 'cxl_switch_decoder' has a flexible array at the
> end of the struct. Any variables placed after will be corrupted.
> Add a warning comment to 'cxl_root_decoder'.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v2:
> - Clarify subject (Alison)
> - Fit comment under 80 chars. (Alison)

Thanks Dave,

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> ---
>  drivers/cxl/cxl.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 044a92d9813e..7db7e217b6f3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -419,6 +419,7 @@ struct cxl_root_decoder {
>  	cxl_calc_hb_fn calc_hb;
>  	void *platform_data;
>  	struct mutex range_lock;
> +	/* Must be the last member. Struct contains a flexible array */
>  	struct cxl_switch_decoder cxlsd;
>  };
>  
> 
> 
