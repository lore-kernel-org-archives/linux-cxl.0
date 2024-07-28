Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF6F6F2E8
	for <linux-cxl@vger.kernel.org>; Sun, 28 Jul 2024 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722192379; cv=none; b=RfL1QoitZNHMQnfhtfGIqDDFSTT/0+E/30orN3hQKGUUzOiifr5zat1CV9ZMK2h/PluXxaog5hHHS/64fW1jzNXAsam+hrEm8pPK5flH6/ZU/Ibgvplsx1YzTENIk4vOMdoB3sctMjwfildzfMAZ4zA+XV5qHn5iB1Qst/sIM/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722192379; c=relaxed/simple;
	bh=tJ3GNdMJNgOhw6y8z3WqbTbG93VGl1z4pJxPYN9Sp+w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KtyTvPAmYcCHBn5bnPkwt6RV7abrYhp3TALeFNS7oyjrCcnUpnyrYsGJeRYUoNsftoBFRRGppF6NN5oLuQdI/OIdnxJBOU0iEAia6nxq8vKY60tqxfzXfffrRg6cUhrOv9UyAbCY661rXiazDvR48Xr8GU+6LbG6KLt7UgRyuYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfSDuxPm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfSDuxPm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84CDEC116B1;
	Sun, 28 Jul 2024 18:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722192378;
	bh=tJ3GNdMJNgOhw6y8z3WqbTbG93VGl1z4pJxPYN9Sp+w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SfSDuxPmE8QIyyJhvE8Q24U/8QqiEMwRuBOs6Ov4UfJtgSv3p/mtRtP7OPn2BF91z
	 FV2bUUA2fVsaJV8kXzfjo7G2RDc0QL4Z3kbZFep/dgUYT/dzjhRAbPgZFgXe6m8kix
	 Ln9o3iqbaZep+cCsBTMc/DHGYUTwyzRAiDhJYQ/1Y1PrbU9UuGJuLyknN+fcXlzJm3
	 NDTAc5S6LD8ybA/2d7BrnOgMoEv4W69JCTXxv8RVhm3taoh7lhYPPHwwapj5jwuO4o
	 A4ryLsjoIBJtV/56gXF5YixdZGzEq/3ASd1yTx4QxIf4ITQAcoNVbs5C19fwCnTQlp
	 B+sQTeiHMsydQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B2B0C4332F;
	Sun, 28 Jul 2024 18:46:18 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <21dca9f0-639f-43b0-b858-a74317954835@intel.com>
References: <21dca9f0-639f-43b0-b858-a74317954835@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <21dca9f0-639f-43b0-b858-a74317954835@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.11
X-PR-Tracked-Commit-Id: a0328b397f3339d8d17a6ec356e94b3c110b010c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e62f81bbd24db746c9b1aa29e7b6423211262ac4
Message-Id: <172219237849.25784.17625938598783570758.pr-tracker-bot@kernel.org>
Date: Sun, 28 Jul 2024 18:46:18 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Jul 2024 09:53:22 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e62f81bbd24db746c9b1aa29e7b6423211262ac4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
