Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D5D16F8FA
	for <linux-cxl@vger.kernel.org>; Mon,  1 Jul 2024 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719865005; cv=none; b=kAesLjmrqLV8uZ6PttrsssjKhTTDGNT6SMK7AMnyOKilDsGssSV61Bu4yWxqOflt5qISUoVEjcyQdGBYDGJIUinjOj//zuxGIka73WpaIKrOO89vzLv7HUfP5wetQpW+I3CAHAjNixeEMSCqUCMNtNQaVblvnzP7JJmuh0ueLdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719865005; c=relaxed/simple;
	bh=SyRQFKqrL/83v7IgvBaRkh6xoPS/nZ42zmLnl4TFtqs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=T2oNfj7zKnG808CNrf6ijv3Q6DhGm40ARfstSqs6K3dpRHc+Qi9yoZybFtNhWy9ZHtt4etmN7V0kGuMQENEgEzCdkScEm1DFvcy9MK2q63yiPfC62fPxQ+AqrhPsas0h+y8e7AOyAFccJSlTOhLGLeLeSBEuOT/epWazHTOXHBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ox9e9TIk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ox9e9TIk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83365C116B1;
	Mon,  1 Jul 2024 20:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719865004;
	bh=SyRQFKqrL/83v7IgvBaRkh6xoPS/nZ42zmLnl4TFtqs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ox9e9TIkWLOhLNXy1Uq6InA3+Iemo5HMGvquCOk8XAam/AzdDa/850QfX9/qyjEss
	 1S7/NIKgiP6k+Og75uZ1x4FPBBizGOwK911UzHulEXly0ONMonwLiIFED8ZrIQq3cl
	 k8QOfrVOZTT0zijf9z7t/IRj46KznWL8yMRMiDbQ0BvJn6rbWWcwVOwaHznIZSKD/J
	 pjVsAyYLac+C6rr5w6imzZ5BOIjYeGebEg+mxQvPu1RkUAvAGd01jRmdOWwMjfYJVA
	 wzJhYzGBLwewqOOKSAD8abSkvfyIvb0vOB/9IlIFjkM4LjwVUM6jJ2bEne1OCxvGsM
	 9xtrF76/C+sSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76A01C43446;
	Mon,  1 Jul 2024 20:16:44 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.10-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <e5477d05-93e0-4268-90ca-581e3f492b4e@intel.com>
References: <e5477d05-93e0-4268-90ca-581e3f492b4e@intel.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <e5477d05-93e0-4268-90ca-581e3f492b4e@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.10-rc7
X-PR-Tracked-Commit-Id: a0f39d51dbf72c28283bd201b97559ed82bc0fe5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73e931504f8e0d42978bfcda37b323dbbd1afc08
Message-Id: <171986500447.16343.9122613204112694817.pr-tracker-bot@kernel.org>
Date: Mon, 01 Jul 2024 20:16:44 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Alison Schofield <alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 1 Jul 2024 10:53:44 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.10-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73e931504f8e0d42978bfcda37b323dbbd1afc08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
