Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219763921DD
	for <linux-cxl@vger.kernel.org>; Sat, 21 Mar 2026 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774105456; cv=none; b=gsvPrq3+2sTjcwjNdLjNT+oqnqp91q+n40goTg9OlEJX2o3G1VWhRUSOI5RKizmlsXyhJb/Z/Xld2uqgq1CUg4dIweZLVXu9rtvsAY6yzii3FQYycXMGYhdXlIMx4s7yld0/1JQbB8N5UdJWqN/HRAQDxptanRawyNo+BoEoQlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774105456; c=relaxed/simple;
	bh=yADcON58BEc3yFXzCjE0Ob9wsd7UaBtY/rhvKXGDZqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAIf/wdZdSL5gcMcJZbi61zdO4RQBSoGJKfj/6jq4CpZNl78DZmv5E+sbnCoQQebnM6iGfvy64eWFwKjsU2Nh+29ghDVkURnUftv2PlA1T0ZNYWLcFwWe/IUO4G0Y9mHt3N69TuukBaikBYP8eavrp6aLwDaUoirNyy5+cKat14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cWBEXRUE; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cWBEXRUE"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5fff52ab292so384764137.1
        for <linux-cxl@vger.kernel.org>; Sat, 21 Mar 2026 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774105454; x=1774710254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=caGxMrakhd3CQmCyLFUIWJ+VIS649rYQrZPqpBwweHk=;
        b=cWBEXRUEXRo+Xq5gb1VIWQ3//d70gdeIrg3jLQqO/l41PjMS7vgdN31dRr8hOvw66J
         nIsF1FZg0bW6ImwTM5qtm6H+GO/2ahzi4u/UuW+IhB/PYin+hxhQrXVvg6gOiV/bofk7
         5Mafn7GKH9p1VAh+aH16MafImru0M4P/QoJZmwgSXY33KH1fupYUh+DELJoUbSNGEkS9
         Qcn23kITwRerHm2Rg6RcYtliMb9Ng1TOfTI/pNs4I8R1Xs0pbbH25bVUG3I2m0NNVaG3
         hdLY98wcfBfdrpl9x9PzSgat1Vugchj6m7yVlZ/1993TigO9CVnVrNyTUTeKj9GxnO84
         ngmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774105454; x=1774710254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=caGxMrakhd3CQmCyLFUIWJ+VIS649rYQrZPqpBwweHk=;
        b=Cg6TVIp+bPv7jATSW3otTIJz49w28DSeMEWswGFB/0VzuDa7ajYnjDCxru/RA6NMQV
         Od1ENnglVEncxgg3q9k0TfkulPOVjggoR7XIRbjZXTs/6CyY1xLPg+lkAh9cdkHKlwHe
         YzMqhff26trZh70Zros+mnT5aArQaDVoQlT4VSKkCUtlN/oHSmqr3s5w6NwtpcKFpDtn
         W8F1MxrBwMHEBwlDYeFAmiYJtVdBa1+KqevqNOakJis8986vpBRedWthJHw1Zf95m3zq
         71hlG9Vlx56jWdAm3wKHf/WUzC7/okrHYjzzIeblzcqlW5hUoXKrI1ITAXL7XXyZItht
         w6zw==
X-Forwarded-Encrypted: i=1; AJvYcCU7CrjIC41fNTH5DIAAPkRx+HTVfmw5A9xpnZY81ew3Gd6/WrQJJVjupUPe0gcEtuZOXzW2LwNYtHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9LLoFMW7y3QFPJg7V6nupovnCgsnmxHs+Pi/oxqtoitcBMwP5
	YGCR5HkdqYvlYYSVId5otBFCbPW1DiOv7gb4P9hPlXWisHedjw3BBKyvHK/B3tptwGs=
X-Gm-Gg: ATEYQzxuf1Tll+1dTsHhlaxFHXdd+crHYzqQRvCuvfEjqFK7uQMpXWXXZCR6ioGGaI3
	rIQrQcN99T9PLxT+j/Vd419HdMmb51/9SFmmc+zrI5icSShW71AniT6JTACYUmUDZFAW1hpDWqG
	Tl1zHKNvSjsVbjUuUPooElIbxEd3tTrlYkQchv9LCb4u7cvbGepcNNC3/ZHMGNJrSb3E5pZ/tPO
	JLAOerzZpATOGcf9f1+6CrEnP2Jve3kHr6RcmULTkHCzBffDwGwyFn8o9p65eSKVx/OKRc+Uizi
	+eOp+jwg1zuHU4xV1+1bhGxUS8IUQ6v9zVzAPcK4cTC90ElKL5lb+T5NN61xYV461YxdO2/QdiR
	Y51PRtyo+JAqF0lztwSb0jgiuSmUSI+doE+9ZWvPQdKT7wBYV2pKOBgaq6VQpGLj9+v5QPs/o/8
	owp6ViZFGAaYWDlsmDOUYzQlyiM2HHO4z2V6psMxARo/gYNQF/GHfq9Ngfuw04Y9DIHFftUTBZF
	Xaad0JG3zsaUTHka8VJT0Y4PA==
X-Received: by 2002:a05:6102:8089:b0:5ff:e39d:9f9b with SMTP id ada2fe7eead31-602aeb3a44amr3175883137.16.1774105454003;
        Sat, 21 Mar 2026 08:04:14 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc90ba89fsm391979885a.40.2026.03.21.08.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 08:04:13 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	osalvador@suse.de
Cc: dan.j.williams@intel.com,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 3/8] mm/memory_hotplug: pass online_type to online_memory_block() via arg
Date: Sat, 21 Mar 2026 11:03:59 -0400
Message-ID: <20260321150404.3288786-4-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321150404.3288786-1-gourry@gourry.net>
References: <20260321150404.3288786-1-gourry@gourry.net>
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

Cc: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/memory_hotplug.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 86d3faf50453..282bf3d89613 100644
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
 
@@ -1492,6 +1494,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
 int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 {
 	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
+	enum mmop online_type = mhp_get_default_online_type();
 	enum memblock_flags memblock_flags = MEMBLOCK_NONE;
 	struct memory_group *group = NULL;
 	u64 start, size;
@@ -1580,7 +1583,8 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 
 	/* online pages if requested */
 	if (mhp_get_default_online_type() != MMOP_OFFLINE)
-		walk_memory_blocks(start, size, NULL, online_memory_block);
+		walk_memory_blocks(start, size, &online_type,
+				   online_memory_block);
 
 	return ret;
 error:
-- 
2.53.0

