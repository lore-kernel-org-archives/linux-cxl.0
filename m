Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0E6C433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  5 Jan 2022 00:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbiAEAyB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 4 Jan 2022 19:54:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:59240 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233102AbiAEAyA (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 4 Jan 2022 19:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641344040; x=1672880040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NAuFMlIO41XSEaN9aYn/3LwnQjhuj+zLUTd1ZJ/6rH0=;
  b=ZFgY4/e8jEXMh5j5U9HgsYGByd93uOJZsnzqA08oM55WWkaUJF+4gZ8z
   ZPGNKKzZ3IokunRub88kzkTytw2KfGcDbrvh3Jw8hPD6Pv1jHPcVwb7lb
   sTAlCvG+k+1Vyljo1QjdL6ifa+7BqCUXdtFfO4ogTrd5tRuwSwt8SWlGy
   atWG73UC/6TWzKIDjdnsaQmdCew9+lKT+0P0RtJtZUst3MTj5RdCD2Y2s
   Q1kibNW3zyVpV+gpEX2Pl/CEII7v3RztzOd1xg6irvNClmru3HPiRk3zv
   5dyuDrfb8n5hQjd/A46KdoztLvJcIWtw45mwAEO3I1IuJ3qDBT81g36Os
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241158438"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="241158438"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 16:54:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="526281112"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 16:54:00 -0800
Date:   Tue, 4 Jan 2022 16:59:16 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/mbox: Do not allow immediate mode in
 SET_PARTITION_INFO
Message-ID: <20220105005916.GA790377@alison-desk>
References: <20220103202100.784194-1-alison.schofield@intel.com>
 <20220104232134.y7j5rs4ljizkl462@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104232134.y7j5rs4ljizkl462@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Thanks for the review Ben...

On Tue, Jan 04, 2022 at 03:21:34PM -0800, Ben Widawsky wrote:
> On 22-01-03 12:21:00, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > User space may send the SET_PARTITION_INFO mailbox command using
> > the IOCTL interface. Inspect the input payload and fail if the
> > immediate flag is set.
> > 
> > This is the first instance of the driver inspecting an input payload
> > from user space. Assume there will be more such cases and implement
> > with an extensible helper.
> 
> Not sure if it's useful, but this was implemented at some point:
> https://lore.kernel.org/linux-cxl/20210210000259.635748-8-ben.widawsky@intel.com/

Thanks. Looking.

> 
snip

> > @@ -405,6 +440,14 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
> >  		}
> >  	}
> >  
> > +	if (!cxl_payload_from_user_allowed(mbox_cmd.opcode,
> > +					   mbox_cmd.payload_in)) {
> > +		dev_dbg(dev, "%s: input payload not allowed\n",
> > +			cxl_command_names[cmd->info.id].name);
> > +		rc = -EINVAL;
> > +		goto out;
> > +	}
> > +
> 
> Perhaps foolishly, the kdocs for handle_mailbox_cmd_from_user() documents the
> error conditions. Would you mind adding EINVAL?

I'm going to try to mv the allowable check, so this will go away.

> 
> Also, cxl_validate_cmd_from_user() was supposed to handle this kind of stuff.
> All validation from user commands should spawn from that. Is there some reason
> this one is different?

The existing cxl_validate_cmd_from_user() happens before we copy the
payload from user - so this payload check didn't fit in there.
Let me look at reorganizing a bit so validating the cmd and it's payload
can both spawn from cxl_validate_cmd_from_user().

> 

snip

>
> > +#define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
> > +
> 
> I think these defines belong in cxl.h
> 
It seems this is OK in cxl.h where other CXL spec defines now live.

> >  /**
> >   * struct cxl_mem_command - Driver representation of a memory device command
> >   * @info: Command information as it exists for the UAPI
> > 
> > base-commit: 53989fad1286e652ea3655ae3367ba698da8d2ff
> > -- 
> > 2.31.1
> > 
