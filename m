Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26042334C28
	for <linux-cxl@vger.kernel.org>; Wed, 25 Mar 2026 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464223; cv=none; b=W6cdyTFID2GCRER8qoJQw3Hu5JM2I0xGJ96lBV0FJFDrmzbn2Xo0WVz43Y4qOsii7vIbtX5VyFsLR3S4gA+HoG6ZAwuwAfkXIeDz1RNEO8gamgoI+6wYaaWHlKIk+097QM+8WxZUTxE2TfzBNOFnsQu5ClL+bNfU/MzXtQcviFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464223; c=relaxed/simple;
	bh=+TUA7GSl+IadLzONgJCGlAsLkiXWBbN6tg4Gxfj1pXc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vy+WW4twNFmg2HZXqWcndHZcCCg9P9NV1DMVLpNzh/1SzJmTdnkuXmckiyjUiWpfPDZizJPgd44BuDJGMv0lpetmZQfBL4cHL3DZkfpN0onQZZZP732pAGAtTFAi87K9xM5JIsh7MB2v8wytVuXLQ7d5+HtS24VYQDME5LXvWvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgwlB5KS0zHnGhl;
	Thu, 26 Mar 2026 02:43:02 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F53240086;
	Thu, 26 Mar 2026 02:43:38 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.47.66.203) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Mar 2026 18:43:37 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: <qemu-devel@nongnu.org>
CC: <anisa.su@samsung.com>, <armbru@redhat.com>, <berrange@redhat.com>,
	<eblake@redhat.com>, <jonathan.cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <lizhijian@fujitsu.com>,
	<mst@redhat.com>, <pbonzini@redhat.com>, <gourry@gourry.net>,
	<nifan.cxl@gmail.com>, <me@linux.beauty>
Subject: [PATCH 1/9] hw/mem: Add tag support to generic host memory backends
Date: Wed, 25 Mar 2026 18:42:49 +0000
Message-ID: <20260325184259.366-2-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20260325184259.366-1-alireza.sanaee@huawei.com>
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

Add a string tag property to HostMemoryBackend so that backends can be
identified by a user-assigned name at runtime. Expose the property through
QOM and add a host_memory_backend_find_by_tag() helper that walks the
object tree to locate a backend by its tag.

This is used by the following CXL patches to resolve a named backend for a
pending DC extent and attach it to the accepted extent when the host
acknowledges the add request.

Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 backends/hostmem.c       | 72 ++++++++++++++++++++++++++++++++++++++++
 include/system/hostmem.h |  2 ++
 qapi/qom.json            |  3 ++
 tests/qtest/qom-test.c   |  8 +++--
 4 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 15d4365b69..270cae9569 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -47,6 +47,50 @@ host_memory_backend_get_name(HostMemoryBackend *backend)
     return object_get_canonical_path(OBJECT(backend));
 }
 
+typedef struct HostMemoryBackendTagSearch {
+    const char *tag;
+    HostMemoryBackend *backend;
+} HostMemoryBackendTagSearch;
+
+static int host_memory_backend_find_by_tag_cb(Object *obj, void *opaque)
+{
+    HostMemoryBackendTagSearch *ctx = opaque;
+    HostMemoryBackend *backend;
+
+    if (!object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)) {
+        return 0;
+    }
+
+    backend = MEMORY_BACKEND(obj);
+    if (!backend->tag) {
+        return 0;
+    }
+
+    if (strcmp(backend->tag, ctx->tag) == 0) {
+        ctx->backend = backend;
+        return 1;
+    }
+
+    return 0;
+}
+
+HostMemoryBackend *host_memory_backend_find_by_tag(const char *tag)
+{
+    HostMemoryBackendTagSearch ctx = {
+        .tag = tag,
+        .backend = NULL,
+    };
+
+    if (!tag) {
+        return NULL;
+    }
+
+    object_child_foreach_recursive(object_get_objects_root(),
+                                   host_memory_backend_find_by_tag_cb, &ctx);
+
+    return ctx.backend;
+}
+
 static void
 host_memory_backend_get_size(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
@@ -460,6 +504,22 @@ static void host_memory_backend_set_share(Object *o, bool value, Error **errp)
     backend->share = value;
 }
 
+static void
+host_memory_backend_set_tag(Object *obj, const char *value, Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
+
+    g_free(backend->tag);
+    backend->tag = g_strdup(value);
+}
+
+static char *host_memory_backend_get_tag(Object *obj, Error **errp)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
+
+    return g_strdup(backend->tag);
+}
+
 #ifdef CONFIG_LINUX
 static bool host_memory_backend_get_reserve(Object *o, Error **errp)
 {
@@ -501,6 +561,13 @@ host_memory_backend_set_use_canonical_path(Object *obj, bool value,
     backend->use_canonical_path = value;
 }
 
+static void host_memory_backend_finalize(Object *obj)
+{
+    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
+
+    g_free(backend->tag);
+}
+
 static void
 host_memory_backend_class_init(ObjectClass *oc, const void *data)
 {
@@ -557,6 +624,10 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
         host_memory_backend_get_share, host_memory_backend_set_share);
     object_class_property_set_description(oc, "share",
         "Mark the memory as private to QEMU or shared");
+    object_class_property_add_str(oc, "tag",
+        host_memory_backend_get_tag, host_memory_backend_set_tag);
+    object_class_property_set_description(oc, "tag",
+        "A user-defined tag to identify this memory backend");
 #ifdef CONFIG_LINUX
     object_class_property_add_bool(oc, "reserve",
         host_memory_backend_get_reserve, host_memory_backend_set_reserve);
@@ -586,6 +657,7 @@ static const TypeInfo host_memory_backend_info = {
     .class_init = host_memory_backend_class_init,
     .instance_size = sizeof(HostMemoryBackend),
     .instance_init = host_memory_backend_init,
+    .instance_finalize = host_memory_backend_finalize,
     .instance_post_init = host_memory_backend_post_init,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
diff --git a/include/system/hostmem.h b/include/system/hostmem.h
index 88fa791ac7..a02e173d48 100644
--- a/include/system/hostmem.h
+++ b/include/system/hostmem.h
@@ -81,12 +81,14 @@ struct HostMemoryBackend {
     ThreadContext *prealloc_context;
     DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
     HostMemPolicy policy;
+    char *tag;
 
     MemoryRegion mr;
 };
 
 bool host_memory_backend_mr_inited(HostMemoryBackend *backend);
 MemoryRegion *host_memory_backend_get_memory(HostMemoryBackend *backend);
+HostMemoryBackend *host_memory_backend_find_by_tag(const char *tag);
 
 void host_memory_backend_set_mapped(HostMemoryBackend *backend, bool mapped);
 bool host_memory_backend_is_mapped(HostMemoryBackend *backend);
diff --git a/qapi/qom.json b/qapi/qom.json
index c653248f85..e6feeb324a 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -658,6 +658,8 @@
 # @reserve: if true, reserve swap space (or huge pages) if applicable
 #     (default: true) (since 6.1)
 #
+# @tag: user-defined memory backend tag (since 11.1)
+#
 # @size: size of the memory region in bytes
 #
 # @x-use-canonical-path-for-ramblock-id: if true, the canonical path
@@ -683,6 +685,7 @@
             '*prealloc-context': 'str',
             '*share': 'bool',
             '*reserve': 'bool',
+            '*tag': 'str',
             'size': 'size',
             '*x-use-canonical-path-for-ramblock-id': 'bool' } }
 
diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index 6421f2d9d9..3109b47cca 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -17,6 +17,7 @@
 
 #define RAM_NAME "node0"
 #define RAM_SIZE 65536
+#define RAM_TAG "ramtag0"
 
 static int verbosity_level;
 
@@ -59,6 +60,8 @@ static void test_list_get_value(QTestState *qts)
 
         } else if (!strcmp(prop_name, "size")) {
             g_assert_cmpint(qdict_get_int(prop, "value"), ==, RAM_SIZE);
+        } else if (!strcmp(prop_name, "tag")) {
+            g_assert_cmpstr(qdict_get_str(prop, "value"), ==, RAM_TAG);
         }
     }
 }
@@ -195,8 +198,9 @@ static void test_machine(gconstpointer data)
     QTestState *qts;
     g_autoptr(QList) paths = qlist_new();
 
-    qts = qtest_initf("-machine %s -object memory-backend-ram,id=%s,size=%d",
-                      machine, RAM_NAME, RAM_SIZE);
+    qts = qtest_initf("-machine %s -object memory-backend-ram,id=%s,size=%d"
+                      ",tag=%s",
+                      machine, RAM_NAME, RAM_SIZE, RAM_TAG);
 
     if (g_test_slow()) {
         /* Make sure we can get the machine class properties: */
-- 
2.50.1 (Apple Git-155)

