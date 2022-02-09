Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ED5C433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Feb 2022 17:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiBIRj3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Feb 2022 12:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbiBIRj2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Feb 2022 12:39:28 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA1FC05CB82
        for <linux-cxl@vger.kernel.org>; Wed,  9 Feb 2022 09:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644428371; x=1675964371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pcWa4vPzDFsaidBuXlyIic9God6Kqn1zS9nlAhJBeyQ=;
  b=lQOw4ky/xWVm7aPCjcf1AczbcNm08LrDFQ4vjaf3luV6cZG1I8JR+vXH
   lO8MTdv32BJwvdmJehUxWU9R3eglWmyp/9W7MkLBvlx3s3WrJaMijSPi1
   N9paJ41GfvC4agCID7cNnQT4xlEVFe4LN0vWpxxqT9fIh9bqkEmIS9leR
   waL8tAcrV2cKUd0IPwL+vGSrhkADCBRECxJ+otLgi2snFEOGw3hJXBc71
   SA0hQxJRd1QzhjunnESWR2EQosMP20ejubwwxL1c0MlSVOfwqVc6ez8d1
   XOKygreoWpxUTpOqzH7bR8ON4WFvZVONK9EftzrXspz1KIuRuLOe0Rrkj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="335676634"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="335676634"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 09:39:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="526084149"
Received: from dgarg1-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.131.253])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 09:39:30 -0800
Date:   Wed, 9 Feb 2022 09:39:29 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/core: Fix cxl_device_lock() class detection
Message-ID: <20220209173929.ivkvmf6nr4omrqwc@intel.com>
References: <164439225406.2941117.3927102269866914339.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164439225406.2941117.3927102269866914339.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-02-08 23:37:34, Dan Williams wrote:
> If cxl_device_lock() is used on a non-CXL device the expectation is that
> the lock class will fall back to CXL_ANON_LOCK. Instead it crashes when
> trying to determine if the device is a 'decoder'. Specifically when the
> device has a NULL type pointer. Just check for NULL before
> de-referencing ->release.
> 
> Fixes: 3c5b90395525 ("cxl: Prove CXL locking")
> Reported-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>

> ---
>  drivers/cxl/core/port.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 9b4bbd51fbaa..d29eb2abdbc2 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -284,7 +284,7 @@ EXPORT_SYMBOL_NS_GPL(is_root_decoder, CXL);
>  
>  bool is_cxl_decoder(struct device *dev)
>  {
> -	return dev->type->release == cxl_decoder_release;
> +	return dev->type && dev->type->release == cxl_decoder_release;
>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_decoder, CXL);
>  
> 
