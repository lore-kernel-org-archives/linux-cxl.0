Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E83D8133
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313080; cv=none; b=nwHhK+bUEe9J3dtyISo8XztlH0rmlz7BtCfyI5nWKiaT/iWBnr20vWRN81tHgTPgqnCVu8LYVtPWSAMNGogp5O8QO0xLkiS0D6/jYlwn4GRLb8D7jS5/qaDQl3jTOHJbNe+sQcXQPcX6HKkR76//oMe9Rk03J71HqDX8K1oE9j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313080; c=relaxed/simple;
	bh=cz/Kd5Fg1n6RVtyFBzJpN2apXZy9vJ9be28aEaW5jhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1WrJoGEmQZ5RhziW00GDlqGLo9tiigHa6kL5jGpoLv/MpLhxoJwM9glKk5Z2ulTuR5tAgXXrTYvuqMvIDEPIZfm1ejGOaf0o5RPTvfvj22R08uJrLSyQ1oZhj46gHPoLi7pmX5MoYjqB0+D/en1TYiahJE1Xf2h7wMq6E2uaEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gwSWxRJ/; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gwSWxRJ/"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-519f9f13b06so9227631cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782313078; x=1782917878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQoqst23Sd/uqsFRXXVKz4Ck7yyavMrD/eBg48X+nsY=;
        b=gwSWxRJ/9hOo2kx43gdyE5gJacA7jTFLDluoTdWGhPNB3ahzdqbfCCwFu16yi57PBV
         QwdHrQCMz9YcVQqDw8s33CaxXtaaVeePyhFn8drBndnIFqyZKEHsqiHV3JWPdbBCbi+L
         V9gmanMdsLXh8CXpUWNmc9bWS23r+IVmLR8icUT6o0hFLNOxxSacBPq/VXzBsx5e28jP
         Q1uDxQHI+2a4YA7iAGd6wX6Z7fxrUi2klZWr5WVXlZeXCV9DnETigX/hlAjk8lrk21WI
         /pcCYdxvws2x48ez/OO5iJ1fIzbT/Gf2rJImHCFux27dee+gA1nbZ81AenUBpzRUrMAw
         +AIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782313078; x=1782917878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UQoqst23Sd/uqsFRXXVKz4Ck7yyavMrD/eBg48X+nsY=;
        b=c60l7h6JjAVdSy2aRvt0rCpIFYpFUq6qD8GNi8CvopHqnlyK/NfG2pEXaBaXAPD4Es
         A1MKXyRqdu8yLuM4Yf57kqjA3tTSslWJlp9tEUar8cUP7zLOQ3zZOgTNPz403EB3x0NV
         foxMgCSEVua+knjyGXGRbz4RyYwZO6Jj2dfCP2nidC7757pjLIKSSpeMmNI/OiPLEH/y
         DQnWIQJebBCzsa35r8cVikaWO9TBpAJm24i2cszpsmacZQHX2GKpXgz4srKcfKtLZgdD
         +lexYuspk6zx09cPDgvjq2BTK4vtykn9RG7xwEwcAXaYHFlwF8jZ3u++W/AkMg+LKm4/
         sShg==
X-Forwarded-Encrypted: i=1; AFNElJ/CLuIOmSpvXTapBJ52nPmW9Jv5HY6114ai/IqUL7GCemqYvmOanWy01BV+RUW01fzoi7j0iQkEY0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa6QIxX3StX53cc7w7jL2ol7UlSBsMi+sYsfMV64juouR4fRc7
	8SW5QBj2IWQhSC+tOEvzNgbQvJ1CS7Td84AF5wkkrImH8ur/fYjeCv7OR86yy7vRF7M=
X-Gm-Gg: AfdE7cn9dZtvNS5SvGofjb3SXbTbcmSLt6a7MlwkreE+UNtQjtnr8IgvWctoL23f4RD
	tWsr8dQ/8YasFi3osqav1N+WsZjbRHUT5hB1NaCIMgTqZZRPEs+wKOftHIxdnRXhPP4s910NdjY
	eKSgbaBPI7/FhfmPSLFOxM8WxsseVxvPzsDQJiC0OC6ExU6WYWz/FWTUf1N2+R3b3MgCBpGVixT
	pUts/J82poc6ZjCY7V3TbKmhbVrq9pu9c8tCGGozez/xhmQXesVxwvxjrhGDiPSEyCawmgb+9iO
	Z9mhBaOmG2Nc+ocxJRQbnwg1KCKcKUHjdTbfAoniE4NtXpWW2l/Gwb3G0jhUq33V2rQrQDGBDcO
	QoNAsdTq7uthGjjHvBwNb9G1dzBqNFjLJW2lw5i1Vv/Rkh/LrLqi5xUo918U+ltsdMnbQaUvJEb
	R+50P6sruD12d2pzQZETp6AKpGQuvIH1tyneEqMu69OWlsQU92T7tcWOfCOXRLFkRXmC9wwCwDI
	A==
X-Received: by 2002:ac8:7dce:0:b0:517:7e26:36a9 with SMTP id d75a77b69052e-51a5485b854mr12138801cf.39.1782313078372;
        Wed, 24 Jun 2026 07:57:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51ae8ee7sm49502301cf.24.2026.06.24.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:57:57 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	nvdimm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
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
	akpm@linux-foundation.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org,
	gourry@gourry.net,
	alison.schofield@intel.com,
	Smita.KoralahalliChannabasappa@amd.com,
	ira.weiny@intel.com,
	apopple@nvidia.com
Subject: [PATCH v5 2/9] mm/memory_hotplug: pass online_type to online_memory_block() via arg
Date: Wed, 24 Jun 2026 10:57:37 -0400
Message-ID: <20260624145744.3532049-3-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624145744.3532049-1-gourry@gourry.net>
References: <20260624145744.3532049-1-gourry@gourry.net>
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
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/memory_hotplug.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7ac19fab2263..6833208cc17c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1337,7 +1337,9 @@ static int check_hotplug_memory_range(u64 start, u64 size)
 
 static int online_memory_block(struct memory_block *mem, void *arg)
 {
-	mem->online_type = mhp_get_default_online_type();
+	enum mmop *online_type = arg;
+
+	mem->online_type = *online_type;
 	return device_online(&mem->dev);
 }
 
@@ -1494,6 +1496,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
 int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 {
 	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
+	enum mmop online_type = mhp_get_default_online_type();
 	enum memblock_flags memblock_flags = MEMBLOCK_NONE;
 	struct memory_group *group = NULL;
 	u64 start, size;
@@ -1582,7 +1585,8 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 
 	/* online pages if requested */
 	if (mhp_get_default_online_type() != MMOP_OFFLINE)
-		walk_memory_blocks(start, size, NULL, online_memory_block);
+		walk_memory_blocks(start, size, &online_type,
+				   online_memory_block);
 
 	return ret;
 error:
-- 
2.54.0

