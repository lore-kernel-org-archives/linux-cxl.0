Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241183D8121
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313083; cv=none; b=qz4PtFaHZy5JFKke1wl5OD/2DfqjyvGQJSamuU5mbLPAvdJ81TW5lkibCZWp6cSUnfKsghVTvnH78GaL2nPFe2CtjjfCJusxp37CyLvswOaULONsq15gWmjdB2u6bQUvJcNEDSIjjYft0Gs4ePC16HJvo8dFJGuHX2MoFBCZagw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313083; c=relaxed/simple;
	bh=nbCS8knRu9kWXO+MoSid1D8mBkTg92BavF+PIpIJUV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=elPJdzOCEav8LaET1wy2Z7dJtj4//Sv9n4/6gp88wzZEjfWGTcs48GAWq/4gjn3D6T0kIXPWX/vTRrthm51HXtW5L61ng1qhIBqJkxbF43EeMFqbi+ehChuWsyXc6qYB6p8a+Lc6+yKuQwlIgi0yiO7UdsnA/dpmkwGMryTsckI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=E2ld2Hod; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="E2ld2Hod"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-519f758bca6so7577481cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782313081; x=1782917881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zb2DpzIiqwLq7NyM2oLUvxWd/WuB3n7pHvXvXxwOytE=;
        b=E2ld2HodjJvY8PEFjCCmlBC+m22VoRxeta7LZZJlkUOZeTl1wxD1Rm6Rsu+24PgXnp
         PpsGKvfVWCEtFO4GDU0IGu0HhjNsc9QkHEIOZetIS6cylfdeaPwLHjgixBcB4maRYFWV
         KMzDzxg8Qj0TORoWDjSPIJKC9op8oBQrSFqI7vhKfxVKGi2q3E9upsctgadrPFLijXEU
         1UTZRF9WK5nxdTvR8fZS2AG0zpMUHTXA0+4D/YnDklhXn4M9xW/jQzVNhrQZ2HRxgDBB
         SEFrnPimBXb5I51lcl9XuQRUZ0XQAIUC0CrIRo7tJ3iNIC5GIl0eDvzxbpxGVjxQspDp
         A8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782313081; x=1782917881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zb2DpzIiqwLq7NyM2oLUvxWd/WuB3n7pHvXvXxwOytE=;
        b=IZoUD26pznTnOI6UnmyiG3b4XIh0AXKNjYsRLIsY7j1iRcV27Gx5C+cGTEvjuzOTTY
         3peWQRAkunonFQPkntcsMMso/VpMNv5aCUPUL+pi08GtPsmS+r1gMqKQF/CkhT/52H+x
         Us8JimrIh0ZmN8dFNmuc0gfntCnTFX4R78H8ZWslxavPHe0GefEG1TwZrDi65cB61zV6
         tvOwd++cNm6BqTtEjG+Xg1S6JFFgBhV7mElhsZQMiP64yY6YjYBe7QA1uPxHuHMbUWGz
         PYnLblxTHr1PVSO7b05Bg6DP+0mD6Ybfrkut4JZV1zGVcVwuiK3faDkwpkD237iaTzC7
         CTbQ==
X-Forwarded-Encrypted: i=1; AFNElJ+kEYfCGBUjH5hpLXn2zvOPxyz08g2DCuo0QDIzt6xQs/206Cm0Eh+aQecE1O9CVaui35S7NnMIXpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXmUa+RB9lzx5pcepqUlPP/KE9+IvbkUXDpqp6V5+dwFaDSqLd
	T2eQBTtU+rfv2SB5Tp2bJiRzHQgkD0FisrmMeod5jSbBdGIxNry0dzeis5hnoPiDsbk=
X-Gm-Gg: AfdE7cms/emNEJj+F2zFfyPt8CUzIbE6TYcNx+1n4EqZH2MkPJ4P9NfNIrgFr/yG70j
	ZLlTqImoEGSVpYOB0qpo3DgdHILkOcL9kfMgm9+pZwkmw7pERNWG2YbLQtvgNModP4/Ds6uAnPb
	2DxzL9hGY71mpVzpHWgwwSc0aU1zig+UWmMQp6TKfyVNqoEjV37yTtvZezgFKMQGP6FpRLxzFvd
	f/oSVhUvMloLMO3QBCXYGfS2b4X9k4TvaOkzlIbGtgqKycWdDC6SqJXmvlvU1Sll89P9RrPIKA5
	wUFYo88TETzSRXFDzK+5SzpPyPzeeymqQtVVejK93yNNEwtfdvRSNZjdZk2zlmi2Z3LbSXBw+pz
	Y7nQi8VHsS8Tkk2mpeEVn/QLdE8FI8OT3o3RUWRB5qwXv3sioIhr9mrxRgWIPkqabAeHU/RpM5p
	N3DWn9ghPL/GWS74GMl1n3O6Iz4vIhJF3gzUjHzo5f92HWElWOvgdVhkPYMlVby7HXdrQHCt/Y8
	A==
X-Received: by 2002:a05:622a:130f:b0:517:675f:3eff with SMTP id d75a77b69052e-51a61d30f45mr54054471cf.10.1782313081085;
        Wed, 24 Jun 2026 07:58:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51ae8ee7sm49502301cf.24.2026.06.24.07.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:58:00 -0700 (PDT)
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
Subject: [PATCH v5 3/9] mm/memory_hotplug: export mhp_get_default_online_type
Date: Wed, 24 Jun 2026 10:57:38 -0400
Message-ID: <20260624145744.3532049-4-gourry@gourry.net>
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

Signed-off-by: Gregory Price <gourry@gourry.net>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/memory_hotplug.h | 2 ++
 mm/memory_hotplug.c            | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 7c9d66729c60..f059025f8f8b 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -316,6 +316,8 @@ extern struct zone *zone_for_pfn_range(enum mmop online_type,
 extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
 				      struct mhp_params *params);
 void arch_remove_linear_mapping(u64 start, u64 size);
+#else
+static inline enum mmop mhp_get_default_online_type(void) { return MMOP_OFFLINE; }
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 #endif /* __LINUX_MEMORY_HOTPLUG_H */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 6833208cc17c..494257054095 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -239,6 +239,7 @@ enum mmop mhp_get_default_online_type(void)
 
 	return mhp_default_online_type;
 }
+EXPORT_SYMBOL_GPL(mhp_get_default_online_type);
 
 void mhp_set_default_online_type(enum mmop online_type)
 {
-- 
2.54.0

