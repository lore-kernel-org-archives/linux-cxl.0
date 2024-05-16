Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3BC1DA3A;
	Thu, 16 May 2024 00:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715821016; cv=none; b=h858rNSTs3U+9odDeUN8cSCU63H3GdQ9HBFT38Xvbe/fQKc1NiROAkuVCgOdNwkz+ENSfvWVG4shkMn0F+DtNFdBB8aGMhzd2lmItlYYXE0o5YIe7f0zgnqp/CxG6oqBOP1tk7a5RiECU9GipXK5ay5qS7CWlcfBdFC4zHHES6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715821016; c=relaxed/simple;
	bh=vWtp5dyQ2rBZxFEcek4C7avvuqJMyWeynbzFScUtkJM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dAGMdwnn8A49S9NV9QSqP06HtT/RrUAvafagDKbX1w2YzgGHcH0Y96u6Ph7YEEEpVwwGJzocuoexrDb7idxu7z2TFOLMh2fvQTHktcElrX4WconCKvlnkaqClnbw80TiOqPNqFL/74txD3h0WSfiyrOC7Ss4rJKjK/Ws6IW0sk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLqMTb3f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLqMTb3f"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E5B2C32782;
	Thu, 16 May 2024 00:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715821016;
	bh=vWtp5dyQ2rBZxFEcek4C7avvuqJMyWeynbzFScUtkJM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dLqMTb3fTEAK+yGtf8i8CLafClKErr6IfYP2YCTPaR1kxo1ZFno6d7LfYIpz94J3y
	 x1X9GMzWkNuJCVNx/xdRTlV/pXbyvnQQ7HdanFNJ6CJCNZR+iJeH6AfwDEZt1ux/fH
	 WlUvWnWZkJWprVwkY9T34VgjM43MSm6ycCnFHbayzb+br//lge2PZWiphSdDXUT9N6
	 zvL6wD8wMVEDaOI+5Ou7ipCw8CCrEWH9sQEws8Lr00b/T9Y4Aaj9b6i440yMr6ygxB
	 mUGsK/83bAUe94C9uygUdO11NfGQ/8UhMMrdSAq4Leg0q33Wrj9brk6KO+Y5755jMk
	 lJKuSH+M8L26w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76635C43332;
	Thu, 16 May 2024 00:56:56 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <99729afb-d538-4172-9659-ea12b993c6c3@intel.com>
References: <99729afb-d538-4172-9659-ea12b993c6c3@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <99729afb-d538-4172-9659-ea12b993c6c3@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.10
X-PR-Tracked-Commit-Id: d99f13843237cf9dbdc1bd873a901662b4aee16f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e9250022e9f2c9cde3b98fd26dcad1c2a9aedf3
Message-Id: <171582101647.27993.3085680135071107558.pr-tracker-bot@kernel.org>
Date: Thu, 16 May 2024 00:56:56 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny <ira.weiny@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 15 May 2024 10:42:04 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e9250022e9f2c9cde3b98fd26dcad1c2a9aedf3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
