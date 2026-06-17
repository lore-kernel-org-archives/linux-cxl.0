Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979793EEAEB;
	Wed, 17 Jun 2026 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704550; cv=none; b=Cg0ga50I5tmYwWxcIdJfWQ6hWhAVsinS6i+1glJOQoVtGMTk1Z2tsvuJvle+syxNNlrERyj9j2kpkPV/mlIw2BKESZUlvvmY68OPwi5Qdz7pzFpvBVYJpOpdoykK05gK94agMzfG6HO3f13JM7hx6rn1exMCz2psBy4a75L5p4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704550; c=relaxed/simple;
	bh=G6coLRg+HrSSMx5FLZXc+S7HLc/2kDZpQIaMt6WvUbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bROgmWouatfZ9mUwSzDll4q9RtU3D5hw+5VbpPqeIEH33+rLzj25y6Bx4/X1rRtARX7SzL7X3+WGDSscv30H2xZLjuFOt5OJRSNE0B+8ea3iV19gHvJtsikw36JiYhYmoE99k1KWAJqFk6mIz7DtZWNZNHPAypQ7Ph3uWJoPazo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fSBp+SVg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fSBp+SVg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DB6D4800;
	Wed, 17 Jun 2026 06:55:42 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4ADEF3F915;
	Wed, 17 Jun 2026 06:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781704546; bh=G6coLRg+HrSSMx5FLZXc+S7HLc/2kDZpQIaMt6WvUbc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fSBp+SVgVlthvJ8XOlt9QaWNJAlBOhz56/JxLGtxEpjbt3lxzYaKrZsRDPDP0JOuM
	 EoeUsjlY0GESsBbJ0TDV+7Clxwk5rzxEqTRpFkO1CbzaPwztC5HNk5KnzbqRVBSAsR
	 vKLjbRYTCmOOySZgOTo3W/oQILHHU/+cqAOins6w=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Wed, 17 Jun 2026 14:54:42 +0100
Subject: [PATCH v6 04/10] ACPI: APEI: GHES: move estatus cache helpers
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-4-91f725174aa0@arm.com>
References: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
In-Reply-To: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
 Saket Dumbre <saket.dumbre@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <djbw@kernel.org>, Ahmed Tiba <ahmed.tiba@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-cxl@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-edac@vger.kernel.org, 
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781704522; l=11163;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=G6coLRg+HrSSMx5FLZXc+S7HLc/2kDZpQIaMt6WvUbc=;
 b=UV6GRYnrYPatszyjZzuguelRlxkvFpsj+0v/JqRGEeefqRNOkDQL9yNyeFbneRDxLC6TCDbhp
 G8Z1dsQZuc6DCdBYH5/MmROy4UZuoUVO+Zf0GgG2fSvXUL18itS7eX9
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

Relocate the estatus cache allocation and lookup helpers from ghes.c into
ghes_cper.c. This code move keeps the logic intact while making the cache
implementation available to forthcoming users.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/acpi/apei/ghes.c      | 138 +----------------------------------------
 drivers/acpi/apei/ghes_cper.c | 139 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/ghes_cper.h      |   5 ++
 3 files changed, 145 insertions(+), 137 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 91638ae7e05e..adab7404310e 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -113,10 +113,7 @@ static DEFINE_MUTEX(ghes_devs_mutex);
  */
 static DEFINE_SPINLOCK(ghes_notify_lock_irq);
 
-static struct gen_pool *ghes_estatus_pool;
-
-static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
-static atomic_t ghes_estatus_cache_alloced;
+struct gen_pool *ghes_estatus_pool;
 
 int ghes_estatus_pool_init(unsigned int num_ghes)
 {
@@ -733,139 +730,6 @@ static int ghes_print_estatus(const char *pfx,
 	return 0;
 }
 
-/*
- * GHES error status reporting throttle, to report more kinds of
- * errors, instead of just most frequently occurred errors.
- */
-static int ghes_estatus_cached(struct acpi_hest_generic_status *estatus)
-{
-	u32 len;
-	int i, cached = 0;
-	unsigned long long now;
-	struct ghes_estatus_cache *cache;
-	struct acpi_hest_generic_status *cache_estatus;
-
-	len = cper_estatus_len(estatus);
-	rcu_read_lock();
-	for (i = 0; i < GHES_ESTATUS_CACHES_SIZE; i++) {
-		cache = rcu_dereference(ghes_estatus_caches[i]);
-		if (cache == NULL)
-			continue;
-		if (len != cache->estatus_len)
-			continue;
-		cache_estatus = GHES_ESTATUS_FROM_CACHE(cache);
-		if (memcmp(estatus, cache_estatus, len))
-			continue;
-		atomic_inc(&cache->count);
-		now = sched_clock();
-		if (now - cache->time_in < GHES_ESTATUS_IN_CACHE_MAX_NSEC)
-			cached = 1;
-		break;
-	}
-	rcu_read_unlock();
-	return cached;
-}
-
-static struct ghes_estatus_cache *ghes_estatus_cache_alloc(
-	struct acpi_hest_generic *generic,
-	struct acpi_hest_generic_status *estatus)
-{
-	int alloced;
-	u32 len, cache_len;
-	struct ghes_estatus_cache *cache;
-	struct acpi_hest_generic_status *cache_estatus;
-
-	alloced = atomic_add_return(1, &ghes_estatus_cache_alloced);
-	if (alloced > GHES_ESTATUS_CACHE_ALLOCED_MAX) {
-		atomic_dec(&ghes_estatus_cache_alloced);
-		return NULL;
-	}
-	len = cper_estatus_len(estatus);
-	cache_len = GHES_ESTATUS_CACHE_LEN(len);
-	cache = (void *)gen_pool_alloc(ghes_estatus_pool, cache_len);
-	if (!cache) {
-		atomic_dec(&ghes_estatus_cache_alloced);
-		return NULL;
-	}
-	cache_estatus = GHES_ESTATUS_FROM_CACHE(cache);
-	memcpy(cache_estatus, estatus, len);
-	cache->estatus_len = len;
-	atomic_set(&cache->count, 0);
-	cache->generic = generic;
-	cache->time_in = sched_clock();
-	return cache;
-}
-
-static void ghes_estatus_cache_rcu_free(struct rcu_head *head)
-{
-	struct ghes_estatus_cache *cache;
-	u32 len;
-
-	cache = container_of(head, struct ghes_estatus_cache, rcu);
-	len = cper_estatus_len(GHES_ESTATUS_FROM_CACHE(cache));
-	len = GHES_ESTATUS_CACHE_LEN(len);
-	gen_pool_free(ghes_estatus_pool, (unsigned long)cache, len);
-	atomic_dec(&ghes_estatus_cache_alloced);
-}
-
-static void
-ghes_estatus_cache_add(struct acpi_hest_generic *generic,
-		       struct acpi_hest_generic_status *estatus)
-{
-	unsigned long long now, duration, period, max_period = 0;
-	struct ghes_estatus_cache *cache, *new_cache;
-	struct ghes_estatus_cache __rcu *victim;
-	int i, slot = -1, count;
-
-	new_cache = ghes_estatus_cache_alloc(generic, estatus);
-	if (!new_cache)
-		return;
-
-	rcu_read_lock();
-	now = sched_clock();
-	for (i = 0; i < GHES_ESTATUS_CACHES_SIZE; i++) {
-		cache = rcu_dereference(ghes_estatus_caches[i]);
-		if (cache == NULL) {
-			slot = i;
-			break;
-		}
-		duration = now - cache->time_in;
-		if (duration >= GHES_ESTATUS_IN_CACHE_MAX_NSEC) {
-			slot = i;
-			break;
-		}
-		count = atomic_read(&cache->count);
-		period = duration;
-		do_div(period, (count + 1));
-		if (period > max_period) {
-			max_period = period;
-			slot = i;
-		}
-	}
-	rcu_read_unlock();
-
-	if (slot != -1) {
-		/*
-		 * Use release semantics to ensure that ghes_estatus_cached()
-		 * running on another CPU will see the updated cache fields if
-		 * it can see the new value of the pointer.
-		 */
-		victim = xchg_release(&ghes_estatus_caches[slot],
-				      RCU_INITIALIZER(new_cache));
-
-		/*
-		 * At this point, victim may point to a cached item different
-		 * from the one based on which we selected the slot. Instead of
-		 * going to the loop again to pick another slot, let's just
-		 * drop the other item anyway: this may cause a false cache
-		 * miss later on, but that won't cause any problems.
-		 */
-		if (victim)
-			call_rcu(&unrcu_pointer(victim)->rcu,
-				 ghes_estatus_cache_rcu_free);
-	}
-}
-
 static void __ghes_panic(struct ghes *ghes,
 			 struct acpi_hest_generic_status *estatus,
 			 u64 buf_paddr, enum fixed_addresses fixmap_idx)
diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
index c6e20fdc6964..5218fc57e562 100644
--- a/drivers/acpi/apei/ghes_cper.c
+++ b/drivers/acpi/apei/ghes_cper.c
@@ -13,10 +13,14 @@
  */
 
 #include <linux/err.h>
+#include <linux/genalloc.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/mm.h>
 #include <linux/ratelimit.h>
+#include <linux/rcupdate.h>
+#include <linux/sched/clock.h>
 #include <linux/slab.h>
 
 #include <acpi/apei.h>
@@ -28,6 +32,9 @@
 
 #include "apei-internal.h"
 
+static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
+static atomic_t ghes_estatus_cache_alloced;
+
 static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
 {
 	phys_addr_t paddr;
@@ -259,3 +266,135 @@ void ghes_clear_estatus(struct ghes *ghes,
 	if (is_hest_type_generic_v2(ghes))
 		ghes_ack_error(ghes->generic_v2);
 }
+
+/*
+ * GHES error status reporting throttle, to report more kinds of
+ * errors, instead of just most frequently occurred errors.
+ */
+int ghes_estatus_cached(struct acpi_hest_generic_status *estatus)
+{
+	u32 len;
+	int i, cached = 0;
+	unsigned long long now;
+	struct ghes_estatus_cache *cache;
+	struct acpi_hest_generic_status *cache_estatus;
+
+	len = cper_estatus_len(estatus);
+	rcu_read_lock();
+	for (i = 0; i < GHES_ESTATUS_CACHES_SIZE; i++) {
+		cache = rcu_dereference(ghes_estatus_caches[i]);
+		if (cache == NULL)
+			continue;
+		if (len != cache->estatus_len)
+			continue;
+		cache_estatus = GHES_ESTATUS_FROM_CACHE(cache);
+		if (memcmp(estatus, cache_estatus, len))
+			continue;
+		atomic_inc(&cache->count);
+		now = sched_clock();
+		if (now - cache->time_in < GHES_ESTATUS_IN_CACHE_MAX_NSEC)
+			cached = 1;
+		break;
+	}
+	rcu_read_unlock();
+	return cached;
+}
+
+static struct ghes_estatus_cache *ghes_estatus_cache_alloc(
+	struct acpi_hest_generic *generic,
+	struct acpi_hest_generic_status *estatus)
+{
+	int alloced;
+	u32 len, cache_len;
+	struct ghes_estatus_cache *cache;
+	struct acpi_hest_generic_status *cache_estatus;
+
+	alloced = atomic_add_return(1, &ghes_estatus_cache_alloced);
+	if (alloced > GHES_ESTATUS_CACHE_ALLOCED_MAX) {
+		atomic_dec(&ghes_estatus_cache_alloced);
+		return NULL;
+	}
+	len = cper_estatus_len(estatus);
+	cache_len = GHES_ESTATUS_CACHE_LEN(len);
+	cache = (void *)gen_pool_alloc(ghes_estatus_pool, cache_len);
+	if (cache == NULL) {
+		atomic_dec(&ghes_estatus_cache_alloced);
+		return NULL;
+	}
+	cache_estatus = GHES_ESTATUS_FROM_CACHE(cache);
+	memcpy(cache_estatus, estatus, len);
+	cache->estatus_len = len;
+	atomic_set(&cache->count, 0);
+	cache->generic = generic;
+	cache->time_in = sched_clock();
+	return cache;
+}
+
+static void ghes_estatus_cache_rcu_free(struct rcu_head *head)
+{
+	struct ghes_estatus_cache *cache;
+	u32 len;
+
+	cache = container_of(head, struct ghes_estatus_cache, rcu);
+	len = cper_estatus_len(GHES_ESTATUS_FROM_CACHE(cache));
+	len = GHES_ESTATUS_CACHE_LEN(len);
+	gen_pool_free(ghes_estatus_pool, (unsigned long)cache, len);
+	atomic_dec(&ghes_estatus_cache_alloced);
+}
+
+void ghes_estatus_cache_add(struct acpi_hest_generic *generic,
+			    struct acpi_hest_generic_status *estatus)
+{
+	unsigned long long now, duration, period, max_period = 0;
+	struct ghes_estatus_cache *cache, *new_cache;
+	struct ghes_estatus_cache __rcu *victim;
+	int i, slot = -1, count;
+
+	new_cache = ghes_estatus_cache_alloc(generic, estatus);
+	if (!new_cache)
+		return;
+
+	rcu_read_lock();
+	now = sched_clock();
+	for (i = 0; i < GHES_ESTATUS_CACHES_SIZE; i++) {
+		cache = rcu_dereference(ghes_estatus_caches[i]);
+		if (cache == NULL) {
+			slot = i;
+			break;
+		}
+		duration = now - cache->time_in;
+		if (duration >= GHES_ESTATUS_IN_CACHE_MAX_NSEC) {
+			slot = i;
+			break;
+		}
+		count = atomic_read(&cache->count);
+		period = duration;
+		do_div(period, (count + 1));
+		if (period > max_period) {
+			max_period = period;
+			slot = i;
+		}
+	}
+	rcu_read_unlock();
+
+	if (slot != -1) {
+		/*
+		 * Use release semantics to ensure that ghes_estatus_cached()
+		 * running on another CPU will see the updated cache fields if
+		 * it can see the new value of the pointer.
+		 */
+		victim = xchg_release(&ghes_estatus_caches[slot],
+				      RCU_INITIALIZER(new_cache));
+
+		/*
+		 * At this point, victim may point to a cached item different
+		 * from the one based on which we selected the slot. Instead of
+		 * going to the loop again to pick another slot, let's just
+		 * drop the other item anyway: this may cause a false cache
+		 * miss later on, but that won't cause any problems.
+		 */
+		if (victim)
+			call_rcu(&unrcu_pointer(victim)->rcu,
+				 ghes_estatus_cache_rcu_free);
+	}
+}
diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
index 4649e3140888..15305c8be9a7 100644
--- a/include/acpi/ghes_cper.h
+++ b/include/acpi/ghes_cper.h
@@ -55,6 +55,8 @@
 	((struct acpi_hest_generic_data *)                              \
 	((struct ghes_vendor_record_entry *)(vendor_entry) + 1))
 
+extern struct gen_pool *ghes_estatus_pool;
+
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 {
 	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
@@ -99,5 +101,8 @@ int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
 			u64 buf_paddr, enum fixed_addresses fixmap_idx,
 			size_t buf_len);
 #endif
+int ghes_estatus_cached(struct acpi_hest_generic_status *estatus);
+void ghes_estatus_cache_add(struct acpi_hest_generic *generic,
+			    struct acpi_hest_generic_status *estatus);
 
 #endif /* ACPI_APEI_GHES_CPER_H */

-- 
2.43.0

