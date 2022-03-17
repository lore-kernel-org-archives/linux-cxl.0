Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CF5C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Mar 2022 18:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbiCQSa0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Mar 2022 14:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiCQSaZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Mar 2022 14:30:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32416E9964
        for <linux-cxl@vger.kernel.org>; Thu, 17 Mar 2022 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647541748; x=1679077748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fvgjqyQd2GV8L8SNf/rUD2wozc3wXS513JcOBjkiO9s=;
  b=Elcn02UhI3cCJ3idV1zw2rvjGgSwPcI/qUvO7bfIEtFELT4hPnMyIQhZ
   s+6XQZ2Cs7hbamO4GqxO50y96FTkZ/64CFWdfgU1rpmJ15d9G8Wrz/KNa
   6/GiDkn2ntjKX0woj98Dhw1UKskmTnv7APPJg5f1STOYUfN/Yq6H+uuIm
   gBySKGFSTr8bz/d6b0ocASE+o89e58R4dudn/SmFnD7mzx239QKTw1ftA
   LX/rrzdYgMA9QAerzmty24Ccb0bFdYyhVMync3bomI+5694zR5Cfdcuo3
   QbcuM3MrhiCrUI4UXizVFnOnHDQibGjfDxjKrTjNo/Zf/F0O4YEAqw4s/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="256677684"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="256677684"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 11:29:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="783937806"
Received: from dshkut-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.229])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 11:29:07 -0700
Date:   Thu, 17 Mar 2022 11:29:00 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Krzysztof Zach <krzysztof.zach@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Subject: Re: [PATCH v2 4/6] cxl/pci: Make cxl_dvsec_ranges() failure not
 fatal to cxl_pci
Message-ID: <20220317182900.3dh6xdmrbqiuqzfl@intel.com>
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164730735869.3806189.4032428192652531946.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220317175228.wpzot2nu4snc6bz6@intel.com>
 <CAPcyv4gyaLun3xeo+cp-KVedR1RrSErH9qSyJ=dpL0fYT+Dvww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gyaLun3xeo+cp-KVedR1RrSErH9qSyJ=dpL0fYT+Dvww@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-03-17 11:20:48, Dan Williams wrote:
> On Thu, Mar 17, 2022 at 10:52 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 22-03-14 18:22:38, Dan Williams wrote:
> > > cxl_dvsec_ranges(), the helper for enumerating the presence of an active
> > > legacy CXL.mem configuration on a CXL 2.0 Memory Expander, is not fatal
> > > for cxl_pci because there is still value to enable mailbox operations
> > > even if CXL.mem operation is disabled. Recall that the reason cxl_pci
> > > does this initialization and not cxl_mem is to preserve the useful
> > > property (for unit testing) that cxl_mem is cxl_memdev + mmio generic,
> > > and does not require access to a 'struct pci_dev' to issue config
> > > cycles.
> > >
> > > Update 'struct cxl_endpoint_dvsec_info' to carry either a positive
> > > number of non-zero size legacy CXL DVSEC ranges, or the negative error
> > > code from __cxl_dvsec_ranges() in its @ranges member.
> > >
> > > Reported-by: Krzysztof Zach <krzysztof.zach@intel.com>
> > > Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  drivers/cxl/pci.c |   27 ++++++++++++++++++---------
> > >  1 file changed, 18 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index 257cf735505d..994c79bf6afd 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -463,13 +463,18 @@ static int wait_for_media_ready(struct cxl_dev_state *cxlds)
> > >       return 0;
> > >  }
> > >
> > > -static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
> > > +/*
> > > + * Return positive number of non-zero ranges on success and a negative
> > > + * error code on failure. The cxl_mem driver depends on ranges == 0 to
> > > + * init HDM operation.
> > > + */
> >
> > It shouldn't depend on 0 ranges, it depends on ranges matching existing HDM
> > decoder ranges. I took a shortcut by just checking global enable originally
> > because we didn't yet have code to enumerate decoders (anything else would be a
> > crazy BIOS bug that's probably not worth working around).
> 
> Hmm, I don't see that as a shortcut. If global enable is set then
> there is no requirement that CXL DVSEC matches the HDM decoder ranges,
> if global enable is not set then the HDM decoder ranges are not in
> effect.

It's true that there is no requirement that the DVSEC matches HDM decoder
ranges, except as you point out before it's going against spec recommendation.

> 
> This is what the new comment in cxl_hdm_decode_init() is trying to
> clarify. My proposal is that Linux ignores the recommendation which I
> think is trying to accommodate legacy CXL 1.1 software stacks which
> Linux never had.
> 

Okay, that's fine.

>         /*
>          * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
>          * [High,Low] when HDM operation is enabled the range register values
>          * are ignored by the device, but the spec also recommends matching the
>          * DVSEC Range 1,2 to HDM Decoder Range 0,1 so, non-zero info->ranges
>          * are expected.
>          */

Maybe explicitly say the driver does not attempt to check this recommendation.
