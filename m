Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A903F342CB0;
	Wed, 18 Mar 2026 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821707; cv=none; b=DULuk2r//RG4emvXVhVwHGTZi4lvrh7Kh4wQn07/aedRn5PFqEM2djPlHiNLQjcrjM1Nx4aBI4yjixSk+sC4PWoePFY5Zck2M29sA0ink/rnS1MJJAqpLyC/V3shoNZ4jHk6kBNmnPz5+gnVDCaPutyF40iM1WZPHxb3Ca58iAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821707; c=relaxed/simple;
	bh=yqTaqO+qzEFFDEYd3nxXky9PFfRd40iUXDeJGUIdVPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/czzcznjCme+9++nchz9joYM6WGL74Sf28FECn7w8sjGJHv9JMtV1uUI+pzIS8DvMN/Z2WR53029CTkunITZ0C6sKE6NFJzqV98qiIegaKSv+7+nvUHX85UH+y78/ITt2u5uTeau06V0giL6msJoO+VlAPGEWdm7vxKk97NTQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nw4Iq8vY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nw4Iq8vY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33813C19421;
	Wed, 18 Mar 2026 08:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773821707;
	bh=yqTaqO+qzEFFDEYd3nxXky9PFfRd40iUXDeJGUIdVPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nw4Iq8vYYab1bMNPqPjAgVJ4mwmMciGmr/iEwes3FeiiJhS+EzCJy2d4r7EW/uvCA
	 MfXOzHbzlRcsN9JeGJse+2M+mm2bb2QXNC0AuW/0qDmZoNyMhdp2HJgWjxJR54of0o
	 4+5+PkO5TcDrJwk2T7kF+GmN18rITr7yIjxGc5NZ6oH+heE98W6xNyYLYDtGwX1MCV
	 bfox/sfXQLKPIdAukr/Squ9VDyuDAiyaS/OmZEQS765cE0/CapPXXr1vmRtmVlzA4W
	 iK1OM/L46e1H4FgmURjcOZKe3O/m71feiDhRgxY/U8hOKm+gJaKmz4L0vtpRCnlAZC
	 xntlLjorMM19g==
Date: Wed, 18 Mar 2026 10:15:01 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 06/14] mm/bootmem_info: remove handling for
 !CONFIG_SPARSEMEM_VMEMMAP
Message-ID: <abpfBcnGOemxQxzL@kernel.org>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-7-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-7-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:44PM +0100, David Hildenbrand (Arm) wrote:
> It is not immediately obvious that CONFIG_HAVE_BOOTMEM_INFO_NODE is

Would be nice to make it more obvious, e.g. something like the patch below.

> only selected from CONFIG_MEMORY_HOTREMOVE, which itself depends on
> CONFIG_MEMORY_HOTPLUG that ... depends on CONFIG_SPARSEMEM_VMEMMAP.
> 
> Let's remove the !CONFIG_SPARSEMEM_VMEMMAP leftovers.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/bootmem_info.c | 37 -------------------------------------
>  1 file changed, 37 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 102ddbd4298e..261abc3e1957 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1841,4 +1841,18 @@ config ARCH_WANTS_PRE_LINK_VMLINUX
 config ARCH_HAS_CPU_ATTACK_VECTORS
 	bool
 
+#
+# Only be set on architectures that have completely implemented memory hotplug
+# feature. If you are not sure, don't touch it.
+#
+config HAVE_BOOTMEM_INFO_NODE
+	def_bool n
+
+config ARCH_ENABLE_MEMORY_HOTPLUG
+	bool
+
+config ARCH_ENABLE_MEMORY_HOTREMOVE
+	bool
+
+
 endmenu
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ad7a2fe63a2a..2d6f348d11f7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -127,6 +127,7 @@ config PPC
 	select ARCH_DMA_DEFAULT_COHERENT	if !NOT_COHERENT_CACHE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
+	select HAVE_BOOTMEM_INFO_NODE if MEMORY_HOTREMOVE
 	select ARCH_HAS_COPY_MC			if PPC64
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e2df1b147184..ef2d2044f1a9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -70,6 +70,7 @@ config X86
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if X86_64 && HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_MEMORY_HOTPLUG if X86_64
 	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
+	select HAVE_BOOTMEM_INFO_NODE if MEMORY_HOTREMOVE
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if (PGTABLE_LEVELS > 2) && (X86_64 || X86_PAE)
 	select ARCH_ENABLE_THP_MIGRATION if X86_64 && TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
diff --git a/mm/Kconfig b/mm/Kconfig
index ebd8ea353687..a371df4f8da4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -455,19 +455,6 @@ config EXCLUSIVE_SYSTEM_RAM
 	def_bool y
 	depends on !DEVMEM || STRICT_DEVMEM
 
-#
-# Only be set on architectures that have completely implemented memory hotplug
-# feature. If you are not sure, don't touch it.
-#
-config HAVE_BOOTMEM_INFO_NODE
-	def_bool n
-
-config ARCH_ENABLE_MEMORY_HOTPLUG
-	bool
-
-config ARCH_ENABLE_MEMORY_HOTREMOVE
-	bool
-
 # eventually, we can have this option just 'select SPARSEMEM'
 menuconfig MEMORY_HOTPLUG
 	bool "Memory hotplug"
@@ -539,7 +526,6 @@ endchoice
 
 config MEMORY_HOTREMOVE
 	bool "Allow for memory hot remove"
-	select HAVE_BOOTMEM_INFO_NODE if (X86_64 || PPC64)
 	depends on MEMORY_HOTPLUG && ARCH_ENABLE_MEMORY_HOTREMOVE
 	depends on MIGRATION
 
 
-- 
Sincerely yours,
Mike.
