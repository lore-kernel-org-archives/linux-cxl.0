Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE96BC433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 15 Jun 2022 21:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344189AbiFOVqW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 15 Jun 2022 17:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344083AbiFOVqV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 15 Jun 2022 17:46:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D58C33A1C
        for <linux-cxl@vger.kernel.org>; Wed, 15 Jun 2022 14:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655329580; x=1686865580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YnMbz5PA3Y94sANgd1CRMm1j7tD4ERno8h315knI5nk=;
  b=fy9oSPmvs00Fe1Ym/APigoJLfXe3G+weaupnA0zCbptQTZdYVGNqH7sw
   vIGtkeZbxxUa5OwCF2wTcGcMYyEzUTxJZoD3mCr/5ou9pc3uDzIMKOTLS
   37+U36PlU1W8QEb03N90a6CgVAyHpqGFE9U4/AskaERxzGsU79BLJlto7
   b/FoqSbipcclgbUSJI23jU63CbAOuL1sdE3yaPEVMgk2jhbSePydOVUcr
   yPKU9AIcU0L35u3ToGRavYSOud8Jj3epp8uqYn4UAhI7hBtNS6JRp7wwZ
   IvkfmU71DoFtw0BFdep+D8yKKWr1lP7sJstXVgXi/End1lvELX+Kix0Fq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="279162386"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="279162386"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 14:46:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="559382241"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 14:46:20 -0700
Date:   Wed, 15 Jun 2022 14:46:02 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        Dan Williams <dan.j.williams@intel.com>,
        Steven Garcia <steven.garcia@intel.com>
Subject: Re: [ndctl PATCH] libcxl: fix a segfault when memdev->pmem is absent
Message-ID: <20220615214602.GA1525164@alison-desk>
References: <20220602154427.462852-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602154427.462852-1-vishal.l.verma@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jun 02, 2022 at 09:44:27AM -0600, Vishal Verma wrote:
> A CXL memdev may not have any persistent capacity, and in this case it
> is possible that a 'pmem' object never gets instantiated. Such a
> scenario would cause free_pmem () to dereference a NULL pointer and
> segfault.
> 
> Fix this by only proceeding in free_pmem() if 'pmem' was valid.
> 
> Fixes: cd1aed6cefe8 ("libcxl: add representation for an nvdimm bridge object")
> Reported-by: Steven Garcia <steven.garcia@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

>  cxl/lib/libcxl.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index 1ad4a0b..2578a43 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -50,9 +50,11 @@ struct cxl_ctx {
>  
>  static void free_pmem(struct cxl_pmem *pmem)
>  {
> -	free(pmem->dev_buf);
> -	free(pmem->dev_path);
> -	free(pmem);
> +	if (pmem) {
> +		free(pmem->dev_buf);
> +		free(pmem->dev_path);
> +		free(pmem);
> +	}
>  }
>  
>  static void free_memdev(struct cxl_memdev *memdev, struct list_head *head)
> 
> base-commit: 4229f2694e8887a47c636a54130cff0d65f2e995
> -- 
> 2.36.1
> 
> 
