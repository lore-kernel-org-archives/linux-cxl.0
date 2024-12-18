Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2B1FCD0F;
	Wed, 18 Dec 2024 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734560411; cv=none; b=D95sYAVubyh6KB2wP2WR2Y+2/DJjJ7Hl/Dv/ICaAZfAwF53emWqLVavPUr1jugBTorZLex3Ce3+qbIKa1VwGNW28ZMwNHuVYcESqOZgTT36l2gEWddLM0dFj4NJ00SxZbhyAceyFl6fEXZi2iT4YuZoVLjGhLjDAXGnJUpmePjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734560411; c=relaxed/simple;
	bh=2RUnEJwVV1hTAlnkvUBmCV/8UXYNINhbbd6C+r/yyro=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VrJFNkIkn7/Dm2B5zYPj/b+rJkY/UgQwiekodMcjRNLCRZ0fncUNmCzF68QoN+Uabyz3PYZca9WXWcYgmJJ1eSsYxgkwWtNiv8mSCWrjUQ6tipSFLmQ8/rVh7vlQvV/Ht9a/JYKEVD10Uv2gIWwMQG/YooayrdMyeLf89XT1FyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nP8uCC9N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nP8uCC9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3702AC4CECD;
	Wed, 18 Dec 2024 22:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734560411;
	bh=2RUnEJwVV1hTAlnkvUBmCV/8UXYNINhbbd6C+r/yyro=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nP8uCC9N1ESvSByb/jHH0shpZpMvCt0ME4S4JEcmI154N6IG2ebjdQqEvS3BQkNH/
	 gFvY7ALaTYACncDg/gVGWfK7j0v+DtPNK6COZBbEp/NThC0FQ1vdalesFNkmoX2kmO
	 V4qeL4Wod8JCVGs2D1NDW0ZpH3xzdh/g4ndcLZQN2Q8F4+ZBgWo2oCl/WmVZqQanco
	 UsGGouItM9TcmKqScF75MnEYl/cjU0Nq34buA1qj+WwbMIsurxMWRMMHCsNP567T94
	 QIe4GfnBWDQnWhUQ2NVpBjcxLad/jbYQisEKSWJEYZxZfBZ/jE0+MuF5BQJXObycqM
	 dngV/PeeSDENg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFC03805DB1;
	Wed, 18 Dec 2024 22:20:29 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.13-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <6762e48637297_2bb90329432@iweiny-mobl.notmuch>
References: <6762e48637297_2bb90329432@iweiny-mobl.notmuch>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6762e48637297_2bb90329432@iweiny-mobl.notmuch>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.13-rc4
X-PR-Tracked-Commit-Id: 76467a94810c2aa4dd3096903291ac6df30c399e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b69810f38cb01fbc958190de43f1a02247f56a9c
Message-Id: <173456042857.1744913.12843609768696670691.pr-tracker-bot@kernel.org>
Date: Wed, 18 Dec 2024 22:20:28 +0000
To: Ira Weiny <ira.weiny@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>, Huaisheng Ye <huaisheng.ye@intel.com>, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron <jonathan.cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 18 Dec 2024 09:04:38 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b69810f38cb01fbc958190de43f1a02247f56a9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
