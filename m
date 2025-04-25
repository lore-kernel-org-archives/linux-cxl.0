Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89FF1F4E4F;
	Fri, 25 Apr 2025 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745624088; cv=none; b=WhVl78s44mSjkJcUXhSko7htmpfqvBrociTJtlUTAL3anmDGOhb77F8mIUKMEslNIrNbuhnBO/xM20zkqMjX9yZacxr1yduLz7O2sSVuiC2n+YRggFbRD6rg4IgBwoYp8IKZKvXfhNs+rX8095ZbD/jsJAD0RMMVvvy0ckBUUDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745624088; c=relaxed/simple;
	bh=lEivvmN2YZY4D1hEv0yUoJKHjTRxAnnUDzO83qZegQE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Lf2Sj6Gknrn3AeaHHt7d5RnWgHnx1wt2F9Ml9++HsvhgQjWJdYkJt44fF7+QalXrsjWqJSjPZhPlUWQCEaSuTnmtqDebcUkoc/GDgE/6npcYjtB233dylxSfGual5eImS+TAxCu0COIfCobd0sb5dyN4Ztv6DfJbrk84qLZPjvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEefpCL/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEefpCL/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8122C4CEE4;
	Fri, 25 Apr 2025 23:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745624088;
	bh=lEivvmN2YZY4D1hEv0yUoJKHjTRxAnnUDzO83qZegQE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IEefpCL/S58MO/rsYC2aStQY4JSDYVXLQ/NyPSikiBiMR2rz8sQZbRxCPaaWSMySG
	 m4U/py48f9Lvvco8pMdmwvdfh2nmSMBcM+nZOXRE8sTnPu4Cbb6908HJTPxXF4j9C7
	 ONfXku7OGyviLuYccOmTz5TedlgeJwjY1DOnIEWIXCCy1cN8AAM9OJBW0C91PL94sr
	 BKaaYJNf54wUsQzpImKcZa67Bt6RPdY4HV/1WCQwMy6JZGRUboSFK+eKW3LH5T1tQz
	 1PQrA6FI+DKzuzgBJHJHx2Z+KOS+HvvugeDPQmKQPKoc6fU1JfbHSe6IaNBA5fusnB
	 o3uPE3WEg1FGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0B5380CFD7;
	Fri, 25 Apr 2025 23:35:28 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.15-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <025f2312-9588-4807-a8a1-cb265251fcd0@intel.com>
References: <025f2312-9588-4807-a8a1-cb265251fcd0@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <025f2312-9588-4807-a8a1-cb265251fcd0@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git cxl-fixes-6.15-rc4
X-PR-Tracked-Commit-Id: 078d3ee7c162cd66d76171579c02d7890bd77daf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4017040ad7a08fc78dc0729545d6e1050d3e629d
Message-Id: <174562412739.3874874.6596957117237273643.pr-tracker-bot@kernel.org>
Date: Fri, 25 Apr 2025 23:35:27 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Apr 2025 10:27:16 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git cxl-fixes-6.15-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4017040ad7a08fc78dc0729545d6e1050d3e629d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
