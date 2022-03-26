Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B362BC433EF
	for <linux-cxl@archiver.kernel.org>; Sat, 26 Mar 2022 00:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiCZAYj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Mar 2022 20:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiCZAYh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Mar 2022 20:24:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5583DBAE
        for <linux-cxl@vger.kernel.org>; Fri, 25 Mar 2022 17:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648254182; x=1679790182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NYQ7CHSGN0CbkvDqjJtuzecrd994ii6zweCNXmSCusw=;
  b=mcKHGX9QehEaEuBfCI0Q27PfO+Wi3e5gEnLsIOqOr3rTW6gSNq3tEM0h
   bTBpQrbLZ/ilKQnsUot0lewbjTQ4QiJ3h/9PU1mYjitZV9CbaElZKFwba
   ChMWKbj9taHrdyBM1RucTerqGQR8Bnpo3KhGdc92EWNU6NJ9mtoVzFCF3
   h/wImuiR6kTpB/TJTaJZI0TqzpIvWdyMjQQN9wh1rS1lQz2whlitgDvWP
   XIJkekE6NG9F6g8Z9CHn99VtgHzwQfINdiJNsYjz1W9B1a8NlzCIF/00p
   vDqXbYhHZg6nKsoS9h2DZXUy2bhW5Ihptq2G7kjeqPuLV/9NW2u/Cae/o
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="256314953"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="256314953"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 17:23:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="516713176"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 17:23:01 -0700
Date:   Fri, 25 Mar 2022 17:25:35 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 6/9] cxl/mbox: Make handle_mailbox_cmd_from_user() use
 a mbox param
Message-ID: <20220326002535.GA1153598@alison-desk>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
 <20220324011126.1144504-7-alison.schofield@intel.com>
 <20220325110443.0000139f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325110443.0000139f@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Mar 25, 2022 at 11:04:43AM +0000, Jonathan Cameron wrote:
> On Wed, 23 Mar 2022 18:11:23 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Previously, handle_mailbox_cmd_from_user(), constructed the mailbox
> > command and dispatched it to the hardware. The construction work
> > has moved to the validation path.
> > 
> > handle_mailbox_cmd_from_user() now expects a fully validated
> > mbox param. Make it's caller, cxl_send_cmd(), deliver it. Update
> > the comments and dereferencing of the new mbox parameter.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> One suggestion below.
>
snip

> > @@ -474,22 +466,22 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
> >  	 * to userspace. While the payload may have written more output than
> >  	 * this it will have to be ignored.
> >  	 */
> > -	if (mbox_cmd.size_out) {
> > -		dev_WARN_ONCE(dev, mbox_cmd.size_out > *size_out,
> > +	if (mbox_cmd->size_out) {
> > +		dev_WARN_ONCE(dev, mbox_cmd->size_out > *size_out,
> >  			      "Invalid return size\n");
> >  		if (copy_to_user(u64_to_user_ptr(out_payload),
> > -				 mbox_cmd.payload_out, mbox_cmd.size_out)) {
> > +				 mbox_cmd->payload_out, mbox_cmd->size_out)) {
> >  			rc = -EFAULT;
> >  			goto out;
> >  		}
> >  	}
> >  
> > -	*size_out = mbox_cmd.size_out;
> > -	*retval = mbox_cmd.return_code;
> > +	*size_out = mbox_cmd->size_out;
> > +	*retval = mbox_cmd->return_code;
> >  
> >  out:
> > -	kvfree(mbox_cmd.payload_in);
> > -	kvfree(mbox_cmd.payload_out);
> > +	kvfree(mbox_cmd->payload_in);
> > +	kvfree(mbox_cmd->payload_out);
> 
> As this function is no longer responsible for allocating these, I'd be inclined
> to pull the frees out to the caller.
> 
> That will make things less fragile to any additional code that might in future
> occur between
> 
> cxl_validate_cmd_from_user() and handle_mailbox_cmd_from_user()
> 
> >  	return rc;
> >  }

Yeah, not so graceful there. I'll pull them out to the caller, but the
caller isn't the place were they were alloc'd. It goes like this:

cxl_send_cmd() {
	copy_from_user()
	cxl_validate_cmd_from_user() - does the allocs now
	handle_mailbox_from_user() - does the frees now
	? Move the frees here ?	
	copy_to_user()
}

I'll move. See what you think in next version.

> >  
> > @@ -511,9 +503,8 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
> >  	if (rc)
> >  		return rc;
> >  
> > -	rc = handle_mailbox_cmd_from_user(cxlds, &c, send.in.payload,
> > -					  send.out.payload, &send.out.size,
> > -					  &send.retval);
> > +	rc = handle_mailbox_cmd_from_user(cxlds, &mbox_cmd, send.out.payload,
> > +					  &send.out.size, &send.retval);
> >  	if (rc)
> >  		return rc;
> >  
> 
