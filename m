Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF324C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Apr 2022 02:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiD2Ciy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 28 Apr 2022 22:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiD2Cix (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 28 Apr 2022 22:38:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2AF92300;
        Thu, 28 Apr 2022 19:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651199737; x=1682735737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1DwS14zK6EF7Z7Fv6nPmoDw8UlO1T/LglioeEangCIY=;
  b=X9Kqph1FdbM0KUHb0MDkezPAwhb3Fr4KMCiVaf/aVNvDjXQ3P1PPwVvj
   h+z+GdqlVz23CNJO1KII79KmyXBWOOweJXkkwxt0cYQtR96EiQAbqYZRC
   cKfUM304hosE+BW1xaWQOEmhtTeG4koPFz085/B0I8ay7n0JT17thHy5X
   2HWtYjwUbTp6kkAUP2NF1kj30flo2NHWt/OMIZ6P0XwHio/hUV68tfdv2
   5kAQDYrJFFJjqloeWCVwfPAS1TwKhI7lev+KyXKcJmhLJh8hniHK9RgCg
   sT5M6i90R6nsEQBOHFcMtdTZlchIMlo0XOGuQyW91OfALEKEZxYH8AmOU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="329446752"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="329446752"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 19:35:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="534248286"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 19:35:36 -0700
Date:   Thu, 28 Apr 2022 19:37:00 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] cxl/mbox: fix logical vs bitwise typo
Message-ID: <20220429023700.GA1320788@alison-desk>
References: <YmpgkbbQ1Yxu36uO@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmpgkbbQ1Yxu36uO@kili>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Apr 28, 2022 at 02:38:25AM -0700, Dan Carpenter wrote:
> This should be bitwise & instead of &&.

Thanks Dan. How'd you find this?

> 
> Fixes: 6179045ccc0c ("cxl/mbox: Block immediate mode in SET_PARTITION_INFO command")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/cxl/core/mbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 731cb43b570e..54f434733b56 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -243,7 +243,7 @@ static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in)
>  	case CXL_MBOX_OP_SET_PARTITION_INFO: {
>  		struct cxl_mbox_set_partition_info *pi = payload_in;
>  
> -		if (pi->flags && CXL_SET_PARTITION_IMMEDIATE_FLAG)
> +		if (pi->flags & CXL_SET_PARTITION_IMMEDIATE_FLAG)
>  			return false;
>  		break;
>  	}
> -- 
> 2.35.1
> 
