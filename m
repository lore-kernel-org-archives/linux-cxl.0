Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0B2C77B73
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Apr 2023 04:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjD0ELl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Apr 2023 00:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239435AbjD0ELh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Apr 2023 00:11:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C701F30C0
        for <linux-cxl@vger.kernel.org>; Wed, 26 Apr 2023 21:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682568696; x=1714104696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iI6rr7j62JUKlH92NEE+7TIZoEc6ZB7cq+4VPoWVa2w=;
  b=WYArLB/mXRx1gwPDDduwEteTtSbA9vMCDe7dSpaxU30ytg/8tANOyGOz
   PJ8+Lvaz9Vt53tk6JMkQRAUP3nYZ1oeUSYMlHjyT8pauYxmOh4vFlZI3p
   zIhOOcFATsw8f0/SvyhHCwMlJC1+Gkmpw4vTM3nhsda0UvyrQzqTVRkpG
   M/SzvPjCV+WgKth1PBxqPJEXRhpFDBe9Zj7EGwzwadfd5uHnAnJuO/wNl
   ThsWq89Dq+OFdgrxc53KzF12jnNLY7QNfsPaz7nDKca+SYFyFhY1WYjEc
   qEKYCqbaVIZr2JhoAz/zqYzf6a/AFfwX76MxlwXVho5rYcS8Qg5LM215k
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="336262082"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="336262082"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 21:11:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="763614315"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="763614315"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.211.65])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 21:11:35 -0700
Date:   Wed, 26 Apr 2023 21:11:33 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v13 6/9] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Message-ID: <ZEn19R/iusbbkPau@aschofie-mobl2>
References: <cover.1681838291.git.alison.schofield@intel.com>
 <1081cfdc8a349dc754779642d584707e56db26ba.1681838291.git.alison.schofield@intel.com>
 <rjgz474mou55qufxwwmy3vpxftagdys6ge3iqs3guqukkw3jlv@ho7vuf7bmjsp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rjgz474mou55qufxwwmy3vpxftagdys6ge3iqs3guqukkw3jlv@ho7vuf7bmjsp>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Apr 25, 2023 at 07:38:11PM -0700, Davidlohr Bueso wrote:
> On Tue, 18 Apr 2023, alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > When a boolean 'true' is written to this attribute the memdev driver
> > retrieves the poison list from the device. The list consists of
> > addresses that are poisoned, or would result in poison if accessed,
> > and the source of the poison. This attribute is only visible for
> > devices supporting the capability. The retrieved errors are logged
> > as kernel events when cxl_poison event tracing is enabled.
> 
> btw thinking of scan media, is there some interface you already
> have in mind?
> 
> Afaict we could have a new 'trigger_poison_list_nocache' attribute,
> or write "scan_overflow" or whatever to this very file.

At the moment, I have 'trigger_scan_media' that results in a spew of
scan media results to a trace file. I guess we'll chat more about 
presenting a _nocache, when I post for review.

I'm concerned that a  _nocache_ will lead user to believe they are
getting 'fresher' results, and to over-use it with that mindset.
Get Poison List gives accurate results and Scan Media is only necessary
when the poison list has overflowed. OK...here I go opening the can of
worms myself ;)


> 
> Thanks,
> Davidlohr
