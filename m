Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06633C0015E
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Jul 2023 20:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjGMUi4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Jul 2023 16:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjGMUil (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Jul 2023 16:38:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6219C2D57
        for <linux-cxl@vger.kernel.org>; Thu, 13 Jul 2023 13:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689280719; x=1720816719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YwVnORyThA4znNgNssMG5Tz6L1nOe0lkLMQz4p20wRg=;
  b=dQPtjBJdMhE3y5LlSDQcY2i2+NubNuTsRhTK0S35WPa/U3QWSxB8jQYR
   cjfWYVcLIAKohJWbShFuXCVVnFHWg40UsIJCyPGimHY7ZMJKxY3woaLrL
   3IBICeRZzG3PzdmtGFJtrl36FGTrlEWLxZr/SkRIiYIM6dM1kbb9iOQw+
   VT2o70u4KfXDvMOUkezzPJ1ODXJNTQtGkEJK73m7vLC5/VXoP+tx10r2r
   HbDHWzpDCDYyq2+c1za2DdsXSkx7Gb16eMfzNpTDsUZBLpGBHS9TNdYdB
   fCLdjitrCkJmxE/h98tv1PtKwgpBZIE8QxiqpP3SDCSxxKUBFq4URvIL7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="365346994"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="365346994"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 13:38:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="792191110"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="792191110"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.243.201])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 13:38:38 -0700
Date:   Thu, 13 Jul 2023 13:38:36 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2] cxl: Update MAINTAINERS
Message-ID: <ZLBgzA8nf3wf5XHQ@aschofie-mobl2>
References: <168921298745.190279.14706856880354094471.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168921298745.190279.14706856880354094471.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jul 12, 2023 at 06:50:36PM -0700, Dan Williams wrote:
> Ben, thank you for all the work to get the CXL subsystem off the ground
> and establishing QEMU as a place where hardware vendors can collaborate
> on the new advancements and mechanisms appearing in the CXL
> specification.
> 
> Jonathan, thank you for your continued review and collaboration, you have
> been a defacto CXL maintainer for a while now.

:)

> 
> Davidlohr, thank you for getting the background command infrastructure
> off the ground and your leadership on and off the lists.

:)

> 
> Dave Jiang, thank you for yor continued attention to all the
> cross-subsytem plumbing issues that CXL continues to create.

:)

> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Adam Manzanares <a.manzanares@samsung.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Acked-by: Davidlohr Bueso <dave@stgolabs.net>
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> ---
> Changes in v2:
> - Show Dave Jiang his due as well.
> 
>  MAINTAINERS |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3be1bdfe8ecc..82de99b6b340 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5140,10 +5140,12 @@ S:	Maintained
>  F:	include/linux/compiler_attributes.h
>  
>  COMPUTE EXPRESS LINK (CXL)
> +M:	Davidlohr Bueso <dave@stgolabs.net>
> +M:	Jonathan Cameron <jonathan.cameron@huawei.com>
> +M:	Dave Jiang <dave.jiang@intel.com>
>  M:	Alison Schofield <alison.schofield@intel.com>
>  M:	Vishal Verma <vishal.l.verma@intel.com>
>  M:	Ira Weiny <ira.weiny@intel.com>
> -M:	Ben Widawsky <bwidawsk@kernel.org>
>  M:	Dan Williams <dan.j.williams@intel.com>
>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
> 
