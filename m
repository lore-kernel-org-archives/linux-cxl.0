Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1351F582C
	for <linux-cxl@vger.kernel.org>; Sat,  4 Oct 2025 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759606082; cv=none; b=Y0WjRQ0HDcTnekcDVM9domhhBLeQrT3+JK7RqT8w8XPW5lClhpEyU8Ib8ioFNpuRN+XIrN9Jt40p/7R9iZM7ACAkjPbCf5aeDKVOcmCac/lS0yUAALcPhq6RwVltCmmHXkKDPEh5EXC5K6vn04sAxc6ZTACb5+3CLECnWe/6gPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759606082; c=relaxed/simple;
	bh=XCNq9KLMn58VI1VVlD1Kj+aGUcLvh1h+beB/UrBzZ8k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WwLFMMxN1r1/vpjKxXlXXYb9RAEq5Z1Klftppnxg0etJNtfRlU0ZSgmU5QMDB3ZdJhWokwm4kaXJ92JoixcMcIC0LyvxcN4XY4yoMCZIr0yhnWhU8n3ggSlllT73KOJ6lplIp6B1lOWpwhF5enKczyECgh7etx0v4ZoK42n3ZHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5/Dr/eh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5/Dr/eh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B05AC4CEF1;
	Sat,  4 Oct 2025 19:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759606082;
	bh=XCNq9KLMn58VI1VVlD1Kj+aGUcLvh1h+beB/UrBzZ8k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=X5/Dr/ehjqwbdZZAnU6d2jXIEz+ZoDiL0gv/fe+Pm15+jVAt2bVWgdWz9rEIg84fC
	 RCpoWIyRC9ic3ZinlF8PjmBjhO9a0vdloZ0S5Rk+unr6lrdnv5mR5wAkmXLhL1jRhR
	 +cdY1deYaiPvldTwuIU2hfZvqH5q2tbXhfCsDrEoCsnYgQ87Cgg4aO+xh/l5g/jTzb
	 FRf5EZsg7m+lZANF1W+WQv7vT9HEg9rwlA9LSNfv+uhSzhsjsS9iri9FJqQr3fb7U+
	 X1a1imbyPJkkib59OhftfW9VoKQ9vRA939lOdRJ6S1zLJgmqf6+LdLLATQvhN66aqr
	 FEpkzYqgaR1ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3548D39D0C1A;
	Sat,  4 Oct 2025 19:27:54 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) changes for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <6be82a4c-859b-4b5f-9a91-c398a319d38e@intel.com>
References: <6be82a4c-859b-4b5f-9a91-c398a319d38e@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <6be82a4c-859b-4b5f-9a91-c398a319d38e@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.18
X-PR-Tracked-Commit-Id: 46037455cbb748c5e85071c95f2244e81986eb58
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d104e3d17f7bfc505281f57f8c1a5589fca6ffe4
Message-Id: <175960607279.420492.5145628157028015547.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 19:27:52 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Alison Schofield <alison.schofield@intel.com>, Dan Williams <dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 1 Oct 2025 16:35:35 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d104e3d17f7bfc505281f57f8c1a5589fca6ffe4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
