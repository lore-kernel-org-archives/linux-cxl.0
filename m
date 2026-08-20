Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6971D378D93;
	Thu, 20 Aug 2026 22:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787264589; cv=none; b=FUe+6BOxpgRuTtUcU2/C4kyuhl4F4sYSB+AF0RvTippAUW2ih13AhCrRxHpE2Lmlp9MWY1Xb6geDelAqAKUGlCMz02FG1BsBsU8drFYtieorgoN4ItAMmzY2oQV6KQfGYWy64hP4rJGCd32MQrOHDQZ2t1wMRDd9mqXIkFmY9sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787264589; c=relaxed/simple;
	bh=On4Tlkg3eLih/ygoUmX6BAvQrUeb1afDXrmNKslZY5k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NjO5BZ8d7hThlQKQTsnComdWT83jOIzL/qMhLfPfmokkM1OosuuLh4Jw5wfuP3rIb4yU033gIXAVzFhN8DgyY7eFViHejGUBo4pdmeCkKpToqHzqSv/TJ8+AfcbD4TmNmojpinNxrm/gIbEzKpHVeIm5db/rW+tLRKUWMIR+8WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiBod6lI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiBod6lI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0084D1F000E9;
	Thu, 20 Aug 2026 22:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787264588;
	bh=d8d3n2e96uE8wq+elxo5bgCaqTJmCng2+CKpnwnT/aE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=LiBod6lIhKxkVh2xTB5rJU4p8xqqUHRIMCyKOYL+OSquutrC2DXLvTClItJ/xPKUf
	 OyjocMxDFGJcKuVahYqAEnUbthHlX3svP6TmApQJKCY36bNZCrb0Pm3ZAoQCmWjfDq
	 IdXEtf6D5khqJN5lNFZBZZYZlb3j5Dxnt1ip7AYevaAOq85/5eNSLOwoj3HY5U7w3K
	 WcXsgEhfy1LoWmAOCBSJmoT6pLmTmUokV97/93CEGCKvdxPJIHuhF3R0woO40MMyIj
	 /4TB9yZVp+8rsGFAmaxbmgaE4RsKUZnI5+Mb8vdEg7JxIkhMRjhBuiMUM9B7BxYoVW
	 LK2+4pKmadlnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56C883924472;
	Thu, 20 Aug 2026 22:22:19 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) changes for 7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <fc9dcf76-4825-4152-9f5d-072270bf3b87@intel.com>
References: <fc9dcf76-4825-4152-9f5d-072270bf3b87@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <fc9dcf76-4825-4152-9f5d-072270bf3b87@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-7.3
X-PR-Tracked-Commit-Id: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 920f27122cbacfd3b540a3f2f67b0145203d5581
Message-Id: <178726453799.517829.44876122559921618.pr-tracker-bot@kernel.org>
Date: Thu, 20 Aug 2026 22:22:17 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Alison Schofield <alison.schofield@intel.com>, Jonathan Cameron <jic23@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Aug 2026 10:55:58 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/920f27122cbacfd3b540a3f2f67b0145203d5581

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
