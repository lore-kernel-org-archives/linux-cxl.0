Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD7618E34B
	for <linux-cxl@vger.kernel.org>; Tue, 20 Aug 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168422; cv=none; b=a8ZUA924KR3ANqnHQW7E5bcB8xX8BbirTasMdMrQpM6YFV6YYb7o4MIUXvfaPBOdk+MjryDQbR4LI/ch/d5IwEGiAD8F2FmQjvpiyq0rKOKpkGq9EnpzXJ6XlRjKYPgVCNExaOumkRpuBqbQO3D0WMo/vFogw9naAUWgUuesvXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168422; c=relaxed/simple;
	bh=nCdzb7G9KsQ48WUismA/wIRi0/iYsOvvGos7bmXvnis=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TFpwInltFuCqGV2hckysj1HWtH6G0zsyooPxOsLnAdEEI/bHwjBh/843pKe+fqzhF6lywEi2m1N7uo3xIaKWV3UnyUvGMFLs0XGqprSPCEuGgftw11n+xl6xrcFR5WeI4B37srXyJG+wo/T6YpygILPOw3/k39RYS9jqY13/aa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRAQZjHp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRAQZjHp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05110C4AF0B;
	Tue, 20 Aug 2024 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724168422;
	bh=nCdzb7G9KsQ48WUismA/wIRi0/iYsOvvGos7bmXvnis=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oRAQZjHpYlyRhy0GPz+zBmcZepH7/l5hL2LjW28hJxL0/GkVAZ8GoNB8MIzdqdsgH
	 x4DN1YrqgH4bBDAex8jjJfREavFgJTh2Mkw7u3A3kmbiWu+6PoGDkrndkSKZ3YtYqx
	 Y1sbVzK3fm7CKnbRiyx0Gj/6D5AWs78GW+DvkqJrCVeRVOkNyXsWEXp+olPkS7rtJz
	 bKfKq3epMSAExgh7z1W3mn1apP0lyQMEJbw5nRAkabBpJAKDs4we2JMmYKHwr26kyH
	 r5nfxHc1CducFBrOXCRCSoqNBoZJ80p/mJHtMLx4ZHFwwviAv67X98iIe90BCVtKsI
	 xVNLHj9JpyGAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE7E43804CA6;
	Tue, 20 Aug 2024 15:40:22 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.11-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <104af007-3deb-41d6-a32b-0fd12173cdb2@intel.com>
References: <104af007-3deb-41d6-a32b-0fd12173cdb2@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <104af007-3deb-41d6-a32b-0fd12173cdb2@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.11-rc5
X-PR-Tracked-Commit-Id: 2c402bd2e85b44dc00ef85b5c0e217de684b5372
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 521b1e7f4cf0b05a47995b103596978224b380a8
Message-Id: <172416842123.1177905.15192899017121003107.pr-tracker-bot@kernel.org>
Date: Tue, 20 Aug 2024 15:40:21 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Alison Schofield <alison.schofield@intel.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 20 Aug 2024 08:33:45 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/521b1e7f4cf0b05a47995b103596978224b380a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
