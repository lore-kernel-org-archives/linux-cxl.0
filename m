Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4CDC433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Apr 2022 16:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344494AbiDLQqO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Apr 2022 12:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357871AbiDLQqN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Apr 2022 12:46:13 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C469149C99
        for <linux-cxl@vger.kernel.org>; Tue, 12 Apr 2022 09:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649781834; x=1681317834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Io+HPEjnkS6Ss76Bh5HovlmHLuF6oPZQtLacfOX2QpE=;
  b=VzK72sHTIxQSUWZlAfeXm+f+8kDGpbvIAqlxPS3Z1duKO211NzorRna4
   JgtEmsE+UhX63BUZ/zBHf+MHoW8E939c4RmdLuJAaW7v0xw08hN3uk7BZ
   jGezzX4tw6PPOwzSjGVV/PFXUeSXzk3IFS3/jxaWKgL3kvTUymVdoGfzm
   rYwN4ahxPZaneoXU8zmkkWhh3zrfO/wT6SJguNpzavCIthk0eCp68SRa2
   poGptXRp1XSp7ctc5NVHIzVKQBbhLPGo84INSWFTlnjt82sJuKpfrG5rA
   HO+g3eEMZLapB6hApO4l/0OIBG1C0X1q/xN/zWwRzE7DdLW//oDzcpS99
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="249719422"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="249719422"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 09:39:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="559403548"
Received: from aalaniz-mobl.amr.corp.intel.com (HELO localhost) ([10.209.160.104])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 09:39:57 -0700
Date:   Tue, 12 Apr 2022 09:39:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     alison.schofield@intel.com
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] cxl/mbox: Replace NULL check with IS_ERR() after
 vmemdup_user()
Message-ID: <YlWrXV93VqBdHPxp@iweiny-desk3>
References: <20220407010915.1211258-1-alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407010915.1211258-1-alison.schofield@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Apr 06, 2022 at 06:09:15PM -0700, Alison Schofield wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> vmemdup_user() returns an ERR_PTR() on failure. Use IS_ERR()
> to check the return value.
> 
> Fixes: be0d0ce77aa3 ("cxl/mbox: Move build of user mailbox cmd to a helper funct
> ions")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/cxl/core/mbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 8a8388599a85..2449878d4b4b 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -263,7 +263,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
>  	if (in_size) {
>  		mbox->payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
>  						in_size);
> -		if (!mbox->payload_in)
> +		if (IS_ERR(mbox->payload_in))
>  			return PTR_ERR(mbox->payload_in);
>  
>  		if (!cxl_payload_from_user_allowed(opcode, mbox->payload_in)) {
> 
> base-commit: 7dc1d11d7abae52aada5340fb98885f0ddbb7c37
> -- 
> 2.31.1
> 
