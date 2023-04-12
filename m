Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCC8C77B6E
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Apr 2023 18:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDLSI2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Apr 2023 14:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLSI1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Apr 2023 14:08:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54C4132
        for <linux-cxl@vger.kernel.org>; Wed, 12 Apr 2023 11:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681322906; x=1712858906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g0Cvya4zmVtgV1dw9fVvLDxRgbA/kmZbvbc9pkGQggM=;
  b=jfDP0EYAvj7CQHgTSScNUJ0E7iKAUWrAGCC23gwyk5NSJoACTQty+HWE
   qNtEG7g6jpRjxzDFkFS2rrvPcUtCvnrA+MMjRCLfUjiTCIw3eitrqDWjI
   Zyc8CkvZSMt6dkSZVQxJPuQpUc3uAY4CoWv6HABNUtfBx/2eDtx05b8hp
   m43vmOcwJbvGPk0FkR51vkMg8o0yN/3wQ/IDI/7gP2HIsuNsa4UZnJhhm
   y3ZnKoM+OVgI2/B9ecNo+y7bYjT4o5HClS4D+iBmhQ5Zn9eB73Eh5QTUd
   DbHIOqkSDG5i0Pf5reHZynBjZsIiIhqq+7/TRs9BS7mw2+gK2HNdOTl3H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="345770966"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="345770966"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 11:06:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="682578282"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="682578282"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.150.154])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 11:06:29 -0700
Date:   Wed, 12 Apr 2023 11:06:27 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v12 1/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Message-ID: <ZDbzI+wyYyZD13yW@aschofie-mobl2>
References: <cover.1681159309.git.alison.schofield@intel.com>
 <e87e1792e147a46f348019cc772e06f2ea19e970.1681159309.git.alison.schofield@intel.com>
 <64360dcc59cb0_417e294de@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64360dcc59cb0_417e294de@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Apr 11, 2023 at 06:47:56PM -0700, Dan Williams wrote:

responding to the non-deprecate-related feedback...

> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 

snip

> > +
> > +int cxl_poison_state_init(struct cxl_dev_state *cxlds)
> > +{
> > +	if (!test_bit(CXL_MEM_COMMAND_ID_GET_POISON, cxlds->enabled_cmds))
> > +		return 0;
> > +
> > +	cxlds->poison.list_out = devm_kzalloc(cxlds->dev, cxlds->payload_size,
> > +					      GFP_KERNEL);
> 
> Given the payload can be multiple pages in size use kvmalloc() like
> cxl_mem_alloc_event_buf().

Got it, thanks.

> 
> > +	if (!cxlds->poison.list_out)
> > +		return -ENOMEM;
> > +
> > +	mutex_init(&cxlds->poison.lock);
> > +	return 0;
> > +}

> > +struct cxl_mbox_poison_in {
> > +	__le64 offset;
> > +	__le64 length;
> > +} __packed;
> > +
> > +struct cxl_mbox_poison_out {
> > +	u8 flags;
> > +	u8 rsvd1;
> > +	__le64 overflow_t;
> 
> I was wondering what the "_t" meant, I always read that as "type". Perhaps
> "_ts" or even just spell out "_timestamp".
>

Sure, picking overflow_ts


> Aside from the minor fixups and reworking the enumeration mechanism per
> above, this looks good to me.
