Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A9DC64EC4
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Mar 2023 21:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCHV6Q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Mar 2023 16:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCHV6P (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Mar 2023 16:58:15 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E134130283
        for <linux-cxl@vger.kernel.org>; Wed,  8 Mar 2023 13:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678312693; x=1709848693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u3JFeTGZMCrxtzOrK/oEg1z2ItEAdKYZuY4+D98f28g=;
  b=IPOa5b0G3ftLw6mkk4hPXEhigFwZ5xVDFkh2WchpLOXH6wno/4V4Oemg
   mqbxPNOB2EEpvUpNvSXzRbpzZk+utAmpUtix9UkArXQWsNrhAcb+qkiV1
   3sRMIJK0H1pCOlPRI+A9uIaXi+40TaW3Xjf1WHTCFNU9kIM1haznICho9
   TONuHfX/DO4sbkj6hnIx+Ld2iToDz+dH+DBwSNrPEaMw55ASX/urnhfdf
   H4vpRjXOaeIPRD5xlfH6JstvlqCRRKetWX0lANt2LqEMFe0P00cmVXeS6
   4v/B9HyeWYtn7EpfCg1JOcznGuT35XKSsd9V5Fl4DicmePmk9n4QaNV7a
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="334990326"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="334990326"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 13:58:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="670485352"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="670485352"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.215.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 13:58:12 -0800
Date:   Wed, 8 Mar 2023 13:58:11 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jehoon Park <jehoon.park@samsung.com>, linux-cxl@vger.kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org
Subject: Re: [ndctl patch RFC 0/2] add support for IDENTIFY command
Message-ID: <ZAkE81CNAjXB48Wz@aschofie-mobl2>
References: <CGME20230307081917epcas2p1accc8f7bf3f31e08525684abb2efa788@epcas2p1.samsung.com>
 <20230307082102.27195-1-jehoon.park@samsung.com>
 <ZAecHtXUX5ZR9ccU@aschofie-mobl2>
 <20230308090134.GA15397@dell-Precision-7920-Tower>
 <6408d271a2c96_f3f4a2943@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6408d271a2c96_f3f4a2943@iweiny-mobl.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 08, 2023 at 10:22:41AM -0800, Ira Weiny wrote:
> Jehoon Park wrote:
> > On Tue, Mar 07, 2023 at 12:18:38PM -0800, Alison Schofield wrote:
> > > On Tue, Mar 07, 2023 at 05:21:00PM +0900, Jehoon Park wrote:
> > > > From: jehoon park <jehoon.park@samsung.com>
> > > > 
> > > > This patchset supports CXL IDENTIFY mailbox command and corresponding
> > > > cxl tool interface command.
> > > > 
> > > > CXL 3.0 Spec 8.2.9.8.1 defines IDENTIFY command which retrieves basic
> > > > information about CXL memory device. The information consist of device's
> > > > firmware version, capacity, LSA size, event log size, poison list size,
> > > > inject poison limit, poison handling capabilities and QoS telemetry
> > > > capabilities. Firmware version, capacity and LSA size are already supported
> > > > and used for partition commands or sysfs attributes while others are not.
> > > > Since patches about event log [1] and poison [2] are discussed recently,
> > > > support for those information will be helpful.
> > > 
> > > Hi Jehoon,
> > > 
> > > Does this need to be a separate command? Identify fields can be included
> > > in cxl list options. For example, the -I option to cxl list, issues the
> > > identify command and includes the partition related entries in that json
> > > output.
> > > 
> > > There are other identify fields that need to be picked up, like the
> > > poison related fields.  They need to be added to the cxl list 
> > > options. We may want to include some when we list the poison, and
> > > some as an option in the memdev listing.
> > > 
> > > Is there some reasoning behind separating this out? If not, can we look
> > > to add the missing fields to the various cxl-list options and add
> > > new cxl-list options where needed?
> > > 
> > > Alison
> > > 
> > 
> > Hi Alison, thank you for comments.
> > 
> > I suggested separate identify command since it retrieves basic information
> > about memdev. Since cxl-list command lists all cxl objects, I intended to
> > focus memdev information by separating it. Also, I referred to nvme-cli
> > which has id-ctrl and id-ns commands.
> > 
> > However, as you commented, some fields were already included in cxl-list.
> > I think the idea that providing information to proper listing option also
> > makes sense.
> > 
> > Then, by following the approach, including fields to cxl-list options,
> > identify fields could be included like below. Do they look fine?
> > 
> > 1. FW version and LSA size are included when listing memdev. ("list -m memdev")
> > 2. For poison related fields (poison_list_max size and inject_poison_limit),
> > include them when listing poison. ("--media-errors" option, patch [1])
> > 3. For capabilities fields, add new option "-C, --capabilities" to the
> > memdev listing. (I see there exists same option for listing nvdimm device)
> > 
> > However, I'm confused about event_log_size fields. Could they be included
> > in capabilities option too? or require new option like "--event"?
> 
> Fundamentally why does user space need to know the event log sizes?
> 
> I do like the idea of getting the 'raw' results of the identify command in
> it's entirety.
> 
> What if list has an '--identify' option which adds the list of Identify
> values as a child json object.
>
That's a good way to add it. That'll give you all the fields in one
place, and then, we can still think about if we want to spit out
specific fields (ie poison related) when we are doing a poison command.
You will have added all the libcxl accessors, making those easier to add.
Alison


> Ira
