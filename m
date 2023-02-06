Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D97C05027
	for <linux-cxl@archiver.kernel.org>; Mon,  6 Feb 2023 23:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBFX6Z (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBFX6X (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 6 Feb 2023 18:58:23 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE6929430;
        Mon,  6 Feb 2023 15:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675727863; x=1707263863;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4f8J10z0rV4Xegc1td8KbY2uGUt+SOYETdbEMKjNf6s=;
  b=FRN8/3od1s5frMnBlMuorv1lohhhVKsL3WVfLsePzH37btGVn01gB63b
   8QuLmiaRbNcmV5O4UkeHQ9d/DDeSAZR9oUAl4IEZR9URnJdc+FZ4ME/6M
   eIUdC2hFzdjAAclyLkYzwAcNR9Tk/ofxDHyPWLbfl67gDiVNz+iVW5wsK
   IdYgCJYFyn9MU7FgxdOCvoScvrrf/twwqWWKZHqlrqi3RdG2j4u4Rz54p
   JYMWap0xvqdk2ozmm32DZUANzrveCO6zCtYwQrjMkfO7w6a4dk25/+S1m
   71+yROC5ayDnO13XqBVvCL4lH7zaeg0QJZaG+L7DlDdh64gMD5uxHFnXv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="327985376"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="327985376"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 15:57:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="995514657"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="995514657"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.111.195]) ([10.212.111.195])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 15:57:42 -0800
Message-ID: <ef7dbdcc-ece0-bb5f-5df9-6ce6179b955c@intel.com>
Date:   Mon, 6 Feb 2023 16:57:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 09/18] cxl/region: Enable CONFIG_CXL_REGION to be toggled
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
 <167564539875.847146.16213498614174558767.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167564539875.847146.16213498614174558767.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/5/23 6:03 PM, Dan Williams wrote:
> Add help text and a label so the CXL_REGION config option can be
> toggled. This is mainly to enable compile testing without region
> support.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/Kconfig |   12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 0ac53c422c31..163c094e67ae 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -104,12 +104,22 @@ config CXL_SUSPEND
>   	depends on SUSPEND && CXL_MEM
>   
>   config CXL_REGION
> -	bool
> +	bool "CXL: Region Support"
>   	default CXL_BUS
>   	# For MAX_PHYSMEM_BITS
>   	depends on SPARSEMEM
>   	select MEMREGION
>   	select GET_FREE_REGION
> +	help
> +	  Enable the CXL core to enumerate and provision CXL regions. A CXL
> +	  region is defined by one or more CXL expanders that decode a given
> +	  system-physical address range. For CXL regions established by
> +	  platform-firmware this option enables memory error handling to
> +	  identify the devices participating in a given interleaved memory
> +	  range. Otherwise, platform-firmware managed CXL is enabled by being
> +	  placed in the system address map and does not need a driver.
> +
> +	  If unsure say 'y'
>   
>   config CXL_REGION_INVALIDATION_TEST
>   	bool "CXL: Region Cache Management Bypass (TEST)"
> 
