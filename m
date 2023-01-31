Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B3FC38142
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 16:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjAaQXk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 11:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjAaQXk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 11:23:40 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3070D13538
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 08:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675182219; x=1706718219;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UMFrrkh8slZMFGjhhEHbqNkHUYGMk+cVve6ATVm9wDY=;
  b=hg9jnEMdUNfS5HGm8rFByxDO9ja3nRICXBs/j4DUNH0U2yle2Fml6nO0
   PY0uK85Ppu2lBBaAhtVAQCtXFkz/6eF4uckP6SdwQZ8gMwUSjK1yzAdxm
   ez+vS6l4TM2NDoClOtCh2vY0Iun35/SsO9KJ7ff0SQ5kviif4qOzrXmii
   bYOUCdxgNVEqKsb6IG7r4CkWbvHnwKKWQkiUI+HDDevvJn6BjRPlRtzSS
   sQo/mx0A0aJ2sEwW19rfMAewL4cdJ02J0bCqLpUQFJJVntD7XqA57SvTe
   MQejC5waA4ancBpBB9wngoKwfowZ1A9i8DYA4g14s5E+QjWFsCdiwvicy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="311504466"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="311504466"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 08:23:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="728006776"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="728006776"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.177.33]) ([10.213.177.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 08:23:37 -0800
Message-ID: <c5e8c02a-2a28-acf3-ee49-a5a6c8ed13c9@intel.com>
Date:   Tue, 31 Jan 2023 09:23:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/4] cxl/mem: Remove unused CXL_CMD_FLAG_NONE define
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        linux-cxl@vger.kernel.org
References: <20221222-cxl-misc-v2-0-60403cc37257@intel.com>
 <20221222-cxl-misc-v2-1-60403cc37257@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221222-cxl-misc-v2-1-60403cc37257@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 1/27/23 5:09 PM, Ira Weiny wrote:
> CXL_CMD_FLAG_NONE is not used, remove it.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> Changes for v2:
> 	Pick up tag
> ---
>   drivers/cxl/cxlmem.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ab138004f644..2d85776236dd 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -393,7 +393,6 @@ struct cxl_mem_command {
>   	struct cxl_command_info info;
>   	enum cxl_opcode opcode;
>   	u32 flags;
> -#define CXL_CMD_FLAG_NONE 0
>   #define CXL_CMD_FLAG_FORCE_ENABLE BIT(0)
>   };
>   
> 
