Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EBDC38142
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Jan 2023 15:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjAXPvl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 24 Jan 2023 10:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjAXPvd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 24 Jan 2023 10:51:33 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A4D49001
        for <linux-cxl@vger.kernel.org>; Tue, 24 Jan 2023 07:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674575492; x=1706111492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p6Z+468ZE9GkVUfzP/owAYLjTTdsLGHbRZ3r41ec6ng=;
  b=iP9EEf8Ao7x2jN0kJusWiY8VZfky6OXQnNC+nyaC/V9EQB35MF0+jdrP
   rLwu9PidJ2kcInj3px3rVmeAYbDxJ/kHAFock65J00P9HchZktxwe83Og
   aUGgvjuG/1mpl8VULBR9Zov7lh7HM9WNqKSVZ2S9CXP8xQPRbzwD4iyr4
   ZBVuRVa6XebSUkKjGmrVbKwD248duBuXlHZkpo1Gz9kcTJkTTx3iaO1ir
   nJUHV657AumDGUnWNXy5vrl0uXWTsBf+rtdHcCZfI/jcAZdjAEtdgOETH
   r/YqTPQPl6w7USb9WklvWbtS2hiJStf7fhg7FK8fdjaxMvo4zkT9yIiyk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="309895784"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="309895784"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 07:51:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="639615976"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="639615976"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.146.181])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 07:51:32 -0800
Date:   Tue, 24 Jan 2023 07:51:30 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] tools/testing/cxl: Remove cxl_test modulo math loading
 messages
Message-ID: <Y8/+giGil3Lmp+n1@aschofie-mobl2>
References: <20230119232937.533986-1-alison.schofield@intel.com>
 <63cf26b6cb40e_4a9a294e4@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63cf26b6cb40e_4a9a294e4@iweiny-mobl.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 23, 2023 at 04:30:46PM -0800, Ira Weiny wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Commit "cxl/acpi: Support CXL XOR Interleave Math (CXIMS)" added
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
> > 
> > The default option is for standard modulo arithmetic, so when the
> > interleave_arithmetic param is not present in sysfs, the cxl_test
> > module is using standard modulo arithmetic.
> 
> Is this correct?  I'm always unsure of myself with the module_param code
> but I believe the sysfs will always be there but the value would be
> "Modulo:0", wouldn't it?
> 
You are right. I made that statement based on some trial/error, and I
guess mostly error, because when I go back around to it now, it operates
just like you say. Thanks!

> > 
> > Fixes: f9db85bfec0d ("cxl/acpi: Support CXL XOR Interleave Math (CXIMS)")
> 
> I'm not sure this is the correct patch for the fixes.
> 
> Would it be?
> 
> Fixes: 7a7e6edfca85 ("tools/testing/cxl: Add XOR Math support to cxl_test") 

Yes. Thanks Ira.

I'll rev this more carefully, and also update the commit msg.
It should have said 'cxl_test module' not 'cxl_test modulo'.

Alison

> 
> Ira
> 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  tools/testing/cxl/test/cxl.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index 30ee680d38ff..ede84de69f59 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -1135,11 +1135,9 @@ static __init int cxl_test_init(void)
> >  	if (interleave_arithmetic == 1) {
> >  		cfmws_start = CFMWS_XOR_ARRAY_START;
> >  		cfmws_end = CFMWS_XOR_ARRAY_END;
> > -		dev_dbg(NULL, "cxl_test loading xor math option\n");
> >  	} else {
> >  		cfmws_start = CFMWS_MOD_ARRAY_START;
> >  		cfmws_end = CFMWS_MOD_ARRAY_END;
> > -		dev_dbg(NULL, "cxl_test loading modulo math option\n");
> >  	}
> >  
> >  	rc = populate_cedt();
> > @@ -1326,7 +1324,7 @@ static __exit void cxl_test_exit(void)
> >  	unregister_cxl_mock_ops(&cxl_mock_ops);
> >  }
> >  
> > -module_param(interleave_arithmetic, int, 0000);
> > +module_param(interleave_arithmetic, int, 0444);
> >  MODULE_PARM_DESC(interleave_arithmetic, "Modulo:0, XOR:1");
> >  module_init(cxl_test_init);
> >  module_exit(cxl_test_exit);
> > 
> > base-commit: 589c3357370a596ef7c99c00baca8ac799fce531
> > -- 
> > 2.37.3
> > 
> 
> 
