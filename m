Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BA8C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 20 May 2022 18:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242969AbiETSyL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 20 May 2022 14:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241499AbiETSyJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 20 May 2022 14:54:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AC3135688
        for <linux-cxl@vger.kernel.org>; Fri, 20 May 2022 11:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653072842; x=1684608842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=i7lxz5F2iHOC0vf8IlCJWIHGh3ktHo4EfaBwOtQyuVw=;
  b=QYk9Cs1qGUMwE1Z9hqhDO+6M/3tXQGneebcmGC7B1XRhwzRsv7yWJzbc
   cS/CXCJaicti8pInhrwLNQTHkcN2jbRnZbdyzG5LuDEHc12YabI2kSqOj
   rf7D/b3bIzqqkaR6JZv20qd+7fyKcP29+n9Yu4DIAu8oYwdFbJSRzfp3I
   Od93F2e4SkAlC1UIsWQN92kr0wO8FHwvq4fBJk0+VogwmoGhEd89PvHL9
   gyfADlQR5dPX9Urq95r6a7eb/QW//tiXlHY1ziUdfbxA2KE3o/sdVN/ZS
   oqMkG5RvvvJW4G1csYUEpnIKitx1MGKvZ6SvgYynTIbPIdbvfKvGPEZin
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="272677849"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="272677849"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 11:54:02 -0700
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="701878804"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 11:54:02 -0700
Date:   Fri, 20 May 2022 11:54:40 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ben Widawsky <bwidawsk@kernel.org>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Update Ben's email address
Message-ID: <20220520185440.GA1411046@alison-desk>
References: <20220520180059.632054-1-bwidawsk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220520180059.632054-1-bwidawsk@kernel.org>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, May 20, 2022 at 11:00:59AM -0700, Ben Widawsky wrote:
> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> I'm leaving Intel. Update email address to korg and add .mailmap
> entries. For now, I will be taking a reduced role in CXL development,
> but I still plan to spend time working on it, and I can still serve as a
> good substitute if needed for maintainer responsibilities (that may
> change in the future).
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Thanks Ben! Glad to hear your staying in the region ;)

Reviewed-by: Alison Schofield <alison.schofield@intel.com>



> ---
>  .mailmap    | 3 +++
>  MAINTAINERS | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 97ccdf147111..e8fb056a8935 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -61,6 +61,9 @@ Bart Van Assche <bvanassche@acm.org> <bart.vanassche@sandisk.com>
>  Bart Van Assche <bvanassche@acm.org> <bart.vanassche@wdc.com>
>  Ben Gardner <bgardner@wabtec.com>
>  Ben M Cahill <ben.m.cahill@intel.com>
> +Ben Widawsky <bwidawsk@kernel.org> <ben@bwidawsk.net>
> +Ben Widawsky <bwidawsk@kernel.org> <ben.widawsky@intel.com>
> +Ben Widawsky <bwidawsk@kernel.org> <benjamin.widawsky@intel.com>
>  Björn Steinbrink <B.Steinbrink@gmx.de>
>  Björn Töpel <bjorn@kernel.org> <bjorn.topel@gmail.com>
>  Björn Töpel <bjorn@kernel.org> <bjorn.topel@intel.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e127c2fb08a7..f5545ce42cc8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4842,7 +4842,7 @@ COMPUTE EXPRESS LINK (CXL)
>  M:	Alison Schofield <alison.schofield@intel.com>
>  M:	Vishal Verma <vishal.l.verma@intel.com>
>  M:	Ira Weiny <ira.weiny@intel.com>
> -M:	Ben Widawsky <ben.widawsky@intel.com>
> +M:	Ben Widawsky <bwidawsk@kernel.org>
>  M:	Dan Williams <dan.j.williams@intel.com>
>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
> -- 
> 2.36.1
> 
