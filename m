Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28396C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 23 Jun 2022 23:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiFWX5c (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 23 Jun 2022 19:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiFWX5b (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 23 Jun 2022 19:57:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507C160F07
        for <linux-cxl@vger.kernel.org>; Thu, 23 Jun 2022 16:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656028651; x=1687564651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WbxT0FN3U+Aeo4a+wXRYJb4bBh1TTmRvgzzwngC1cHk=;
  b=B5HvwZBeItq7yVUw8sBHGx7zo4cHCS7ZHu5oo5eKDwtrYFYB2XSEZalx
   gZuJFFkK21Dum8m2kN8Kubd/o7/P8Uvq8SmN21mRrDxxfK/MU8b69U6/1
   ooeXB/w4qIP6pRztl2M0dlm4DWsYJSxPDnVbzM06ujIgfsP0glLXOqGhR
   Vp7yKC2B9wGT6w/ftheESzn7U5dwbiStEjTACWULU4/AeE0UaxPzKOqhB
   wyfLEu9h3Ms3vWUtM8457q1GHEhiKWG8iAJb7eBoj1h3tFv64Nx3ezksc
   QfeG/9jLZWmoE/3AbcOGP/6N13fwhZQqZraAyLrKLIB9oCWniU+4wbW3b
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="269601950"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="269601950"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 16:57:30 -0700
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="915438021"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 16:57:30 -0700
Date:   Thu, 23 Jun 2022 16:56:54 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>,
        nvdimm@lists.linux.dev
Subject: Re: [PATCH] memregion: Fix memregion_free() fallback definition
Message-ID: <20220623235654.GA1557841@alison-desk>
References: <165601455171.4042645.3350844271068713515.stgit@dwillia2-xfh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165601455171.4042645.3350844271068713515.stgit@dwillia2-xfh>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jun 23, 2022 at 01:02:31PM -0700, Dan Williams wrote:
> In the CONFIG_MEMREGION=n case, memregion_free() is meant to be a static
> inline. 0day reports:
> 
>     In file included from drivers/cxl/core/port.c:4:
>     include/linux/memregion.h:19:6: warning: no previous prototype for
>     function 'memregion_free' [-Wmissing-prototypes]
> 
> Mark memregion_free() static.
> 
> Fixes: 33dd70752cd7 ("lib: Uplevel the pmem "region" ida to a global allocator")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> ---
>  include/linux/memregion.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/memregion.h b/include/linux/memregion.h
> index e11595256cac..c04c4fd2e209 100644
> --- a/include/linux/memregion.h
> +++ b/include/linux/memregion.h
> @@ -16,7 +16,7 @@ static inline int memregion_alloc(gfp_t gfp)
>  {
>  	return -ENOMEM;
>  }
> -void memregion_free(int id)
> +static inline void memregion_free(int id)
>  {
>  }
>  #endif
> 
> 
