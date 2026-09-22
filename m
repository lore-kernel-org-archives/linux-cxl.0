Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA43B840F;
	Tue, 22 Sep 2026 04:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051161; cv=none; b=RKyyxWI4Gm9VNoGodWv9JR/6xmSUg4uSNh/mO6vALkSc5J2kFwLEKBDQFbYWl/LAOCZ8r0OQ7qyWbatKB7wnrCbI66SAJUTuykP375178qIy5I3Giaa+INM415XnjEDqQ7ZP2Wr7zlsVT6D4YMoV0y5aopHx0sMgvT5Zf64IGLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051161; c=relaxed/simple;
	bh=lekNrCeizC80DsGXP6pOl7QXhc03K2jyvI0Q4G/xeCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpIncmsKl4WolDHbX0Hai5ugwhpRnaixaHJQHCi0HVx7c4/OiT/xgk1P2gY2BGaBvUtJYSiv+b9ccBZOhjUFQell2aj5zVvuXhqglWkNldY/mkYlZxtiiSh4FzELqxqJHko7MZHfGItYYKg51YwrcqWPh9+B5vlKQO7DpqpqM6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ER3J5r3V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ER3J5r3V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A901F00898;
	Tue, 22 Sep 2026 04:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790051159;
	bh=D28fmX0v2APqwSVoGcnG1C5Rh5Hd9l3BseXRfD4IHME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ER3J5r3VzZNuMuHQZZdT2tmD/sauynFhocssTfXIyQ+aeQ6bHpu8UA/btjPDGg3MH
	 NfePtUdGHG+QdKUDw/Hf0NGR7IZE7GwghF/aWpWREdZXIu24P6AHSeBPDeGCLdrDIx
	 Wo2hVOEZoDUAtcCdLZA3wprGabCwotwqb5oR8Sxge67tTTQNIQJfd0/VaVOMDx61j7
	 +cDtnjNI9J99y88D82hGsEYUaZkrWCSbySiRs5MQTyfbTWfoiTKsRuMG4xw3dJF/61
	 wFzzJtYuXoUWfMMZjp6HroZWXyPWrA8cZ9PVa08HOFKF79taCFtsp8GJ7ykAzcwjQk
	 z8EZnhQvf7G5A==
Date: Tue, 22 Sep 2026 06:25:50 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 13/13] mm/memory_hotplug: drop
 CONFIG_HAVE_ARCH_PFN_VALID handling from pfn_to_online_page()
Message-ID: <arIDTjj5C05Z0Hp5@localhost.localdomain>
References: <20260921-b4-sparsemem_cleanups-v2-0-54d81d65e125@kernel.org>
 <20260921-b4-sparsemem_cleanups-v2-13-54d81d65e125@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-b4-sparsemem_cleanups-v2-13-54d81d65e125@kernel.org>

On Mon, Sep 21, 2026 at 09:59:05PM +0200, David Hildenbrand (Arm) wrote:
> Drop CONFIG_HAVE_ARCH_PFN_VALID handling, as CONFIG_HAVE_ARCH_PFN_VALID
> is never used with CONFIG_MEMORY_HOTPLUG, as the latter depends on
> CONFIG_SPARSEMEM_VMEMMAP. Make sure it stays that way.
> 
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs
