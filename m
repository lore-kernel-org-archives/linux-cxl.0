Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D2D1C8631;
	Mon,  3 Nov 2025 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213020; cv=none; b=VQ1x62x5gSM+I6JGzWobGfjIA4rbdEUyWYYVbimlS1mpJlOshvdL09RBzloKUHgiIwAloxVcljnGpsv5I6vgOpApknH5MGAdLAWNjqNJs5nENvekgGqj8uukBA9kTxCMubVU8nf+Ao0h0WNPqzRdc6qryDweC7ifddMNPeuu/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213020; c=relaxed/simple;
	bh=N55eo52Pcgfxt95Av7Tt7iGJnaLH87zi6nTnO+AdxFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FU9s2f4nNOZO5BeqhZiHdCfPHa70c+Un22Z6/fgtFsBH1yHniP5/xjE1VIZT7vBE3HeZVtHvMzoVSP9LVfJ5Epg4PtX4ANj2DAAoajhMiBS/UeWcMvMIZVo9ah5Ar7TllhmQYY2kNvmpOd4Yz36I3h4Y7wk9tlA9gyo0L2dqnzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=W1Gmhljn; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="W1Gmhljn"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B911740C2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762213018; bh=K8PIBNbs70W46i6wcDq6wkYz/yBo/jDRwIBRu7rD6kU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=W1GmhljnEtURIiuRsg76bqLPRr7r6N7R2SL4ienRowJhjt1SKun4lf0DnQJ2DMmdh
	 8u1TiWGVx79nmzXKwh43CO1V461lvoji6Jz9ePuyCEAZFbR1Dhk8fJR5W9cVSI1hHw
	 /nTkZlkcuqMbRZ6+rNUSTXV3CxiPzyyiNj6XP38JXuGfWYKTk7L+HVxOh6yODLe9Sp
	 FIJTjAK0OnffozTwXOLcu37EOyTY8r9RSOZHHuqKHlHicyWzCy0c698xOgi8pidFLV
	 Uv0dHyFM3kf9NimFJXyyUxX9XqFczfaT43ECASzF62zANDH+MfxT4JqNHWG/Cxfd8X
	 E0BxgXwR/AuZg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B911740C2A;
	Mon,  3 Nov 2025 23:36:58 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, gourry@gourry.net, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/driver-api/cxl: remove page-allocator
 quirk section
In-Reply-To: <20251003143233.1985150-1-gourry@gourry.net>
References: <20251003143233.1985150-1-gourry@gourry.net>
Date: Mon, 03 Nov 2025 16:36:57 -0700
Message-ID: <87bjlibsdi.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gregory Price <gourry@gourry.net> writes:

> The node/zone quirk section of the cxl documentation is incorrect.
> The actual reason for fallback allocation misbehavior in the
> described configuration is due to a kswapd/reclaim thrashing scenario
> fixed by the linked patch.  Remove this section.
>
> Link: https://lore.kernel.org/linux-mm/20250919162134.1098208-1-hannes@cmpxchg.org/
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  .../cxl/allocation/page-allocator.rst         | 31 -------------------
>  1 file changed, 31 deletions(-)

This patch is still outstanding...should I take it through docs?

Thanks,

jon
