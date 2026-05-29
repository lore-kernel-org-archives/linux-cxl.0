Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD81409602;
	Fri, 29 May 2026 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085625; cv=none; b=lE8kA5tdqJ2LiJ3qLaZu3MYjyYCutL6sQnQ3pfrvPTsuaS5zannVlb7e6LBzDSpapais4avM61iWQR/LBQCKDsCtfy7HG/AYxIMYEe6tFVjpSns8XUxqmTX0aOhF5gFlajvaqY/TW1FRrrsZpX19q08g6dTxB8MUlFiele8TRTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085625; c=relaxed/simple;
	bh=Xmth4Qqxc51mCgnqH00KLrb8w7Tp4AXmpc4cP/xuMrQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HsJtOcVFKIeEZigD0v/LiM67luM9EbaWZsVPNqgzA9QfnnupHcrxT9xYT/m82GmwHv/r9S0PppA4r7Wu/Yr7Hf893+ZEL9D1tISQkRnmgTPRHBBFwEAybXPsq+kHFvesUr6/k7jWEfKXZseevB3sBZU4RW/DDHrthVbzMwynVN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhdNohNd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhdNohNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304AE1F00893;
	Fri, 29 May 2026 20:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780085624;
	bh=JJZb/7j+jFRum4BbSYghs9vGrT4Td2jiYnsfYpYJE7s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=XhdNohNd/F6LXgM/qSJGsIgn5qClruBTLOsty47W9MnZOcS9lMg63A0g6NxuCJZB3
	 58fUACmF+qmfebY3fNRou68jtbBGBnI3KtOEjdBYOASq5njtuYTonMkdUklPH+Pz2s
	 Kv0sP2zS5nzZQBRjFux7Vek5cwYEAam4d3PdPF20ccmyQ96lIt7HrNawCW4XOITuvR
	 SRFh12GYuTjGfo1zj2uX1Q+82mA3mUwlnVCga/Sx1JKPo/Xa4F9VNsRwswB770Esc2
	 5c7WtVmIpMP7yd2TmaBzmMXMREjaUKY8I1smj/mzFc/lMcKF67lCXO8r4sZNJZoQA8
	 K6lUz3l9Q+rdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A9239301A0;
	Fri, 29 May 2026 20:13:49 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 7.1-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <483677d6-0119-4c07-8cb1-3fa9cf7c42a3@intel.com>
References: <483677d6-0119-4c07-8cb1-3fa9cf7c42a3@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <483677d6-0119-4c07-8cb1-3fa9cf7c42a3@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-7.1-rc6
X-PR-Tracked-Commit-Id: d90f236f8b9e354848bd226f581db27755ab901d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3101173200b8ef6b725d7ab289e9508659b20d61
Message-Id: <178008562777.1949175.480115832504906883.pr-tracker-bot@kernel.org>
Date: Fri, 29 May 2026 20:13:47 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <djbw@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Alison Schofield <alison.schofield@intel.com>, Ira Weiny <iweiny@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 May 2026 09:17:24 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-7.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3101173200b8ef6b725d7ab289e9508659b20d61

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
