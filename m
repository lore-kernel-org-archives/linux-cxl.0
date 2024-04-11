Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9997C4B5CD
	for <linux-cxl@vger.kernel.org>; Thu, 11 Apr 2024 23:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712879582; cv=none; b=Rh3/h95nZmy3oNQGU76lpVP7cCgWwLeNgy3lx5l9iGtNdACv5wXIDvx49ysI2/FMYVdAp9IirCOx3Ue3MMvl164VfZMzJ4dT5W9sUUrvjcVTeTsLhrQahsW4zx9lSgDix/D4Jn8JneoVFFox68TY4OwHNWTKJnSK7ZWfca/J3zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712879582; c=relaxed/simple;
	bh=G5zFL9+nUm+cKihGLtWNi+B94Q+aubzz0Qh7UTk5E9U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jkQHtXJF5dz5csi0ISXsuG21oX5LcRv0i54crzsZ7QgjdBup3fmSaoHSMzy5bJLxWcZw5XhIHv5q/fZvyVz+4oGnSpHR3QH5wJzgzYZOpY1maPq+Vuz+aWmPEo/Ic6J+axm0tNW/BAAeViQzKbpWUXUznblf2HJEVEycFVtPRn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYrdWE83; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYrdWE83"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F21CC113CC;
	Thu, 11 Apr 2024 23:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712879582;
	bh=G5zFL9+nUm+cKihGLtWNi+B94Q+aubzz0Qh7UTk5E9U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GYrdWE83zeVVqACb0HaxXUpBL/eOczkk/7MfiXiWwgIDjfqF8B0N3dYAqcRzH+Nvw
	 jphDmlj53fNbx43mwhYZMYDromCpEA+T9rzBUwacguTpPz3dqjvfp8nAFdaIZnVQBg
	 FWLSgXxHcDWAxcUFpvyl3xm3pXXGJwu0zSCjmwCTO9a93/LzBfqHxCx5PY1I4l+C9G
	 hdCVxBWLufj7XkG6QAPW+P1m2VYZHA8T3Qw0pSuZbT3XWG/secSl5Q/IK/kRgbaidY
	 Bz8qeYzIIGjW9dlHNJbdxKWmnz9ENmukdaCw3nH5gqrHCle/92ypuU+4cfVGboWbGx
	 doCST3WHWi79w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2EE0BC433F2;
	Thu, 11 Apr 2024 23:53:02 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.9-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <02842127-1716-4372-a77e-d742d7dcab8a@intel.com>
References: <02842127-1716-4372-a77e-d742d7dcab8a@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <02842127-1716-4372-a77e-d742d7dcab8a@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.9-rc4
X-PR-Tracked-Commit-Id: 7bcf809b1e7889ab7e75fe1fcf8f1a98332f36d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 586b5dfb51b962c1b6c06495715e4c4f76a7fc5a
Message-Id: <171287958217.26385.15152974836178815649.pr-tracker-bot@kernel.org>
Date: Thu, 11 Apr 2024 23:53:02 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Apr 2024 16:37:10 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/586b5dfb51b962c1b6c06495715e4c4f76a7fc5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
