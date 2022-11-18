Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70692C433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Nov 2022 00:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbiKRAc4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Nov 2022 19:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbiKRAc4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Nov 2022 19:32:56 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BA14C240
        for <linux-cxl@vger.kernel.org>; Thu, 17 Nov 2022 16:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668731575; x=1700267575;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=up2Y27e9dvoWmqcMckHh0Q2rX64pZyhonVD/GA2J+aA=;
  b=aCaiODfwiUhI7CdJllHcoyTbtXKSBI1913Px2sF4BxEJE6FYovVPQn4W
   hk3estvkWEv6OkmZemDsJ4Ihzom4nxlBQd/EJ4uY2Qafu6iSJuntsUikd
   qwFcwkSG9sb7FSH7n3aELVsa0POHfXVb8vTjvzJVy7VIR6R21P6D1eaiG
   8DP83G85g/vq6GQ04/1ShUXNPdmnuEdHH2GxKmPoWRqybwG5iMyFcMCDH
   8rwml+JL6bOC57fn/B9pD4+JglphkE9wML0W/xJMDy/Q69DyLqT47OvQU
   AjOLsODfLxxVz9xsL10thB7Tx6micDsbhHBJP7WmhEeUpB1cKkTqK7i42
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="310645175"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="310645175"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 16:32:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="642307619"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="642307619"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.84.12])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 16:32:54 -0800
Date:   Thu, 17 Nov 2022 16:32:53 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 2/3] cxl/acpi: Support CXL XOR Interleave Math (CXIMS)
Message-ID: <Y3bStbK7whfEPXah@aschofie-mobl2>
References: <cover.1668227077.git.alison.schofield@intel.com>
 <37ac2e3d3580af13755edd6f8e0bbdf11d5c206b.1668227077.git.alison.schofield@intel.com>
 <20221112062823.4mrp4kz6hxsd3uxw@offworld>
 <Y3J9NCmVX7t34DYD@aschofie-mobl2>
 <20221114185729.nxahgs66ybe2x5mr@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114185729.nxahgs66ybe2x5mr@offworld>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Nov 14, 2022 at 10:57:29AM -0800, Davidlohr Bueso wrote:
> On Mon, 14 Nov 2022, Alison Schofield wrote:
> 
> > The reasoning behind removing the check, versus expanding it, is that the
> > check shouldn't have been there in the first place. The ACPI driver is
> > responsible for parsing the CFMWS's but it is the responsibility of the
> > region driver to decide which CFMWS's it can use.
> > 
> > If you believe that premise, then we let all interleave arithmetics
> > 'get through' to the region driver.
> 
> The way I see it, acpi should be setting the callback because it is a _direct_
> consequence of parsing the cfmws, and that's really the same logic as we have
> now, in that it sets it when allocating the rp decoder. And that doesn't take
> away from the region driver responsibility of choosing the actual host bridge.

With a little help from my friends ;) I'm hopeful the next version
meets your expectation by setting the calc_hb only once when allocating
that root port decoder.

> 
> Thanks,
> Davidlohr
