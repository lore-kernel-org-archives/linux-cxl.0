Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E78F33993
	for <linux-cxl@vger.kernel.org>; Thu,  3 Apr 2025 05:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743659182; cv=none; b=NM4v9AHFyAO15I1yVIhzE8xlkIHaNbnIiBKHacMdREaodVO57clpWuUHMDt595mle+vlDFoQMFITdRhbfWIHQ3Q5v92TOqL7o5psux2xGQO9T7LbEiC49R7bNcOq7VJHmaMzL/YJaNQe5e7fhq5Wm3yIJaoYW+uB2yQssoFFIBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743659182; c=relaxed/simple;
	bh=kXwJfsjgkdxRNbqG3ROaWfurHcNnV1vzFG3lZfrj3Zg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bNO3UNNQTHc4ioDvMGogvA1aKjegUFWXew1GFo5ABr5Eb36HKNR5z2zKp/+L7WZN0BqHnZoX6ndD5TYi5eBIes/ZlbgOF25eotIG5HUbn3oHBN94ES7Et2V7VHy6y38HVfUJBAhYCOmULzRcoflB6AmOMRV8HuRRje2u/522MY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW9Nuquw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW9Nuquw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87938C4CEE3;
	Thu,  3 Apr 2025 05:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743659181;
	bh=kXwJfsjgkdxRNbqG3ROaWfurHcNnV1vzFG3lZfrj3Zg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZW9NuquwZaQ2iAULQyKWOwHbLf2xfUOzVnnqAkz/1gW9EwCqQkETpZIIoMZoVuOeA
	 D73u2nYgggx8D47U62OsqrtAs+xho0hR5jB6iTdImVO+oxNS1A/0P49gra+VMvWHnw
	 rutL/NhCaL13GHC18AEhxyjSC0KYQDRBeWyih/m05Yfmg7wD6+iUgYYKfnzt3rN+KT
	 +1i0VVhliW9wLhiBR1Wt/TNeZeTVX8OycUc8mKgRefjBtGy/vUcuLLEWIRqAsmWcef
	 tqc4urn28zOWElftaN9VX5HmDmWGThdAcw2fvvX8v3sFMib/0M1i1BO7B4AJp2Nvtu
	 B1Z5wJdFK7w3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD57381090F;
	Thu,  3 Apr 2025 05:46:59 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) changes for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <6a5fe8c7-614a-48ea-9f0e-74da972a6589@intel.com>
References: <6a5fe8c7-614a-48ea-9f0e-74da972a6589@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <6a5fe8c7-614a-48ea-9f0e-74da972a6589@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.15
X-PR-Tracked-Commit-Id: aae0594a7053c60b82621136257c8b648c67b512
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01ecadbe09b6c685de413ada8ba6688e9467c4b3
Message-Id: <174365921823.1797294.2131606172072372347.pr-tracker-bot@kernel.org>
Date: Thu, 03 Apr 2025 05:46:58 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, Alison Schofield <alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 31 Mar 2025 11:02:36 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01ecadbe09b6c685de413ada8ba6688e9467c4b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
