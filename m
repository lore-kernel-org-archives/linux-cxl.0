Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4ACC27C76
	for <linux-cxl@archiver.kernel.org>; Wed, 25 Jan 2023 22:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjAYWfg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 25 Jan 2023 17:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjAYWff (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 25 Jan 2023 17:35:35 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C084941C
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jan 2023 14:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674686134; x=1706222134;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wEDLqCbgND0NPEIbeBXeW3SVjcmiqrbnSbUeuEPly1Y=;
  b=FMDneXfMpwEUfB7qWc7MZmqSLngRWGk7FsZid7hP5WqYDrqJikSAZMqb
   Pnj9XicZgFIrmsJJRgXtPFsy7zyPpeBPLMzq0G6h3IJfwjJYnMR74tN0Z
   aO9Xb5QfHoB672sqUUI2+2bppqI1P30ZTiPO7FmsuH94ROj09ht0Slc7+
   tATQEeGxLPhcsrkfUdmPpmcrLFv6Mii3WQeUkXwlCY+Du9Ezmv4a4zOmo
   vLy9X40HQjLntHO1ateYymu+nJsRsVfZuYlWLbn7k1x5fGMgdgnpTz8cf
   pFaJJt2SDx4vxu3t0jdLR+BaFlLYu7etioyH+Jk1DY6/X3WfY2uvyOYLK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="310276690"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="310276690"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 14:35:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="991416684"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="991416684"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.209.145.70]) ([10.209.145.70])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 14:35:33 -0800
Message-ID: <65f467d4-5511-e1ea-50e9-ba3720099c0d@intel.com>
Date:   Wed, 25 Jan 2023 15:35:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v2] tools/testing/cxl: Remove cxl_test module math loading
 message
Content-Language: en-US
To:     alison.schofield@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     linux-cxl@vger.kernel.org
References: <20230125181336.667448-1-alison.schofield@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230125181336.667448-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 1/25/23 11:13 AM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Commit "tools/testing/cxl: Add XOR Math support to cxl_test" added
> a module parameter to cxl_test for the interleave_arithmetic option.
> In doing so, it also added this dev_dbg() message describing which
> option cxl_test used during load:
> "[  111.743246] (NULL device *): cxl_test loading modulo math option"
> 
> That "(NULL device *)" has raised needless user concern and the info
> emitted can be discovered elsewhere.
> 
> Remove the dev_dbg() messages and make the module_param readable via
> sysfs in case a lookup is wanted.

Should the module_param perm change go to a second patch since it has 
nothing to do with removal of the debug warning?

> 
> Fixes: Fixes: 7a7e6edfca85 ("tools/testing/cxl: Add XOR Math support to cxl_test")
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> Changes in v2:
> - Use correct Fixes Tag in commit log. (Ira)
> - Param always appears in sysfs. Don't say otherwise in commit log. (Ira)
> - Commit msg: s/modulo/module, s/messages/message
> - No change in code
> 
>   tools/testing/cxl/test/cxl.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 30ee680d38ff..ede84de69f59 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1135,11 +1135,9 @@ static __init int cxl_test_init(void)
>   	if (interleave_arithmetic == 1) {
>   		cfmws_start = CFMWS_XOR_ARRAY_START;
>   		cfmws_end = CFMWS_XOR_ARRAY_END;
> -		dev_dbg(NULL, "cxl_test loading xor math option\n");
>   	} else {
>   		cfmws_start = CFMWS_MOD_ARRAY_START;
>   		cfmws_end = CFMWS_MOD_ARRAY_END;
> -		dev_dbg(NULL, "cxl_test loading modulo math option\n");
>   	}
>   
>   	rc = populate_cedt();
> @@ -1326,7 +1324,7 @@ static __exit void cxl_test_exit(void)
>   	unregister_cxl_mock_ops(&cxl_mock_ops);
>   }
>   
> -module_param(interleave_arithmetic, int, 0000);
> +module_param(interleave_arithmetic, int, 0444);
>   MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
>   module_init(cxl_test_init);
>   module_exit(cxl_test_exit);
> 
> base-commit: 589c3357370a596ef7c99c00baca8ac799fce531
