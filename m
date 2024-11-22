Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF0E1A4F20
	for <linux-cxl@vger.kernel.org>; Fri, 22 Nov 2024 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732314761; cv=none; b=DGaK6E7L+NtAP42cuz3WHoUydSLKhLbfXlVVrM8EWmx2Of7OgHQLAhypLUV3KlHokzdBEyMcR4pExQxZPslSWpHpH8j5ZCa5J0dkxd5xbCtRiUrBCDPyEN5M631VY/j3lbrU2ZhOh0xPt/YaPJWkp9Kqe0n2B/QppFilWVjwBkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732314761; c=relaxed/simple;
	bh=c/myV3TfaoHbIuiyWU8ba202A4X9yAMqQibGHgodzL0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=m+Eeqc4IqEPwOKevDkUZDFhUDWZcyWx+0i2/+1XLAWyCEwcq0Zber9lQEsUjjatsSvNmegUdLP4JVWWZVfzgSUjWEevUJ4bRz/JPBtobZMm6b4iyWGfsuLfQFtyX0lcMEG00CpOlTT8Q1oq1rtqORkQrl2TE8lq61OjBmNgsHiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vyga26tx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vyga26tx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526E0C4CECE;
	Fri, 22 Nov 2024 22:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732314761;
	bh=c/myV3TfaoHbIuiyWU8ba202A4X9yAMqQibGHgodzL0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Vyga26txUcggl1gWYh4f/E+T+qROtEn+i2YoR/wuliA55Iz6NB0Y5FszTi8O0L1tD
	 M684zlEEm98jcYU2quWALGmgoKUeEzk6p9E7MLqvNeYcg11kjZ1R6N6vhC4gPsUXKF
	 nNluVzgOXETArCaRSX3dC8EgHnqwbNwa745NJcnceliBLLNOmtHyLYVhqf8tb7/Qlq
	 g2UOELseuBMmJeJhpfEbPpoSLr3aTT5P0F2b0GE7XDx629itLSar0LyhYuwjntjGX0
	 z4B4Mrnkb+TQ6UvVw9N147kpSrb2HjieKO2uokBVG9tzd+pB5h5lB1GgSYj8JekZnJ
	 86RpDTgX21i1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCB83809A00;
	Fri, 22 Nov 2024 22:32:54 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <5662041f-2563-486c-8e71-077f31dc2ecd@intel.com>
References: <5662041f-2563-486c-8e71-077f31dc2ecd@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <5662041f-2563-486c-8e71-077f31dc2ecd@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.13
X-PR-Tracked-Commit-Id: a83383e2ae7c499ff7b318945d9b2fe4e3006c2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 563cb0b1e736853cfc78956b9de362d2aae74887
Message-Id: <173231477317.2827182.3245227798642934546.pr-tracker-bot@kernel.org>
Date: Fri, 22 Nov 2024 22:32:53 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alison Schofield <alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Nov 2024 14:15:53 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/563cb0b1e736853cfc78956b9de362d2aae74887

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
