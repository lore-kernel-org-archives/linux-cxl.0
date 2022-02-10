Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16681C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Feb 2022 01:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiBJBV7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Feb 2022 20:21:59 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiBJBVx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Feb 2022 20:21:53 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E4E764B
        for <linux-cxl@vger.kernel.org>; Wed,  9 Feb 2022 17:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644456115; x=1675992115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k4XmFxYwiQf90YO5F9uSngj6XxlhUgVcFHJaBkORY+8=;
  b=EM2E1pSjwAlTm23Rc9kJIhipV7plmXTjWuQ4EbcZ/7NUc1d/CXn4EKR2
   ObGnrmbcRM7Pn6EeVOP3c2XiaYL7TOAamyg/vfbHit/B36gxTlPEaPRQ5
   2nAg0iYnS4tXnI9FwnakcMV17O1fM6O3xY/pTM3WOFsIfX0HTjZjgn80J
   C0qUudlxz5QKo6W2BgZwtTpEZVffD+QT0mjQAGEpHBTULPdSNGW4aah/f
   blumHJ9/j9wbrywlPGsmOorLJm6tub8ovshefrm7mUgPFdraEGpmXqHGL
   zbApz0wZ0n4pQH8lW+k2kDVcwZtBqVeBiWnTpZA3q7LfNkLOhGZdTFs4X
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="310119597"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="310119597"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 17:06:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="482555871"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 17:06:42 -0800
Date:   Wed, 9 Feb 2022 17:10:46 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, vishal.l.verma@intel.com
Subject: Re: [ndctl PATCH 26/37] cxl/memdev: Add serial support for
 memdev-related commands
Message-ID: <20220210011046.GA956428@alison-desk>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298564631.3021641.5552442288217413180.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164298564631.3021641.5552442288217413180.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, Jan 23, 2022 at 04:54:06PM -0800, Dan Williams wrote:
> Allow for a "-s, --serial" option to turn the argument list into serial
> identifiers.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/cxl/memdev-option.txt |    5 ++++
>  Documentation/cxl/meson.build       |    4 ++-
>  cxl/memdev.c                        |   45 ++++++++++++++++++++++++++---------
>  3 files changed, 41 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/cxl/memdev-option.txt b/Documentation/cxl/memdev-option.txt
> index e7785827ab4c..64348bed1791 100644
> --- a/Documentation/cxl/memdev-option.txt
> +++ b/Documentation/cxl/memdev-option.txt
> @@ -2,3 +2,8 @@
>  A 'memX' device name, or a memdev id number. Restrict the operation to
>  the specified memdev(s). The keyword 'all' can be specified to indicate
>  the lack of any restriction.
> +
> +-S::
> +--serial::
> +	Rather an a memdev id number, interpret the <memdev> argument(s)

Rather 'than'

That's all :)
> +	as a list of serial numbers.

snip

