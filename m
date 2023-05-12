Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92104C77B7F
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 21:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjELVv2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 17:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239194AbjELVvJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 17:51:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351DF2682
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 14:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683928269; x=1715464269;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g6hhyED8T6PVIdoE0Rjrl9VGbwA09dSmxE1kvH5wR0Y=;
  b=UQrJRUtWhObGMcjunlfvh1+TBkDq1llD55vxlPe8Dbv04IVaekUROlNp
   uReuMRKz7Vmnk46eMdbExrQd3vuzdj4NH09O+0mNk97MgzFvJRuBe1QPQ
   ueeEtmofksmrtCbHTMa/51s1ivwGQl7SMYdbe9z79PAsOpa/Tno7/E4rq
   Y+SZJcrhi/2nMJHBXkcmeIGVDNp81LyfwV4b+mbX2TKEXOsHCE6Ph/PGD
   ZVWgLS7ZXUPMpTbxUwii4l9/WRm7C7GYL5lowh6yAmUy9R6dHVNOLP60/
   rfcw+FrAIObXbTRftHZ5YnLSQFZ/HkPraf3tX80zTOOyiLdstVyoJHlC9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="350916592"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="350916592"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 14:51:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="824502762"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="824502762"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.160.55]) ([10.213.160.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 14:51:08 -0700
Message-ID: <4cabef9c-a997-90d2-e10a-5b0bad873e99@intel.com>
Date:   Fri, 12 May 2023 14:51:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH] tools/testing/cxl: Use DEFINE_STATIC_SRCU()
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com
References: <168392709546.1135523.10424917245934547117.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168392709546.1135523.10424917245934547117.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 5/12/23 2:31 PM, Dan Williams wrote:
> Starting with commit:
> 
> 95433f726301 ("srcu: Begin offloading srcu_struct fields to srcu_update")
> 
> ...it is no longer possible to do:
> 
> static DEFINE_SRCU(x)
> 
> Switch to DEFINE_STATIC_SRCU(x) to fix:
> 
> tools/testing/cxl/test/mock.c:22:1: error: duplicate ‘static’
>     22 | static DEFINE_SRCU(cxl_mock_srcu);
>        | ^~~~~~
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   tools/testing/cxl/test/mock.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index c4e53f22e421..de3933a776fd 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -19,7 +19,7 @@ void register_cxl_mock_ops(struct cxl_mock_ops *ops)
>   }
>   EXPORT_SYMBOL_GPL(register_cxl_mock_ops);
>   
> -static DEFINE_SRCU(cxl_mock_srcu);
> +DEFINE_STATIC_SRCU(cxl_mock_srcu);
>   
>   void unregister_cxl_mock_ops(struct cxl_mock_ops *ops)
>   {
> 
