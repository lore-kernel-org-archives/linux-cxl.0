Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6901415AD95;
	Sat,  5 Oct 2024 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728151661; cv=none; b=FfqllmFzVHqJEKi6awTvHeRUZmvC6gxq/dIYJPQw9vxo/jbrSPiWQ1V/o5OtSLTIY5y/9/G59wxi0VjpdL5JD6IVxYBJ3BLE8ENeo1dh1ot74Mnw9RGICRx+RGXveUOaBowKQaqNRaLqlVCy9Fnf3hjxUtyocw0F/vQiukdYPSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728151661; c=relaxed/simple;
	bh=GmmFyKrU5swxZ2BugKkkMRWFXAjbS4LavYSlMMbAqZc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JZo9CWLZS2z2uOQDxqXw4JKjOEFVaqGJOAg7glBovi0k3PyKRlM/z+SGcw23eqlZbsKIBmFXECSGUCJitR7GH/Jt8Drv0aJ42fFWDWJEzTETyh+iSSt+HH6zOQPV6RF3yutWhaUnhnDTTke/b1sUvY/CGOjcVnIPUt1e8wngvVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGse38+K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGse38+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF61BC4CEC2;
	Sat,  5 Oct 2024 18:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728151661;
	bh=GmmFyKrU5swxZ2BugKkkMRWFXAjbS4LavYSlMMbAqZc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KGse38+K9FzCJs98EE+BxSgDC/LP0LbohDbIYLtxaMTwVnDusBrFaoMqaoTufUabd
	 B6isnXZC+nPYD6TrZWGgMY/0DWQsiqI6I++vQoODpyII5KbrQg7VNwbRhAqF6YDq2Y
	 D/+emybIKc/3YEASXIM0WFq7AyYqzb+u74a+lS7wIk6i9dLe6YJAe0ru38Un2g7xHq
	 BhYVGzAo94qYFvxkfaEBW2dY4FKo8/en7az/Nn2bAavMf0Xa+sFvWLVN8Oiz6y5t4Z
	 r1PEYhVw643JXvCdKne6iwaB/AnIarb3oEaE6y3CH8maYeqBX8d2+gEEODU/jLhSsr
	 +2HHovt8oBWBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3D33806656;
	Sat,  5 Oct 2024 18:07:45 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.12-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <6701760b2e390_16041829420@iweiny-mobl.notmuch>
References: <6701760b2e390_16041829420@iweiny-mobl.notmuch>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <6701760b2e390_16041829420@iweiny-mobl.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.12-rc2
X-PR-Tracked-Commit-Id: ee1e3c46ed19c096be22472c728fa7f68b1352c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c50f221837e9672e67f0a6be40ee02974cd7851
Message-Id: <172815166458.3145223.9175011205009966813.pr-tracker-bot@kernel.org>
Date: Sat, 05 Oct 2024 18:07:44 +0000
To: Ira Weiny <ira.weiny@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>, Dan Williams <dan.j.williams@intel.com>, Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>, Ira Weiny <ira.weiny@intel.com>, "Jiang,
 Dave" <dave.jiang@intel.com>, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 5 Oct 2024 12:23:23 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.12-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c50f221837e9672e67f0a6be40ee02974cd7851

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
