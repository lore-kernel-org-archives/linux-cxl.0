Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CDFC77B71
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 21:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjDNVWi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Apr 2023 17:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjDNVWh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Apr 2023 17:22:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E221092
        for <linux-cxl@vger.kernel.org>; Fri, 14 Apr 2023 14:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681507356; x=1713043356;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=eiTxzzFPE1Q5FDN18H3CIWrUBWJ3pLeFgjVPdOvUzno=;
  b=QocUHAG0P+e6AlR3JEVog4/jzuVfoutD3Ep6kekaUNg/XgORDxiIo5Ad
   Gu1KenPWgZ2fDAaRI1mdEHbdqh8mclQNS6cVjZdn8zYbYMAD+gwOQDwuc
   a1su4fr1mtWPyss8UaWhYVyOQ6IDKTD402a9bMVcx2XV040KAinvzzffi
   bLKDCSf3zztVeq9G9yeQINFXjC6c7Jls5siLMZOnA7yGPM7kQqaQiGl60
   DMKTqHPLoNUskmcMB68VScYqYrC3UGHQNxqqILsUC/h/e63K98YvIIU9i
   o1e3BgePUYiKsvA/v+jQgtjcc1/FAXYg0poTvhYEjFFD/dtxN7+QI2w2E
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="346416202"
X-IronPort-AV: E=Sophos;i="5.99,198,1677571200"; 
   d="scan'208";a="346416202"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 14:22:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="689963394"
X-IronPort-AV: E=Sophos;i="5.99,198,1677571200"; 
   d="scan'208";a="689963394"
Received: from tpattadx-mobl1.amr.corp.intel.com (HELO [10.212.122.87]) ([10.212.122.87])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 14:22:36 -0700
Message-ID: <4f9f0682-fa8a-3491-5ee8-3b375585837f@intel.com>
Date:   Fri, 14 Apr 2023 14:22:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH 3/5] cxl/core: Drop unused io-64-nonatomic-lo-hi.h
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
References: <168149842935.792294.13212627946146993066.stgit@dwillia2-xfh.jf.intel.com>
 <168149844596.792294.8273108394688012953.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168149844596.792294.8273108394688012953.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 4/14/23 11:54 AM, Dan Williams wrote:
> After the discovery of a case where an implementation misbehaves with
> register reads larger than the definition of the register the other
> usages of readq() were audited and found to be correct, but some cases
> where the io-64-nonatomic-lo-hi.h include is not needed were discovered,
> delete them.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/mbox.c |    1 -
>   drivers/cxl/core/port.c |    1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f2addb457172..6198637cb0bb 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> -#include <linux/io-64-nonatomic-lo-hi.h>
>   #include <linux/security.h>
>   #include <linux/debugfs.h>
>   #include <linux/ktime.h>
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 4d1f9c5b5029..b060757c4000 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1,6 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> -#include <linux/io-64-nonatomic-lo-hi.h>
>   #include <linux/memregion.h>
>   #include <linux/workqueue.h>
>   #include <linux/debugfs.h>
> 
