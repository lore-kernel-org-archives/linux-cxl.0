Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC55DC761A6
	for <linux-cxl@archiver.kernel.org>; Fri, 31 Mar 2023 18:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjCaSwa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 31 Mar 2023 14:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjCaSw3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 31 Mar 2023 14:52:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FAA20C32
        for <linux-cxl@vger.kernel.org>; Fri, 31 Mar 2023 11:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680288748; x=1711824748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8hnV43EDZB3RRS87MPVId2kgXbugZ8t1wqOQauFubIc=;
  b=EUalqnsGaDkHUsjGOvJ5gqJbuR87h3mCP8djk3gc1p6OGUH47rNFJls/
   iPMzfzNeBRDWxtXCEGH+yqGqGuU1c5V22x4vGf3Enh6kpffJkT22PwnxY
   x3xEODHJ/y0tkJgmEU9NVg/hdZf98CNqQbObLdjZArjdIsQf1Ih9AC97H
   KFkm3Ty8rsZT/rGrFomjOHLqxPi0MfJxRTiuNtiD8ZWe5Tvf9NfUHzvJS
   0AHAb1vjvkTknaYR4PaEjXH0b+ADEmq/hP5dA+13TKZQBrZ0OSfBgeaNj
   h05C+l598/6Nu2Jl7HJcmjxQvWlk7Gi3lIpM5vKtRTFKZgxNfVUwfXUGy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="344060300"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="344060300"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 11:52:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="687772757"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="687772757"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.63.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 11:52:27 -0700
Date:   Fri, 31 Mar 2023 11:52:25 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 01/12] cxl/memdev: Add support for the Inject Poison
 mailbox command
Message-ID: <ZCcr6TQP8/PU1Vbr@aschofie-mobl2>
References: <cover.1679892337.git.alison.schofield@intel.com>
 <976c3fcb43f31c0b303709a14a044652bc267978.1679892337.git.alison.schofield@intel.com>
 <0986cce6-fcc7-8c47-32df-29a2b308b758@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0986cce6-fcc7-8c47-32df-29a2b308b758@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Mar 31, 2023 at 11:11:11AM -0700, Dave Jiang wrote:
> 
> 
> On 3/26/23 10:03 PM, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > CXL devices optionally support the INJECT POISON mailbox command. Add
> > memdev driver support for the mailbox command.
> > 
> > Per the CXL Specification (3.0 8.2.9.8.4.2), after receiving a valid
> > inject poison request, the device will return poison when the address
> > is accessed through the CXL.mem bus. Injecting poison adds the address
> 
> s/bus/protocol/?

Quoting the spec there, but probably better to translate into kernel
driver language and say: ..is accessed through the CXL.mem driver.

> 
> > to the device's Poison List and the error source is set to Injected.
> > In addition, the device adds a poison creation event to its internal
> > Informational Event log, updates the Event Status register, and if
> > configured, interrupts the host.
> > 
> > Also, per the CXL Specification, it is not an error to inject poison
> > into an address that already has poison present and no error is
> > returned from the device.
> > 
> > If the address is not contained in the device's dpa resource, or is
> > not 64 byte aligned, return -EINVAL without issuing the mbox command.
> > 
> > Poison injection is intended for debug only and will be exposed to
> > userspace through debugfs. Restrict compilation to CONFIG_DEBUG_FS.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Just a NIT below. Otherwise,
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
Thanks!
> > ---
snip
> > +
> > +	inject = (struct cxl_mbox_inject_poison) {
> > +		.address = cpu_to_le64(dpa)
> > +	};
> 
> Why not inject.address = cpu_to_le64(dpa);? Uneless there are more
> assignments coming in later patches?

Actually nothing else in that struct. It's just a pattern repeated needlessly.
I'll clean up.

Thanks,
Alison

> 
> DJ
> 

snip to end.


