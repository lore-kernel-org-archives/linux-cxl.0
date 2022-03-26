Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757EAC433F5
	for <linux-cxl@archiver.kernel.org>; Sat, 26 Mar 2022 00:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiCZAZ1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Mar 2022 20:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiCZAZ0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Mar 2022 20:25:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAB0205D5
        for <linux-cxl@vger.kernel.org>; Fri, 25 Mar 2022 17:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648254228; x=1679790228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ilo81GJ2CfDiKqwNEDxsfgfpv27N2+uIC8fL3iH4U5g=;
  b=bYTaDYaQW27KlapawcwsdQWpXyt3bw1yz0D3GEThGmXIK7k4QGFuOcB0
   S2suZX9NqiCQzqwxClZLVzmCErtE7nXrHjfFXSNudfQSu1YhHyPNQvWLK
   yqsaVfZqUbM29qzdpihdeq4CTKlSwiVqSVog2YLGWVqq40k6pNS5v+1IM
   jTUPs9KhtozRbpMiY4jNKoie3O34dFaexrJiE/KcVXDtQBNZapo4Ni+gf
   +STzYc4ABXX9UM6ssEnvTJbqSlr9x3mLdujglmG/5FWIz8AKmLugkEBHa
   yH1qm0N5bRp14v6I25valJHVuZnD1vayJch3qmUV2nTDD+qXmXy6kTiaS
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="246228126"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="246228126"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 17:23:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="501942651"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 17:23:48 -0700
Date:   Fri, 25 Mar 2022 17:26:21 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 5/9] cxl/mbox: Remove dependency on cxl_mem_command
 for a debug msg
Message-ID: <20220326002621.GB1153598@alison-desk>
References: <20220324011126.1144504-1-alison.schofield@intel.com>
 <20220324011126.1144504-6-alison.schofield@intel.com>
 <20220325105600.0000529a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325105600.0000529a@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Mar 25, 2022 at 10:56:00AM +0000, Jonathan Cameron wrote:
> On Wed, 23 Mar 2022 18:11:22 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > In preparation for removing access to struct cxl_mem_command,
> > change this debug message to use cxl_mbox_cmd fields instead.
> > Retrieve the pretty command name from cxl_mbox_cmd using a new
> > opcode to command name helper.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/mbox.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 205e671307c3..d6d582baa1ee 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -127,6 +127,17 @@ static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
> >  	return NULL;
> >  }
> >  
> > +static const char *cxl_mem_opcode_to_name(u16 opcode)
> > +{
> > +	struct cxl_mem_command *c;
> > +
> > +	c = cxl_mem_find_command(opcode);
> > +	if (c)
> > +		return cxl_command_names[c->info.id].name;
> 
> nitpick, but i'd prefer the error path out of line.
> 	if (!c)
> 		return NULL;
> 
> 	return cxl_command_names[c->info.id].name;

Got it, thanks!

> 
> Otherwise
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
