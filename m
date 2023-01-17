Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435FBC3DA78
	for <linux-cxl@archiver.kernel.org>; Tue, 17 Jan 2023 18:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjAQSqk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 17 Jan 2023 13:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbjAQShr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 17 Jan 2023 13:37:47 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489913801F
        for <linux-cxl@vger.kernel.org>; Tue, 17 Jan 2023 10:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673978909; x=1705514909;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wIc4U+5gXC+GeYkUTzI+XrWvybjkaynC0y2t1WmDimY=;
  b=gvwKNasxFOXRxMFYoSLPWH48dCxft25Zk4h2OiEvPIHyhg6ofqJZwgwu
   lKfuByfhtoYUbj9c3eT+/oohQfaU8JojBmYYaIQ4LxkcFTx5Lj165YsuB
   auDy0hzbJFzx6himrsy3J+Yi0s7RCEZlaIdhhdnmDGawAGqvYzCA5UwGp
   oBA0OtknQ1AVteEjiQY0VDn9hnh+lg2V7LnGnGRtcBtBslmwjKfEEr3DA
   WacYehhHie6EgDkqYPjGm7laQaWmm6FmP6B9QJDDQ2Dc7lRzcaWyMaiT8
   pkEKcWusCk1wL6j91dKvP2pWnVay7Lz1P+rtlr5UNZMZUL/irHkkJr0sO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="326046422"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="326046422"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 10:08:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="722763704"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="722763704"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.41.87]) ([10.212.41.87])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 10:08:26 -0800
Message-ID: <0907017b-a620-0089-8d10-b3dc92e145ed@intel.com>
Date:   Tue, 17 Jan 2023 11:08:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 2/2] cxl: Add tprintk support for header log hex dump
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, dan.j.williams@intel.com
Cc:     linuxarm@huawei.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
References: <20230113154058.16227-1-Jonathan.Cameron@huawei.com>
 <20230113154058.16227-3-Jonathan.Cameron@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230113154058.16227-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 1/13/23 8:40 AM, Jonathan Cameron wrote:
> May not make sense in general, but very helpful when writing multiple
> header logging support.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The user logging software would be retrieving from the log data directly 
instead of parsing the trace output right? Will people visually inspect 
the formatted trace output? Useful for debugging?

> ---
>   drivers/cxl/core/trace.h | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 20ca2fe2ca8e..64f6ad13529d 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -62,10 +62,13 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>   		 */
>   		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>   	),
> -	TP_printk("%s: status: '%s' first_error: '%s'",
> +	TP_printk("%s: status: '%s' first_error: '%s' header_log: %s",
>   		  __get_str(dev_name),
>   		  show_uc_errs(__entry->status),
> -		  show_uc_errs(__entry->first_error)
> +		  show_uc_errs(__entry->first_error),
> +		__print_hex_dump("", DUMP_PREFIX_OFFSET, 32, 4,
> +				(char *)__entry->header_log,
> +				CXL_HEADERLOG_SIZE_U32, false)
>   	)
>   );
>   
