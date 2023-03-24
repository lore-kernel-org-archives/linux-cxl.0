Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C993C6FD20
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Mar 2023 14:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjCXOzo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Mar 2023 10:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjCXOzn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Mar 2023 10:55:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA93411147;
        Fri, 24 Mar 2023 07:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eTcXgqk2rzRigxmbJ3ABqXEIuWKSD+gs6tvhN/boums=; b=NCsmFY/Lysf9dov02yXtwZY+a7
        gdMqk3opPGE7GRSUOwdRJ+aA3XqQ7BoEg/EMAsSRDc2IG9h3/9LZArrdeImlHy/FLRj6+DFkTrRsU
        odxkREjbZLEtyJCq1dIYWSyZMfi9u1jNv0jM0UrrVyMxlH0CCsNjkAoImoJY/Wbpiej8HfqHr4t9z
        3OLUz4rB7ZkwYNk7WAwds0HVS5A/A3mVZzBx31FYp/89aRPyz0VvCGGgInCWOe7dIIP3jk1aZc8zT
        IbrB5ONEwGqjTb8kMU6KuBx1VBd1YnXNdDvSc2cG6Ynz0t70Yrfr2PrXLUHOeXLKA/5H0UsiZfEUX
        CNWOgZzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfioo-00504p-5t; Fri, 24 Mar 2023 14:55:02 +0000
Date:   Fri, 24 Mar 2023 14:55:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kyungsan Kim <ks0204.kim@samsung.com>
Cc:     dan.j.williams@intel.com, lsf-pc@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
        viacheslav.dubeyko@bytedance.com, ying.huang@intel.com
Subject: Re: RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Message-ID: <ZB25xqRMgTrQas5W@casper.infradead.org>
References: <641b7b2117d02_1b98bb294cb@dwillia2-xfh.jf.intel.com.notmuch>
 <CGME20230323105106epcas2p39ea8de619622376a4698db425c6a6fb3@epcas2p3.samsung.com>
 <20230323105105.145783-1-ks0204.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323105105.145783-1-ks0204.kim@samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 23, 2023 at 07:51:05PM +0900, Kyungsan Kim wrote:
> One problem we experienced was occured in the combination of hot-remove and kerelspace allocation usecases.
> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.

No, that's not true.  You can allocate kernel memory from ZONE_MOVABLE.
You have to be careful when you do that, but eg filesystems put symlinks
and directories in ZONE_MOVABLE, and zswap allocates memory from
ZONE_MOVABLE.  Of course, then you have to be careful that the kernel
doesn't try to move it while you're accessing it.  That's the tradeoff.

> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.

I think you mean "migrated".  It can't be swapped unless you put the
page on the LRU list, inviting the kernel to swap it.

> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.

This sounds dangerously confused.  Do you want the EXMEM to be removable
or not?  If you do, then allocations from it have to be movable.  If
you don't, why go to all this trouble?

