Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E9F18E047
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737739813; cv=none; b=F2XZG+D8n38CQdXgxLg0eMi4CfGoECcRAEbM44lqrWKT1cafjHXLVdT57ZWGoxaTXES17C1t8hjH/YAmoquGd89oMYqmamMkg6+OIHWlzo+DPQD8QKwiNKVFTJdAZEfNX0pma2GoS75VGMbYiSwaNyQwcS6x7qnBCIzRiUDV+nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737739813; c=relaxed/simple;
	bh=WjWJ2s8Ljjvp+TFWlz04qz831FtyAQwFI3Jm6wQoTkI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgr6xnPaoFHHnPoYg9uie00yPxT/psVK4YfA5ATxfW1Aq52veCTRbH4stUywg5xJeWCZzo0L0JZTRo8YlwUdn4y0dyxlZKOr3BBsMUgdR+2w1SQmH62w9QFIfMLlvjfHLOeE/iodeGCpBNWYHAYRj946F+1Q0Xzwse94Ril44UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YflBx2h0Zz67l35;
	Sat, 25 Jan 2025 01:28:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 04EB8140B18;
	Sat, 25 Jan 2025 01:30:09 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 Jan 2025 18:30:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
CC: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Alexandre Iooss
	<erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, <linuxarm@huawei.com>, Niyas Sait
	<niyas.sait@huawei.com>
Subject: [RFC PATCH QEMU 2/3] plugins: Add cache miss reporting over a socket.
Date: Fri, 24 Jan 2025 17:29:04 +0000
Message-ID: <20250124172905.84099-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124172905.84099-1-Jonathan.Cameron@huawei.com>
References: <20250124172905.84099-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

This allows an external program to act as a hotness tracker.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 contrib/plugins/cache.c | 75 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 7 deletions(-)

diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 7baff86860..5af1e6559c 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -7,10 +7,17 @@
 
 #include <inttypes.h>
 #include <stdio.h>
+#include <unistd.h>
 #include <glib.h>
+#include <sys/socket.h>
+#include <arpa/inet.h>
 
 #include <qemu-plugin.h>
 
+static int client_socket = -1;
+static uint64_t missfilterbase;
+static uint64_t missfiltersize;
+
 #define STRTOLL(x) g_ascii_strtoll(x, NULL, 10)
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
@@ -104,6 +111,7 @@ static Cache **l2_ucaches;
 static GMutex *l1_dcache_locks;
 static GMutex *l1_icache_locks;
 static GMutex *l2_ucache_locks;
+static GMutex *socket_lock;
 
 static uint64_t l1_dmem_accesses;
 static uint64_t l1_imem_accesses;
@@ -385,6 +393,21 @@ static bool access_cache(Cache *cache, uint64_t addr)
     return false;
 }
 
+static void miss(uint64_t paddr)
+{
+    if (client_socket < 0) {
+        return;
+    }
+
+    if (paddr < missfilterbase || paddr >= missfilterbase + missfiltersize) {
+        return;
+    }
+
+    g_mutex_lock(socket_lock);
+    send(client_socket, &paddr, sizeof(paddr), 0);
+    g_mutex_unlock(socket_lock);
+}
+
 static void vcpu_mem_access(unsigned int vcpu_index, qemu_plugin_meminfo_t info,
                             uint64_t vaddr, void *userdata)
 {
@@ -395,9 +418,6 @@ static void vcpu_mem_access(unsigned int vcpu_index, qemu_plugin_meminfo_t info,
     bool hit_in_l1;
 
     hwaddr = qemu_plugin_get_hwaddr(info, vaddr);
-    if (hwaddr && qemu_plugin_hwaddr_is_io(hwaddr)) {
-        return;
-    }
 
     effective_addr = hwaddr ? qemu_plugin_hwaddr_phys_addr(hwaddr) : vaddr;
     cache_idx = vcpu_index % cores;
@@ -412,7 +432,11 @@ static void vcpu_mem_access(unsigned int vcpu_index, qemu_plugin_meminfo_t info,
     l1_dcaches[cache_idx]->accesses++;
     g_mutex_unlock(&l1_dcache_locks[cache_idx]);
 
-    if (hit_in_l1 || !use_l2) {
+    if (hit_in_l1) {
+        return;
+    }
+    if (!use_l2) {
+        miss(effective_addr);
         /* No need to access L2 */
         return;
     }
@@ -422,6 +446,7 @@ static void vcpu_mem_access(unsigned int vcpu_index, qemu_plugin_meminfo_t info,
         insn = userdata;
         __atomic_fetch_add(&insn->l2_misses, 1, __ATOMIC_SEQ_CST);
         l2_ucaches[cache_idx]->misses++;
+        miss(effective_addr);
     }
     l2_ucaches[cache_idx]->accesses++;
     g_mutex_unlock(&l2_ucache_locks[cache_idx]);
@@ -447,8 +472,12 @@ static void vcpu_insn_exec(unsigned int vcpu_index, void *userdata)
     l1_icaches[cache_idx]->accesses++;
     g_mutex_unlock(&l1_icache_locks[cache_idx]);
 
-    if (hit_in_l1 || !use_l2) {
-        /* No need to access L2 */
+    if (hit_in_l1) {
+        return;
+    }
+
+    if (!use_l2) {
+        miss(insn_addr);
         return;
     }
 
@@ -739,14 +768,16 @@ QEMU_PLUGIN_EXPORT
 int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
                         int argc, char **argv)
 {
-    int i;
+    int i, port;
     int l1_iassoc, l1_iblksize, l1_icachesize;
     int l1_dassoc, l1_dblksize, l1_dcachesize;
     int l2_assoc, l2_blksize, l2_cachesize;
+    struct sockaddr_in server_addr;
 
     limit = 32;
     sys = info->system_emulation;
 
+    port = -1;
     l1_dassoc = 8;
     l1_dblksize = 64;
     l1_dcachesize = l1_dblksize * l1_dassoc * 32;
@@ -808,11 +839,39 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
                 fprintf(stderr, "invalid eviction policy: %s\n", opt);
                 return -1;
             }
+        } else if (g_strcmp0(tokens[0], "port") == 0) {
+            port = STRTOLL(tokens[1]);
+        } else if (g_strcmp0(tokens[0], "missfilterbase") == 0) {
+            missfilterbase = STRTOLL(tokens[1]);
+        } else if (g_strcmp0(tokens[0], "missfiltersize") == 0) {
+            missfiltersize = STRTOLL(tokens[1]);
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
         }
     }
+    if (port >= -1) {
+        uint64_t paddr = 42; /* hello, I'm a provider */
+        client_socket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+        if (client_socket < 0) {
+            printf("failed to create a socket\n");
+            return -1;
+        }
+        printf("Cache miss reported on on %lx size %lx\n",
+               missfilterbase, missfiltersize);
+        memset((char *)&server_addr, 0, sizeof(server_addr));
+        server_addr.sin_family = AF_INET;
+        server_addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+        server_addr.sin_port = htons(port);
+
+        if (connect(client_socket, (struct sockaddr *)&server_addr,
+                    sizeof(server_addr)) < 0) {
+            close(client_socket);
+            return -1;
+        }
+        /* Let it know we are a data provider */
+        send(client_socket, &paddr, sizeof(paddr), 0);
+    }
 
     policy_init();
 
@@ -840,6 +899,8 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
         return -1;
     }
 
+    socket_lock = g_new0(GMutex, 1);
+
     l1_dcache_locks = g_new0(GMutex, cores);
     l1_icache_locks = g_new0(GMutex, cores);
     l2_ucache_locks = use_l2 ? g_new0(GMutex, cores) : NULL;
-- 
2.43.0

