Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FE3C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Mar 2022 23:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiCZABC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Mar 2022 20:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiCZABB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Mar 2022 20:01:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9035B3D0
        for <linux-cxl@vger.kernel.org>; Fri, 25 Mar 2022 16:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648252765; x=1679788765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+aa9NKZ7SYMZ243A3RqL+DfDUze2Qp/Eki+LG3QPkKo=;
  b=Y8waeZ71BvEluAj9V32X7+7I0IiwhoT9Q73xY4D+yNA+xMEb1kbrNQfp
   eEUu7QmXeFAogS/3Zt3tm1fJRO7l1AHczFimCkJHE1bVfvtlAcfQQFY43
   WSdS1QZHNMiE5l2cHdfspa0VTMwiz3irshNLJd+EhCoPwR4Sf/eN+FWsg
   jh/lj9+IfnywLCp91v88XezYzKjwaTVjFaBNBeLAHqFVTiha/o4qitDCQ
   SiXlZPUaFxMsVv7EgB1wwknLTmDD+LBZfg5TtLHlbjHydnGmBoJc289A/
   h6eHx3Dxiz6ZZCKvKyCNPq38jIF3LF+vO400bpDgttIpZJiTeubnvh1aC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="246225631"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="246225631"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 16:59:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="501937064"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 16:59:25 -0700
Date:   Fri, 25 Mar 2022 17:01:58 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 1/9] cxl/mbox: Move cxl_mem_command construction to
 helper funcs
Message-ID: <20220326000158.GA1153435@alison-desk>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
 <20220324011126.1144504-2-alison.schofield@intel.com>
 <20220325102724.0000144d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325102724.0000144d@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Mar 25, 2022 at 10:27:24AM +0000, Jonathan Cameron wrote:
> On Wed, 23 Mar 2022 18:11:18 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Sanitizing and constructing a cxl_mem_command from a userspace
> > command is part of the validation process prior to submitting
> > the command to a CXL device. Move this work to helper functions:
> > cxl_to_mem_cmd(), cxl_to_mem_cmd_raw().
> > 
> > This declutters cxl_validate_cmd_from_user() in preparation for
> > adding new validation steps.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> A few trivial comments inline.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Thanks for the review Jonathan -

> > ---

snip
> >  
> > +static int cxl_to_mem_cmd(struct cxl_dev_state *cxlds,
> > +			  const struct cxl_send_command *send_cmd,
> > +			  struct cxl_mem_command *mem_cmd)
> > +{
> > +	const struct cxl_command_info *info;
> > +	struct cxl_mem_command *c;
> > +
> > +	if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
> > +		return -EINVAL;
> > +
> > +	if (send_cmd->rsvd)
> > +		return -EINVAL;
> > +
> > +	if (send_cmd->in.rsvd || send_cmd->out.rsvd)
> > +		return -EINVAL;
> > +
> > +	/* Convert user's command into the internal representation */
> 
> Not clear which chunk of code this applies to.  Seems like we
> are just getting some addresses here (obviously that applies to original
> code as well) Perhaps move down to where you fill in mem_cmd?

The comment above applies to the line that immediately follow.
ie. senc_cmd->id indexes into the command array.

> 
> > +	c = &cxl_mem_commands[send_cmd->id];
> > +	info = &c->info;
> 
> I don't mind that much either way, but you could do these at
> declaration of the local variables above, before doing the sanity checks.
> 

I err'd on moving things as much 'as is' as possible to keep the
patches easier to review. I like your suggestion and will do it.
(Please like it when you see it in the next version ;))

> > +
snip

> > -
> > -	return 0;
> > +	return rc;
> I haven't read on yet so I'll assume there is more coming in this function as otherwise
> you could just return directly in the two if / else paths.

Yeah, you are seeing some foreshadowing, and you've noted similar in
other patches. I'll clean that up.

Thanks,
Alison

> 
> Thanks,
> 
> Jonathan
> 
> >  }
> >  
> >  int cxl_query_cmd(struct cxl_memdev *cxlmd,
> 
