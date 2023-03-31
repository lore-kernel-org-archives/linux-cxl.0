Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753BCC761A6
	for <linux-cxl@archiver.kernel.org>; Fri, 31 Mar 2023 19:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCaTUY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 31 Mar 2023 15:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCaTUX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 31 Mar 2023 15:20:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B771115F
        for <linux-cxl@vger.kernel.org>; Fri, 31 Mar 2023 12:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680290423; x=1711826423;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pBrkq1ai9YojA1O2jF+1Wws2BuWqXohi0gU8/fShhVE=;
  b=RTXBVTz+uU+Auk9hqOzGqDXMCQE/cXvwSsxu4qvgl/Qh6/LFJ4u0lw5D
   RszwGJSSO0B4xz+8OsqtWnPpNyYcDIHZ6zOOdupeyhl/N1KUkfn5/Nbit
   XaxrEtIj+DcjvbN6msPFLVjCBnqgYP5Kl8yH2/GY5wYJEgD1j6P8DIEW2
   I8SIzO5B9cva4dNY7s5JYgITiKHiW3lQmH5kdKpaWp7tuaOpKHBwtOzkg
   qGkWz7T2cZcXVgloYAxLMcupk3cker4T4wOhgKPCCnfZ7R6F9tn37y78n
   6vzz5wqnimR0BbuRxV488ZK6GwegxMcTUL7ENSMglBctisCT9KcCqf7rh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="404272229"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="404272229"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 12:20:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="859458087"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="859458087"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.71.212]) ([10.212.71.212])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 12:20:22 -0700
Message-ID: <fb6a960c-9430-fb27-e1e5-a1f53ec3b9ad@intel.com>
Date:   Fri, 31 Mar 2023 12:20:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v5 12/12] tools/testing/cxl: Require CONFIG_DEBUG_FS
Content-Language: en-US
To:     alison.schofield@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     linux-cxl@vger.kernel.org
References: <cover.1679892337.git.alison.schofield@intel.com>
 <a9a8a99c4f106ba88ac839d391b83d662d5d2b92.1679892337.git.alison.schofield@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <a9a8a99c4f106ba88ac839d391b83d662d5d2b92.1679892337.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 3/26/23 10:03 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The cxl_mem driver uses debugfs to support poison inject and clear.
> Add debugfs to the list of required symbols so that cxl_test can
> emulate those poison operations.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   tools/testing/cxl/config_check.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/cxl/config_check.c b/tools/testing/cxl/config_check.c
> index 99b56b5f6edf..0902c5d6e410 100644
> --- a/tools/testing/cxl/config_check.c
> +++ b/tools/testing/cxl/config_check.c
> @@ -13,4 +13,5 @@ void check(void)
>   	BUILD_BUG_ON(!IS_MODULE(CONFIG_CXL_PMEM));
>   	BUILD_BUG_ON(!IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST));
>   	BUILD_BUG_ON(!IS_ENABLED(CONFIG_NVDIMM_SECURITY_TEST));
> +	BUILD_BUG_ON(!IS_ENABLED(CONFIG_DEBUG_FS));
>   }
