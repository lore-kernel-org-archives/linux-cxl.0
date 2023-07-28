Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B34AC001E0
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jul 2023 18:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjG1Sj2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jul 2023 14:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjG1Sj1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jul 2023 14:39:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5284487;
        Fri, 28 Jul 2023 11:39:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FF47621E1;
        Fri, 28 Jul 2023 18:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B59EFC433C8;
        Fri, 28 Jul 2023 18:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690569565;
        bh=/R4Z/ucLXewnrANqdXvRAHeb2trVsmRiITueYR8CBH8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PCSdKRe9rRyCPDOBMSUgS7FcX5FDz/C7BWZ3ymokydyQmHaEgp/pdPUs3suQ7/vkR
         weZ8U56XOcFVE9+iCBYKlzY3sH+BRTXEQjGeBRQ4bIvMEHEb7/g7hCjC88pgOYCZKw
         njOJoKD7tg3uId0V3x29Bkp2xnMJHltMqGuhaBLJClwuGFR+oeL/kGGSKXjdGSpV+d
         DyrAwaAb3qaf0tCAGcZIWCqbH4+W3NtDm1nBo21WAdJvEmE/pYTEC94fwMF2LNRaVO
         2sC757fK0qJVBW10Cua905As4TKSqMD2bmftbjqynkZ4mpuilIzH2r22FbWAxY2FQB
         g8+wpgGsOd6xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1A1EC43169;
        Fri, 28 Jul 2023 18:39:25 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5c506f1121b7169b8cb1ed4ee1f5ffd9a2fe4392.camel@intel.com>
References: <5c506f1121b7169b8cb1ed4ee1f5ffd9a2fe4392.camel@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <5c506f1121b7169b8cb1ed4ee1f5ffd9a2fe4392.camel@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.5-rc4
X-PR-Tracked-Commit-Id: 70d49bbf962ce4579bebd82938ef7f265bc3e6ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f24767ca4f004f6a34411229a84394e1b94deae7
Message-Id: <169056956565.21363.11272637812955791844.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jul 2023 18:39:25 +0000
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The pull request you sent on Thu, 27 Jul 2023 21:47:21 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.5-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f24767ca4f004f6a34411229a84394e1b94deae7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
