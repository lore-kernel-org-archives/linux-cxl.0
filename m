Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A0FC001DF
	for <linux-cxl@archiver.kernel.org>; Thu,  3 Aug 2023 17:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbjHCR1N (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Aug 2023 13:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbjHCR1H (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Aug 2023 13:27:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88F23A99;
        Thu,  3 Aug 2023 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691083626; x=1722619626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rp7B3I/GBMKQs5p7TDEdoIsKR+4FXBctgetPo1nQNeo=;
  b=h5sFZzIQs4VKn6n0NGhXoUEiyX3on6aIz15ClC7D8DL0oVuc1TKxnCmw
   W/t+soRJkQxMINSYuFdmt5fJwSJgU/ZqwddTOU9KAggkDwU8tiGex0Ayz
   Sl2RAof3bRqiUNiXh2f3we4UzokSehS6zV2JdQQTJ+ln1pB6YEp55fybh
   tHznkELUybKMwSdimVdwc21ol7w+2l7TKk2K1OE7tLN5KhvjnyH2GPIz6
   C01j18cMjmL9H5bWq5oTlbHYNToVBGoXkuRkd+lZzY+7YXfnXRpmBinan
   zXWenn18LymB7unF19ZHMIKXk2L5fgwxLgbuZERwN8F29Hh0jPz5aFbfU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="368846179"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="368846179"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 10:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="732880747"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="732880747"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.86.212])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 10:26:49 -0700
Date:   Thu, 3 Aug 2023 10:26:48 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cxl/mbox: Add handle to event processing debug
Message-ID: <ZMvjWChU7htT7wD8@aschofie-mobl2>
References: <20230731-cxl-fix-clear-event-debug-print-v2-0-9bdd08d386e9@intel.com>
 <20230731-cxl-fix-clear-event-debug-print-v2-2-9bdd08d386e9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731-cxl-fix-clear-event-debug-print-v2-2-9bdd08d386e9@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Aug 01, 2023 at 01:13:29PM -0700, Ira Weiny wrote:
> Knowing which handle is being processed helped in debugging new event
> code.  Add a dev_dbg() message with this information.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> ---
>  drivers/cxl/core/mbox.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index a1c490f66bbf..f052d5f174ee 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -947,9 +947,13 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  		if (!nr_rec)
>  			break;
>  
> -		for (i = 0; i < nr_rec; i++)
> +		for (i = 0; i < nr_rec; i++) {
> +			dev_dbg(dev, "Event log %d: processing handle %u\n",
> +				type,
> +				le16_to_cpu(payload->records[i].hdr.handle));
>  			cxl_event_trace_record(cxlmd, type,
>  					       &payload->records[i]);
> +		}
>  
>  		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
>  			trace_cxl_overflow(cxlmd, type, payload);
> 
> -- 
> 2.41.0
> 
