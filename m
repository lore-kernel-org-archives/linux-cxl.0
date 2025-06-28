Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416F5191F91
	for <linux-cxl@vger.kernel.org>; Sat, 28 Jun 2025 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751072515; cv=none; b=DbCkVhlC1saChm/OVg+hLJpaCQWwwR+ochHl/feDH2pWJLIZdQUerV3DzCYP/WANcRyoZWcz/tyADmtFyeIOAew3OqXKS7zlejkA7ACMAwYa2fDHRXTJmDcnzJfTIoCdtqBhpB2JFsJ5L3dyvQxe9jPevEnDKRBOWqRMIXtP/G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751072515; c=relaxed/simple;
	bh=tApXBx7zmFhT7IozjpgY0cNJ9enefQcGtrNkEZLJFKk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=am6cLA9Q82+Sri1Hf6DndZu5Qbx76Rlz76axBcjbrUllT6Cj40WZMnPxAMWyBUHzxb5oHkEnfF8gAYaBXhO2MHkUIBT7XrJRgvmZ4V+4vYtRE4UrfYYpC5lczt0QejonhutMTVRkoVHcLNm135hcDh2QoqaJRSGb7rjlQ2UwKrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahf4/E+Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahf4/E+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163E6C4CEE3;
	Sat, 28 Jun 2025 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751072515;
	bh=tApXBx7zmFhT7IozjpgY0cNJ9enefQcGtrNkEZLJFKk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ahf4/E+YvWb0+KkFmZGML7hsTq+x3yc8L3nl2WbQFKkeuzKK7dHHWjNP3R6hMo37a
	 2efmGTGwRpbbVwlRDLPrBiE4bQhZeEbSPjrdwK8dpMSXe1JAIXj2Ula1DQ9VeiR4XI
	 4PEnaZvAwA7008oL4eL8DbbUNMumI0VHh7qU+o9ZxBDngh6UucGGE6P2IaQLayw5hr
	 oVivjuWM/wS56qE1UrwW/b+C/9Sc3IrJUx5ysk0nB0OoRijwyhUu+p/7kaOpeskZZM
	 Twf5jre6WmzozzU8RnI7IXXhKqzPHK9t8PJLMKMlXtBdJ/PqkMb9uUMc3oIkJ6N98C
	 Wmq4Xjq/g3cnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C5C38111CE;
	Sat, 28 Jun 2025 01:02:22 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) fixes for 6.16-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <f6947076-4709-4346-8917-105743dfb98e@intel.com>
References: <f6947076-4709-4346-8917-105743dfb98e@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <f6947076-4709-4346-8917-105743dfb98e@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.16-rc4
X-PR-Tracked-Commit-Id: 0a46f60a9fe16f5596b6b4b3ee1a483ea7854136
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26fd9f7b7ff3794c5de0e6ae538cead53118b4c3
Message-Id: <175107254070.2102963.8741166982515900624.pr-tracker-bot@kernel.org>
Date: Sat, 28 Jun 2025 01:02:20 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Jun 2025 09:26:10 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.16-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26fd9f7b7ff3794c5de0e6ae538cead53118b4c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
