Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE907C433EF
	for <linux-cxl@archiver.kernel.org>; Sat, 18 Jun 2022 01:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbiFRBgO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Jun 2022 21:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiFRBgN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Jun 2022 21:36:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25D52EA20;
        Fri, 17 Jun 2022 18:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655516172; x=1687052172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=onY+nCZRWkua/63LAwmpFnBbwjRkTru5ODMAf4ATfe8=;
  b=PaZ+53fzYRSrj+WqI/RVaAFxTvABL/URCyjVgCn/cgxuiKsTBHzKkxe8
   WrR6oqFb3PaRlpW/f7BPgLNOaHASzG5z6NhYTX4jKHZKVzh/ttkQx6vGV
   UAfYbyH8H6dBQwpAFSbsBP3ehDZdXD4px59J8jZJAD/6XyM5lyO00etRR
   lEZStxmlOnPsoLfp+V2MWaPVkF1bqXWiGR7jXff7NjTULQnH0UahiBmzB
   IF4S1ufz0X/MjTu6qx8OjA3ilAdi9qTbWgFosKwTK1qrUJ9fIje6opzG+
   S/8rYsp6HiEDWUkvy1k8PC5PYcLotGCze3B4Ypy9A/oF52qu24loOLdNX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="365943806"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="365943806"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 18:36:12 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="590337607"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 18:36:12 -0700
Date:   Fri, 17 Jun 2022 18:35:49 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/core: Add sysfs attribute get_poison for list
 retrieval
Message-ID: <20220618013549.GA1534210@alison-desk>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <57644934bb7af8e1c692735f53c2c415a1ba16d1.1655250669.git.alison.schofield@intel.com>
 <62accb0345de2_81c5e29454@dwillia2-xfh.notmuch>
 <20220618002121.GA1533961@alison-desk>
 <62ad25a4146fd_899b32948c@dwillia2-xfh.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ad25a4146fd_899b32948c@dwillia2-xfh.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jun 17, 2022 at 06:08:52PM -0700, Dan Williams wrote:
> Alison Schofield wrote:
> > On Fri, Jun 17, 2022 at 11:42:11AM -0700, Dan Williams wrote:
> > > alison.schofield@ wrote:
> > > > From: Alison Schofield <alison.schofield@intel.com>
> > > > 
> > > > The sysfs attribute, get_poison, allows user space to request the
> > > > retrieval of a CXL devices poison list for its persistent memory.
> > > 
> > > If the device supports get poison list for volatile memory, just grab
> > > that too. With the "to be released soon" region patches userspace can
> > > trivially translate DPA addresses to media type.
> > > 
> > 
> > Dan,
> > 
> > The only way I know to discover if the device supports poison list for
> > volatile is to do the get_poison_list on the volatile range and see
> > what happens. Am I missing a capability setting somewhere?
> 
> If someone executes "echo 1 > trace_poison_list" I expect that the
> driver does:
> 
> get_poison_list(volatile_range);
> get_poison_list(pmem_range);
> 
> ...and if scanning the volatile partition ends in error then that just
> means no error records appear. When the error is "Invalid Physical
> Address" the driver can just remember that's a permanent error and never
> try again. So it's more like:
> 
> if (volatile_range_valid) {
> 	if (get_poison_list(volatile_range) == INVALID_PHYS_ADDR)
> 		volatile_range_valid = false;
> }
> get_poison_list(pmem_range);
> 
> ...but that's probably overkill since get_poison_list() is cheap. Just
> treat it like the zero error records case.

Got it!

> 
> In the to be released region provisioning patches there is a DPA
> resource tree partitioned by DPA mode type, so the poison list code
> probably wants to do something like:
> 
> down_read(&cxl_dpa_rwsem);
> for (p = cxlds->dpa_res.child; p; p = p->sibling)
> 	get_poison_list(p->start, resource_size(p));
> up_read(&cxl_dpa_rwsem);

Great ending to the week! This is going to make collecting the
poison per region much simpler than I was imagining :)



