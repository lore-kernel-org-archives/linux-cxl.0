Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95507C77B71
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 20:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDNUeF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Apr 2023 16:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjDNUeE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Apr 2023 16:34:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4795B9F
        for <linux-cxl@vger.kernel.org>; Fri, 14 Apr 2023 13:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681504438; x=1713040438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JfnBO2TtGcP7rctWDCaAWNU2aeBaI6D5GEbgadU6kJ4=;
  b=TXOadu+W1npXsF2e4QHbpha6zZ6x9brFpF7HQGCAg2zhI3KGl5i6GKGl
   4k2e/V4iXRxFei8sc3vmsA8GMPmHSmoTjEdmR0mNYYtW668XLl5q4qyvx
   EsONCmA1hBS8e1FJMSf4V+zb/Wpmyjci1aZdivKGb4QqbbRnrY6A5udKb
   3Prg+GHYxewIefaQ9Yn6zARCeCwPqWEkKT4xAZ3gN8nEXQ8pt8FFMi+Z1
   s13eu/5Uu0aR7nqBU0KPYVBhDbq0ca7J5BJ+eXccSS38izG0oRAhJzqoe
   DSIf6GJb4zy3gRWrWE5Xqb/hza4mlzkBA9MTAvhCJTiKLzQtV8Y4A6CKN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="430855895"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="430855895"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 13:33:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="754577757"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="754577757"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.22.80])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 13:33:58 -0700
Date:   Fri, 14 Apr 2023 13:33:56 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/5] cxl/core: Drop unused io-64-nonatomic-lo-hi.h
Message-ID: <ZDm4tEIH77DwV6cF@aschofie-mobl2>
References: <168149842935.792294.13212627946146993066.stgit@dwillia2-xfh.jf.intel.com>
 <168149844596.792294.8273108394688012953.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168149844596.792294.8273108394688012953.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Apr 14, 2023 at 11:54:06AM -0700, Dan Williams wrote:
> After the discovery of a case where an implementation misbehaves with
> register reads larger than the definition of the register the other
> usages of readq() were audited and found to be correct, but some cases
> where the io-64-nonatomic-lo-hi.h include is not needed were discovered,
> delete them.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> ---
>  drivers/cxl/core/mbox.c |    1 -
>  drivers/cxl/core/port.c |    1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f2addb457172..6198637cb0bb 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> -#include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/security.h>
>  #include <linux/debugfs.h>
>  #include <linux/ktime.h>
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 4d1f9c5b5029..b060757c4000 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> -#include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/memregion.h>
>  #include <linux/workqueue.h>
>  #include <linux/debugfs.h>
> 
