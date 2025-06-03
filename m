Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE66025291D
	for <linux-cxl@vger.kernel.org>; Tue,  3 Jun 2025 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748992777; cv=none; b=Bumg/QZB6n0BvM4UaQlLrfevnjUd18EexAn15GG1rS5KmYBj5x0xwvfRy/MNSJnaPgRkAQS7DDrYE6sd2VvJQDa1enMQhQMNr0TfRdrnN57tFIKppz6W/HbyN1ajDJ262QODdAl3FRy1mPZ+cVL93KUzG163EPmAEXz3NcNFwis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748992777; c=relaxed/simple;
	bh=lKFtrIIrmzscyabM7tcdsny4uG9ct2AGHwnFCekLagw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=STAeOfScZ273ohXP4Pzn01yctgdyaaKigvBDocijYKzOB9d8LxHtj8zhNq+tFHmmNnYj6bzXGodQqbpF62HTNqxWeV/QkQ/rETViFB/c//ShO/SrDJWRTTQfbZnkw9VF+pZQflsRpGcNzVx3IlxVXbiK+EtZ+moNy8U1xK1DiK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSTr8imm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSTr8imm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE946C4CEF1;
	Tue,  3 Jun 2025 23:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748992776;
	bh=lKFtrIIrmzscyabM7tcdsny4uG9ct2AGHwnFCekLagw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HSTr8immb2HvmF/SprxwanDKd08q0gCFCaMJ+fsHTHUHXOu/OEPcmJS+ZiSPMgM15
	 ZTKgeqD+8nAObTLT3mvn3XlWTmodanl1bMuKCBw94V5B9uEUllBRaPOycohYMs2F9Z
	 EkhFxRkwyRVmikuw0+fNZi2ppzb3yHfnHMSJq6eWMRLWlCjknXFEH6Mqn7z6f4S8Pn
	 Z1yiILWwOwW7jCURiTTAbQNw6DlpDaY6PT3UNLG/Bg8kUthfHZnnqH5UMp30Bcvfzs
	 l/QDK71VPNNh5b9taFwtZgrz9+ZwaCHqX3Mrm8lDMOAtl9b7pm5IVA8JLleuFGJ6vo
	 52jHlaNu2l8hQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713C0380DBEC;
	Tue,  3 Jun 2025 23:20:10 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) changes for 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <fa4797c7-e7a5-4703-bce3-7c5bfb827234@intel.com>
References: <fa4797c7-e7a5-4703-bce3-7c5bfb827234@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <fa4797c7-e7a5-4703-bce3-7c5bfb827234@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.16
X-PR-Tracked-Commit-Id: 9f153b7fb5ae45c7d426851f896487927f40e501
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29e9359005dd1ac5f9683608891718e6a32a20a3
Message-Id: <174899280923.1701538.713902184359687787.pr-tracker-bot@kernel.org>
Date: Tue, 03 Jun 2025 23:20:09 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 3 Jun 2025 10:25:21 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29e9359005dd1ac5f9683608891718e6a32a20a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
