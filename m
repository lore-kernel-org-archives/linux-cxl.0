Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8F43C3C0E;
	Thu,  2 Jul 2026 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982761; cv=none; b=YuFZUfSfLH1AsSEHb3gnGqDkCrkcGCLWHdA1Pr9BlENXgyoZo5jPZ6WWUwZbbYHQHbnmHWIkvCB1jR0rNbNhceChd3U5TuQp06JY6jGWF4qOhZTMgmZ1f56ByaA5fA+SHFlWETBGJZiSljBEMqlBYAYSNCBRLA1055837Dj+ea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982761; c=relaxed/simple;
	bh=7bRwM7xlh+Fh0nTf2syhV7p8cEk+Y8AUlLsZZCC5ggE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQ23OZtdtg/59a/lgeNnMrZLgRKgZ/hzPglCMBqJZR/GqcCzDHjJ4rQvDh/0bXy3ttdgSi5S2BFjBTNiW4jsqXXtBpyXpfbRsFcgJNY8+XdNF+MaXau2z6ULQsa7lV8Wut6aIuj91xBdj7YZhIhfn8fcfIpb3EFdguf3yhhb0b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifAvPDOM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifAvPDOM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E1D1F000E9;
	Thu,  2 Jul 2026 08:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782982759;
	bh=lfPuK3pRg856su0ASlXAFH8kRCV4bOWi+Ap7fm6v0ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ifAvPDOM4W4W5kC7SzH8i8TQkzG9PguoVbJQ0hWON48b7V8IPqHGIwljJqHVXgM5P
	 HCU4MNquBsYk5iaONdznPJIT9kYiXSe8QkoRHw7BmV+yMnbiYhpMbmpxipbXOJzSv+
	 3f1vNhQ+hCmatu3i00/cOlTlkxqGk+J7oa3z8fB0FVkryoFbLqFlUaQtMMlw7zaOtQ
	 lpen1Ueu5Qpz+ouBwppCbbUoJGNbcuoGj8oDhQspLNKc+EmK1fV1tEw+SY1H9gW/sO
	 LvlLYkK5Y5orwmrAgwcuvLcHBJDiEHMzQrKxSP0+/1ben3x+JPDjP5Mb8GBuNz5fQT
	 fUBGUPzaO48sQ==
From: Mike Rapoport <rppt@kernel.org>
To: linux-mm@kvack.org,
	Gregory Price <gourry@gourry.net>
Cc: Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	david@kernel.org,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	mgorman@techsingularity.net,
	hannes@cmpxchg.org,
	vbabka@kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2] mm/mm_init: handle alloc_percpu failure in free_area_init_core_hotplug
Date: Thu,  2 Jul 2026 11:59:11 +0300
Message-ID: <178298253859.2129536.12250607095937758446.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701221613.2818148-1-gourry@gourry.net>
References: <20260701221613.2818148-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 01 Jul 2026 18:16:13 -0400, Gregory Price wrote:
> We miss a failed allocation check for pgdat->per_cpu_nodestats, which
> results in a NULL deref when we offset into the per-cpu area.
> 
> Propagate -ENOMEM up the stack and leave per_cpu_nodestats pointing
> at boot_nodestats so a later online can retry the allocation.
> 
> hotadd_init_pgdat() returns NULL on failure, which __try_online_node()
> already maps to -ENOMEM.
> 
> [...]

Applied to fixes branch of memblock.git tree, thanks!

[1/1] mm/mm_init: handle alloc_percpu failure in free_area_init_core_hotplug
      commit: 2ebce860bdd7ae5e13002811bc9bbbf33fcfc221

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: fixes

--
Sincerely yours,
Mike.

