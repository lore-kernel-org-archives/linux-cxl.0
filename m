Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F7C35CB9D
	for <linux-cxl@vger.kernel.org>; Fri, 14 Nov 2025 21:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156577; cv=none; b=q0gsSVdqfVz32QFXVzHbhtSOK0cyVGzPjS9iA5kwsKJPgHgp3F1O5z0RIycf6B2TgwRanexZGATUtL2Rnm3GFpyaMKoaz6B1xuA4lrEPfBZUqS96VqPTBSalh0MDYp7su5QfU0OaQBtrsMUNSgk3TpURMdKxytiQ/KtywBb9RS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156577; c=relaxed/simple;
	bh=9hEUP/C9t21kkbdG4IG3ntDII/LJXuX+JwfGQ1ISvKA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QxXxHCLWby0T72NiDP3DV50jcV44jKCmj55JiZh73Ayq+TinOGb11J0PoBcU9ftm3vdhoFp+Tv6WnU8EXqVrYhJoEEwSr1lxElRqjFEx+qeYg+toQrJqTX/d9tK1Oha1V+PGAXCozW5NAR0dWuNNKo0vzSPnW0K5U+mLDUC94qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WabwAbSt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WabwAbSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18D6C4AF0C;
	Fri, 14 Nov 2025 21:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763156576;
	bh=9hEUP/C9t21kkbdG4IG3ntDII/LJXuX+JwfGQ1ISvKA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WabwAbStwc+KEua6VFWcSyTOP4be7gSmpLV8L0yfLt6ihof8HEjDanT2eqApfYydk
	 w+LH2R+WPRfr8/4GhJMd9UH3g6PSvOm9gwhUyPf9WlNzwn+PsnsxD5DjMqXHk1HFtS
	 qhk5mdI434Ro9CR7hBUzGK2VMwuYeiPK5TgVbj2SgQ3ZRa9udKJs80bUEZ7IgXxCXb
	 5paoHSexseEUxGiyQGubHu+03cWkWpb8UhCvIbjbN5If5tJqfgHrAaZLFXhJ0PDT2r
	 pfYUxC26YWSurtVrWbZgfaAPl17Sc30FIt1G90uGdXXWazk6n9V4ajBGzihFbglrgn
	 9iPvy+tVLgKyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C323A78A5E;
	Fri, 14 Nov 2025 21:42:26 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.18-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <b263ef64-1ae6-49ff-88af-a1f69c545837@intel.com>
References: <b263ef64-1ae6-49ff-88af-a1f69c545837@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <b263ef64-1ae6-49ff-88af-a1f69c545837@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.18-rc6
X-PR-Tracked-Commit-Id: 214291cbaaceeb28debd773336642b1fca393ae0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6014e75e87562abd3c55a7b6d361bbe66beb0b07
Message-Id: <176315654465.1846194.7431786202484340876.pr-tracker-bot@kernel.org>
Date: Fri, 14 Nov 2025 21:42:24 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>, Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Nov 2025 09:10:11 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.18-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6014e75e87562abd3c55a7b6d361bbe66beb0b07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
