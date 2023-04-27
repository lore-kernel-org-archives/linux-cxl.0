Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDFEC77B61
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Apr 2023 21:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjD0Vfg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Apr 2023 17:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0Vff (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Apr 2023 17:35:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADECF212C
        for <linux-cxl@vger.kernel.org>; Thu, 27 Apr 2023 14:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682631333; x=1714167333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MGRc/GZSluJjRVGS95hFGcXKukfFqXuU+TPvkAnM1yA=;
  b=kdJyXozi8CfDVJkTTOb3XKifgv+nhyu02tAnozyprCgKhImQuV0iyL87
   ABEg/EVhGWsfpkJ4/CGa9Xt9Q1HmIwaBhnoZYysCpV1IFBWkcyC+9xIAk
   DvWgjb1e2YS2SpCvKsm/GJoe43drFFGDKq9LBQNFlYteHj5D7um5Iwl1C
   ln4ul7ZCL+LyDkD2SM8ln9cHL+U/Ebz/WqAA+ujXxn56PYzMO+dPWLLYu
   yoTTwaOCzmw2M5lSmXMJVYFAhZDSNZ5h69Vf8KMtQyvpLsDGuS1bcS83p
   knm8+REFuUcckCoMkbZ9YzQnNDxoMLmzEjI8jAqLVeRYyABrvtmFeHI3P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="412935175"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="412935175"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 14:35:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="1024282232"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="1024282232"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.57.248])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 14:35:32 -0700
Date:   Thu, 27 Apr 2023 14:35:30 -0700
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
Message-ID: <ZErqopqx2rDgW62h@aschofie-mobl2>
References: <cover.1681838291.git.alison.schofield@intel.com>
 <1081cfdc8a349dc754779642d584707e56db26ba.1681838291.git.alison.schofield@intel.com>
 <rjgz474mou55qufxwwmy3vpxftagdys6ge3iqs3guqukkw3jlv@ho7vuf7bmjsp>
 <ZEn19R/iusbbkPau@aschofie-mobl2>
 <iurygq7c3gg6gskfzgnl3mkr7trbpnp3bo6nzqiwyonzw2kscy@w5s3xh6fkell>
 <644aa4369184_586729479@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZErKa3dztvM4aTP2@aschofie-mobl2>
 <644ad2fecc06f_58672948e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <644ad2fecc06f_58672948e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Apr 27, 2023 at 12:54:38PM -0700, Dan Williams wrote:
> Alison Schofield wrote:
> > On Thu, Apr 27, 2023 at 09:35:02AM -0700, Dan Williams wrote:
> > > Davidlohr Bueso wrote:
> > > > On Wed, 26 Apr 2023, Alison Schofield wrote:
> > > > 
> > > > >At the moment, I have 'trigger_scan_media' that results in a spew of
> > > > >scan media results to a trace file. I guess we'll chat more about
> > > > >presenting a _nocache, when I post for review.
> > > > 
> > > > I'm not crazy about calling the interface scan media straight how just
> > > > because it's very unintuitive - albeit users that care will probably
> > > > don't care.
> > > > 
> > > > >
> > > > >I'm concerned that a  _nocache_ will lead user to believe they are
> > > > >getting 'fresher' results, and to over-use it with that mindset.
> > > > 
> > > > Agreed.
> > > > 
> > > > >Get Poison List gives accurate results and Scan Media is only necessary
> > > > >when the poison list has overflowed. OK...here I go opening the can of
> > > > >worms myself ;)
> > > > 
> > > > trigger_poison_list_overflow?
> > > > 
> > > > If triggered and the list hasn't overflowed yet, just be a nop?
> > > 
> > > What about a "poison_overflow" policy? Defaults to "report", but you can
> > > write "scan" to have trigger_poison_list invocations fallback to
> > > scan_media on overflow.
> > 
> > With a policy like that, the driver may automatically do scan media
> > in response to overflow reports.
> 
> Sure that's what the policy enables.
> 
> > For users that want to schedule those scans (policy set to 'report'),
> > they can do so my doing trigger_scan_media at their leisure.
> 
> It's not clear that scan media matters so much in practice that the
> kernel needs to have separate controls for it.
> 
> One of the observations of the overflow threshold is that the failing
> part is likely to be RMA'd before the poison list fills up. Scan Media
> was more relevant in the PMEM days [1] before List Poison was introduced
> in CXL that promised to always record poison on creation.
> 
> If Scan Media is an operation that is rarely used, does the kernel need
> to carry a trigger_scan_media attribute? I.e. the kernel only needs one
> way to kick off a poison collection event and the depth of that
> collection is an optional policy setting. Whether that policy needs to
> be configurable is also an argument that needs evidence.
> 
> > Would you expect the driver to retain overflow state, and warn those
> > users that they are issuing scan_media without prior overflow events?
> 
> I don't follow the use of plural "users". Only the single platform owner
> cares about the health of the hardware.

This conversation isn't new or a surprise. The no user access was discussed
previously, off-list. Let's pick it back up when I post the scan support
patchset - so we can get more eyes on it, and keep the discussion in one
place.

Alison

> 
> [1]: https://pmem.io/documents/IntelOptanePMem_DSM_Interface-V3.0.pdf
