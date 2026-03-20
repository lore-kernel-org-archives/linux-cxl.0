Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A683341065;
	Fri, 20 Mar 2026 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044841; cv=none; b=mGBcWTXEPQO2gmBHi44Y9ZmhnJ3DhJ60PsjV/dD9h+TBM9c9cG45JKP7Iov0cJumInL0KifqcddWhANQY9U18XwS9hdhXaQ+Rt9H2zAwqebSyyibTRW/9Vvd7tzlm46pzWUn5cA2N7UZnKhCkY35k4wUpN+bTm/TiAWglLYZg34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044841; c=relaxed/simple;
	bh=mvXhiGTn6tZZYnNOOoiRbg2GgcaMPiyLXwyjxmdxo84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ttEzB9UWMy2kWm7lbj1FdgMW9kHNgrDd3CLG/dkvMHytcM0cnxN2be9yh1dOUw8105eRliI4Snkr85x8u6cONMTjq1RwKdg+9ImXJh3imHtMs/6/8bXjNOYohmNjRSabGOJdPfTU3mY2uFBMXCGZXmbskwBtPBC4dFU95Qg3VaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/uB2w7D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/uB2w7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BC5C2BC87;
	Fri, 20 Mar 2026 22:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774044840;
	bh=mvXhiGTn6tZZYnNOOoiRbg2GgcaMPiyLXwyjxmdxo84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X/uB2w7DSbxaqWWZI0SFouAEqRYt5ziW1QewNaYsFL+YJCSIra6vwkHxw1G9GGCh4
	 BIg7cd7GsHXYGOKUNs0MzTHjHG60jQ69wHz78GZiVzLl9CYVKK8mKlaJBjYPupxasS
	 g+bH6a1n9UMg+IiOGJihFzUSK7KfYpQoRfoiR5xltvNtvoFnAacVxiUXKk85xWL8c9
	 muE+/XC1RcriPyCEgQuzM4jbHkE9K1Cv3yzKRDknP/UJEsuMIMFvejFsVGjnmVpp4O
	 pbmnmWeUm1R8FQmqFTejFLSSs151sXs6nnngVkaakFF4+Yn2aN1kiPBhn3e/pwFWuy
	 w+3VzFUlJqhAg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Fri, 20 Mar 2026 23:13:36 +0100
Subject: [PATCH v2 04/15] mm/Kconfig: make CONFIG_MEMORY_HOTPLUG depend on
 CONFIG_SPARSEMEM_VMEMMAP
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-sparsemem_cleanups-v2-4-096addc8800d@kernel.org>
References: <20260320-sparsemem_cleanups-v2-0-096addc8800d@kernel.org>
In-Reply-To: <20260320-sparsemem_cleanups-v2-0-096addc8800d@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Oscar Salvador <osalvador@suse.de>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
 linux-cxl@vger.kernel.org, linux-riscv@lists.infradead.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0

Ever since commit f8f03eb5f0f9 ("mm: stop making SPARSEMEM_VMEMMAP
user-selectable"), an architecture that supports CONFIG_SPARSEMEM_VMEMMAP
(by selecting SPARSEMEM_VMEMMAP_ENABLE) can no longer enable
CONFIG_SPARSEMEM without CONFIG_SPARSEMEM_VMEMMAP.

Right now, CONFIG_MEMORY_HOTPLUG is guarded by CONFIG_SPARSEMEM.

However, CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG is only enabled by
* arm64: which selects SPARSEMEM_VMEMMAP_ENABLE
* loongarch: which selects SPARSEMEM_VMEMMAP_ENABLE
* powerpc (64bit): which selects SPARSEMEM_VMEMMAP_ENABLE
* riscv (64bit): which selects SPARSEMEM_VMEMMAP_ENABLE
* s390 with SPARSEMEM: which selects SPARSEMEM_VMEMMAP_ENABLE
* x86 (64bit): which selects SPARSEMEM_VMEMMAP_ENABLE

So, we can make CONFIG_MEMORY_HOTPLUG depend on CONFIG_SPARSEMEM_VMEMMAP
without affecting any setups.

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index ebd8ea353687..c012944938a7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -472,7 +472,7 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
 menuconfig MEMORY_HOTPLUG
 	bool "Memory hotplug"
 	select MEMORY_ISOLATION
-	depends on SPARSEMEM
+	depends on SPARSEMEM_VMEMMAP
 	depends on ARCH_ENABLE_MEMORY_HOTPLUG
 	depends on 64BIT
 	select NUMA_KEEP_MEMINFO if NUMA

-- 
2.43.0

