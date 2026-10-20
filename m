Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493414;
	b=hjXfGNN8NHfxR6Xv7s1+pKUrksND4Ppndv4kCVC2iPsyNsEOWDdKCHs7Q6g5NAqGtPjp
	 T6aV5OeoctuOn1VrnnteSzFH2i53enD9HDq/zBE9NyYOvPaUCLXFR4JtWzFinhsmbsMhU
	 2DM57HFy4iyunX6Y5CgEMpyYNSPOLXR9NfGRFZN/cRpk3RM8Vem2TnoZiG4j0Wr/+JcDm
	 uSssQOqWYIYXifdPTPJJmOA7GPdNetxH7t35iMcSDMq1/mbwnm+G5s+++gESY5QhnSbJs
	 RdIKVCf8FIjL6plZhhFaS/q0zEd6s/T055umTg13AdKgm5D64h6g1AQWtmzBJ9d9HQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493414;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=EljyyKpOaP+UVHeVMtiabRjWia9m5EXPj7DEMxHLTqI=;
	b=tqL8SKxumak/bnkWLc2LBRDZKabdWUh7tLd5yxdXnbisjz2nvuprryIXIGZnZCLXjZAx
	 VIWseaSMBSMnv0NnK8UP0oHcgIGuMrRtcUjKA6iK07RqF3dhg9lI38Mo+T5pWnqCKnEaQ
	 XxmG+y6HG1IpVBsADnmJG0dEcfy1n8mnmlz2FPYCbTDv2i619hKzzvdj97ytZsYoCIPXr
	 GnM980+BnxbUEF8D9zjViSqorrTlKAXtfzkRE2qU4bjY2QMYw/c4MaaBPg4I61t1ggqrA
	 Ok0KbT8bpvkH1yBo4ZUbZB9LpVYKvEP6+XPRTNEpjTUsDlDHzt0Wqjla93THnYX2v7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QMWsi5VV;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD63B606A320
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD63B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QMWsi5VV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EljyyKpOaP+UVHeVMtiabRjWia9m5EXPj7DEMxHLTqI=;
	b=QMWsi5VVcviMK0s0SHV+TgMQk21CviSjtawjS/R8q89kZClam+7WG56cyle89XmhkpEnMp
	9JMXCTEeMD61s7Ip6tjq2YTSPsDcHoc0fea4kdHHaI3V0ZcykzlXQ/yoMvpxa8DQuLr5za
	0MvGekwskWGDTwuoBBqy1OmjO3Zc8Zo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-_7Frlu4AM46-pYvhF0dpvA-1; Tue,
 20 Oct 2026 10:50:08 +0000
X-MC-Unique: _7Frlu4AM46-pYvhF0dpvA-1
X-Mimecast-MFC-AGG-ID: _7Frlu4AM46-pYvhF0dpvA_1792493403
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7188D1956076;
	Tue, 20 Oct 2026 10:50:03 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC7271800586;
	Tue, 20 Oct 2026 10:50:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:59 +0400
Subject: [PATCH v7 42/65] virtio-balloon: convert guest-stats property to
 QAPI type
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-42-431a86b02b58@redhat.com>
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
In-Reply-To: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, Alberto Garcia <berto@igalia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
 Junjie Cao <junjie.cao@intel.com>, Anisa Su <anisa.su@samsung.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, 
 John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org, 
 linux-cxl@vger.kernel.org, qemu-s390x@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>, 
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>, 
 Xianglai Li <lixianglai@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Alistair Francis <alistair@alistair23.me>, Alexander Graf <graf@amazon.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, Ani Sinha <anisinha@redhat.com>, 
 Luc Michel <luc@lmichel.fr>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Samuel Tardieu <sam@rfc1149.net>, "Denis V. Lunev" <den@openvz.org>, 
 FangSheng Huang <FangSheng.Huang@amd.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Conor Dooley <conor@kernel.org>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Titus Rwantare <titusr@google.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, Peter Xu <peterx@redhat.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, 
 Hendrik Brueckner <brueckner@linux.ibm.com>, xen-devel@lists.xenproject.org, 
 Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Fam Zheng <fam@euphon.net>, 
 Farhan Ali <alifm@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, 
 Tao Tang <tangtao1634@phytium.com.cn>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Jiri Pirko <jiri@resnulli.us>, 
 Eric Auger <eric.auger@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=10182;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=0g8PFfs3LJuc0BLWv6rMvjXCCHAbNtdnRJuucBbysso=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZbJgd7s8Bcgu4jJ87MBVuZ+yAsGD3uZV7Ld
 ZOdhpMi4vyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWwAKCRDa6OEJdZac
 5a+iD/9O1qwWl2Gco4J1mBvanY/rwFGr7NPb9pyAfuwVDpozMDdvXhMl7hahB1Ds96uxJ/rE4qX
 SBiL4gdjh3V17vwq4s8eVGAy4vXzmKarp9JFyYGBdIYBMyaD/l/nF9JpCvzHBfeoJVaJiT1PQQt
 xYL67ZSgUBNuzxP6nOe8i/6molK+XMubhLA3Kq2QQXlkYO/VdfQtO/IJhzrmXxbG01aPW1rlCzK
 dpH2Pg86MU+st3pFO6V2u2mWPT4iBrhRvldHPguFEFz3XzWBP4mk0lC6FjZzlsEbsug2La+TE/A
 Cssx+kRcv3yHPtzgrG0dTA8JSlBWJMGi6Mj+MpceHoDoFYuX3fYpide5R/fVlg+SeNqlorDtHuk
 novEDfzkqUfPInZeNVGWeblx5V2CWdPPHGjJiTexE+gYnW0dCzCdm7huVbeMNcwx115bEnARo3K
 3p5W5EaVBokC/qsklxmPmHMpC8HOC11c6bky6ZydQ9R0CXbJaooGegZUHMl8BQVojw9uT4HuIEf
 zhvHk7DKGkyT1aTa3Oe+Ey83EQ7NDIygPh75uIZjWT6gzgVMLebNYJMiE9wdeb8EdXuAg/JFEnW
 F8wmPQVW1QH9o6VSbwih+m8LfSoBGJO4URR1+cnKCLSUdPeyYFJmFz5ZccsUYDyKK8i/VtQMyW0
 2U8t9WP1qP4jaPg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: wThPxp8a-OSreUFtGHzI4J65NqMGYHR5mIqX3Ux7S78_1792493403
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Define VirtioBalloonStats and VirtioBalloonGuestStats QAPI struct types
in the schema, replacing the hand-rolled visitor in balloon_stats_get_all()
with a generated visit_type_VirtioBalloonGuestStats() call.

The wire format is preserved: the JSON output from qom-get is identical
to the previous hand-rolled visitor output.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/interop/virtio-balloon-stats.rst | 22 +--------
 hw/virtio/virtio-balloon.c            | 84 ++++++++++++--------------------
 qapi/machine.json                     | 92 +++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+), 75 deletions(-)

diff --git a/docs/interop/virtio-balloon-stats.rst b/docs/interop/virtio-balloon-stats.rst
index b9a6a6edb229..88d3271bbb02 100644
--- a/docs/interop/virtio-balloon-stats.rst
+++ b/docs/interop/virtio-balloon-stats.rst
@@ -22,27 +22,7 @@ polling the guest's balloon driver for new stats in the specified time
 interval.
 
 To retrieve those stats, clients have to query the guest-stats property,
-which will return a dictionary containing:
-
-  * A key named 'stats', containing all available stats. If the guest
-    doesn't support a particular stat, or if it couldn't be retrieved,
-    its value will be -1. Currently, the following stats are supported:
-
-      - stat-swap-in
-      - stat-swap-out
-      - stat-major-faults
-      - stat-minor-faults
-      - stat-free-memory
-      - stat-total-memory
-      - stat-available-memory
-      - stat-disk-caches
-      - stat-htlb-pgalloc
-      - stat-htlb-pgfail
-
-  * A key named last-update, which contains the last stats update
-    timestamp in seconds. Since this timestamp is generated by the host,
-    a buggy guest can't influence its value. The value is 0 if the guest
-    has not updated the stats (yet).
+which will return a VirtioBalloonGuestStats (see QAPI documentation).
 
 It's also important to note the following:
 
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 7ffbe48e5134..bfc75f5dfc72 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -29,6 +29,8 @@
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-events-machine.h"
+#include "qapi/qapi-type-infos-machine.h"
+#include "qapi/qapi-visit-machine.h"
 #include "qapi/visitor.h"
 #include "trace.h"
 #include "qemu/error-report.h"
@@ -170,33 +172,8 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
     }
 }
 
-/*
- * All stats upto VIRTIO_BALLOON_S_NR /must/ have a
- * non-NULL name declared here, since these are used
- * as keys for populating the QDict with stats
- */
-static const char *balloon_stat_names[] = {
-   [VIRTIO_BALLOON_S_SWAP_IN] = "stat-swap-in",
-   [VIRTIO_BALLOON_S_SWAP_OUT] = "stat-swap-out",
-   [VIRTIO_BALLOON_S_MAJFLT] = "stat-major-faults",
-   [VIRTIO_BALLOON_S_MINFLT] = "stat-minor-faults",
-   [VIRTIO_BALLOON_S_MEMFREE] = "stat-free-memory",
-
-   [VIRTIO_BALLOON_S_MEMTOT] = "stat-total-memory",
-   [VIRTIO_BALLOON_S_AVAIL] = "stat-available-memory",
-   [VIRTIO_BALLOON_S_CACHES] = "stat-disk-caches",
-   [VIRTIO_BALLOON_S_HTLB_PGALLOC] = "stat-htlb-pgalloc",
-   [VIRTIO_BALLOON_S_HTLB_PGFAIL] = "stat-htlb-pgfail",
-
-   [VIRTIO_BALLOON_S_OOM_KILL] = "stat-oom-kills",
-   [VIRTIO_BALLOON_S_ALLOC_STALL] = "stat-alloc-stalls",
-   [VIRTIO_BALLOON_S_ASYNC_SCAN] = "stat-async-scans",
-   [VIRTIO_BALLOON_S_DIRECT_SCAN] = "stat-direct-scans",
-   [VIRTIO_BALLOON_S_ASYNC_RECLAIM] = "stat-async-reclaims",
-
-   [VIRTIO_BALLOON_S_DIRECT_RECLAIM] = "stat-direct-reclaims",
-};
-G_STATIC_ASSERT(G_N_ELEMENTS(balloon_stat_names) == VIRTIO_BALLOON_S_NR);
+/* Update VirtioBalloonStats QAPI type when new stats are added */
+G_STATIC_ASSERT(VIRTIO_BALLOON_S_NR == 16);
 
 /*
  * reset_stats - Mark all items in the stats array as unset
@@ -258,33 +235,31 @@ static void balloon_stats_get_all(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
     VirtIOBalloon *s = VIRTIO_BALLOON(obj);
-    bool ok = false;
-    int i;
+    VirtioBalloonStats stats = {
+        .stat_swap_in = s->stats[VIRTIO_BALLOON_S_SWAP_IN],
+        .stat_swap_out = s->stats[VIRTIO_BALLOON_S_SWAP_OUT],
+        .stat_major_faults = s->stats[VIRTIO_BALLOON_S_MAJFLT],
+        .stat_minor_faults = s->stats[VIRTIO_BALLOON_S_MINFLT],
+        .stat_free_memory = s->stats[VIRTIO_BALLOON_S_MEMFREE],
+        .stat_total_memory = s->stats[VIRTIO_BALLOON_S_MEMTOT],
+        .stat_available_memory = s->stats[VIRTIO_BALLOON_S_AVAIL],
+        .stat_disk_caches = s->stats[VIRTIO_BALLOON_S_CACHES],
+        .stat_htlb_pgalloc = s->stats[VIRTIO_BALLOON_S_HTLB_PGALLOC],
+        .stat_htlb_pgfail = s->stats[VIRTIO_BALLOON_S_HTLB_PGFAIL],
+        .stat_oom_kills = s->stats[VIRTIO_BALLOON_S_OOM_KILL],
+        .stat_alloc_stalls = s->stats[VIRTIO_BALLOON_S_ALLOC_STALL],
+        .stat_async_scans = s->stats[VIRTIO_BALLOON_S_ASYNC_SCAN],
+        .stat_direct_scans = s->stats[VIRTIO_BALLOON_S_DIRECT_SCAN],
+        .stat_async_reclaims = s->stats[VIRTIO_BALLOON_S_ASYNC_RECLAIM],
+        .stat_direct_reclaims = s->stats[VIRTIO_BALLOON_S_DIRECT_RECLAIM],
+    };
+    VirtioBalloonGuestStats guest_stats = {
+        .last_update = s->stats_last_update,
+        .stats = &stats,
+    };
+    VirtioBalloonGuestStats *argp = &guest_stats;
 
-    if (!visit_start_struct(v, name, NULL, 0, errp)) {
-        return;
-    }
-    if (!visit_type_int(v, "last-update", &s->stats_last_update, errp)) {
-        goto out_end;
-    }
-
-    if (!visit_start_struct(v, "stats", NULL, 0, errp)) {
-        goto out_end;
-    }
-    for (i = 0; i < VIRTIO_BALLOON_S_NR; i++) {
-        if (!visit_type_uint64(v, balloon_stat_names[i], &s->stats[i], errp)) {
-            goto out_nested;
-        }
-    }
-    ok = visit_check_struct(v, errp);
-out_nested:
-    visit_end_struct(v, NULL);
-
-    if (ok) {
-        visit_check_struct(v, errp);
-    }
-out_end:
-    visit_end_struct(v, NULL);
+    visit_type_VirtioBalloonGuestStats(v, name, &argp, errp);
 }
 
 static void balloon_stats_get_poll_interval(Object *obj, Visitor *v,
@@ -1037,7 +1012,8 @@ static void virtio_balloon_instance_init(Object *obj)
     s->free_page_hint_cmd_id = VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN;
     s->free_page_hint_notify.notify = virtio_balloon_free_page_hint_notify;
 
-    object_property_add(obj, "guest-stats", "guest statistics",
+    object_property_add_qapi(obj, "guest-stats",
+                        &VirtioBalloonGuestStats_type_info,
                         balloon_stats_get_all, NULL, NULL, NULL);
 
     object_property_add_qapi(obj, "guest-stats-polling-interval", &int_type_info,
diff --git a/qapi/machine.json b/qapi/machine.json
index 9b145c635baf..34be3156270c 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1126,6 +1126,98 @@
 ##
 { 'struct': 'BalloonInfo', 'data': {'actual': 'int' } }
 
+##
+# @VirtioBalloonStats:
+#
+# VirtIO balloon device guest memory statistics.
+#
+# If the guest doesn't support a particular stat, or if it couldn't
+# be retrieved, its value will be -1.
+#
+# @stat-swap-in: The amount of memory that has been
+#     swapped in (in bytes).
+#
+# @stat-swap-out: The amount of memory that has been
+#     swapped out to disk (in bytes).
+#
+# @stat-major-faults: The number of major page faults
+#     that have occurred.
+#
+# @stat-minor-faults: The number of minor page faults
+#     that have occurred.
+#
+# @stat-free-memory: The amount of memory not being used
+#     for any purpose (in bytes).
+#
+# @stat-total-memory: The total amount of memory available
+#     (in bytes).
+#
+# @stat-available-memory: An estimate of how much memory is available
+#     (in bytes) for starting new applications, without pushing the
+#     system to swap.
+#
+# @stat-disk-caches: The amount of memory, in bytes, that can be
+#     quickly reclaimed without additional I/O.  Typically these pages
+#     are used for caching files from disk.
+#
+# @stat-htlb-pgalloc: The number of successful hugetlb page
+#     allocations
+#
+# @stat-htlb-pgfail: The number of failed hugetlb page
+#     allocations
+#
+# @stat-oom-kills: The number of OOM killer invocations
+#
+# @stat-alloc-stalls: The number of memory allocation stalls
+#
+# @stat-async-scans: The number of memory scanned asynchronously
+#
+# @stat-direct-scans: The number of memory scanned directly
+#
+# @stat-async-reclaims: The number of memory reclaimed asynchronously
+#
+# @stat-direct-reclaims: The number of memory reclaimed directly
+#
+# Since: 11.2
+##
+{ 'struct': 'VirtioBalloonStats',
+  'data': {
+    'stat-swap-in': 'uint64',
+    'stat-swap-out': 'uint64',
+    'stat-major-faults': 'uint64',
+    'stat-minor-faults': 'uint64',
+    'stat-free-memory': 'uint64',
+    'stat-total-memory': 'uint64',
+    'stat-available-memory': 'uint64',
+    'stat-disk-caches': 'uint64',
+    'stat-htlb-pgalloc': 'uint64',
+    'stat-htlb-pgfail': 'uint64',
+    'stat-oom-kills': 'uint64',
+    'stat-alloc-stalls': 'uint64',
+    'stat-async-scans': 'uint64',
+    'stat-direct-scans': 'uint64',
+    'stat-async-reclaims': 'uint64',
+    'stat-direct-reclaims': 'uint64' } }
+
+##
+# @VirtioBalloonGuestStats:
+#
+# Guest statistics from the VirtIO balloon device.
+#
+# @last-update: timestamp in seconds of the last stats
+#     update from the guest (since this timestamp is generated
+#     by the host, a buggy guest can't influence its value),
+#     or 0 if no update has been received yet.
+#
+# @stats: balloon memory statistics
+#
+# Since: 11.2
+##
+{ 'struct': 'VirtioBalloonGuestStats',
+  'data': {
+    'last-update': 'int',
+    'stats': 'VirtioBalloonStats' } }
+
 ##
 # @query-balloon:
 #     Return information about the balloon device.

-- 
2.56.0.116.g6de20f6092dc

