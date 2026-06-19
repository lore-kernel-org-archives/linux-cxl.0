Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D07240D587
	for <linux-cxl@vger.kernel.org>; Fri, 19 Jun 2026 00:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781827774; cv=none; b=WmeWkX5q+vxTFe/ELt8qhw9KksZTbhWKICSIUZ0fnrjRcLx5X1KejtDkqNvqVKT8/fPpfGgEadOhMZp3MsXnY3Gx7qxJmyBbNMeypEfb+hTEM6ZCilkMKHjKffd8w/aaIAk2em/xb1t8L7YZlQZ4SP3yi1MJTFJbAx13QMKXlV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781827774; c=relaxed/simple;
	bh=38hL8m18EKji9VylYdiILDCEhliE6GQK23RJoDOtfWg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VytO6MiCzDd71/WYubNzTFhDsrjd6YHvAyZUaYEkN/3lv4pCOdXi96UJm3bLLEQays69VyR8m7vkPaCH+URZbiuoEgT4sBCKbB6UUzHBIpH+Xgd4qq+emAxxl0w27laRfXH4nS4mEGel2NO0cYh3tZxFKKZoroc4eFQEYckQ57E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOigXF47; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOigXF47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2181F000E9;
	Fri, 19 Jun 2026 00:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781827772;
	bh=IozD/ewRqzj9BdiyJ4QLdByYWyCl1B8ztoIEex0vqkM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=aOigXF47InNixSKO+R1J4ENiJaOhG4oiNLHKaUkK7Mr3HwHoGqHhbiIExNpK54MEB
	 Lilktz1GXolUwaeOzIwrMaO4BVKHQQevYs5eY1vSfb/aPUjDbs8S8MKcNUFwTuiNdp
	 i0lFtHDgJcPa95fy/hTrt3j34aofr0mXY6OgbKJa/nfYDi35YI74BBIEaWSFznv3qN
	 SzCewWJchk/M2Xw0vMyokyv5yjQLI7suL5ZFa0b9HwxtBMtsg5T6ZkD2+zFFeK9JKR
	 AIcvsJdSnCEzjAGbfvVaaG7opD1hbvtqQOAid1CG4b+ljdXRioiNpYp0nhoqzsIvif
	 gtJPnYKtFHvwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B703A5676C;
	Fri, 19 Jun 2026 00:09:26 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) changes for 7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <a2506e5e-9159-4f8e-86de-4a11e88522a8@intel.com>
References: <a2506e5e-9159-4f8e-86de-4a11e88522a8@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <a2506e5e-9159-4f8e-86de-4a11e88522a8@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-7.2
X-PR-Tracked-Commit-Id: f72af41a43e16276c46d44cf8a833cc0f9ba9d48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5cd1731cc883a9914d91e3b93d4597317b5b5339
Message-Id: <178182776513.3120511.3205778924253681383.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jun 2026 00:09:25 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams <djbw@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Jun 2026 11:27:39 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5cd1731cc883a9914d91e3b93d4597317b5b5339

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
