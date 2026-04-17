Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C4331D362
	for <linux-cxl@vger.kernel.org>; Fri, 17 Apr 2026 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776466810; cv=none; b=lsXqu3VRmWiTFf+se6yH5CPVH1BUHLtdv3Xa3IgYn+s76bbz9QbGYKo/kylhRLNbse3ATkl0T3Jh5hPfCpttUHUlMTBk4GGyWn/XY5gS473r4JXabGRb7DF2B2bBrEQhm6QgjClTjoc7hDAQnhnayBMq3uI7goTG2yib/gkdhyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776466810; c=relaxed/simple;
	bh=LeC/2khI4b22tOIYCTEpBLKjhOVenzW7I4bh1B9fvNE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Tb/ioua57WKe+KbCHpue5ufhuY+/aIo4c7nSzuF6+nLaJCHWBi3h0DNOuz3prOkVdMUN00+K+2IELIWV7jkyuSpItQ23KRP4Y+BzO5cl7tj5buG2XYnm8xIq42mgebSsHlRhRwCyWzN8eJKiufOVxx5/SfOsyTWsWmdwxFRziz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F556UfS/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F556UfS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85392C19425;
	Fri, 17 Apr 2026 23:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776466810;
	bh=LeC/2khI4b22tOIYCTEpBLKjhOVenzW7I4bh1B9fvNE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=F556UfS/zuxq6755kc1ze6Eer9+yuHPzvReMXhQ0qyjMOyt1peqBD0gTkWEZWrgR7
	 gorrOk4En/KHbl6Yci5mVDflYCaxN+yNxyYJmtskGP1HzkBhDvlMHRLwGVC3SiwoqE
	 RWDZL8Gf4ph7sDtYCPLayRHut7aRHmxS4WTTXnOy49IG9nZYN2xSOQ3BcDKf9TpDep
	 M2SVVeNVBr9F0ut5R4QdOLIJ1on/FFBPy/oMJBjo3ZhO6PwgQntoEIBBhY1fyPt28G
	 mVQ+b7FdqXMLlR5FYfk0SdjVYrSW8eC9laDLUhqDpwwioDKGZGaA/fxnYSOhqTAIG2
	 dO9nJ3sF0UWVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DFA380CEEC;
	Fri, 17 Apr 2026 22:59:39 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) changes for Linux 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <a699673d-8bfa-4d5d-9831-6e420ad56280@intel.com>
References: <a699673d-8bfa-4d5d-9831-6e420ad56280@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <a699673d-8bfa-4d5d-9831-6e420ad56280@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-7.1
X-PR-Tracked-Commit-Id: 6c724ce0ec6ed8608917673bbb363b208ce2644c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12bffaef28820e0b94c644c75708195c61af78f7
Message-Id: <177646677748.187646.18116749913690568228.pr-tracker-bot@kernel.org>
Date: Fri, 17 Apr 2026 22:59:37 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams <djbw@kernel.org>, jic23@kernel.org, Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 Apr 2026 11:00:02 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-7.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12bffaef28820e0b94c644c75708195c61af78f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
