Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D933C05027
	for <linux-cxl@archiver.kernel.org>; Sun, 29 Jan 2023 19:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjA2Tex (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 29 Jan 2023 14:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjA2Tew (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 29 Jan 2023 14:34:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE74C1ABE0;
        Sun, 29 Jan 2023 11:34:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 921BCB80D84;
        Sun, 29 Jan 2023 19:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B2F9C433D2;
        Sun, 29 Jan 2023 19:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675020889;
        bh=MBnuau6jQoq95jznRli70tsGSRvs7Mi925jpYcuVfTQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BTfCqHB/MQFyTRzN+Wwb6mOPhFuQ+BDV8y8v3xsKDnxRUci5wYwVx8VnLXSaDLTZ/
         NOpoLzSifb6iwXsoLEnKRnMe9DvsZzSLdZl+2O5CqzdDiFyaIcFiWJlfPdEJU0tg/7
         wIvo3VHtPkIWsmgoWJQq6mpo1BmGw23ge7StUT864ZHPaNnefi85ebWgW4JV78Mdnk
         XeqHYnFn1bMY3PH++lUqUagcWn258Rgukss/4wUxDjhj2dJMAJyrj1x096lf19CaMI
         ji4DfpMSCU2ZYViWHWeWeBHK5Jpb/1s1UHhg08OztcaUo8P5UfUl7opmdFJ5+aXTNy
         aIZ7nl6DokpBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27700E54D28;
        Sun, 29 Jan 2023 19:34:49 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) fixes for 6.2-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <63d5b57256698_1e36329481@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <63d5b57256698_1e36329481@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <nvdimm.lists.linux.dev>
X-PR-Tracked-Message-Id: <63d5b57256698_1e36329481@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-for-6.2-rc6
X-PR-Tracked-Commit-Id: 19398821b25a9cde564265262e680ae1c2351be7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 803929285af4194d490d5652a64731d613e78b8b
Message-Id: <167502088915.8980.8860054846844197480.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Jan 2023 19:34:49 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     torvalds@linux-foundation.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The pull request you sent on Sat, 28 Jan 2023 15:53:22 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-for-6.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/803929285af4194d490d5652a64731d613e78b8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
