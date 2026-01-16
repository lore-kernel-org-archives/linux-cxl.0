Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38353314D2E;
	Fri, 16 Jan 2026 23:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768607181; cv=none; b=rmdKwEc+VctCvVjBEjWoqMaic4dpr9OhqmXGd+cOuTHytgCZoa/vehNLH/7Iv9Ftl9/yof7VyfaenzvaEE9wFzx/GP0zUKVgtp9wtv8OKcpy1az2gg8thqmeK/Colzskad3XEOx4/76ugoRUBwwX5Zr5yPRG5sYKm72qrMxe0mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768607181; c=relaxed/simple;
	bh=vH0T080kLpK3KQnyvAxprSDpbScdwpqDLb87OODdebA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A7c6plYdMVu6ky6QOuzQkeXKGJ8/zan/j+I/JQSrP1YbGjbWgLN4DvIxfjtTN7ePS50qJ2VUTdKk3FosMKphyn6L/lEYSKrxvBajz8nl8rd+mU7/QNpqk1QK/YYe94H+L1tnSSNEGmnRQfq6KnBl2AfeZEYNMs4NzCvb+tYq8Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffjdX0qV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffjdX0qV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAABC16AAE;
	Fri, 16 Jan 2026 23:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768607181;
	bh=vH0T080kLpK3KQnyvAxprSDpbScdwpqDLb87OODdebA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ffjdX0qVc3fdNNCP1tchhUgrjwu/D++2Oj39ulogK0Pnl8jp9rzu8dLb/+30SW4v0
	 yV6nX2tHgqzhLIOaH82rnl6gckSNQCnIkXht/MJZLpiYjGanyPP2newykXgrZ3m/I4
	 j5dDTHcWgXyLG0tykbtAVEz1ueo+cCjP+Yx2uQ0aT21OeAD3Yo1pjWUrqcwexwf1bc
	 ED/b5fLUw7QTiPkRVyw7fvYyPjT0E//a+ulutfeTJjZGPPUVpkuaHs1mpS3x+H4P3v
	 n9rPD8LGh+xA+/L8T++5wRsYINHtlBi1nuhlAqFFTbxiCB1G4rsrr+cAe4rn9CGSPz
	 s/2i3JexLbzog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5B46380CECB;
	Fri, 16 Jan 2026 23:42:53 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.19-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <fe2b0fb8-8203-4630-b974-54d223353c24@intel.com>
References: <fe2b0fb8-8203-4630-b974-54d223353c24@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <fe2b0fb8-8203-4630-b974-54d223353c24@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git cxl-fixes-6.19-rc6
X-PR-Tracked-Commit-Id: 8441c7d3bd6c5a52ab2ecf77e43a5bf262004f5c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6782a30d20775bc03d516b0f56befc73f3893be8
Message-Id: <176860697241.838122.10502547025434034114.pr-tracker-bot@kernel.org>
Date: Fri, 16 Jan 2026 23:42:52 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Jan 2026 11:03:10 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git cxl-fixes-6.19-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6782a30d20775bc03d516b0f56befc73f3893be8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
