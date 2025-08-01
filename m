Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D97238157;
	Fri,  1 Aug 2025 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754090992; cv=none; b=ct05iyLbjCs0LdA+XEOBTC+92mIOozZAMvwfdW2XBmUVkb8PHlMpzL3VIyambi983eRVczOldSAlQ7jmN/0iSuCg7mJWNLOOxkAyXp9BU50ndotGszrI86HLrGK0MeSBsJnxg86OzuvFz/qaV8KR2dNtHtrBQw5VpsxIXjPifZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754090992; c=relaxed/simple;
	bh=GFvO/zmSU/s3a5Tkk2vXmQ+JmGfHYiSCJxrGZC2PXm0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=j/7pTk9YsTpBd2Qfg/0UjzTdq5YlCEE/SWDrkMH56e0CkOT5procULWofHvK0uA7o4SGvPjNo1wrhegtbnI6Yekor/97EGXOyxkcLnBwnz3+Yoq1H/x4VYqjdjEmrjx9OkIdL5LdF4Dq5ODiZif+cC6vln69oUgXdRXY18b4p3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESYDMhhn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESYDMhhn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A925AC4CEE7;
	Fri,  1 Aug 2025 23:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754090992;
	bh=GFvO/zmSU/s3a5Tkk2vXmQ+JmGfHYiSCJxrGZC2PXm0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ESYDMhhnIVC8GUTTFjUsgPLwjPpRYSEDvJ9nKZI6+Coht68weJncBVRCbIW9/KOep
	 LPmZHw+QR6GlXvyM5Sk3G2ODwkhxmYBmFrYUNvt4bVq0OPQZH9z4y+GvJzpnHsNZLn
	 uNlB2898Pa2/AijpPQqEGGq/NXDRu97Ghk0dZLQ3dtnnlUhWVnIQ8Eo6DX7aOaccKy
	 7JWoPDQCi/xGgrvUvSaTe8UKuLSDFLir1o0Hi9ewih27NtVzE+eTlPwFubNUVN/qEG
	 2r5RZx0Ey9Lw3822PXKmHYI2mXg4YHY9ANJ68dDFHLeF+paQNAHiD6JDYFBjL/CX/1
	 WE5lRTDx9mP8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34296383BF56;
	Fri,  1 Aug 2025 23:30:09 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) changes for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <d354ab06-852a-41ed-b9de-0663e8efce5d@intel.com>
References: <d354ab06-852a-41ed-b9de-0663e8efce5d@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <d354ab06-852a-41ed-b9de-0663e8efce5d@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.17
X-PR-Tracked-Commit-Id: f11a5f89910a7ae970fbce4fdc02d86a8ba8570f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d41e5839d80043beaa63973eab602579ebdb238f
Message-Id: <175409100771.4150140.204585841772754919.pr-tracker-bot@kernel.org>
Date: Fri, 01 Aug 2025 23:30:07 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>, Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Aug 2025 10:34:52 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d41e5839d80043beaa63973eab602579ebdb238f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
