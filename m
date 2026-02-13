Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C766BFCE
	for <linux-cxl@vger.kernel.org>; Fri, 13 Feb 2026 01:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770945536; cv=none; b=C4hrqZgrXVJj+yfNWibmcrfDVVJiX7inoU19tYdJMoNyX6zApNCdeFxWoFzkmVwTefttT21fhlSwdE3+sAenXfaJ/bdAo0Zoe9TChChs66QyQ+jRCEYa8FNznWBPSVDibuszOtHi3ybk9tgkz8fsul13ou6GebFLlnpmsUG8hGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770945536; c=relaxed/simple;
	bh=KZQLKHLLMjGeZR6fHGaPFfdrstwqzCzYgdn3p2y9XtM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ig3KDrcyPysZ+l+OCYDd0Tiy3PbNHviyG1uHt1QFtMTyaBVxlDBJpTWb6XDuFv5/qGNrZ1z9F0M0whcwNeLtO4BpEXtsgiDZHp1rPiUm9xGtp89Ox/fd83I309vhsyubw5yBczLtsezmjKQZJ1OIroD1LF5k4LTO30BBKWpaNds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pg2Nygy1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pg2Nygy1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB079C4CEF7;
	Fri, 13 Feb 2026 01:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770945535;
	bh=KZQLKHLLMjGeZR6fHGaPFfdrstwqzCzYgdn3p2y9XtM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pg2Nygy13OBOv4Eo+WEYgySB5O6dMYiAcMt77dtbqK9WVznVcg/BM2EbZ069MOOuM
	 9Y0MxzmGWRBWZyaqapWMCv9zeuT4WzGnVmmQKUG/EXm8cZmAgtau4HwsButBaL2L9V
	 Py9rKZRh4dmEZFdCcr4bkkC70tzL+SWqcMQbiBuSsEYLXlNi1Ruxjx4Xcn+WrhE08k
	 r3MqjbHNCnlp7nDntG2acIUq7x3EGoqpA0hIxlXbQt1GUveRlSl5sJGv0p+yav1qvU
	 AzGCQUWsVsHyxNSaiFPdB3kh2RxyXn6rSVcKd0JoZNpy11dj5fJDQg6EaLqNZr2pl3
	 NZ59w/OYW57gQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 48475393108D;
	Fri, 13 Feb 2026 01:18:51 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) changes for 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <a7496d42-eb0a-412e-b5c7-66b45f9e5258@intel.com>
References: <a7496d42-eb0a-412e-b5c7-66b45f9e5258@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <a7496d42-eb0a-412e-b5c7-66b45f9e5258@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-7.0
X-PR-Tracked-Commit-Id: 63fbf275fa9f18f7020fb8acf54fa107e51d0f23
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e812928be2ee1c2744adf20ed04e0ce1e2fc5c13
Message-Id: <177094552985.1792804.6686319614842927745.pr-tracker-bot@kernel.org>
Date: Fri, 13 Feb 2026 01:18:49 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Feb 2026 15:23:46 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-7.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e812928be2ee1c2744adf20ed04e0ce1e2fc5c13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
