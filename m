Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2607C38147
	for <linux-cxl@archiver.kernel.org>; Wed, 18 Jan 2023 23:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjARXTG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 Jan 2023 18:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjARXTA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 Jan 2023 18:19:00 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DA5654DC
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 15:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674083940; x=1705619940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HrfjoYSO6jNGEjkonmaLp6BchdVhRCRvOob5L/T+si4=;
  b=aoJpF6dI32eJMXhXzfCGSFLH31kLb5gCAHnkBNs0LTYIByKBG5i+VpWJ
   2whvqhABJVLcatnavtT0XGHGITpj5w6XJQ5qZqmpcDZomOueRNOgJ+wdC
   ww9AtFPpWZTzVNb7I1REGkqZ2rlP+IVo1fzGBIqzZn/tRUpWfVKzP984r
   XgXPFZGew5415y/K8XCvu4ajgKRkz+ZmDBtAo/4PQJXVdYy+HL3hfFKm7
   +4SeQRuVP2xfZPhjCr6OancmNTTldaOsNZ7h8/AnnMOMeTXrWcWBtmm/4
   Abq7OD1ScIj8nw+tEo3SFKPSjdP+sEnsYju7FdZ4EcCde5cj8OVKLLnnI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="325180044"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="325180044"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 15:18:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="728430290"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="728430290"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.119.104])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 15:18:57 -0800
Date:   Wed, 18 Jan 2023 15:18:55 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v9 3/3] tools/testing/cxl: Add XOR Math support to
 cxl_test
Message-ID: <Y8h+X/XdFYuLLgR1@aschofie-mobl2>
References: <cover.1669847017.git.alison.schofield@intel.com>
 <54670400cd48ba7fcc6d8ee0d6ae2276d3f51aad.1669847017.git.alison.schofield@intel.com>
 <63c85497274b5_c81f02941e@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63c85497274b5_c81f02941e@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jan 18, 2023 at 12:20:39PM -0800, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Expand the cxl_test topology to include CFMWS's that use XOR math
> > for interleave arithmetic, as defined in the CXL Specification 3.0.
> > 
> > With this expanded topology, cxl_test is useful for testing:
> > x1,x2,x4 ways with XOR interleave arithmetic.
> > 
> > Define the additional XOR CFMWS entries to appear only with the
> > module parameter interleave_arithmetic=1. The cxl_test default
> > continues to be modulo math.
> > 
> > modprobe cxl_test interleave_arithmetic=1
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  tools/testing/cxl/test/cxl.c | 118 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 115 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index 7edce12fd2ce..c7dba7550106 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> [..]
> > @@ -897,6 +997,16 @@ static __init int cxl_test_init(void)
> >  	if (rc)
> >  		goto err_gen_pool_add;
> >  
> > +	if (interleave_arithmetic == 1) {
> > +		cfmws_start = CFMWS_XOR_ARRAY_START;
> > +		cfmws_end = CFMWS_XOR_ARRAY_END;
> > +		dev_dbg(NULL, "cxl_test loading xor math option\n");
> > +	} else {
> > +		cfmws_start = CFMWS_MOD_ARRAY_START;
> > +		cfmws_end = CFMWS_MOD_ARRAY_END;
> > +		dev_dbg(NULL, "cxl_test loading modulo math option\n");
> > +	}
> > +
> 
> Missed this earlier., but noticed now that I am running it. If no device
> is available then just use pr_debug() instead of dev_dbg(). That said,
> these messages could just be skipped altogher and make the value of
> @interleave_arithmetic readable via sysfs if something really needs to
> recall what mode the test module is running in. I.e.:

Understand (now). I'll send a patch like you suggest.
Thanks!

> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 14530fe1edc6..b7d7420e74ea 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1265,11 +1265,9 @@ static __init int cxl_test_init(void)
>         if (interleave_arithmetic == 1) {
>                 cfmws_start = CFMWS_XOR_ARRAY_START;
>                 cfmws_end = CFMWS_XOR_ARRAY_END;
> -               dev_dbg(NULL, "cxl_test loading xor math option\n");
>         } else {
>                 cfmws_start = CFMWS_MOD_ARRAY_START;
>                 cfmws_end = CFMWS_MOD_ARRAY_END;
> -               dev_dbg(NULL, "cxl_test loading modulo math option\n");
>         }
>  
>         rc = populate_cedt();
> @@ -1456,7 +1454,7 @@ static __exit void cxl_test_exit(void)
>         unregister_cxl_mock_ops(&cxl_mock_ops);
>  }
>  
> -module_param(interleave_arithmetic, int, 0000);
> +module_param(interleave_arithmetic, int, 0444);
>  MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
>  module_init(cxl_test_init);
>  module_exit(cxl_test_exit);
> 
> Otherwise, the current code leads to a concerning:
> 
> "[  111.743246] (NULL device *): cxl_test loading modulo math option"
> 
> ...at startup.
