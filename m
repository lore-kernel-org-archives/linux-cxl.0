Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795209238;
	b=hc3/24G67Oe5eGce1ZcMot4YKg3rV5zaw9od05YUao3Z9WEc7UqdywztByRvUmRs92wg
	 TRUGRFKXvsY/Bw+uWDVG+CafCMoh8hfq+j46S65FYWZaOvLB/p5WIfxBUTFsLZJnl8GD7
	 baXiDnzApgtY/4hgv9Z1Y1WtuN/83TO8l5OqEUrkh+Ob7BRhdL8b6RJavplqVe8HCDmuB
	 oJmvzyF58wbV0weX/BmcD2VPt6fO1Rl11PjRV8NrmvsgEpAx7LZyT+RyEzNfSSbyulhB7
	 OzfhFcEfVTZC0h+DvNgslsfDuUdNA2ImDuTKnUB3f5lJCsui6xNVH/3Rto3rtc+y01g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209238;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=uYh8SPUt2LrSL/s2wHhKwGI1fZWxGIc0LPnwRkHYdOY=;
	b=APAfqjSVWsjdTxcPnxu5zFldsRpuAxo/LTdG9iIALxM+9GLX6jZpaMlJYR74kPz8xYJ9
	 lsK2GxGGoT/qceLUIkHgToEYQuiQrJf4COmsvzelIgLP5LP3ouVjfw72CBicRGs+aTNDK
	 Wqlkhe+tJbFJ1Khjm8U7jmd9KFwytcfcaiP0JrfIJHDQxzWum9zex9Y0Wr4G3WGC1qlzk
	 xjad2dSolH7J74JIzLBZh8Ox2wz4Yw+FfRMnoZmP9bjisLb/ZXhdGny027tvYzseebqRX
	 azOPzTwWgeY/5VgkkE87oVE1B4R45dzi3V7iv1oJ87VleNm3CFwaUo+eRFQBLPKY5/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEl2jQDp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A43606A68D;
	Fri, 20 Nov 2026 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEl2jQDp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DEC1F000C0;
	Fri, 20 Nov 2026 21:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795209238;
	bh=uYh8SPUt2LrSL/s2wHhKwGI1fZWxGIc0LPnwRkHYdOY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=nEl2jQDp2I6Lv7N0bv4BbOA07V+HKhTBMk1W8j82Tw61lGXSz1RBtW/+/Yi/5vNsV
	 PYP03OWZFo3kfvXco7NTVP66NosbDUJCxefImhM/FR29u0bwugHEjpj2xletgoY+yh
	 AVGu+qZGsSbgfjuWxht6I+cp4JVjwbaZSK9pwBGJI/b+8maIrz1NgeCquZSo2LuM7z
	 6JB/z9hEtK8DRluK6+5xbkzUXIXgMmYrz6aXHLlEankzgZjobIU8mi/AUNt3T8W3oZ
	 hil1aJ+ggyWEJdnETOQRfKxZWJz8HwHm8fKVuk4uZtptHYIxatidu8OPsCfTsq4w8v
	 pE6ggDw9CXE2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3F6380A964;
	Fri, 20 Nov 2026 21:13:58 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 7.4-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <c2b42261-71e8-46c1-b847-16b12ee81676@intel.com>
References: <c2b42261-71e8-46c1-b847-16b12ee81676@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <c2b42261-71e8-46c1-b847-16b12ee81676@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-7.4-rc4
X-PR-Tracked-Commit-Id: a02576de05178f15ffe6fc7551496de7de8acfde
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b98adc197f7300e875fbcd4cf5dfa5ebe3d6dc08
Message-Id: <179520923695.792202.12507789531731571982.pr-tracker-bot@kernel.org>
Date: Fri, 20 Nov 2026 21:13:56 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Alison Schofield <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 20 Nov 2026 10:34:45 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-7.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b98adc197f7300e875fbcd4cf5dfa5ebe3d6dc08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
