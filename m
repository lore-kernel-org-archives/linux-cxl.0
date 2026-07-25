Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0118A93F
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jul 2026 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784988041; cv=none; b=lu8NassUA1RccaTV8wE24EgI2ZrmBz7qmn+PyZHvuyYrVFTMD+CWWB/aSe7jNldWySTVUyHrT2ZvRhzpJ2i9nCDovayNNpE++59e12g6y6/R3T60qBi7SXKl0NDtbxUoi+Ir/ER3h+Zu202OtrevHLor3ICBEIzBZCTJA5Ncj3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784988041; c=relaxed/simple;
	bh=cHf62MM7xs8MyYaKCneLSpmy1ZQnYtBo02wawGmze8I=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=YdVxHiTKeKeHtjY2K5XHkm8C45L8E/3dCF9+E69Obf9wywY14gbIpfL2W4giPv/ey/KevsKsdesglwHvfmyHzqidn1hm46dpVqYXi2iRF++n0a6egjjDMvGTmKrl6gD8ZHZ/D3SY6zF9iQJoL3aGOSikEMtPcSflUNHojyf0cJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UyrBQikd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyrBQikd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784988038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AtLVIwc0ChM1DAVD/TK9Kdk+EW2zZ0ZeWIrt7VGyKwA=;
	b=UyrBQikdzC90UlR7T298b6bs85ANjNAsUcNq/Fh0bpRQSZ+vMwkhFSBGKotDK7zLNz3sHu
	G6g78TrCsUDvY0fpmTi09yH1YTgAxmzNfTN9xzojiBdXryMPgo6HxfVc55mdIgwpJiuB8z
	kh06+WpFzCog20fAnbyWZO1QsoCUGMw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-x8aZ-dWwN-uPiL_crLLRfA-1; Sat,
 25 Jul 2026 10:00:35 -0400
X-MC-Unique: x8aZ-dWwN-uPiL_crLLRfA-1
X-Mimecast-MFC-AGG-ID: x8aZ-dWwN-uPiL_crLLRfA_1784988033
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 324E919560B3;
	Sat, 25 Jul 2026 14:00:33 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D23D180057F;
	Sat, 25 Jul 2026 14:00:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 18:00:04 +0400
Subject: [PATCH 3/7] Fix many -Werror=maybe-uninitialized
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260725-fix2-v1-3-5c9a6ce7b96a@redhat.com>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
In-Reply-To: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>, 
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6067;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cHf62MM7xs8MyYaKCneLSpmy1ZQnYtBo02wawGmze8I=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZMFlCWxHn7jIomyURmJuovkpyjcBlkf/N5odt
 oLz9/9EtPmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamTBZQAKCRDa6OEJdZac
 5Y0vD/0SR5HxF/C+Z0FR/NpAEwtvAKL/to877Y2j6riXG+XLJGlctWPOti3dSsJ2We4/6N0phS4
 jX+SrUb7I3yTddkVQJ1ANziFWaCtAefJazJHT2ZPzH9fELWM+6q4oSOBUREBowYo/KiMHqBSbmA
 eyNjbN7xd+t5AV8oQ2/Ldl6zRx24TovNrqCWGRLd0ebp78O+Mqq6S41tyYa/z0e1U9CFxtIb3Ue
 Y9rRJ6b+Be4JkfgFD9RQKCxcS3m/6ENa41I5NRRVZzNsTqC8lIMGDmtpaXqQGrkOPb1oY/Dg1YM
 +qp4kZFfOU0fRkGsXYrCbjP7QXJ5FXpOC0+9KId/cPH4pDq7Q1MoApbO9f3C2SrF0JVBqAGd6/P
 6tAyz2TFDbqEBCo5Uzoff/5Z7GhrMejYrCkE/6291iWv1fw5pyPJDOXiW6YdQPH85YcWHazzwpC
 6Ca5rg2yEZehVMQwsRPUrf8SSQvI3XcijEsIbEcVjO/hrQOb5RJFwFBJvT5NPJ8aVVvQouzKel0
 2YABqudcIlWwGFtVCExjnY31NZpAxLjxHD6VUqT6JUsoi3hwKAXX36+jPYIumVPTy+/yWCNASAB
 9vuz22kVOruymo1ap02Nu86OIC0N4AnDW/sIQ3wEAM/mOnJDWzuL0/1i/NDwnHcbCdt4JRGbs+t
 3DEggiEc3Vykt+A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: O9RTOyn7dW0NHsLNt1nbN3DZfzubwZ692BwAg1Z4vCU_1784988033
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

When compiled with -Og, gcc produces many false-positives
gcc (GCC) 16.1.1 20260515 (Red Hat 16.1.1-2).

We already use auto-var-init=zero, but better be explicit.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/blkio.c                 |  4 ++--
 block/qcow2.c                 |  2 +-
 hw/cxl/cxl-host.c             |  2 +-
 hw/scsi/scsi-disk.c           |  2 +-
 hw/scsi/scsi-generic.c        |  4 ++--
 hw/scsi/virtio-scsi.c         |  2 +-
 io/net-listener.c             | 10 +++++-----
 target/i386/cpu.c             |  3 ++-
 target/i386/emulate/x86_mmu.c |  4 ++--
 9 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index d2ba2a4d58dc..f7cb6e0b57d4 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -278,7 +278,7 @@ static bool blkio_completion_fd_poll(void *opaque)
 {
     BlockDriverState *bs = opaque;
     BDRVBlkioState *s = bs->opaque;
-    int ret;
+    int ret = -1;
 
     /* Just in case we already fetched a completion */
     if (s->poll_completion.user_data != NULL) {
@@ -559,7 +559,7 @@ static bool blkio_register_buf(BlockDriverState *bs, void *host, size_t size,
     BDRVBlkioState *s = bs->opaque;
     struct blkio_mem_region region;
     BlkioMemRegionResult region_result;
-    int ret;
+    int ret = -1;
 
     /*
      * Mapping memory regions conflicts with RAM discard (virtio-mem) when
diff --git a/block/qcow2.c b/block/qcow2.c
index 19271b10a49f..639593d737c8 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -838,7 +838,7 @@ static const char *overlap_bool_option_names[QCOW2_OL_MAX_BITNR] = {
 static void coroutine_fn cache_clean_timer(void *opaque)
 {
     BDRVQcow2State *s = opaque;
-    uint64_t wait_ns;
+    uint64_t wait_ns = 0;
 
     WITH_QEMU_LOCK_GUARD(&s->lock) {
         wait_ns = s->cache_clean_interval * NANOSECONDS_PER_SECOND;
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 7e744312f1d8..eba13c9e7cba 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -279,7 +279,7 @@ static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
     MemoryRegion *mr = NULL;
     uint64_t vmr_size = 0, pmr_size = 0, offset = 0;
     MemoryRegion *direct_mr;
-    g_autofree char *direct_mr_name;
+    g_autofree char *direct_mr_name = NULL;
     unsigned int idx = state->hdm_decoder_idx;
 
     if (ct3d->hostvmem) {
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 1b0cce128c5e..82dc75cb7d10 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3263,7 +3263,7 @@ static bool scsi_disk_pr_state_needed(void *opaque)
 {
     SCSIDiskState *s = opaque;
     SCSIPRState *pr_state = &s->qdev.pr_state;
-    bool ret;
+    bool ret = false;
 
     if (!s->qdev.migrate_pr) {
         return false;
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 8999f3b72006..b044561ae2dd 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -553,8 +553,8 @@ bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp)
     SCSIPRState *pr_state = &s->pr_state;
     Error *local_err = NULL;
     bool check_stale_key = true;
-    uint64_t key;
-    uint8_t resv_type;
+    uint64_t key = 0;
+    uint8_t resv_type = 0;
 
     /* Get the migrated PR state */
     WITH_QEMU_LOCK_GUARD(&pr_state->mutex) {
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 6c7376801190..833f773d7f6c 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1093,7 +1093,7 @@ static void virtio_scsi_push_event(VirtIOSCSI *s,
 
 static void virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq)
 {
-    bool events_dropped;
+    bool events_dropped = false;
 
     WITH_QEMU_LOCK_GUARD(&s->event_lock) {
         events_dropped = s->events_dropped;
diff --git a/io/net-listener.c b/io/net-listener.c
index 1fd0f6cb5ab8..8df19c35bd8f 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -54,11 +54,11 @@ static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
                                               gpointer opaque)
 {
     QIONetListener *listener = QIO_NET_LISTENER(opaque);
-    QIOChannelSocket *sioc;
-    QIONetListenerClientFunc io_func;
-    gpointer io_data;
-    GMainContext *context;
-    AioContext *aio_context;
+    QIOChannelSocket *sioc = NULL;
+    QIONetListenerClientFunc io_func = NULL;
+    gpointer io_data = NULL;
+    GMainContext *context = NULL;
+    AioContext *aio_context = NULL;
 
     sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
                                      NULL);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5805d33ab92d..e9759ab25077 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7734,7 +7734,7 @@ static void x86_cpuid_get_avx10_version(Object *obj, Visitor *v,
 static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
                                          Error **errp)
 {
-    const AVX10VersionDefinition *def;
+    const AVX10VersionDefinition *def = NULL;
     CPUX86State *env = &cpu->env;
 
     if (!version) {
@@ -7758,6 +7758,7 @@ static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
         }
     }
 
+    assert(def != NULL);
     if (def->version < version) {
         error_setg(errp, "avx10-version can be at most %d", def->version);
         return false;
diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 8d4371467fd7..c1cb385b3228 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -185,8 +185,8 @@ static MMUTranslateResult walk_gpt(CPUState *cpu, target_ulong addr, MMUTranslat
     int largeness = 0;
     target_ulong cr3 = x86_read_cr(cpu, 3);
     uint64_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
-    MMUTranslateResult res;
-    
+    MMUTranslateResult res = 0;
+
     memset(pt, 0, sizeof(*pt));
     top_level = gpt_top_level(cpu, pae);
 

-- 
2.55.0

