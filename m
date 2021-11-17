Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF36C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 17 Nov 2021 17:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC5A61BFB
	for <linux-cxl@archiver.kernel.org>; Wed, 17 Nov 2021 17:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbhKQRTn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 Nov 2021 12:19:43 -0500
Received: from mga18.intel.com ([134.134.136.126]:7293 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhKQRTn (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 17 Nov 2021 12:19:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="220883369"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="220883369"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 08:57:20 -0800
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="494986893"
Received: from ccgepper-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.140.112])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 08:57:20 -0800
Date:   Wed, 17 Nov 2021 08:57:19 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Saransh Gupta1 <saransh@ibm.com>, linux-cxl@vger.kernel.org
Subject: Re: Follow-up on the CXL discussion at OFTC
Message-ID: <20211117165719.pqig62t5z2grgjvv@intel.com>
References: <OF255704A1.78FEF164-ON0025878E.00821084-0025878F.00015560@ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF255704A1.78FEF164-ON0025878E.00821084-0025878F.00015560@ibm.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Saransh. Please add the list for these kind of questions. I've converted your
HTML mail, but going forward, the list will eat it, so please use text only.

On 21-11-16 00:14:33, Saransh Gupta1 wrote:
>    Hi Ben,
> 
>    This is Saransh from IBM. Sorry to have (unintentionally) dropped out
>    of the conversion on OFTC, I'm new to IRC.
>    Just wanted to follow-up on the discussion there. We discussed about
>    helping with linux patches reviews. On that front, I have identified
>    some colleague(s) who can help me with this. Let me know if/how you
>    want to proceed with that.

Currently the ball is in my court to re-roll the RFC v2 patches [1] based on
feedback from Dan. I've implemented all/most of it, but I'm still debugging some
issues with the result.

> 
>    Maybe not urgently, but my team would also like to get an understanding
>    of the missing pieces in QEMU. Initially our focus is on type3 memory
>    access and hotplug support. Most of the work that my team does is
>    open-source, so contributing to the QEMU effort is another possible
>    line of collaboration.

If you haven't seen it already, check out my LPC talk [2]. The QEMU patches
could use a lot of love. Mostly, I have little/no motivation until upstream
shows an interest because I don't have time currently to make sure I don't break
vs. upstream. If you want more details here, I can provide them, and I will Cc
the qemu-devel mailing list; the end of the LPC talk [2] does have a list.

> 
>    Thanks for your help and guidance!
> 
>    Best,
>    Saransh Gupta
>    Research Staff Member, IBM Research

[1]: https://lore.kernel.org/linux-cxl/20211022183709.1199701-1-ben.widawsky@intel.com/T/#t
[2]: https://www.youtube.com/watch?v=g89SLjt5Bd4&list=PLVsQ_xZBEyN3wA8Ej4BUjudXFbXuxhnfc&index=49
