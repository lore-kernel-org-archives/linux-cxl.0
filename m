Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414E7358363
	for <linux-cxl@vger.kernel.org>; Tue, 24 Mar 2026 20:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774385958; cv=none; b=DRKwwBptGfBYiD13doMBlXPKIviyPhepfpKhEgw5w6ekj7rNsUgjH/5E+8tTD1iJnWmA9kc3uqBCWAyxlYvHCmzaSWPQcPEHmrbOp+A9sopUzVHSHHbZ3BDDQU3lTHZUJVd/5sUOX8rD1AQ1skpAtkbakKOvMeyeBlbyFfXrNes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774385958; c=relaxed/simple;
	bh=c3eH0hSMQRdmEqWrGTP8brLrbYIqSCN5n6/7Xv95oPc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LrBlS+SNuBX8JHoKpoesMwy/EkZ2hYXH1lBK7KseXDapmgr+gGfcfU1AaywT22sIy6i7dDTPn/f7RrQWanT/lVYhd3EZSGZaAXIAEk3Xk30zwlD9pq1sw4Os2Ih0kUdJWXYgNnICzlKIRqv6OB+ABV+ze8vOimDPTt2dEaE+e9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEb68b/q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEb68b/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48CEC19424;
	Tue, 24 Mar 2026 20:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774385957;
	bh=c3eH0hSMQRdmEqWrGTP8brLrbYIqSCN5n6/7Xv95oPc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lEb68b/qsmwU33tokABNGinz2R1zri+SJX+8bkF/Njc5MJCAmi0s6wD0Kr+3Q/UJ7
	 Iv9ZuR+/0X5csH4b9/eERXOPBmyBZ6RjBTeoKRuyYk/N5LTNZ2HuckfQC0Jic3FiA7
	 CSMdWZSLSixeoxs5PZjragw/iH//lYUGYw0AYq8UAfZQ+sLYJpsIy5JjVEwNDBKXXz
	 u+JSpoG3aVjLuA3nj0nF6CIDdI6AGrZ8cSl7ZnUtl1MHJFcQD5NuWjHb0M43S7aUux
	 z+IjbQ60UlpbP45VHa/8XQTp6oTlM5W0eTgUAhcjLOfx+F+pbvFLYGhhjvKeugy+a+
	 Lm8ZpoTfxhFjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1503808203;
	Tue, 24 Mar 2026 20:59:06 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 7.0-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <1b13cc4d-4103-4462-a0c1-590ad2d6725c@intel.com>
References: <1b13cc4d-4103-4462-a0c1-590ad2d6725c@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <1b13cc4d-4103-4462-a0c1-590ad2d6725c@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-7.0-rc6
X-PR-Tracked-Commit-Id: be5c5280cf2b20e363dc8e2a424dd200a29b1c77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45f667ebb06a141a5fbb1cae1b44a81102a23bc8
Message-Id: <177438594529.1304315.5638575031014822323.pr-tracker-bot@kernel.org>
Date: Tue, 24 Mar 2026 20:59:05 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Keith Busch <kbusch@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 24 Mar 2026 10:11:24 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-7.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45f667ebb06a141a5fbb1cae1b44a81102a23bc8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
