Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7926EC27C76
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 01:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjAZBSS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 25 Jan 2023 20:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbjAZBSS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 25 Jan 2023 20:18:18 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4891811641
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jan 2023 17:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674695896; x=1706231896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gl9MRpdfa1ZUPdB0uU2EcdMMenlagDsY+1DlOsr0RqA=;
  b=IkQBvPa8C6yIA0yftGVqBGg4CZNC+Iw0CkT8lM0Ox3UOaMMp93bSqUdf
   MvjtC4hOUMC3PN9lReHZegma5dDVQYigbNy/dj+H9x+sQwcaOYXGOqpp3
   0gWuznRMGRDxUGz4m/SLuzpfM/npHwApHEiu+A5ftbfuYYqDgF9CrhtPH
   eVFJZnJve5aN6/2x71S9Lww8EsBBBoOzuj+Nvl4W3AInP8t79D8J+dTWw
   NAn5Rz5PPRJzXYW99s/NRbbo7QPrgJI56//1MMjXRaf1k0+lftdHexvlQ
   QTv56ipc8OEbzo679PaZrotCxiVO1oJsaacFRkh+eQY0kzY73fBt1PjkC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="306387202"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="306387202"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 17:18:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="731251356"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="731251356"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.71.142])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 17:18:15 -0800
Date:   Wed, 25 Jan 2023 17:18:13 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] tools/testing/cxl: Remove cxl_test module math
 loading message
Message-ID: <Y9HU1ZzWlOprUMg4@aschofie-mobl2>
References: <20230125181336.667448-1-alison.schofield@intel.com>
 <65f467d4-5511-e1ea-50e9-ba3720099c0d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65f467d4-5511-e1ea-50e9-ba3720099c0d@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jan 25, 2023 at 03:35:32PM -0700, Dave Jiang wrote:
> 
> 
> On 1/25/23 11:13 AM, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Commit "tools/testing/cxl: Add XOR Math support to cxl_test" added
> > a module parameter to cxl_test for the interleave_arithmetic option.
> > In doing so, it also added this dev_dbg() message describing which
> > option cxl_test used during load:
> > "[  111.743246] (NULL device *): cxl_test loading modulo math option"
> > 
> > That "(NULL device *)" has raised needless user concern and the info
> > emitted can be discovered elsewhere.
> > 
> > Remove the dev_dbg() messages and make the module_param readable via
> > sysfs in case a lookup is wanted.
> 
> Should the module_param perm change go to a second patch since it has
> nothing to do with removal of the debug warning?
> 

Thanks Dave -

I don't think a second patch, but I can make the connection better
between the 2 pieces. Where it says the 'info emitted can be discovered
elsewhere', elsewhere is that now readable param.

I'll rev it.  Also, I might need to base on a fixes branch, rather than
cxl/next, like I've been doing.

Will check.


> > 
> > Fixes: Fixes: 7a7e6edfca85 ("tools/testing/cxl: Add XOR Math support to cxl_test")
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> > 
> > Changes in v2:
> > - Use correct Fixes Tag in commit log. (Ira)
> > - Param always appears in sysfs. Don't say otherwise in commit log. (Ira)
> > - Commit msg: s/modulo/module, s/messages/message
> > - No change in code
> > 
> >   tools/testing/cxl/test/cxl.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index 30ee680d38ff..ede84de69f59 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -1135,11 +1135,9 @@ static __init int cxl_test_init(void)
> >   	if (interleave_arithmetic == 1) {
> >   		cfmws_start = CFMWS_XOR_ARRAY_START;
> >   		cfmws_end = CFMWS_XOR_ARRAY_END;
> > -		dev_dbg(NULL, "cxl_test loading xor math option\n");
> >   	} else {
> >   		cfmws_start = CFMWS_MOD_ARRAY_START;
> >   		cfmws_end = CFMWS_MOD_ARRAY_END;
> > -		dev_dbg(NULL, "cxl_test loading modulo math option\n");
> >   	}
> >   	rc = populate_cedt();
> > @@ -1326,7 +1324,7 @@ static __exit void cxl_test_exit(void)
> >   	unregister_cxl_mock_ops(&cxl_mock_ops);
> >   }
> > -module_param(interleave_arithmetic, int, 0000);
> > +module_param(interleave_arithmetic, int, 0444);
> >   MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
> >   module_init(cxl_test_init);
> >   module_exit(cxl_test_exit);
> > 
> > base-commit: 589c3357370a596ef7c99c00baca8ac799fce531
