Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBFEC433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Apr 2022 21:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiDMVjl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiDMVjl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Apr 2022 17:39:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6241A5A09C
        for <linux-cxl@vger.kernel.org>; Wed, 13 Apr 2022 14:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649885839; x=1681421839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k1lCeF1/ccmhHkwlC0ZX6ss/6hy6bj2z/gUpqtBWCd8=;
  b=f1ktIUISuf9NNZFXCMw41/1Ft/6Amqn9HQNHsgCRjgmjBVEXn9rJJRUh
   kS/8/k3NNsxFpVNAt3cCfwN1fXIYVHZa8Agh+Y9cWxTYGjv4naThgzObc
   fz90fS9X46lSMt+81q1MkuBJ0Cttcpoe7FN04e6rF9wpOLyppP9mZEeLr
   K9lEvjfZfashSN1VkjLT32TdADTBxshQh8f3EsUnwF22idrogiycGAQOk
   34OKt4vPx9WNthJSIGaTkv0K+Odf1gYs3+/iwTV0HtwhQ4xo+QDY0X0j/
   X8trisdY97cIbX+MouhH3MaTvHbl0vfuQGx4rIyuBQGpK5TyJ62yneV0i
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="349216504"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="349216504"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:37:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="623841718"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:37:19 -0700
Date:   Wed, 13 Apr 2022 14:39:13 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Widawsky, Ben" <ben.widawsky@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        lkp <lkp@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] cxl/mbox: Restore signedness to a mailbox payload
 variable
Message-ID: <20220413213913.GA1242919@alison-desk>
References: <20220413191311.1242361-1-alison.schofield@intel.com>
 <20220413202902.bpyczvz56pxlhgkq@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413202902.bpyczvz56pxlhgkq@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Apr 13, 2022 at 01:29:02PM -0700, Ben Widawsky wrote:
> On 22-04-13 12:13:11, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > A mailbox command output size value of (-1) means that a device
> > may return a variable sized output to that command. The device
> > defines a maximum payload size, so the driver will allocate enough
> > memory to receive that maximum payload for variable size mailbox
> > commands.
> > 
> > A recent code refactoring discarded the signedness on 'out_size'
> > before checking it, thereby breaking the handling of mailbox
> > commands with variable sized output. Pass along both in_size and
> > out_size with signedness, and only discard the signedness when
> > building the cxl_mbox_cmd structure.
> > 
> > Smatch warn: unsigned 'out_size' is never less than 0
> > 
> > Fixes: be0d0ce77aa3 ("cxl/mbox: Move build of user mailbox cmd to a helper funct
> > ions")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Per internal discussion, do we want to change in_size also? I'm in favor of
> fixing the ABI.
> 
Thanks for reviewing!
OK - next version will removed the signedness from the ABI.
Compare to UINT_MAX for the variable size option.

> [snip]
> 
