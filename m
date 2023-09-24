Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96332CE7A8C
	for <linux-cxl@archiver.kernel.org>; Sun, 24 Sep 2023 21:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjIXVYY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 24 Sep 2023 17:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjIXVYY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 24 Sep 2023 17:24:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00661A6;
        Sun, 24 Sep 2023 14:24:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AB04C433C7;
        Sun, 24 Sep 2023 21:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695590657;
        bh=SlCdRELu2YsZXTzRtyf4tTfzcJrUlXa62fa6Fq1rSaY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DorbX6tPMQ1MjV97Kr6yqxugxtlHicm3HnKV7XFBvtaeJZDIuYpDbnjAV27F5cq2C
         na5W14GX8MmSutTle+Je1JaDUi5DQ6EaKbQj8WVg1apQ8lcue0wSlDod0O9O4h8y6a
         m1JCLk/MwCc4yOVQwY5c5U7d9Pv2Eg4oUwq4KkJwgkaP3ONNf0FdOOOIGCr5XSN05v
         Io3f5hQ741mdkyqpsW/ywqpawJ89NPT8cKqBputcCCnZkykGuUULKV01rf4LKQQixC
         HbjRdrYXLmaXKebl9nLLg5044QXSnz/Mt6h0OvNTuA8IlvRbnIjxnlrMBwDdnkhWDo
         aa4DUa3cZZTFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 885FEC595C0;
        Sun, 24 Sep 2023 21:24:17 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.6-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <650f60a224347_124e92943@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <650f60a224347_124e92943@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <650f60a224347_124e92943@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.6-rc3
X-PR-Tracked-Commit-Id: c66650d29764e228eba40b7a59fdb70fa6567daa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ad78f8cee9ae6cd99c685e217e89fa99cc222ef
Message-Id: <169559065754.13804.10058874010062366932.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Sep 2023 21:24:17 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     torvalds@linux-foundation.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The pull request you sent on Sat, 23 Sep 2023 15:03:14 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ad78f8cee9ae6cd99c685e217e89fa99cc222ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
