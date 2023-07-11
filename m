Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81061EB64DC
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Jul 2023 17:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGKR7l (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Jul 2023 13:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjGKR7l (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Jul 2023 13:59:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3837510D2
        for <linux-cxl@vger.kernel.org>; Tue, 11 Jul 2023 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689098380; x=1720634380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bRVTZaz2t4181flWqGOZRCbLyIGNkOJzBypJ9G1bTo8=;
  b=G0SeOp9NQlFa3Jb0Z61bZEi/PsdJ+lqP9rV+0wDxtigvKn/lRavaNz5B
   mq6rSuoTfVJ3fCbKn2Ap+5XnolSgh3Waz/wmO0WSNHC2UurCanVMzT1V3
   BLPnja7CbBW38VSfialn+qUFq7QG5YZb+bHjNyWPTHpPVsUDjaYCAXrj9
   pIz95lUz1524NSlPeOfKxP6OD7anR5B1DyZzoS8CFr8YpR1t+U6V3vkVS
   rgiJ+ss7toU6wIOBcRGx4ex/IXon0tXISxCmijmIEohIUjmbnKWQNNAkF
   L/SojcP9sZwBA2rcbqwPajjk01FIXLpJWXI47ouz2KfOpcNAgXO+1N7qt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="428406193"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="428406193"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:29:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="698503230"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="698503230"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.140.181])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:29:28 -0700
Date:   Tue, 11 Jul 2023 10:29:26 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Breno Leitao <leitao@debian.org>
Cc:     vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
        ave.jiang@intel.com
Subject: Re: [PATCH v2] cxl/acpi: Release device after dev_err()
Message-ID: <ZK2RdpFO3aEqyFY6@aschofie-mobl2>
References: <20230711161704.3033220-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711161704.3033220-1-leitao@debian.org>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jul 11, 2023 at 09:17:04AM -0700, Breno Leitao wrote:
> Kfence detected an user-after-free in the CXL driver. This happens in
> the cxl_decoder_add() fail path. Kfence drops this message:
> 
>   BUG: KFENCE: use-after-free read in resource_string
> 
> This is happening in cxl_parse_cfmws(), where put_device() is called,
> releasing cxld->dev, and then, later, dev_err(cxld->dev) is called
> referencing the released device.

Hi Breno,

How do you see the above happening? I don't see a dev_err(cxld->dev)
after the put. There is a dev_name(&cxld->dev), but it can never be
reached after the put, because we return before that line is reached.

Like I said in v1 - maybe the only problem here is that the resource
is not freed.

Alison



> 
> Just release the device after the message is printed/dev_err().  On top
> of that, cxl_parse_cfmws() must fail (returns rc) in case of
> cxl_decoder_add() or cxl_decoder_autoremove() failing (rc != 0), instead
> of swallowing the error and returning 0.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> v1 -> v2
>  * Return the error (rc) instead of swalling it
> 
> ---
>  drivers/cxl/acpi.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 658e6b84a769..efead5cc8a89 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -291,14 +291,16 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  	}
>  	rc = cxl_decoder_add(cxld, target_map);
>  err_xormap:
> -	if (rc)
> -		put_device(&cxld->dev);
> -	else
> -		rc = cxl_decoder_autoremove(dev, cxld);
>  	if (rc) {
>  		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
>  			cxld->hpa_range.start, cxld->hpa_range.end);
> -		return 0;
> +		put_device(&cxld->dev);
> +		return rc;
> +	}
> +	rc = cxl_decoder_autoremove(dev, cxld);
> +	if (rc) {
> +		dev_err(dev, "Failed to register autoremove action\n");
> +		return rc;
>  	}
>  	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
>  		dev_name(&cxld->dev),
> -- 
> 2.34.1
> 
