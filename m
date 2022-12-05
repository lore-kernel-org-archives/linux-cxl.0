Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2FBC4332F
	for <linux-cxl@archiver.kernel.org>; Mon,  5 Dec 2022 19:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbiLETyL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Dec 2022 14:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiLETxY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Dec 2022 14:53:24 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F364CBDE
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 11:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670269956; x=1701805956;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=etNmnpEYFyZhjQmxjVUcyTuNGE69eFiZY3nz35oqob0=;
  b=RjwNQ8j7V8ZlqD4FzogImE+DiX4SBpUBxSRPqZRVSrkDq4+I2B4xkL4V
   ItbAZ0Qg7M4CtpuvESIW59eNIVW2gj49Si/asXl6FLVHvwfPbvBL/uVQ6
   3ctHZF4Pf5EDUGkNKiqpNAAM4CmChPfkOuTwvSfVXtddce2anWcJXvkik
   CP7Jp5kaBM38JANcbNPxd06mu0xeJuROy5l4GzpjRdkLGg6JvRgAM3elv
   FqjK/yvbtJHOZWplx5EC/6CCTbAHR7BGCJjUFr6vFlsrp601p1Cdjykpc
   OnPyrmjJtvpvmAW/W0J1VN9q2kjbImqRXVfRqz2JiGCBg7gI8xnBBMEtC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="317592279"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="317592279"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 11:52:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="770468614"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="770468614"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.26.166]) ([10.212.26.166])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 11:52:34 -0800
Message-ID: <e131cc43-8638-0ece-b61d-dc9f81f53bfc@intel.com>
Date:   Mon, 5 Dec 2022 12:52:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH] tools/testing/cxl: Require cache invalidation bypass
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Alison Schofield <alison.schofield@intel.com>
References: <167026948179.3527561.4535373655515827457.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167026948179.3527561.4535373655515827457.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 12/5/2022 12:44 PM, Dan Williams wrote:
> The typical environment where cxl_test is run, QEMU, does not support
> cpu_cache_invalidate_memregion(). Add the 'test' bypass symbols to the
> configuration check.
> 
> Reported-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   tools/testing/cxl/config_check.c |    2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/cxl/config_check.c b/tools/testing/cxl/config_check.c
> index de5e5b3652fd..c4c457e59841 100644
> --- a/tools/testing/cxl/config_check.c
> +++ b/tools/testing/cxl/config_check.c
> @@ -10,4 +10,6 @@ void check(void)
>   	BUILD_BUG_ON(!IS_MODULE(CONFIG_CXL_BUS));
>   	BUILD_BUG_ON(!IS_MODULE(CONFIG_CXL_ACPI));
>   	BUILD_BUG_ON(!IS_MODULE(CONFIG_CXL_PMEM));
> +	BUILD_BUG_ON(!IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST));
> +	BUILD_BUG_ON(!IS_ENABLED(CONFIG_NVDIMM_SECURITY_TEST));
>   }
> 
