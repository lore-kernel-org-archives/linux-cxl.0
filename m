Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD16C54EAA
	for <linux-cxl@archiver.kernel.org>; Mon, 23 Jan 2023 23:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjAWX6C (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 18:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjAWX6B (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 18:58:01 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F182706
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 15:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674518279; x=1706054279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gz250PNFsi397qjZHgx21mh4GYu8f2d9s6Q07TFTl40=;
  b=KIMEz7gkLGrJnLTaIKlprsErU5E0EPuM4+DmSH8Pn8VV//gy2OOaD3cB
   r339Ws+9so6freiD+o8vGVeHinzf7YBvhgRV0n8T9UZbxkQkKz9mqiqPA
   0zZeKPvGeUb918wtxpNigDRzGPINVyBK+4wm8gLuPg8QbY2COIRrVaH8/
   bPXC1xSBs0dHBg0J/JLAhwclbCarPRE39pMRZMF3nZ8mJNqNWJUxzi1gM
   Hkh6ET010cJGsqcG0eabYLZ32uA4duWPW2lTWO2+dLRxbu1QKett5RwdZ
   utDpu5SaJFTS8/ONp9dhY5WOxatXiOkps/5TPJfpJW1uEwfa5vyFtXxED
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="324869193"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="324869193"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 15:57:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="835783242"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="835783242"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.2.84])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 15:57:38 -0800
Date:   Mon, 23 Jan 2023 15:57:37 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 6/6] tools/testing/cxl: Add a param to test poison
 injection limits
Message-ID: <Y88e8TauBr/5Z/lg@aschofie-mobl2>
References: <cover.1674101475.git.alison.schofield@intel.com>
 <25a3d2a144a9dcc8ce1da241a72917eb7d6ad3f2.1674101475.git.alison.schofield@intel.com>
 <20230123152831.000065e5@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123152831.000065e5@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 23, 2023 at 03:28:31PM +0000, Jonathan Cameron wrote:
> On Wed, 18 Jan 2023 21:00:21 -0800
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > CXL devices may report a maximum number of addresses that a device
> > allows to be poisoned using poison injection. When cxl_test creates
> > mock CXL memory devices, it uses MOCK_INJECT_DEV_MAX (8) for all
> > mocked memdevs.
> > 
> > Add a module parameter, param_inject_dev_max to module cxl_mock_mem
> > so that testers can set custom injection limits.
> > 
> > Example: Set MOCK_INJECT_DEV_MAX to 7
> > $ echo 7 > /sys/module/cxl_mock_mem/parameters/param_inject_dev_max
> > 
> > A simple usage model is to set it before running a test in order to
> > emulate a device's poison handling. Changing the max value in the
> > midst of inject, clear, and get poison flows, needs to be carefully
> > managed by the user.
> > 
> > For example, if the max is reduced after more than max errors are
> > injected, those errors will remain in the poison list and may need
> > to be cleared out even though a request to read the poison list will
> > not show more than max. The driver does not clear out the errors that
> > are over max when this parameter changes.
> > 
> > Suggested-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Seems sensible. I was thinking of doing something similar in the QEMU
> code as it's tedious injecting lots of errors just to make it overflow.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I did some basic testing of the non mock parts of this against my
> latest qemu branch.   Mostly works fine but I need to think a little
> about how to handle clears of part of a larger poison entry and potential
> to trigger list overflow on a clear.
> You avoid that problem here by only dealing with 64 byte entries which
> is sensible for the mocking driver.
> 

Thanks for the review Jonathan.
I did get feedback, in diff forum, to handle the changing of max_errors
more cleanly, ie. use module callback or make it a sysfs attribute.
I'll be revving for that.

Alison

> > ---
> >  tools/testing/cxl/test/mem.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index 14d74bfb3124..5b938283c1d7 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -17,6 +17,8 @@
> >  #define MOCK_INJECT_DEV_MAX 8
> >  #define MOCK_INJECT_TEST_MAX 128
> >  
> > +int param_inject_dev_max = MOCK_INJECT_DEV_MAX;
> > +
> >  static struct cxl_cel_entry mock_cel[] = {
> >  	{
> >  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_SUPPORTED_LOGS),
> > @@ -155,7 +157,7 @@ static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> >  			cpu_to_le64(SZ_256M / CXL_CAPACITY_MULTIPLIER),
> >  		.total_capacity =
> >  			cpu_to_le64(DEV_SIZE / CXL_CAPACITY_MULTIPLIER),
> > -		.inject_poison_limit = cpu_to_le16(MOCK_INJECT_DEV_MAX),
> > +		.inject_poison_limit = cpu_to_le16(param_inject_dev_max),
> >  	};
> >  
> >  	put_unaligned_le24(CXL_POISON_LIST_MAX, id.poison_list_max_mer);
> > @@ -589,7 +591,7 @@ static struct cxl_mbox_poison_payload_out
> >  	int nr_records = 0;
> >  	u64 dpa;
> >  
> > -	po = kzalloc(struct_size(po, record, MOCK_INJECT_DEV_MAX), GFP_KERNEL);
> > +	po = kzalloc(struct_size(po, record, param_inject_dev_max), GFP_KERNEL);
> >  	if (!po)
> >  		return NULL;
> >  
> > @@ -604,7 +606,7 @@ static struct cxl_mbox_poison_payload_out
> >  		po->record[nr_records].address = cpu_to_le64(dpa);
> >  		po->record[nr_records].length = cpu_to_le32(1);
> >  		nr_records++;
> > -		if (nr_records == MOCK_INJECT_DEV_MAX)
> > +		if (nr_records == param_inject_dev_max)
> >  			break;
> >  	}
> >  
> > @@ -638,7 +640,7 @@ static bool mock_poison_dev_max_injected(struct cxl_dev_state *cxlds)
> >  		if (mock_poison_list[i].cxlds == cxlds)
> >  			count++;
> >  	}
> > -	return (count >= MOCK_INJECT_DEV_MAX);
> > +	return (count >= param_inject_dev_max);
> >  }
> >  
> >  static bool mock_poison_add(struct cxl_dev_state *cxlds, u64 dpa)
> > @@ -909,6 +911,9 @@ static struct platform_driver cxl_mock_mem_driver = {
> >  	},
> >  };
> >  
> > +module_param(param_inject_dev_max, int, 0644);
> > +MODULE_PARM_DESC(param_inject_dev_max, "Maximum number of physical addresses that can be poisoned in the mock device. The default is 8. The cxl_test driver limit is 128 across all mock devices.");
> Perhaps: Maximum number of 64 byte blocks that can be poisoned...
> > +
> >  module_platform_driver(cxl_mock_mem_driver);
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_IMPORT_NS(CXL);
> 
