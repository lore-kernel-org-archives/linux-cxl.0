Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0FEC77B73
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Apr 2023 19:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244578AbjD0TSL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Apr 2023 15:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244538AbjD0TSL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Apr 2023 15:18:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C931FD2
        for <linux-cxl@vger.kernel.org>; Thu, 27 Apr 2023 12:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682623090; x=1714159090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D2/95qLabuM0vXvgBGyvqSPq9Wo7lYHMZ8xEtDZJwPk=;
  b=eeu7IDDrjIqmNkEmRm0l6UvLV4tor5UQteGOiBPptX/+yhjSwyClNeXg
   9lfMJRJhfpTK+7R+oi2Y1FYv/x64JHtux6fk0w86D9ftVa48IdlmJ4QSc
   kjzxJJoWNP5ivbLGSXN7HtMjcCC8//kpPhEvMLMrHxfDEP1bAZu2yWTb+
   Gt39SFrNVRHDgeUpveSZJCixCaFKp6SxD8YmYGCQgpoXbag86IwQtAri0
   QGv2sr3Vjr1pw1gO87fUGLx3DFx9nfkNnGyABpHVGqyqJ0oHKHZOSiLEH
   y1vVCVlcDO9WnhfX/pKJ0kbLe6I3j+D8X+mGph0q6gHpbHl9oqBQS2LuO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="412901149"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="412901149"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:18:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="671894724"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="671894724"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.57.248])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:18:05 -0700
Date:   Thu, 27 Apr 2023 12:18:03 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v13 6/9] cxl/memdev: Add trigger_poison_list sysfs
 attribute
Message-ID: <ZErKa3dztvM4aTP2@aschofie-mobl2>
References: <cover.1681838291.git.alison.schofield@intel.com>
 <1081cfdc8a349dc754779642d584707e56db26ba.1681838291.git.alison.schofield@intel.com>
 <rjgz474mou55qufxwwmy3vpxftagdys6ge3iqs3guqukkw3jlv@ho7vuf7bmjsp>
 <ZEn19R/iusbbkPau@aschofie-mobl2>
 <iurygq7c3gg6gskfzgnl3mkr7trbpnp3bo6nzqiwyonzw2kscy@w5s3xh6fkell>
 <644aa4369184_586729479@dwillia2-mobl3.amr.corp.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <644aa4369184_586729479@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Apr 27, 2023 at 09:35:02AM -0700, Dan Williams wrote:
> Davidlohr Bueso wrote:
> > On Wed, 26 Apr 2023, Alison Schofield wrote:
> > 
> > >At the moment, I have 'trigger_scan_media' that results in a spew of
> > >scan media results to a trace file. I guess we'll chat more about
> > >presenting a _nocache, when I post for review.
> > 
> > I'm not crazy about calling the interface scan media straight how just
> > because it's very unintuitive - albeit users that care will probably
> > don't care.
> > 
> > >
> > >I'm concerned that a  _nocache_ will lead user to believe they are
> > >getting 'fresher' results, and to over-use it with that mindset.
> > 
> > Agreed.
> > 
> > >Get Poison List gives accurate results and Scan Media is only necessary
> > >when the poison list has overflowed. OK...here I go opening the can of
> > >worms myself ;)
> > 
> > trigger_poison_list_overflow?
> > 
> > If triggered and the list hasn't overflowed yet, just be a nop?
> 
> What about a "poison_overflow" policy? Defaults to "report", but you can
> write "scan" to have trigger_poison_list invocations fallback to
> scan_media on overflow.

With a policy like that, the driver may automatically do scan media
in response to overflow reports.

For users that want to schedule those scans (policy set to 'report'),
they can do so my doing trigger_scan_media at their leisure.

Would you expect the driver to retain overflow state, and warn those
users that they are issuing scan_media without prior overflow events?

