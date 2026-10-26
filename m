Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035493;
	b=EcfKXJbKW5vPRum0pTAaZRscwq+mWgBlZ7IHKujOkFYPUHnpNktrfqPv175uJxUp7Uhp
	 PqlviRAwyJikgcg7ogXchB+att/WLQKVXM/a1sS7tUMC80Im/RyeuDY2/TgXCy/1UT7gq
	 5eydgs5FFBms4+D+vb9zp+x2yVLSlLUehQNHrfZSB3YhItrXY3x3FXDIRPuqrGdKrHwr8
	 TKAONPv/7x3WO+AMYz/pUj4UtRe3EGrhUG6D06dxYqTiwin5xs3tJ2I7Ul7cppjWp/Iux
	 lyzBzQc1J83qYJ4zzZ7wgG14L9szO9CDntURLJfRGTbBnJQMU+zvt7wkq+n7bv+tkMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035493;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=u/DbbleB1yxzNOmb95ORYrmAuG4KvpZHlkEZVirEP1o=;
	b=zpwkuMbTpo7qB126MlAO3SxjyY46VSqjvLYyKhJx7TyiYjfCTJCmDqVfAbiaGWlkVj/K
	 a+wbi5wUDVa1WsnlQ8MPnYSrYnfZhnn2LyjGDDWkSBdp6iqMrQ0lk/vT97eelQmnTPcHF
	 ZnGd98f9ejDaI1h4bFm0Iyj9GtBjKqVRzAL9Q5JrwbAsVlAvUDWoDJx1QjyaqFt5CfFEK
	 5Gep0o6LYDFOIy5LmRJ1+XUbJCZcvgchipQl3uccpoD7ndoD+mJBe2FDIrL54EsqhWkVy
	 +wHGbmkqNWh0B9N0ooNKUm8FLiOm5w7aAt6qopG+LgWA20SFH37A+tx4+5SVimoVSmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5thMcXt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE490606A31E;
	Mon, 26 Oct 2026 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D5thMcXt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71F71F01825;
	Mon, 26 Oct 2026 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793035492;
	bh=u/DbbleB1yxzNOmb95ORYrmAuG4KvpZHlkEZVirEP1o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=D5thMcXtOJmluOYsp6g9oQHFshxESYr+Wtgj3162rQ3bFN2ko+IGGY5b9bpxK3osp
	 BeH5vM3B8/HrNp/wWm2s4OPXDtZMAT03mmVdJATbg03TUYj9RRNIzR4KS+Zv+TRd/G
	 qtP81mykgKEDxjK5Zy5Pvzqy8uA/GnD8b4yNUrt3xtrAbrdRhsTWlCFD6t25qfBKNJ
	 /aWmu/7hw3kPHIGjXGdsUEkVROWx7aEayEr5U7oWmsVubjn5+pv826m//Q1H7I3LL9
	 hg0I81GVa5QJwWOESYe1lfmRRUnE9x/WxGag65YXpCiEDhM6GyalN3CK3h+AIqNygJ
	 fObmqA8N7xrsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE6063AA58BF;
	Mon, 26 Oct 2026 17:24:52 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) for 7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <038679a4-e6c7-495a-8283-c3d0670ac191@intel.com>
References: <038679a4-e6c7-495a-8283-c3d0670ac191@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <038679a4-e6c7-495a-8283-c3d0670ac191@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-7.4
X-PR-Tracked-Commit-Id: cf15f9f2361dd4002203716b7b878393c0eee4bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6bbdb67a4b9f2366debd8b5b05b1822490982ef
Message-Id: <179303549140.3291751.13917106703381824376.pr-tracker-bot@kernel.org>
Date: Mon, 26 Oct 2026 17:24:51 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Vishal Verma <vishal.l.verma@intel.com>, Alison Schofield <alison.schofield@intel.com>, Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>, Li Ming <ming.li@zohomail.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Thu, 22 Oct 2026 08:35:10 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-7.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6bbdb67a4b9f2366debd8b5b05b1822490982ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
