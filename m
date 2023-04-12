Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743CCC77B6E
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Apr 2023 18:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjDLSB3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Apr 2023 14:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjDLSBX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Apr 2023 14:01:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933656E80
        for <linux-cxl@vger.kernel.org>; Wed, 12 Apr 2023 11:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681322481; x=1712858481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v4rEqS9P2CIHVYv8u9uYSTmSMU45Q8tFZi6g369fxhc=;
  b=bE5c7iwxlzadxbZP6YHkm5K9pqGe2D6TEvSpYq+nW+oaZ/RlcXXmai5C
   FQ8dSmwkpPDx9Epg3+8rl5pBrfkxee1tSLSHqmmDD1L8bZR7can9UBGbS
   j8gKdxEehyFmQJ3Z6+VOjAdSDHQF99UTVZKzkFvFOaB+Xgsibhx/Ph+bQ
   wK1blx9Y5HOnBmiTLnJC2PHNG8SV/zbWkfolNuNcY41myDRYCf/6WyF1+
   9gFc2oIGqTezH2Agi94ZdMDg8VA0Ore2xFaqDkEPx6r8aRWIycJAjzjxH
   6a1qvZZF5rDwuQ4ukOFs0QTvpQShg7oZ5AZgxpbUAN9Ic4I7vLEsY55BV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332678331"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332678331"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 11:01:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="863398391"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="863398391"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.150.154])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 11:01:20 -0700
Date:   Wed, 12 Apr 2023 11:01:18 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v12 1/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Message-ID: <ZDbx7qjw+SP+6sSe@aschofie-mobl2>
References: <cover.1681159309.git.alison.schofield@intel.com>
 <e87e1792e147a46f348019cc772e06f2ea19e970.1681159309.git.alison.schofield@intel.com>
 <64360dcc59cb0_417e294de@dwillia2-xfh.jf.intel.com.notmuch>
 <ZDY3dR0vA6+zihxN@aschofie-mobl2>
 <64363f30a6370_417e294d0@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64363f30a6370_417e294d0@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Apr 11, 2023 at 10:18:40PM -0700, Dan Williams wrote:
> Alison Schofield wrote:
> > On Tue, Apr 11, 2023 at 06:47:56PM -0700, Dan Williams wrote:
> > > alison.schofield@ wrote:
> > > > From: Alison Schofield <alison.schofield@intel.com>
> > > > 

snip

> > > 
> > > With this new interface I do not expect we want to support user tooling
> > > that wants to retrieve the list via ioctl. So I think this wants a
> > > lead-in patch that deprecates the poison command support so that the
> > > linux-cxl community only has one mechanism to maintain going forward.
> > > 
> > > Something like the below as a lead-in, and then you would add code to
> > > cxl_walk_cel() to set a flag for the "get poison" machinery.
> > 
> > In the inject & clear series, I made the commands kernel exclusive (and
> > also blocked their usage in raw mode).
> > 
> > https://lore.kernel.org/linux-cxl/1576040e-e8db-bc78-2fa3-622c8f7da8ec@intel.com/T/#m5b86f3e88ee7ad5b92843babdb9fd41b7f03cf36
> > 
> > Is that not enough or not the right protection?
> 
> I think I'm having deja vu and maybe we talked about this already and I
> forgot the outcome?
> 
> The concern is having a consistent approach across the commands that are
> valid from userspace all the time, those that are valid sometimes
> (temporarily marked exclusive), and those that are unsupported from
> userspace (unsupported via raw command being a special case of that).
> 
> For recent new mailbox functionality like CXL_MBOX_OP_GET_EVENT_RECORD
> and the DCD commands, that are only expected to be executed from the
> kernel, those are kept out of the CXL_CMDS list, not marked exclusive.
> 
> The commands marked exclusive like the label commands return EBUSY, but
> only while libnvdimm owns the label area. If libnvdimm is disconnected
> (echo pmemX > /sys/bus/cxl/drivers/cxl_pmem/unbind), then those commands
> stop being exclusive.
> 
> So, I think I want to keep "exclusive" as a set of commands that are
> suitable to build into a user tool just that the tool needs to know the
> rules about when those commands might be busy.
> 
> For poison the user tool is expected to use sysfs + trace-events, so
> including it in the list of available commands returned by
> CXL_MEM_QUERY_COMMANDS only to never be able to execute it seems wrong.
> 
> Marking it deprecated as a "whoops" feels more honest and brings it in
> line with the other commands that are permanently kernel exclusive.


Yes, we were here previously w Inject & Clear series, and didn't close on
it. My last words were were in a inject/clear changelog:

>>  I didn't deprecate the ioctls as Dan suggested. Instead, I followed
>>  on Ira's recent clean up wrt enabled and exclusive commands, deciding
>>  that the honest response to a cxl_query() would be 'Enabled' (if hardware
>>  supports) and kernel 'Exclusive' (always). Please take a look.

Once we deprecate, is there a way for users to determine what commands a
device supports?

Can you post that deprecate patch preemptively? I'll update the affected
series to follow it.

Please include SCAN_MEDIA & GET_SCAN_MEDIA in your patch for the same reason. 
SCAN_MEDIA_CAPS is harmless.

 	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
-	___C(SCAN_MEDIA, "Scan Media"),                                   \
-	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
+	___DEPRECATED(SCAN_MEDIA, "Scan Media"),                          \
+	___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
 	___C(MAX, "invalid / last command")

Alison

