Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C48F288C34;
	Sat, 18 Oct 2025 19:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815390; cv=none; b=SOYAK6YZDcBcykWXThpch9DaXKeXefDfvKpE3GCZJsrpSFGXBEIHf78GKxGhl8QqynDVFvnji1kh0RmVZfKoEm/g2VDzBD74yjlPIeKuYEig+P+SoYph9+6qnb5bidScYXfl8mjIqXnbYcnq1CFF0eb2+oN8mH7phwYTP6nrlcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815390; c=relaxed/simple;
	bh=InE4Hu+liqrKpegKA5uPHCMkEelWune79jtS1en73h4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EIC9TYqBLDKSWCjUGZbV/lcs4klCft8NLhSacM3zd9p+rxOZtALmIaTPTnnv9AwNo4yActMQCIcGLP5I28Qm7slu4oS5CsCLFSLb760r4PUSXCwqFVZb8nhZNDgyfI2RJUvLCnjM4tQjdpYvRl35Fumcalvj1XED/Dr2rEQMIxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJk0hXth; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJk0hXth"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225A7C4CEF9;
	Sat, 18 Oct 2025 19:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760815390;
	bh=InE4Hu+liqrKpegKA5uPHCMkEelWune79jtS1en73h4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jJk0hXthpr+xM+19TYsCYHqKKIJ56Kf37WlGBloY7jFC9factLqHvS5Gn2o4hcByI
	 LXp+X+0vQDKXYluV3dhNMQO8AQHKzY8ouTUifwUCH81Cqbwrzo9rd+abmmF/e9jE40
	 FRe7aXCM3Y16WdJ7Tu2zYNFRWl7DziJmZzL5D7RNyXI7JLKrZVMHn3coKQx6azPKJ6
	 obydAlu/LaR1B4SIoFtlioIBgW6A3GwvJroo7FccNQnipUvwn1YulkGK+ZrB6l0RG8
	 Thf9rtwikzchejjBSTTPK9qCfpVL2wRJaPKfCDQMEZM5TappQddmrpLMtHkMoKzu1e
	 RDgYIf6eybthg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7124C39EFBBA;
	Sat, 18 Oct 2025 19:22:54 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ea01d693-0d81-419c-ae20-6332feadd412@intel.com>
References: <ea01d693-0d81-419c-ae20-6332feadd412@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <ea01d693-0d81-419c-ae20-6332feadd412@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.18-rc2
X-PR-Tracked-Commit-Id: a4bbb493a3247ef32f6191fd8b2a0657139f8e08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea0bdf2b945e91137cc465d3833aeb659ba93d79
Message-Id: <176081537289.3081941.5281546598724773428.pr-tracker-bot@kernel.org>
Date: Sat, 18 Oct 2025 19:22:52 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Oct 2025 09:30:49 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea0bdf2b945e91137cc465d3833aeb659ba93d79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
