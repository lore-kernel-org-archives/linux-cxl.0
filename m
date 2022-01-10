Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4D7C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Jan 2022 02:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbiAJCIe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 9 Jan 2022 21:08:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:43692 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238174AbiAJCId (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 9 Jan 2022 21:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641780513; x=1673316513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fhnRMLo/QilbbIsk9kE7uOTlXpRYWy5r+8MKRY1tuNE=;
  b=H2pxUb+laDfLhUbPkQFDdaoWXnu6ZHzxBbORvU8WavMFY7CYYoY+tznr
   92Ux+/rE7/0ab73yBUuKIZva+13NayMnGUkylGLtz1wDx40RER83H52c3
   QLRPjGH3yZgpb5VWEy4cKtVjOfaAkiQe8bhsNI4Bv4sw1+kMKNUVsTf51
   gAG4FkI7VMth6A4UIn4s0vVw0PkMbz5eCBq8nJ+XP9gK4xZz1wKrzcVUS
   Tf/wa0lW+vOPvcBamiFiGYiv9PVIyxoGMpdnjwxY4P9r7buBdgi9T3EO9
   Olv8DPVQT2gwSU2ZJr0FIKZUHIkzXcMJU719ZDDrK+3/RhmPNW/5SJQsW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="241948512"
X-IronPort-AV: E=Sophos;i="5.88,275,1635231600"; 
   d="scan'208";a="241948512"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 18:08:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,275,1635231600"; 
   d="scan'208";a="528087717"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2022 18:08:32 -0800
Date:   Sun, 9 Jan 2022 18:13:38 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-cxl@vger.kernel.org
Subject: Re: [ndctl PATCH 5/7] libcxl: add interfaces for SET_PARTITION_INFO
 mailbox command
Message-ID: <20220110021338.GA813196@alison-desk>
References: <cover.1641233076.git.alison.schofield@intel.com>
 <fa45e95e5d28981b4ec41db65aab82c103bff0c3.1641233076.git.alison.schofield@intel.com>
 <20220106205302.GF178135@iweiny-DESK2.sc.intel.com>
 <20220108015121.GA804835@alison-desk>
 <CAPcyv4jdt-936WpqNQv7hR2oPSFHbqsCDs40JgBJBaxZ-tHPJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jdt-936WpqNQv7hR2oPSFHbqsCDs40JgBJBaxZ-tHPJw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jan 07, 2022 at 06:27:40PM -0800, Dan Williams wrote:
> On Fri, Jan 7, 2022 at 5:46 PM Alison Schofield
> <alison.schofield@intel.com> wrote:
> >
> > On Thu, Jan 06, 2022 at 12:53:02PM -0800, Ira Weiny wrote:
> > > On Mon, Jan 03, 2022 at 12:16:16PM -0800, Schofield, Alison wrote:
> > > > From: Alison Schofield <alison.schofield@intel.com>
> > > >
> > > > Add APIs to allocate and send a SET_PARTITION_INFO mailbox command.
> > > >
> > > > +   le64 volatile_capacity;
> > > > +   u8 flags;
> > > > +} __attribute__((packed));
> > > > +
> > > > +/* CXL 2.0 8.2.9.5.2 Set Partition Info */
> > > > +#define CXL_CMD_SET_PARTITION_INFO_NO_FLAG                         (0)
> > > > +#define CXL_CMD_SET_PARTITION_INFO_IMMEDIATE_FLAG                  (1)
> > >
> > > BIT(0) and BIT(1)?
> > >
> > > I can't remember which bit is the immediate flag.
> > >
> > Immediate flag is BIT(0).
> > Seemed awkward/overkill to use bit macro -
> > +#define CXL_CMD_SET_PARTITION_INFO_NO_FLAG                             (0)
> > +#define CXL_CMD_SET_PARTITION_INFO_IMMEDIATE_FLAG                      BIT(1)
> >
> > I just added api to use this so you'll see it in action in v2
> > of this patchset and can comment again.
> 
> Why is a "no flag" definition needed? Isn't that just "!IMMEDIATE"
>
You are right. The no flag set case is !IMMEDIATE.

>Also BIT(1) == 0x2, so that should be BIT(0), right?
Yes IMMEDIATE FLAG IS BIT(0). 

This chatter is related to using something more descriptive that '0'
for !IMMEDIATE when the cxl command makes the call to the api. (Patch 7)
I added a new accessor in v2 that returns the bit.


