Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1631C2DC7
	for <linux-cxl@vger.kernel.org>; Fri, 27 Sep 2024 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727467211; cv=none; b=X1LutZsupItjw83aGm+liFNc0VKKoNhB1x7XlFHQDHPg+HPCDgkHmJ50GH60O9ii9czykvXTATlpSUjoUU0OQPetmOISHC9R55mrJ9sal0dZxqTKy/Re1UHtFuDmMpXwNriODWLqb82ARTtPoHlU9vcZZPX9e8J6XczQt97eHBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727467211; c=relaxed/simple;
	bh=R7s9rMx/yvvuDO2/vYHytYYP9gCVMio3MUlZhni1VwM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=komec39X8GVz3HV4FppMLBzYypszNe255MKfYCnm8oIUE7UzUSZZttCis0+dNiW9hwjkiPPW1R2AKaLI0kSVK5mK+iCtF8xpWGEfLhb4T9z9+w2TZuy63mWxkS/68vJ5xIikguzYLYSJlEFf+VgN+wIJ8CQ6efB/1o0WWPgswNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxdSKFeS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxdSKFeS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBF4C4CEC7;
	Fri, 27 Sep 2024 20:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727467211;
	bh=R7s9rMx/yvvuDO2/vYHytYYP9gCVMio3MUlZhni1VwM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mxdSKFeS/BfmhUYxic5f1dMC2KszvrB87D8jeWACM5HQEW4KalCg5DbH7OqAq+5Ci
	 hOL+FAIXbcz6O2qjo9LwaMyBt28gl/osi1RiaLsjV3lEOYGDkZ5JC7V4PPPixhCtuf
	 5LQbNbfVmnHTThBB2yYp/9SmLqT4vMe3OGu7o36HAsN7D/GBk3LlN1+XX8J5H3m+sE
	 /d5BLHeM4bG153WGB9HlvyFtjXIJubl55yWjJiCi7KcGl64Gb94G9o4ZOSIGH6AvKf
	 kNnSZO3NCjT7k5wLUxce4TMRtANQzLbQziRBVxabsz82SXg5jSJS6Q1uD45RI00lkw
	 lRsjTUMffCeqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB8503809A80;
	Fri, 27 Sep 2024 20:00:14 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <9c4d4de9-5c24-4644-ba41-875bf19da10b@intel.com>
References: <9c4d4de9-5c24-4644-ba41-875bf19da10b@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <9c4d4de9-5c24-4644-ba41-875bf19da10b@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git cxl-for-6.12
X-PR-Tracked-Commit-Id: 2c70677dabb5e326467160e28915b804b925b53b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 033af36def3e8676b344f4b4817b5ad81ed22aa7
Message-Id: <172746721340.2065565.15946610547538526235.pr-tracker-bot@kernel.org>
Date: Fri, 27 Sep 2024 20:00:13 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Sep 2024 07:02:57 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git cxl-for-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/033af36def3e8676b344f4b4817b5ad81ed22aa7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
