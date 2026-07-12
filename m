Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0386C340D9D
	for <linux-cxl@vger.kernel.org>; Sun, 12 Jul 2026 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783871127; cv=none; b=ICDUHL9BO/TzAYSJN4gZIUahzyKUQzLqSj0jR43LyWwLk/kNTRWSjv4hOyAd1cX5jdgNuybD/2jEW5ybISZY3SgkLoPoK7TSIV9YKMbb071x5n7McBsrIwxNhV0LPZ22J8N+hmDAlThEqvu4bUVwfZKBUmMhP9bxEERY7iQ1yd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783871127; c=relaxed/simple;
	bh=PA4Bqt4ZM/5eU9t/Xv2IagzZnnLp2iO/pQZpXfi9d2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1XAdiJ+p/fXb8o2teHJD3LBGdXgcy5VCFvjiPJHeF0CF6MvtGaLGRbOgc4hOykgN9BLjfa22rqXU6NywoiXEM3G49gxY1q9dzgtx1AMMcBStUv9KgnkIyUpg/UCD8FqQPDP8Ih0l5NwexwRfFB5ieXEeaAg/t2XUYI9SnbIJIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qkQwxyi+; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qkQwxyi+"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e4fd65b2bso126161785a.0
        for <linux-cxl@vger.kernel.org>; Sun, 12 Jul 2026 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783871121; x=1784475921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qpaKnc1e95Tg7VSs2UGrLw6c/qizit0d3ArQLheYoTo=;
        b=qkQwxyi+lS/V6C/6ZbviOYZiK/Xyxwj0S1s5rI/8IjIakus0/4wabvGX9MLUW+mRMJ
         ACfreLka0ufxOaXhswp7U60dnZaqZGcPLZRzs8X1G94ZnrXV1IATULPMOSSH169xGqph
         tu+6Ug/8MyVgNZ2ORyrEKKcSDFCqNXctaMWVN5bvgrkDBdaC8ESQZRRHEjyanbTXPRAu
         q48L5wai0s5lIHiWMCY0a06leNDRZLQ46NWpbwzumk+14PUQx4rC9ls+hx3KTexvvNL3
         YYu4v3xkof/1jdkFSZhfCJlGPpq78uMUAswALJGTP4AqTMIh+Ce1d7wZg1LJrg33kSeI
         yz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783871121; x=1784475921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qpaKnc1e95Tg7VSs2UGrLw6c/qizit0d3ArQLheYoTo=;
        b=p5ODkQocNVMnyZPCJnbpVOPN/HTLffhhepm3Ige8m7/U8e8c1j3eaPa8hPGybFk4N2
         V9KkwXTJnJp069kmvXngiteu+qftfuuQsHELIGXVpR8rXadb+Vwr/jTW3BBxG7/riLlo
         aVa3/3p9kfPcefjA2iDeGUsvnm93FE6XAyjWS7gcuZIbQnExQ/DdNKh9MCiPKtqs8uZq
         Ss6BghlWWPQUrRNFh+ZE/CN9PUYTUBYxaXqRWForD8/dt3HmT68OKnA6l0jWG8uak2qm
         5FQAmY/iT6Ca7m3MSO4UY6D6oMGu6iGHnNbMHo0vtonrHLsrc9s4W1a08l404MvYPDtf
         JqXw==
X-Forwarded-Encrypted: i=1; AHgh+RpMLUzFJTfpOtgrVMfewxPO1SoaIjLz2+SAmxEh5eUFUKez6H+lXq91bEJo+mUiV2nb3mPVWVRpAVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4kucdKLQ9t3lpHS9PWgrWEuB4TLql6uAgy8bT8ZBwFniafVsQ
	+/0xVjuv3UicBAqe9ZUOGrJ88xC7caLn7t/r0NmMY/7WdQwR0cOtho0tlA/iJS6xDIk=
X-Gm-Gg: AfdE7cmZlfslWq2giJbRXNjitxJcVaG59Ga0zzH1VUstsJta4VSHhGdyJo0l1OayV2f
	ZJdPbuYtmByd6wp9/KftvhHnowoKv6cXiSF+W9P+mM63ouiLxEGD4DtpzMPqQTWiXGojdNjq/UP
	ceAdQV4rbmgucIdYiabALlNPeZaLY/qTXkFR1Mf+UiQwTlFc4L1pV6t/bCNUJqyueL8VaEsekoE
	myIl8mD/UxZYkuXcwl6WMpVP7PUY06zVCxwv6rG4u1wRoOmcLDo1nykdca19SYwb1O4+3zG6obS
	40GsBBOwUu9dtthKGyfrHOAQ80h7UmVR0TyCGb44cwOZpK+oPFkrDUSuZHZuORy56q5es4FAjsp
	YKwmpy6F7ciX0rTq4x5O2ADVok2aYaNmGFNQowp7txAALNwZzfgEzwTq0t37viCN82Tpr3T86rI
	/6MpwjqH+dU7d4N0I3PLWRnDnMyFV17liK/HAvj3YvD1F26GSVebxJU+uduG3sU/RXhp3w/6A/z
	A==
X-Received: by 2002:a05:620a:2913:b0:915:e9c3:f1a0 with SMTP id af79cd13be357-92ef2b35bfemr677144185a.12.1783871120928;
        Sun, 12 Jul 2026 08:45:20 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d61facsm862186485a.42.2026.07.12.08.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 08:45:20 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com,
	david@kernel.org,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org,
	gourry@gourry.net,
	Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PATCH v7 03/10] mm/memory_hotplug: pass online_type to online_memory_block() via arg
Date: Sun, 12 Jul 2026 11:44:57 -0400
Message-ID: <20260712154505.3564379-4-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712154505.3564379-1-gourry@gourry.net>
References: <20260712154505.3564379-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify online_memory_block() to accept the online type through its arg
parameter rather than calling mhp_get_default_online_type() internally.

This prepares for allowing callers to specify explicit online types.

Update the caller in add_memory_resource() to pass the default online
type via a local variable.

No functional change.

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/memory_hotplug.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8b137328dcf01..e625529baf996 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1338,7 +1338,9 @@ static int check_hotplug_memory_range(u64 start, u64 size)
 
 static int online_memory_block(struct memory_block *mem, void *arg)
 {
-	mem->online_type = mhp_get_default_online_type();
+	enum mmop *online_type = arg;
+
+	mem->online_type = *online_type;
 	return device_online(&mem->dev);
 }
 
@@ -1495,6 +1497,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
 int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 {
 	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
+	enum mmop online_type = mhp_get_default_online_type();
 	enum memblock_flags memblock_flags = MEMBLOCK_NONE;
 	struct memory_group *group = NULL;
 	u64 start, size;
@@ -1583,7 +1586,8 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 
 	/* online pages if requested */
 	if (mhp_get_default_online_type() != MMOP_OFFLINE)
-		walk_memory_blocks(start, size, NULL, online_memory_block);
+		walk_memory_blocks(start, size, &online_type,
+				   online_memory_block);
 
 	return ret;
 error:
-- 
2.53.0-Meta

