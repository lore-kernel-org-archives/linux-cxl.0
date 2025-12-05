Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CEB1E2614;
	Fri,  5 Dec 2025 03:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764903796; cv=none; b=LU9DbOBgj8V6hcu5Bf8wePV4hW1hHTmAUxgSHKe5Cfy8AC3MyCY8uZHe8A29B5/6czYui9Xxn30zpI8jJZBDUcNibGwMA1y8Nse1N4D++iRYoZ2VW0CpiA/N9xOIr/LJxhWJs0E1Blo35q9HtEUEkMPAmXYgSkLCxblBzDHySls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764903796; c=relaxed/simple;
	bh=gd9FF3l1uBj5p5OVcASZfBa+zOR6hGjiwkXGC7+4d2E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=G3zYZMCjD+tw53qj/xxCLBITsSyrRODxroNlIJS8gvqbBZWoOfzthWJC8J42Y0Z4V73ExR2uPxF4z83w+6Qh7j4XC+4V+vrnViWrZNLSoz8VsvNcfD9ZgjL9+kREMf9T/dld92KZsEf8IQPDtyarOZjlaSHOEfqPhgwgI3Reg2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzxL38uZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzxL38uZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8306C4CEFB;
	Fri,  5 Dec 2025 03:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764903795;
	bh=gd9FF3l1uBj5p5OVcASZfBa+zOR6hGjiwkXGC7+4d2E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gzxL38uZGNHDGw8oH1osJV19WJTnvpkFEKtWlT68IrIRXJAjYpBeLmkNfb40hxVrD
	 l7xJqkYZXKmx0BNhxPKc/Bx+K/1uTr8uC3MkvsJw3Y2V7ori9qv6AR4X45fqC1P6i5
	 rKtkC9jE432xZRMnFUoqmcmRHfSHN4/uiWkbDPHQzWVtenxn8iffkdIWWy+bEUiwPT
	 OE7gElqqZYjqmjvNWc9eys8B4T1IGxDBmP1ZIXQwuahgjPnEtAuTUsm9mB3W2j1+qF
	 52D8jRpmxyMNC8VKjARk3BVycqt8IiOinpHpOfwjmlTg37ohhLeRI2hZwEL9A/V4EB
	 qqZJUtrpTIA2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 03AA73AA9A89;
	Fri,  5 Dec 2025 03:00:15 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) changes for 6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <59b991e0-d7dd-4285-b052-c3574249409f@intel.com>
References: <59b991e0-d7dd-4285-b052-c3574249409f@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <59b991e0-d7dd-4285-b052-c3574249409f@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.19
X-PR-Tracked-Commit-Id: ea5514e300568cbe8f19431c3e424d4791db8291
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5797d10ea4fade7df0f920c368cad07f705afc63
Message-Id: <176490361406.1073302.16674800003884261271.pr-tracker-bot@kernel.org>
Date: Fri, 05 Dec 2025 03:00:14 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny <ira.weiny@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 1 Dec 2025 10:33:18 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5797d10ea4fade7df0f920c368cad07f705afc63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
