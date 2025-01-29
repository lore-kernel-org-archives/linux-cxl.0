Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157101E0DD8;
	Wed, 29 Jan 2025 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738180818; cv=none; b=ioYOm8CGEltfZA3AUq7lI2gBd9b+tD8/LMl/GrGvwBc4jM7RJstVW+JmbIfNIkNRvsRDWlpdT9R2WI8oMa1z2mX5RZoAQLybkqghnnWOYOs/7h+nurQMnkbKgmYOqacAtarseHn0YZAnZJKVf+4+vRuL4X3EZ5D6YwsjGY3i+lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738180818; c=relaxed/simple;
	bh=53GJr3rmppH7G29euyurqTKB6+pFryNXuqiF3CeiUIE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Dwiw8SOME4YcMkKdhm0ea4CPDLPuRxdcrI8v1GvsiPWooL45i9q3lSX52y9jnEPI80HmaF5NJUxJDolilZ0MqC+uir+Fk9Msb6p8ietcCQScsee401Q978ou01acqUnxtxDt0xU2bKfj9vwOY20jty/dnfzW7KQIdYwewVdIKQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aL0iVnp3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aL0iVnp3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96ABC4CEE4;
	Wed, 29 Jan 2025 20:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738180817;
	bh=53GJr3rmppH7G29euyurqTKB6+pFryNXuqiF3CeiUIE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aL0iVnp3k+lrCHlBk2HvvB8/TPrDemvjdO4nXMjyfa1O+WcLG11Os6SwPw3f0+IQ1
	 S2gz1iLkBNexpHHQXJzFe5F129qSr7Ms6/saOcFx/4W6z4WYZt9xlun3mr0jHF1Ubb
	 UPb9YVGparXSCs7Q5QxigEe0/4izOQS86p+DsyFWRVFUGl9W9fBVNr0h33qK5R1YLa
	 HL4Bp1+jJ4cE322PEKb0J9pVCsjUuR1vkMOOTbW84eQ643/OweuWF/FTfQXNDwONe7
	 b+1Q5wgO6vk6WivXvXxWh5LPygFsCzvICvt/nCtr/kaxWGcPrzFJpzMWZst+xoVtMD
	 +1Sm2I3VhLymw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34510380AA66;
	Wed, 29 Jan 2025 20:00:45 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) changes for 6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <96c924e7-a684-45c9-b23d-6401ae727159@intel.com>
References: <96c924e7-a684-45c9-b23d-6401ae727159@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <96c924e7-a684-45c9-b23d-6401ae727159@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.14
X-PR-Tracked-Commit-Id: 448a60e85ae2afe2cb760f5d2ed2c8a49d2bd1b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9071080d1e7af1a3a1699c3ba065c3293b5d09ce
Message-Id: <173818084399.411204.5322338935148977339.pr-tracker-bot@kernel.org>
Date: Wed, 29 Jan 2025 20:00:43 +0000
To: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, Alison Schofield <alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 29 Jan 2025 09:28:11 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9071080d1e7af1a3a1699c3ba065c3293b5d09ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
