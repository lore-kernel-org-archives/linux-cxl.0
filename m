Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9524341068
	for <linux-cxl@vger.kernel.org>; Sun, 12 Jul 2026 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783871128; cv=none; b=gMBNEJDTWmBmUecncWSeyYU9Jt1gDk3vVSCQjxSSpZaqk8DaugIA4eF9kvYZNjra2Ib3O1yorAxGrBDGh54QDdf2ZeWtsmCcsEzTfCmoip2aMG9RkkHmVASKHMmDrL7c16PFyYorVR8roDnncvgpadIPTKpt1c87xA/szc/oLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783871128; c=relaxed/simple;
	bh=uhoFb1AdQ1YY63K+zjDeKis0/pyRtDsZVbRXxtXWIEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgHr6933P4G7gaUgcyBw8mtRhI+8VHM0Fn4asM7nc93E9Ic6Fal1mJdBJKOVYjjZdsoWZfXUnrgpXcFdPNmfRDw+ngbU2f3MPktGDw6Sld6NHbTQoiUsHH+88qxynlNBXvUi06bXzYyb5r+fiahh2ERGSfXg6VMQ6qfth/dAnyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FsDCEHzZ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FsDCEHzZ"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-920f33347f5so138581885a.3
        for <linux-cxl@vger.kernel.org>; Sun, 12 Jul 2026 08:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783871123; x=1784475923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zjJw3wlBuqXvLpxi0GmvsmDJYE5o3ZwGQsOl9zW5rZ8=;
        b=FsDCEHzZ6ObAzYO+uIrwhLS6SpuDFiRHY4PN5Xqvn8fXFhYY2fju0cIElpd6qlt7B3
         UQWHgm5MIaZdCJSq/utvA+u46asV9VrhVrPSkIwNP0r1bEzSOBQ/ZcJPM8DxA9hda6jU
         XGpN++uG4hEbuCmrN0Bv8/TtUkDz48dISsPfpgtN6Xex+mns5tO0chbc2kDchD6ssPBx
         X/XoRbLzE+F37BD9ohQ3c7qaXQq4Kojr10SHyoKnag7KGOJinOc2SJoQwGxG1M1F/JEg
         CPeIFRV1VDQq8383J2Uq+KOIum9zPrshkbnwAo7pZGtS2qGS/MDmIdaD+CuzrNATrDn3
         Y+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783871123; x=1784475923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zjJw3wlBuqXvLpxi0GmvsmDJYE5o3ZwGQsOl9zW5rZ8=;
        b=rw24DzLinDyr/hobgfVV6jhS8IA+4x/Hs23OP4snsbr4DAK7atpkmMdIcf0p/eqacp
         TDkkytC+SYkns1CExaGqmeRe8ZT1uLdBlUfM8otCQvIqYpcHaBCfvNI5CfkyCnJ2kI2w
         BHYQKaA8d0tAC6D0CWaadhXyrm6z2MDBnBEM6EMEnk89uRSqRHqiOJKb+ntr+nR23v7X
         ZOeM6Kdryn7EObFYQPlOQF1DLtPu+Yy1pvGSZIYm1gtCjH9ZsHOgUkOY8EV+uy8u8/hX
         tbBZGVo4FqGS+FEc6ZyxUBKVppYkNG6uNKrzdGa5b9hsJ8t7P2eiI2HLNec3+7QmBO+n
         vRzA==
X-Forwarded-Encrypted: i=1; AHgh+RolYfNFVK23o4mSSaCHXLq43JKuhJ614P4+Dbxfx9YzZ/4G//9JgSVVQmoK9rlQUnVa3o80rFzG/Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUoeOgcDBy2tTgsFOj3tggwxh+Blt2m9kiD7Ib6KioP8V1Jm4F
	MTJEVR7opSKAjI0HP7UnoQ98H5Kyt0mBWl4vV+GVaBrWWWh7rXMbVJYhReulx/1MvyU=
X-Gm-Gg: AfdE7cm0gF4wdhKc9mwpbEpoy+i926SLX8biJfTUL5yoyc9dBrhpqau4P7VIRSXFOB0
	+/zOJHBA+pUwD9sxS408nS45QeX2mDQXOLUC3fs+ECJEWcu1yvWdINL4Z2agBpS+bUiWrTeiz2V
	20pCR1W2H+aWGBhckgOlX/oIZMqM4pBFtYLewWU5nkyabTl1YhJNzbfS3nmsQaKGqBoshHobGpf
	/XoNvwKiWljvKRln8t3pgthZZBJSFHFLu6/sbxjPIodnMxvJFFiI+bPLw/oTouFOlKUFmnIiC7S
	OJ2o13hz7C/zAmBHxd0PPu0zOWxQbanBh9cNSCMlKc+LJVTbhEW1o59AmB2rrcENu7i6ssqG/6y
	D1a/NnjPZUFNlHhNaoi+rn14+qgv28sppA5038dvZWgou/klJ78JzyoceZ7swAnYTssEmK9lLnx
	B69Ew9PE26h3MF/1kQkSO+8yie9OX/l5mP6uXi4fqMLXAsHGv78YKwvMnDRkRNBWxmR2eJQaXaU
	g==
X-Received: by 2002:a05:620a:4711:b0:92e:5610:e479 with SMTP id af79cd13be357-92ef2bfd741mr601996885a.52.1783871122600;
        Sun, 12 Jul 2026 08:45:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d61facsm862186485a.42.2026.07.12.08.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 08:45:22 -0700 (PDT)
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
	gourry@gourry.net
Subject: [PATCH v7 04/10] mm/memory_hotplug: export mhp_get_default_online_type
Date: Sun, 12 Jul 2026 11:44:58 -0400
Message-ID: <20260712154505.3564379-5-gourry@gourry.net>
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

Drivers which may pass hotplug policy down to DAX need MMOP_ symbols
and the mhp_get_default_online_type function for hotplug use cases.

Some drivers (cxl) co-mingle their hotplug and devdax use-cases into
the same driver code, and chose the dax_kmem path as the default driver
path - making it difficult to require hotplug as a predicate to building
the overall driver (it may break other non-hotplug use-cases).

Export mhp_get_default_online_type function to allow these drivers to
build when hotplug is disabled and still use the DAX use case.

In the built-out case we simply return MMOP_OFFLINE as it's
non-destructive.  The internal function can never return -1 either,
so we choose this to allow for defining the function with 'enum mmop'.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/memory_hotplug.h | 2 ++
 mm/memory_hotplug.c            | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 8f6da2656f4e2..f19893f5fa948 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -317,6 +317,8 @@ extern struct zone *zone_for_pfn_range(enum mmop online_type,
 extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
 				      struct mhp_params *params);
 void arch_remove_linear_mapping(u64 start, u64 size);
+#else
+static inline enum mmop mhp_get_default_online_type(void) { return MMOP_OFFLINE; }
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 #endif /* __LINUX_MEMORY_HOTPLUG_H */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e625529baf996..be8e8e2cd1535 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -239,6 +239,7 @@ enum mmop mhp_get_default_online_type(void)
 
 	return mhp_default_online_type;
 }
+EXPORT_SYMBOL_GPL(mhp_get_default_online_type);
 
 void mhp_set_default_online_type(enum mmop online_type)
 {
-- 
2.53.0-Meta

