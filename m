Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B2D391E6E
	for <linux-cxl@vger.kernel.org>; Sat, 21 Mar 2026 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774105458; cv=none; b=p5hwteZC/z6kmztunVehoVflqvHaFm7PH2lF4fQwJMDOORL0+OCiw5QKd0QGDamCREdbSKhNKms9iADyBdfhQT4iONyneRM5WO0SsdSkz8IoL1nnk6QQz3cwbjsCtvAl0lmrydie/1WK1bZHoaNyAseylb2kr0HMF9fMWFwjqqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774105458; c=relaxed/simple;
	bh=cwLq4fYvCtZxySyHqWgZl6tJPwolVZsJKYMQbZ2gyMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLv5s94x/NtD6m94+m6Bdgi8CloWhHEajR4xVJ04GtP/9qzDz669pjvrnqEly/6QW2nbv89RRC03aSPz8i65g//itRnoCEiGCxslIkc1EINg6f4DmhvtpJzyJiqlR0W2EDfHObvOZUj0DmcREgyu8SD2vX0VMKm70Y3y4nlB120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=k1w30U+/; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="k1w30U+/"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5ffe6887e29so1892204137.1
        for <linux-cxl@vger.kernel.org>; Sat, 21 Mar 2026 08:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774105456; x=1774710256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aQsutcLH43Y9NxwFlNMe1GVmyWLzH9mSMGyjSQ6t5E=;
        b=k1w30U+/9SOiGAzhJFbIo+EURteHnRFqZgB6yRO7ST4LnAcfMpcG340ALNvH7lAUjr
         b1Lx7llOdek3Vj5zpQzCRFvAfACeLtNNEQlS1qExj/BQfvolO4ctmg6UEm6bHqBdx++E
         jx4Pw00kS2xh1GfvlCgl/q8i8lEz92xzKNhdng3rpZ7Ob8Jal6WTq8pIX0xVcHGK3tAB
         rAFhVBB23DQWmhp27Rl668ELAIK04pA0VbaPBKF8boSByQxm3mVuRVUIr5DX/qekW2sZ
         Nyg+LhVGSFhwzTTV1/CHReYUf7QZdSMIzSDILSTj+FcM/zRN/7Whxavrgv81sLUfVwwg
         Mgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774105456; x=1774710256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8aQsutcLH43Y9NxwFlNMe1GVmyWLzH9mSMGyjSQ6t5E=;
        b=jXLHIfA7e+wR1Co+QTHMrwKEl9EDcOlqUCFl+DGXDy60G5my7BflUpjCstonmv0+Uq
         osAfTPJwjvAnx2p8oe08Rzqu3Nuz5O9TK5tzIH/ODnscfSv1ve2Ws8xftlmVq7YD9r6r
         TtycCeb/4MU7u9wrIqPTw79774fehKoWMYwAavh002AcLDfXrD56xjH+bEXnPjFWnDTo
         z+nMqqzy9O2C9mz0MA92GVmfJQyN0snk/t3SNSgXI0dMZv8HIBQ3V73uGZab3tUUDH2v
         Z/iI1t5A9og4IcPFeeY2eZ1Kd5VeejmH683oDPnA+j1tb9uuJsRUh/npK53dijrhrjQ5
         /eVw==
X-Forwarded-Encrypted: i=1; AJvYcCVjfDPXaXlNHGGiqpoEPQnMfSW6H/I0tEwC0hxQjFDwTTZ+qWeOfko94WGcCR4cB9u1zb+xv7oHdno=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU2nZb80pol9zvWDiTKf5UaIIXE0yqpedzxQoWzN/wI0Qge7RI
	mCS5sBacNBT3oaQ+O2pLIa47cwoYlR3cM0x3CN+2JJYt0FMuyaaA8OXflJZAczzf47E=
X-Gm-Gg: ATEYQzzQscPspAubUEg7IWW+4pOFUdmH/svItbu5poRNSyPcdzBn37HYDzvjajXIRKd
	unPhKKyDLRbvWCCNolqaCYtF43kcztiDzZPsUkdMu4nzaGjxlT2cONOjSy2Y7UDCNRln6FOY4cu
	GWso9AJ5JoFBM+umwCFSdauzvQ4h040v1D60Bm1BVXVNyvFYb1yTN4kw0WaEJqjuzIT0klK2sMn
	4pH9uloD08hXADQj3FpOHL15Epg032HqReSBd0LQc6Ds+1x/B2kG9XQnLbRjZnEUK7mB96iBf5i
	f5mBTz71UizEVm2oukBYi/fuSvaS1HtPPXk/3Yj/FS2ThQ7f4z/RRODLO6k9vD32UYaXNra+VcH
	k0TMeoAa7Jvxzl1h8rXff1EQ4eyIN3SMCkm/eb9m4VdMyC+seRs3Wd54X7GtCdNpFmTMW93iSqH
	jnuKdbvC4wMdaJX6nFLw+9my7bNbFMAjCA23F5LrlCx1zC+gM/WG7XjukuC0hBVMYlsN3jLSzq9
	Y3+Nr5++uk5o+TGzGA8QcdgWQ==
X-Received: by 2002:a05:6102:5a94:b0:5ff:fbe4:89c with SMTP id ada2fe7eead31-602aed31766mr3273670137.26.1774105456040;
        Sat, 21 Mar 2026 08:04:16 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc90ba89fsm391979885a.40.2026.03.21.08.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 08:04:15 -0700 (PDT)
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
Subject: [PATCH 4/8] mm/memory_hotplug: export mhp_get_default_online_type
Date: Sat, 21 Mar 2026 11:04:00 -0400
Message-ID: <20260321150404.3288786-5-gourry@gourry.net>
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
---
 include/linux/memory_hotplug.h | 29 +++++++++++++++++++++++++++++
 mm/memory_hotplug.c            |  1 +
 2 files changed, 30 insertions(+)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index e77ef3d7ff73..a8bcb36f93b8 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -6,6 +6,7 @@
 #include <linux/spinlock.h>
 #include <linux/notifier.h>
 #include <linux/bug.h>
+#include <linux/errno.h>
 
 struct page;
 struct zone;
@@ -28,6 +29,27 @@ enum mmop {
 	MMOP_ONLINE_MOVABLE,
 };
 
+/**
+ * mmop_to_str - convert memory online type to string
+ * @online_type: the MMOP_* value to convert
+ *
+ * Returns a string representation of the memory online type,
+ * suitable for sysfs output (includes trailing newline).
+ */
+static inline const char *mmop_to_str(enum mmop online_type)
+{
+	switch (online_type) {
+	case MMOP_ONLINE:
+		return "online\n";
+	case MMOP_ONLINE_KERNEL:
+		return "online_kernel\n";
+	case MMOP_ONLINE_MOVABLE:
+		return "online_movable\n";
+	default:
+		return "offline\n";
+	}
+}
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 struct page *pfn_to_online_page(unsigned long pfn);
 
@@ -221,6 +243,11 @@ static inline bool mhp_supports_memmap_on_memory(void)
 static inline void pgdat_kswapd_lock(pg_data_t *pgdat) {}
 static inline void pgdat_kswapd_unlock(pg_data_t *pgdat) {}
 static inline void pgdat_kswapd_lock_init(pg_data_t *pgdat) {}
+
+static inline int mhp_online_type_from_str(const char *str)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* ! CONFIG_MEMORY_HOTPLUG */
 
 /*
@@ -316,6 +343,8 @@ extern struct zone *zone_for_pfn_range(enum mmop online_type,
 extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
 				      struct mhp_params *params);
 void arch_remove_linear_mapping(u64 start, u64 size);
+#else
+static inline enum mmop mhp_get_default_online_type(void) { return MMOP_OFFLINE; }
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 #endif /* __LINUX_MEMORY_HOTPLUG_H */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 282bf3d89613..af9a6cb5a2f9 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -240,6 +240,7 @@ enum mmop mhp_get_default_online_type(void)
 
 	return mhp_default_online_type;
 }
+EXPORT_SYMBOL_GPL(mhp_get_default_online_type);
 
 void mhp_set_default_online_type(enum mmop online_type)
 {
-- 
2.53.0

