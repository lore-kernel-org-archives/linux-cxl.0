Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E661C43334
	for <linux-cxl@archiver.kernel.org>; Sat, 18 Jun 2022 00:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383787AbiFRAWY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383802AbiFRAVp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Jun 2022 20:21:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A500069B6F;
        Fri, 17 Jun 2022 17:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655511704; x=1687047704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0RU6N5WPdmWr67K93Ub4kXJAzQ5+ISdL4xHiVGEqwbM=;
  b=RSOINgv4bfqjrvD9VtIPNpK7mFNiKkSJFuE0lk1HwwC43alvE/5FXyZ1
   3d5WXH5mgiz0sBpOt0e75x3oRsfL+RGFGokJCHYvuLGdjj6qJuNfGtPXP
   6P2bnZIEhXlSvvXGSgeTmmkrWg1hggUN45CLLrHlDAwI4M5ESPT6hxBw6
   2ASpJXdSZgXSMr0c1NeRkYVb+BLQXs4MtB8V26biz8Ip6VF1ZTTxzvkqc
   bdzHx57kG87c/Gic2lFHWr1KYXi7Mzn2KeDprU9iLjnqb7Ua1Vi4ubeLy
   NBaGBk7VMbGeNPXBsHHUcu28Yqw5U3TYITbQHrAB6iuWPMiuf1j5NmVWH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280673373"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280673373"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 17:21:44 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="713947707"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 17:21:44 -0700
Date:   Fri, 17 Jun 2022 17:21:21 -0700
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
Message-ID: <20220618002121.GA1533961@alison-desk>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <57644934bb7af8e1c692735f53c2c415a1ba16d1.1655250669.git.alison.schofield@intel.com>
 <62accb0345de2_81c5e29454@dwillia2-xfh.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62accb0345de2_81c5e29454@dwillia2-xfh.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jun 17, 2022 at 11:42:11AM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > The sysfs attribute, get_poison, allows user space to request the
> > retrieval of a CXL devices poison list for its persistent memory.
> 
> If the device supports get poison list for volatile memory, just grab
> that too. With the "to be released soon" region patches userspace can
> trivially translate DPA addresses to media type.
> 

Dan,

The only way I know to discover if the device supports poison list for
volatile is to do the get_poison_list on the volatile range and see
what happens. Am I missing a capability setting somewhere?

Here's a blanket "Got it, Thanks!" for all the other pieces.

Alison


> > 
snip
