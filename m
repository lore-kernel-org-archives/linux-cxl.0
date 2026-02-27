Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E692F2853F3
	for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772218783; cv=none; b=HImzuhMloIadjrTiV18GfoOh4Azn0Q6bC+xfhbE+fcVuPJ9L5Y35k7ITGV8o/QHSZA+ZOqp/+txAxIUksUciY0FOPmr6JxZ/UrENOBtd6KD/bbGkgqJTOE2lL016WUc+xaaKrh8ML4GMc5ZTPSUPraVKUEkn+SxYRLuUeSpaFyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772218783; c=relaxed/simple;
	bh=ZhHRMHhX5Gk+VHFduEYg6Mbb1BGkZwTu4UeGAI/A1wQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Zu+a0mqJ6VBIKRo3O0Jh2jUmuoQFmcUj9/S8eCz1AxX9AUvg7OSTCFsOS3KQtcEJgKWbvRhqlLOa3eRunYrXEM0KFQxCGEQ2pq2QpYJyfZJuBiSi3yEE3fFMsOPDtZr9HNTuHQUAisdIJMKQKDsZqjMzEz01jGeJiMysA4BuJFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGwpthOH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGwpthOH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA977C116C6;
	Fri, 27 Feb 2026 18:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772218782;
	bh=ZhHRMHhX5Gk+VHFduEYg6Mbb1BGkZwTu4UeGAI/A1wQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pGwpthOHrQdUmXtOjt+BHUP27oeTIukzmxelaR4euqHNYMXiOdt/6567d0fIbTc9F
	 HLUHzieRaA2lOmL9B8ptz1/NkpDnMBwvTcGXxBQU1bNJZn+OPKGTaWM7ifnjp11i6H
	 l6iKFRL0tHSowZhzF7OMLkXBzV//LVk5FNHIweB7ZImztQqNvGt15Lc/9ZLx5PeRkV
	 cznO6eQ7AWnjuAN09ACSg0NRV6AeODUN6l8bTjNoeDDdKvIgBOhgm9yx1vFblK1LQa
	 3uYCiL4rRkLSb5MIaiTkEFoSJNKU1LCmnQUj8Fs9jtWEK14UtO9AgBDFgVSPNWcIjS
	 p5wYJBFwPanPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA29939E9614;
	Fri, 27 Feb 2026 18:59:47 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 7.0-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <ec463b87-7b6b-4b4b-a993-ec8bea26d2d0@intel.com>
References: <ec463b87-7b6b-4b4b-a993-ec8bea26d2d0@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <ec463b87-7b6b-4b4b-a993-ec8bea26d2d0@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-7.0-rc2
X-PR-Tracked-Commit-Id: e46f25f5a81f6f1a9ab93bcda80d5dfaea9f4897
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aed968f8a6cd60a4aa32b5e9c0973c95c443ef4e
Message-Id: <177221878623.2713791.977603988124272405.pr-tracker-bot@kernel.org>
Date: Fri, 27 Feb 2026 18:59:46 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>, Dan Williams <dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Feb 2026 11:09:03 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-7.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aed968f8a6cd60a4aa32b5e9c0973c95c443ef4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
