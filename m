Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C433D3334
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780694367; cv=none; b=nUhDN7o5qLEYRfauoy7etKpoBnt2E+YhU1OyxI7Gluou8i2GDGeekySpPSY7h7IHENlxv/Kh6KE0NSTx5WjuJhYA6jPYh5ClL5ZY8kjW+u9chXqEgxtlOnHlniXgBzz9D9fYD8FbVFlmvEJHrB7n55ys06faSv++FoQbXYRe7q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780694367; c=relaxed/simple;
	bh=5Ke3NaIM8Nos+HKJ6P0Knao9PHLgdSQ3RyZDgwl5zPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuzxlPUnDXONQKx6PvPOaZMWbzQ7vlUbSDx6G3L0ltg2+wu7Am4WrZ7h7fuxvhXiinczYpbiAusZre+B4B0jP+WGGC9dDZzZJ0K5pe7P6n6Vgow/jZyHEPRimXwKOSEUyfAR1fdqF3t37Van0Rrjn0WfirqBwBmYmLiAfavbgrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=oinAKT2G; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="oinAKT2G"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ccdf8d4ac5so26222486d6.1
        for <linux-cxl@vger.kernel.org>; Fri, 05 Jun 2026 14:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780694358; x=1781299158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oucyR6ExWtK/Mt3ZHMUJ1XBxl0rtHFiWxfVOhnoVW3U=;
        b=oinAKT2Gymn+/oDqzROE9bnryQuZ3vuRYexanN8h7eCN+NIjzUk1YXIfoz7J7QOKb1
         Wj/4ZhiWpwBSDTbCbJUbhGfLndAc3eouVdofHo2zF+rBBTKYp9rG1pIOmxP5MTTy4WL8
         3fhTWk8QdhC3R/Bpq7crTk31P80L17wn3YJE0w2hOg9c6xmlQL/SiIQDniXumj/pSwXh
         QrlhMGF2BpwW/QpTtdHLjWkad5fInsannvvbnz2ZV9RoUj+I3VvXSxaLcR35TkZo27mV
         AePyf4oTkex8TS/XN/qlaPFzIxpQWmEo022P6PKYkDhgz6oI9Du7JX0sULh3L38/ApgR
         Kn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780694358; x=1781299158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oucyR6ExWtK/Mt3ZHMUJ1XBxl0rtHFiWxfVOhnoVW3U=;
        b=lwmZ9uQFuWRy77eTDyMfNl1vJl7jG69EaPn6lTEIV8NRbd5ZXk2wCnBCjcbw4YrJUj
         hK8E6Vpnf+Ykt1eqTUIoQvV3HItVDMiGWJ8xY6Cp/micUUEnUzxmnyRGZBfejgaEAiU/
         kNI+7zN9PxkqSMessptQaxw7s0gdm4lsKRfiyOfoSwKpkNvw6carohOB00VLlgGkcLqz
         oyp/L5WzcG30d9z617U4M3TqAZczXrtaDvSMv9SZC4nhijKI4E63ahdMvs9r0IuzNDeK
         fqitH2Oo/yrOeHjZItYi3GFCVmfYyN5ot8Fi4uOhhCAugYBbWXhsnYittJEcMITa/NuD
         ZhtQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5khHjULR93KWr0DgLMNglIeDu5W4UkbF2aI00wwUjeTtK8M1IHkpeDmRinbSP2Mr/TECi2p9BFHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8a5K6PRWUc628JaBcfSyi30I3e0rCtSUgat7wDZTwhbNVYtS9
	028U/HgirTj7Gfjc3aycBOtkqwTkBIDQ6kPrQsWG32ufoodj//5I/gp+7mxMhth9h40=
X-Gm-Gg: Acq92OHWyBiehNhlrH5/o5HuusrIAGW2hnpKxICTcWEH4v+T5fbmeWhvlFauZSjraNu
	a3YQJZPZjT+p2+dVZOaxB5pRSy+2CHV7fUHpN/EqpRzmDYRFRhl3CHi1l7VSOsnw2ZMJsu2ILFt
	8jOTu2VVgFaDVtpy11Tqqcqv6Ohf+37fL2TpuUBNlb35smJY4CVjYGM8YDeau+py1IKYoAgL6z1
	rk9Pex4d4jO3vinAA5d++sMTz0ckq6X9oq3taDcIU7tOklxmRh9Oe9VICVK0beREeQuF2KRDBE8
	ju48drulZBUiLuVqMj0G/kwIwDiVUZCQptOK46kCYwyFkR3qgerMkGMBi9P5NU2oVkFUaerF080
	aJm/lW59yqpasV1N4bH80YfqW0klYmZWfPRVbmaXaPAny1W72/9WXkwA1sk7ZxM70jPiQdgS6nH
	vasozamaEzF3W0ZsTWG3sEfQsDJ49TMZXpjM7WlJbhJUvEAtBpO1jyhfxyi39iaNIxgir1ByLJh
	GyTFhMw39DA/1fK0Bzrvsw=
X-Received: by 2002:a05:6214:2687:b0:8cc:d4fd:702c with SMTP id 6a1803df08f44-8cee62655c6mr91017826d6.43.1780694358540;
        Fri, 05 Jun 2026 14:19:18 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd277bbcsm90518196d6.49.2026.06.05.14.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 14:19:18 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	nvdimm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-cxl@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	shuah@kernel.org,
	gourry@gourry.net,
	alison.schofield@intel.com,
	Smita.KoralahalliChannabasappa@amd.com,
	ira.weiny@intel.com,
	apopple@nvidia.com
Subject: [PATCH v4 2/9] mm/memory_hotplug: pass online_type to online_memory_block() via arg
Date: Fri,  5 Jun 2026 22:19:04 +0100
Message-ID: <20260605211911.2160954-3-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605211911.2160954-1-gourry@gourry.net>
References: <20260605211911.2160954-1-gourry@gourry.net>
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

