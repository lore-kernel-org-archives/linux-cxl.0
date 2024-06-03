Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987CC13B791
	for <linux-cxl@vger.kernel.org>; Mon,  3 Jun 2024 22:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454858; cv=none; b=Wvuy5i8GMMAp2qfjxte+F1fPvvg6R1YwXT36uQ9GujMfLwMvxt5y2gwgj+zJQ8Ri/1ZR8yhZWTD2Jw7ujZEfzZhMj5lR9W/NWSSxulGn0tOUn+ZwFDBVXDEfNZHUUFM68DTcXYKY06rCZIb0JCFqUiuOEXjqRvCArvdj5jD2y4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454858; c=relaxed/simple;
	bh=fwKyqH3th4zyUa65IdxFMpzehQSKV73E7rpoLwAWbH0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qGuntd3FtLPS4fV3sTs5vrtHAgRwaSbzpqxiL6il0tLVL6Ogv7ibz2Ka8g2aRbhBB0j1KO3kT66wytBJmzLcN2FSQy3BODM7TpdJCsb9rAISpq4i3PejIzzftWdnPXwwIqgzFQ/5alvnXdxr+tBkrl3H9ktzJTn0hUIwEYMAUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVqd0PyG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVqd0PyG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75B8FC2BD10;
	Mon,  3 Jun 2024 22:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454858;
	bh=fwKyqH3th4zyUa65IdxFMpzehQSKV73E7rpoLwAWbH0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AVqd0PyGAtByvpcvvZ0kfbjV6+G5SYY6daz8s67FV7c8dsa9OcAxZbQ89HgWIevHk
	 jStHlRd4RR4nSAYvCOjuQCtVTb6cOIYMyFntyRhSWGpjLUVL8TUvnzg77o0EdSD3gY
	 oLPGQF3GloY2RNnmFFkP1VddgeGorxDWLUsyewIMNHRzRpbdHE1Ql/srg6r2vG5DSI
	 ulgxGvyyBYziNmhOJKZMcri/c2kzUKkC+pi+k4ajYS9KrSudrF5LMLhAQyPXtA0FFr
	 KndpwL54qugNow4K0ChrgeIhCFMU766htvjBlw3zpwpAGu98+4yvhuSFUO3csNjKhL
	 T+23V+fmq1epA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67D3CC32766;
	Mon,  3 Jun 2024 22:47:38 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.10-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <2d329d00-c5eb-47b2-8529-5cc177fd0770@intel.com>
References: <2d329d00-c5eb-47b2-8529-5cc177fd0770@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <2d329d00-c5eb-47b2-8529-5cc177fd0770@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.10-rc3
X-PR-Tracked-Commit-Id: 49ba7b515c4c0719b866d16f068e62d16a8a3dd1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ab79514109578fc4b6df90633d500cf281eb689
Message-Id: <171745485841.7043.9128644447744375882.pr-tracker-bot@kernel.org>
Date: Mon, 03 Jun 2024 22:47:38 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny <ira.weiny@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 3 Jun 2024 14:00:17 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ab79514109578fc4b6df90633d500cf281eb689

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
