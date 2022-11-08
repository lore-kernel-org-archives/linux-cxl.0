Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0B9C4332F
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Nov 2022 16:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbiKHQEk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 11:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbiKHQEi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 11:04:38 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB0524090
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 08:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667923477; x=1699459477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TUjGvD9RQdG7kZzMsY9tj/iCoE8nnMBkLtziVc6jl8E=;
  b=Xdwf9r41iwHW59ASD4nk9zZo3C2+Wr4gbUSpd7nUSH5rqpK0fiRVocfa
   ebAutaYLLnOvYPbgGmvKfsa/pTgkFGQtjzPqjJFhLLbFeVI0T1d4JXJVS
   jmHW0kbVJO+KFypwE6kbIIHvQVMDdq54obV+8igxnT4wqiNg0jH+qBC2d
   zprtk/qBONwBi1xsptO4ck3FEWvCkT0Wv1/uXkAwO5qVTP93OJxPiK60L
   4sTeZDw4b42uHQ6JD70XzHEJ5EOoMBkiocipUCQ+GWmmvT6ofCwmxxfGZ
   uJ3cnzCR0Zs2OR7w+x3sYMMJtJBaAQdH02TIon2iD8hva6WvQom2jg/KC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="372876622"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="372876622"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 08:04:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="881562720"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="881562720"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.11.119])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 08:04:00 -0800
Date:   Tue, 8 Nov 2022 08:03:59 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     vishal.l.verma@intel.com, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev
Subject: Re: [ndctl PATCH 13/15] cxl/region: Default to memdev mode for
 create with no arguments
Message-ID: <Y2p979yA5W6wklee@aschofie-mobl2>
References: <166777840496.1238089.5601286140872803173.stgit@dwillia2-xfh.jf.intel.com>
 <166777848122.1238089.2150948506074701593.stgit@dwillia2-xfh.jf.intel.com>
 <Y2lsYawI3eQayact@aschofie-mobl2>
 <6369995b14772_18432294f0@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6369995b14772_18432294f0@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Nov 07, 2022 at 03:48:43PM -0800, Dan Williams wrote:
> Alison Schofield wrote:
> > On Sun, Nov 06, 2022 at 03:48:01PM -0800, Dan Williams wrote:
> > > Allow for:
> > > 
> > >    cxl create-region -d decoderX.Y
> > > 
> > > ...to assume (-m -w $(count of memdevs beneath decoderX.Y))
> > 
> > I'm not understanding what the change is here. Poked around a bit
> > and still didn't get it. Help!
> > 
> > Leaving out the -m leads to this:
> > $ cxl create-region -d decoder3.3 mem0 mem1
> > cxl region: parse_create_options: must specify option for target object types (-m)
> > cxl region: cmd_create_region: created 0 regions
> > 
> > Leaving out the the -m and the memdevs fails because the memdev order is
> > not correct. 
> > $ cxl create-region -d decoder3.3
> > cxl region: create_region: region5: failed to set target0 to mem1
> > cxl region: cmd_create_region: created 0 regions
> > 
> > This still works, where I give the -m and the correct order of memdevs.
> > cxl create-region -m -d decoder3.3 mem0 mem1
> 
> Oh, I was not expecting the lack of automatic memdev sorting to rear its
> head so quickly, and thought that "cxl list" order was good enough for
> most configurations.

I wasn't clear on what was being advertised as supported with this
change. I didn't read this as an announcement of automatic region
creation, but it seemed you were hinting at it.

> 
> Can provide more details on your configuration in this case? If this is
> current cxl_test then I already do not expect it to work with anything
> but decoder3.4 since the other decoders have more complicated ordering
> constraints.
> 
> I.e. your:
> 
> cxl create-region -d decoder3.3
> 
> ...worked as expected in that it found some memdevs to attempt to create
> the region, but you got unlucky in the sense that the default order that
> 'cxl list' returns memdevs was incompatible with creating a region.

Pretty much exactly as you say above. My example was w cxl_test
decoder3.3, w 2 HB's. The automagic worked fine w decoder3.4 w 1 HB.

