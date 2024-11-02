Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1C53D76;
	Sat,  2 Nov 2024 01:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730512039; cv=none; b=jrNhJPvtk359JnKXXMbomhgUnQqLvUut8bnVkTDAh1gTtPWT2Pw5BX8Wi22xojs2Qbka52ntu+8BuN0vxF+pRf18JuQ4R2dfzeOlTAMfVgYADBQvHt388aisht9T1Ic3uumFJbCheaFvxdXypgrkMmOycW8NY2SMZ92z+197FgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730512039; c=relaxed/simple;
	bh=lJ1cwki+rcDEV8P2Hr4+pMHouOgKq2J2k9v/HCUJ1pA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=i5jR5RHRYDOjaSXzHcKTiVViM7oeFSON+9NeoAMd5Od4S+fUOCPnuM+JoUPRVVViI54W75QBF4qtlOl0QMtM4tCcJcNzu25v/HeD0SuPoDWMM55QzTUVVmaXx1ksWi/1Pja+ci1OAcban1peP2iM3h+1AvCLNZkjLYAkT38dJ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0+ackE8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0+ackE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17739C4CECD;
	Sat,  2 Nov 2024 01:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730512039;
	bh=lJ1cwki+rcDEV8P2Hr4+pMHouOgKq2J2k9v/HCUJ1pA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L0+ackE8s9txXGvK4uEOIvacm470+p/qiAIpgCN/7qIZmBRlE2RHeuw1w6wDe22XB
	 ufrCsfYqMqs1mb8Uk8fNSbd6oXPEPjckMZf7QSVueWjKtuzFIWj1eTyz9ArPMAsOJG
	 gGP3J0T/oxWZT45ZZyNTR7vPid6UP+aiOCHyHBnrSDA8w4EmsRaaOBypPsyt4lYcxP
	 ttB7M8s3Z0iQoGuqFCmXEchvNIdLWOXUprYmfErROuUyXWo7+GXFS1y0MTHca7wuJz
	 +houzGTjyYMWa6Nd17awyfU4R7wDA20kortVy5dfFvat9HzfqYwDM/AkWspi7cvEJq
	 xavvtEHrEb7Ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F2E3AB8A90;
	Sat,  2 Nov 2024 01:47:28 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <672522d276c1f_9d3632949b@iweiny-mobl.notmuch>
References: <672522d276c1f_9d3632949b@iweiny-mobl.notmuch>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <672522d276c1f_9d3632949b@iweiny-mobl.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.12-rc6
X-PR-Tracked-Commit-Id: 3a2b97b3210bd5758f66fad04c5171f85a016a04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1966a1fd218e1f5d5376bf352f9a4c26aba50b5
Message-Id: <173051204708.2889628.7065776642935085214.pr-tracker-bot@kernel.org>
Date: Sat, 02 Nov 2024 01:47:27 +0000
To: Ira Weiny <ira.weiny@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>, Dan Williams <dan.j.williams@intel.com>, Shiju Jose <shiju.jose@huawei.com>, Gregory Price <gourry@gourry.net>, Zijun Hu <quic_zijuhu@quicinc.com>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, Dave
 Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Nov 2024 13:49:54 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1966a1fd218e1f5d5376bf352f9a4c26aba50b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
