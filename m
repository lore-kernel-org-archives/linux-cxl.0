Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CC13612ED;
	Wed, 18 Mar 2026 20:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773866961; cv=none; b=OWKrVRkbwdmMyev7i5lfcKVhFhGBUCkvaQp+pc99QK7EmXk+F+IKYrczytEfzq5xfJBzJZMDDlDJvxVdar65la41rW5wZMcbf9a5lRMg3WxlhE20EB6BR5w2CGOf8kI4kAScIux3C0LXAP7elfuR8MpYqA/mcHC3FFY5ucvzzq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773866961; c=relaxed/simple;
	bh=b5f4mwga2wtiJMuvYl5L0vlWKtXxjoH6FUgmUY6RyPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bff+sQoypNNLmFbdPYFFcdD0zed3PHFEg6SK+Vdlgri9kVJ2smrctexztUHV+gUxGXzbidg5d37M2OUnU3jKA9kXUJ1LZJCAxTn6plIuTYgmH6MwKo5P5xl9DROVKN6SJOUf2qKv4LUVmttOCJRLjVfnDeE/4JUXl8bSOjbEk0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38C33201B;
	Wed, 18 Mar 2026 13:49:13 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F8823F7BD;
	Wed, 18 Mar 2026 13:49:17 -0700 (PDT)
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Wed, 18 Mar 2026 20:48:01 +0000
Subject: [PATCH v3 04/10] ACPI: APEI: GHES: move estatus cache helpers
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-topics-ahmtib01-ras_ffh_arm_internal_review-v3-4-48e6a1c249ef@arm.com>
References: <20260318-topics-ahmtib01-ras_ffh_arm_internal_review-v3-0-48e6a1c249ef@arm.com>
In-Reply-To: <20260318-topics-ahmtib01-ras_ffh_arm_internal_review-v3-0-48e6a1c249ef@arm.com>
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-cxl@vger.kernel.org
Cc: Ahmed Tiba <ahmed.tiba@arm.com>, Michael.Zhao2@arm.com, robh@kernel.org, 
 linux-arm-kernel@lists.infradead.org, Dmitry.Lamerov@arm.com, 
 rafael@kernel.org, conor@kernel.org, will@kernel.org, bp@alien8.de, 
 catalin.marinas@arm.com, krzk+dt@kernel.org, linux-doc@vger.kernel.org, 
 mchehab+huawei@kernel.org, tony.luck@intel.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773866948; l=11327;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=b5f4mwga2wtiJMuvYl5L0vlWKtXxjoH6FUgmUY6RyPA=;
 b=ZpTqRCwKnkMJYB/FRZ7GaL/NG36iW4k2Cw5rYF4gxNVzs0ssUFlRhvy3OGjrBFxA8XhDh9QOX
 fDsQee2MWaUAbndPpCITi4aCYUUbabYzWVdbfaXNyOzuKTqLmqBqZ+e
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

Relocate the estatus cache allocation and lookup helpers from ghes.c into
ghes_cper.c. This code move keeps the logic intact while making the cache
implementation available to forthcoming users.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/acpi/apei/ghes.c      | 138 +----------------------------------------
 drivers/acpi/apei/ghes_cper.c | 140 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/ghes_cper.h      |   6 ++
 3 files changed, 147 insertions(+), 137 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d562c98bff19..8a9b4dda3748 100644
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
@@ -715,139 +712,6 @@ static int ghes_print_estatus(const char *pfx,
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
index 8080e0f76dac..0a117f478afb 100644
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
@@ -27,6 +31,9 @@
 
 #include "apei-internal.h"
 
+static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
+static atomic_t ghes_estatus_cache_alloced;
+
 static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
 {
 	phys_addr_t paddr;
@@ -258,3 +265,136 @@ void ghes_clear_estatus(struct ghes *ghes,
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
+void
+ghes_estatus_cache_add(struct acpi_hest_generic *generic,
+		       struct acpi_hest_generic_status *estatus)
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
index a38e3440b927..627fb1a5a121 100644
--- a/include/acpi/ghes_cper.h
+++ b/include/acpi/ghes_cper.h
@@ -19,6 +19,7 @@
 #ifndef ACPI_APEI_GHES_CPER_H
 #define ACPI_APEI_GHES_CPER_H
 
+#include <linux/atomic.h>
 #include <linux/workqueue.h>
 
 #include <acpi/ghes.h>
@@ -57,6 +58,8 @@
 	((struct acpi_hest_generic_data *)                              \
 	((struct ghes_vendor_record_entry *)(vendor_entry) + 1))
 
+extern struct gen_pool *ghes_estatus_pool;
+
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 {
 	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
@@ -99,5 +102,8 @@ int __ghes_check_estatus(struct ghes *ghes,
 int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
 			u64 buf_paddr, enum fixed_addresses fixmap_idx,
 			size_t buf_len);
+int ghes_estatus_cached(struct acpi_hest_generic_status *estatus);
+void ghes_estatus_cache_add(struct acpi_hest_generic *generic,
+			    struct acpi_hest_generic_status *estatus);
 
 #endif /* ACPI_APEI_GHES_CPER_H */

-- 
2.43.0

