Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1653431E6;
	Thu, 30 Apr 2026 03:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519560; cv=none; b=OL0m3w5WEUdOnp5VZkJ4Wl7Cf/Kh3tkQNzDSZrDO5xMdQ+k2p7EPw+AzG1JUxLF19tyZXjIVxdtYZ2OCdn8X46Jkyjt+vyxoI0SsWxIpA3tKiiqr+CswMBHBGau5b/gZimFnWLtgbJQoZdT37UY3z9yRA/eMhaP16UDuN4G8/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519560; c=relaxed/simple;
	bh=FqQgY6wUDRilF2lGF6AUp3SKA6W84Y4EVzMNWrmj1MA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t1o2tqH2s9p8Cmg/KdD1h1DKCuRWer5mloDr89NozFaf6UBa5POklNb8fmLaP2CBgEV0g8Bl3wCGFZssbDBqwq+3jzQc6fBkkOQD1WR1fTHVAUdAw3BCDFVa+l9kNrJ1+5eC/418uT/NFmBZmRdmZ+iv1GJX54zQfRDL+rbBd+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBlnnBYu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBlnnBYu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EC8C2BCB8;
	Thu, 30 Apr 2026 03:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519560;
	bh=FqQgY6wUDRilF2lGF6AUp3SKA6W84Y4EVzMNWrmj1MA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dBlnnBYufwWMR1nExtz6aedB6xaU7P3x/0oqMjOtTdGUGUeJhPpncFc8sQY3bIxea
	 XS/p9LPRIkyQYR5a1xzoJhZL0FGP3XnLB7ZOHUY+pjLBscTvEbhOx3347ogxt9Bg+O
	 C2d21DtveABggnbmyzR85YZv8OmWR7FrM7RHm1MgP1DRBG3Ws+XDi1lSb5QcoQRFQy
	 HggmLnjnOtaQyPsKj5Of94mOctLczazEPyKkSBrZTM0g4YEqgl8wDGz5u4d4xH7e3X
	 tNGIsp/yArFBiyVYOS04DFlQB67Ot1uXHMbEsSeRTpDG+n3WdwGMNxgjPm1MfRZuFz
	 N/I5dqZRvaPOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF413809A07;
	Thu, 30 Apr 2026 03:25:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 00/15] mm: memory hot(un)plug and SPARSEMEM cleanups
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177751951529.2274119.16732782086222000591.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:25:15 +0000
References: <20260320-sparsemem_cleanups-v2-0-096addc8800d@kernel.org>
In-Reply-To: <20260320-sparsemem_cleanups-v2-0-096addc8800d@kernel.org>
To: David Hildenbrand (Arm) <david@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, osalvador@suse.de, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, ljs@kernel.org,
 Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, sidhartha.kumar@oracle.com,
 linux-mm@kvack.org, linux-cxl@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Fri, 20 Mar 2026 23:13:32 +0100 you wrote:
> Some cleanups around memory hot(un)plug and SPARSEMEM. In essence,
> we can limit CONFIG_MEMORY_HOTPLUG to CONFIG_SPARSEMEM_VMEMMAP,
> remove some dead code, and move all the hotplug bits over to
> mm/sparse-vmemmap.c.
> 
> Some further/related cleanups around other unnecessary code
> (memory hole handling and complicated usemap allocation).
> 
> [...]

Here is the summary with links:
  - [v2,01/15] mm/memory_hotplug: fix possible race in scan_movable_pages()
    https://git.kernel.org/riscv/c/89e69c7d187e
  - [v2,02/15] mm/memory_hotplug: remove for_each_valid_pfn() usage
    https://git.kernel.org/riscv/c/9d80de66a046
  - [v2,03/15] mm/sparse: remove WARN_ONs from (online|offline)_mem_sections()
    https://git.kernel.org/riscv/c/e66383b6746d
  - [v2,04/15] mm/Kconfig: make CONFIG_MEMORY_HOTPLUG depend on CONFIG_SPARSEMEM_VMEMMAP
    https://git.kernel.org/riscv/c/fb3c3f5d27ef
  - [v2,05/15] mm/memory_hotplug: simplify check_pfn_span()
    https://git.kernel.org/riscv/c/62257a5fb987
  - [v2,06/15] mm/sparse: remove !CONFIG_SPARSEMEM_VMEMMAP leftovers for CONFIG_MEMORY_HOTPLUG
    https://git.kernel.org/riscv/c/119c31caa59e
  - [v2,07/15] mm/bootmem_info: remove handling for !CONFIG_SPARSEMEM_VMEMMAP
    https://git.kernel.org/riscv/c/41293414433a
  - [v2,08/15] mm/bootmem_info: avoid using sparse_decode_mem_map()
    https://git.kernel.org/riscv/c/7f8e592bb327
  - [v2,09/15] mm/sparse: remove sparse_decode_mem_map()
    https://git.kernel.org/riscv/c/22688ade3b54
  - [v2,10/15] mm/sparse: remove CONFIG_MEMORY_HOTPLUG-specific usemap allocation handling
    https://git.kernel.org/riscv/c/dac89b150bdb
  - [v2,11/15] mm: prepare to move subsection_map_init() to mm/sparse-vmemmap.c
    https://git.kernel.org/riscv/c/fead6dcff83b
  - [v2,12/15] mm/sparse: drop set_section_nid() from sparse_add_section()
    https://git.kernel.org/riscv/c/b551ed94d959
  - [v2,13/15] mm/sparse: move sparse_init_one_section() to internal.h
    (no matching commit)
  - [v2,14/15] mm/sparse: move __section_mark_present() to internal.h
    https://git.kernel.org/riscv/c/08e5f77c3720
  - [v2,15/15] mm/sparse: move memory hotplug bits to sparse-vmemmap.c
    https://git.kernel.org/riscv/c/738de20c4faf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


