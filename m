Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0066AC433EF
	for <linux-cxl@archiver.kernel.org>; Sat, 26 Mar 2022 00:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiCZAaE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Mar 2022 20:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiCZAaD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Mar 2022 20:30:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5A0AF1C8
        for <linux-cxl@vger.kernel.org>; Fri, 25 Mar 2022 17:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648254508; x=1679790508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5aKrMWRBVw/RdlcPEdpECBN/G7XkPnLscykADRjPQQQ=;
  b=kshYyoPMj1tvmOaTI0Yj5kotEGFLJAci9ZJaFrDor52jOex8lNbOir36
   OI65EEEjw2QMNBLc/4q5nKV7c8GDylTZ1kDtPgAclqlTHvKYA5/g0MV4G
   2pKSRbBMnFFUcGYprA95gOwpK/J/5/QKaAjf9d15WvtzqlqcfecWr2Tdc
   XEXkI6A1GGVu13D1ZFDoldWYTbQt+S0U5b2cIMfw1hTwKeBO2tn5DDdTw
   l4apNnZcTwU7sKxRc/nl5iARfTUAH1OGfxoa4G4IRgh1NWOo9Ge+xfVj/
   btGiSEZKTprAgd7YDxtdW/MMUXpVimq++mVAPm50WT2ETxWawkqcCwBWB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="238678158"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="238678158"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 17:28:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="501943496"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 17:28:27 -0700
Date:   Fri, 25 Mar 2022 17:31:01 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 8/9] cxl/mbox: Block immediate mode in
 SET_PARTITION_INFO command
Message-ID: <20220326003101.GA1153706@alison-desk>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
 <20220324011126.1144504-9-alison.schofield@intel.com>
 <20220325111816.00005cf8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325111816.00005cf8@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Mar 25, 2022 at 11:18:16AM +0000, Jonathan Cameron wrote:
> On Wed, 23 Mar 2022 18:11:25 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > User space may send the SET_PARTITION_INFO mailbox command using
> > the IOCTL interface. Inspect the input payload and fail if the
> > immediate flag is set.
> > 
> > This is the first instance of the driver inspecting an input payload
> > from user space. Assume there will be more such cases and implement
> > with an extensible helper.
> > 
> > In order for the kernel to react to an immediate partition change it
> > needs to assert that the change will not affect any active decode. At
> > a minimum this requires validating that the device is using HDM
> > decoders instead of the CXL DVSEC for decode, and that none of the
> > active HDM decoders are affected by the partition change. For now,
> > just fail until that support arrives.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Follow on comment from one in earlier patch on the use of a goto
> to skip the input payload case... Otherwise,
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
snip
> >  static int cxl_to_mbox_cmd(struct cxl_dev_state *cxlds,
> >  			   struct cxl_mbox_cmd *mbox, u16 opcode,
> >  			   size_t in_size, size_t out_size, u64 in_payload)
> > @@ -235,6 +269,13 @@ static int cxl_to_mbox_cmd(struct cxl_dev_state *cxlds,
> >  	if (!mbox->payload_in)
> >  		return PTR_ERR(mbox->payload_in);
> >  
> > +	if (!cxl_payload_from_user_allowed(opcode, mbox->payload_in)) {
> > +		dev_dbg(cxlds->dev, "%s: input payload not allowed\n",
> > +			cxl_mem_opcode_to_name(opcode));
> > +		kvfree(mbox->payload_in);
> > +		return -EBUSY;
> > +	}
> 
> Ah. This is making the block before the label larger. I'm still doubtful that
> the code is more readable with the goto though rather than just having
> it indented one more tab.
> 
You remembered my goto from a few patches back and still don't
appreciate it ;)
Will redo.
Thanks for the reviews Jonathan!

