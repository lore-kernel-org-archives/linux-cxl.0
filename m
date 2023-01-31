Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891BFC636CC
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 16:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjAaQY2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 11:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjAaQYV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 11:24:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376BA53B2C
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 08:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675182260; x=1706718260;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q/KpNOR7Y95KYazjgeBm6f/ekZW+NYfDAWqBApCvizs=;
  b=fz0lGzeMFkwR5/OUKlcpxfvV7mOYxKzbif+MPmzizKXLjN7JRD9z7FTU
   hhqK7B1zPXwVMeMH6s8g5LP4b3/PblcHNiwDno29VSrFAAtDfYvC6yNG3
   69vsQRyI4JuFdVVaNp/zcmXvAhUa9KZDRiornHu75VV69kTb/W0Mo5Fvr
   wocooqS/tH8fNrSNFvWWnQ0xcFuBZrKtiZDWCZ5X4EkEFXlp+M18nsXUS
   NpARFKTZa5amOEvuRQz0k+AOBWIMGcxp/StD/KUV7UNf40Fzx8lalwxlQ
   koRR2ZLtCgSuMT/FQr9jRXXcDYCCKTeJKBpEZLKOJstXi3phoEcBR8ene
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="311504608"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="311504608"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 08:24:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="728006917"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="728006917"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.177.33]) ([10.213.177.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 08:24:18 -0800
Message-ID: <8239547a-aabe-29ca-5cec-ee49db68973b@intel.com>
Date:   Tue, 31 Jan 2023 09:24:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/4] cxl/uapi: Add warning on CXL command enum
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
 <20221222-cxl-misc-v2-2-60403cc37257@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221222-cxl-misc-v2-2-60403cc37257@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 1/27/23 5:09 PM, Ira Weiny wrote:
> The CXL command enum is exported to user space and must maintain
> backwards compatibility.
> 
> Add comment that new defines must be added to the end of the list.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> Changes for v2:
> 	Pick up tag
> ---
>   include/uapi/linux/cxl_mem.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index c71021a2a9ed..459a3f7f764b 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -19,6 +19,10 @@
>   #define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
>   #define CXL_MEM_SEND_COMMAND _IOWR(0xCE, 2, struct cxl_send_command)
>   
> +/*
> + * NOTE: New defines must be added to the end of the list to preserve
> + * compatibility because this enum is exported to user space.
> + */
>   #define CXL_CMDS                                                          \
>   	___C(INVALID, "Invalid Command"),                                 \
>   	___C(IDENTIFY, "Identify Command"),                               \
> 
