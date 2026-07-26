Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1B8189F43
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785098739; cv=none; b=Uy8Z1j24Thec0EhLyN0SDP8zK8dNyRAQPOCJkddsBOHR76WusmC/RyIdv+M82jvMp/s7esj6m4ZKtMdCQ3itFASbaWgL0MD3/CRac74Uv2ECtYXUjHe5VXbPtfy9J14P3ACk2GcJgsouJ36PRDhyHAHXUvVbd/zBY5gYLuYyCOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785098739; c=relaxed/simple;
	bh=fcpLJyqHW+NBPjd22Abqq192DosvFzwYSWsrX/V2B3w=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=kHYRbURVRBM72RqYEuCibn4hT1PVKOGkt8RYO4/LTNAt2qoMMJMpoLkZI4pjdU1g0vGxS3xvryxzQtuFIpWdPsXNJLSEFtIbLMkSJOa6aeMaD4tLCI8q6H0FwQd4ZFZGEnfRFJ3/tynt9wLBYe8GNetpBT6a2kdzZBjOmcsFgLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fk0sj8YV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fk0sj8YV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785098736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1qaXwrZ97SmSwNI4+ReXuIEhgm8sWXcmQboUN67GDk=;
	b=Fk0sj8YV1s7cr+3uvazTHr4X4PRGJub7EZoyFHxR9ROnxurJhrMc2W2V8TK0yulNlcxdpC
	FRHf4qigkhRkNLgtpKTrGSD8izC53yjSRF8Zkrt8K3E2ZvZv1UcVumjqKLdmy0BLjlb3Hb
	Q0E0UH6L5t0Z119l/CGIrW5sX12ATXg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-iFhpVBxaMWyFtW2ZHR5y5Q-1; Sun,
 26 Jul 2026 16:45:33 -0400
X-MC-Unique: iFhpVBxaMWyFtW2ZHR5y5Q-1
X-Mimecast-MFC-AGG-ID: iFhpVBxaMWyFtW2ZHR5y5Q_1785098731
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AFC018007FD;
	Sun, 26 Jul 2026 20:45:31 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE22F1956047;
	Sun, 26 Jul 2026 20:45:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 00:44:11 +0400
Subject: [PATCH v2 12/12] qdev-monitor: drain RCU callbacks in
 qdev_device_add_from_qdict
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260727-fix2-v2-12-d0c4831ed7ea@redhat.com>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
In-Reply-To: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5862;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=fcpLJyqHW+NBPjd22Abqq192DosvFzwYSWsrX/V2B3w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZnGXjUhIMgw39+zUP7myS8AIr8NMr5KcG+Ttc
 EcD7MASeTqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamZxlwAKCRDa6OEJdZac
 5U+wD/9+PsTDyw71Fsn83Zo+U1bHBfaQbsh9EQfdc/qxGoGLnhbTTF9ICc+fSNydwdqMGv4WcQl
 kfQWMbfo2UArbrRdSdPW2IkXj0dNWPGfQ+XjL9BlKDqQknaMU38VO0rAOz7IQj/RUrEjTG6tr0G
 vxrVnOW7bvbvfxC/IfD1qGvWlt+XPaDF8cMTJSkWkCVX/s3+fCFEbab1XVhWjF1TsHJ1+pbxjV/
 OZXDt/nyGL7Dr9aQ7BNPpunzzyOb92UAzfAxVoJ4Naz2tluKb0929GKQSHvvLaVQSDOyFNLreIb
 En0fsHIhQk5RfuX4XKX4W8GM/NGDfqXtt1nQ6aLVuFcJwZDnzZqQtzVjIHoB+x9UbtgYyVpTkwq
 MyEXWgJZkcYzxfL1YYxRQWbMUzY7KnxtulYFsl6GwTVZ+abzWMt2ktP1qR0vOjVzblMd6bWYUyC
 NmVBueISfxAMCtsKWbR1iBAux6nG5k7jw0lLgKMtVyjVHuydwcqudVzFHm2cxj5zRWPBfgZH980
 LnqEWshuNFTnwEfWGKuc7PDx5S5mnE9xw0bgg/pVMmNzQ3ZWQ1fGwcEUGcsetWXT34tBPs1I9cI
 C7ouFzyNa1PYmyOaX+lkgeSf0e88g1XxRbAQEkakdUwVboAnikK2oN27CCuYWW5lE+WYhKPyFyh
 YXc2EacOuMEht8w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: UEJsrdXrEjauj9-uh5LCjA2Y8X1zJPFR_BRPATybg8E_1785098731
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

qmp_device_add() and hmp_device_add() drain pending RCU callbacks after
a failed device_add, since some bus teardown (e.g. bus_remove_child())
is deferred to call_rcu(). -device on the command line reaches the same
qdev_device_add_from_qdict() with errp pointing at error_fatal, whose
ERRP_GUARD() exits before control returns to the caller, so the caller's
drain_call_rcu() never runs.

Move the drain into qdev_device_add_from_qdict()'s own err_del_dev path
and drop the now-redundant calls in qmp_device_add() and
hmp_device_add(). Gate it behind a new drain_rcu parameter, because
virtio-net failover can reach qdev_device_add_from_qdict() from an MMIO
write dispatched under address_space_write()'s RCU read lock.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/monitor/qdev.h |  3 ++-
 hw/audio/intel-hda.c   |  2 +-
 hw/net/virtio-net.c    |  2 +-
 system/qdev-monitor.c  | 42 ++++++++++++++++--------------------------
 4 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
index f85f25738d58..72d2fa4654d3 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -12,7 +12,8 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp);
 int qdev_device_help(QemuOpts *opts);
 DeviceState *qdev_device_add(QemuOpts *opts, Error **errp);
 DeviceState *qdev_device_add_from_qdict(const QDict *opts,
-                                        bool from_json, Error **errp);
+                                        bool from_json, bool drain_rcu,
+                                        Error **errp);
 BusState *qdev_find_default_bus(DeviceClass *dc, Error **errp);
 
 /**
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 3d361a4976c6..128c5ee612ce 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1313,7 +1313,7 @@ static void intel_hda_and_codec_init(const char *audiodev)
     BusState *hdabus;
 
     qdict_put_str(props, "driver", "intel-hda");
-    intel_hda = qdev_device_add_from_qdict(props, false, &error_fatal);
+    intel_hda = qdev_device_add_from_qdict(props, false, true, &error_fatal);
     hdabus = QLIST_FIRST(&intel_hda->child_bus);
 
     codec = qdev_new("hda-duplex");
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f0e3beb29032..0c5da8cb71af 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -916,7 +916,7 @@ static void failover_add_primary(VirtIONet *n, Error **errp)
 
     dev = qdev_device_add_from_qdict(n->primary_opts,
                                      n->primary_opts_from_json,
-                                     &err);
+                                     false, &err);
     if (err) {
         qobject_unref(n->primary_opts);
         n->primary_opts = NULL;
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 00fed791cce1..77508bb1c3f1 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -650,7 +650,8 @@ BusState *qdev_find_default_bus(DeviceClass *dc, Error **errp)
 }
 
 DeviceState *qdev_device_add_from_qdict(const QDict *opts,
-                                        bool from_json, Error **errp)
+                                        bool from_json, bool drain_rcu,
+                                        Error **errp)
 {
     ERRP_GUARD();
     DeviceClass *dc;
@@ -746,6 +747,18 @@ err_del_dev:
     object_unparent(OBJECT(dev));
     object_unref(OBJECT(dev));
 
+    /*
+     * Some bus teardown (e.g. bus_remove_child()) is deferred via
+     * call_rcu(). When safe, drain those callbacks so the failed
+     * device is fully torn down before we return. Callers that are
+     * already inside an RCU read-side critical section (e.g. MMIO
+     * dispatch during virtio-net failover) must pass drain_rcu=false
+     * to avoid deadlocking on the grace period.
+     */
+    if (drain_rcu) {
+        drain_call_rcu();
+    }
+
     return NULL;
 }
 
@@ -755,7 +768,7 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
     QDict *qdict = qemu_opts_to_qdict(opts, NULL);
     DeviceState *ret;
 
-    ret = qdev_device_add_from_qdict(qdict, false, errp);
+    ret = qdev_device_add_from_qdict(qdict, false, true, errp);
     if (ret) {
         qemu_opts_del(opts);
     }
@@ -869,19 +882,7 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
 {
     DeviceState *dev;
 
-    dev = qdev_device_add_from_qdict(qdict, true, errp);
-    if (!dev) {
-        /*
-         * Drain all pending RCU callbacks. This is done because
-         * some bus related operations can delay a device removal
-         * (in this case this can happen if device is added and then
-         * removed due to a configuration error)
-         * to a RCU callback, but user might expect that this interface
-         * will finish its job completely once qmp command returns result
-         * to the user
-         */
-        drain_call_rcu();
-    }
+    dev = qdev_device_add_from_qdict(qdict, true, true, errp);
     object_unref(OBJECT(dev));
 }
 
@@ -1017,17 +1018,6 @@ void hmp_device_add(Monitor *mon, const QDict *qdict)
     }
     dev = qdev_device_add(opts, &err);
     if (!dev) {
-        /*
-         * Drain all pending RCU callbacks. This is done because
-         * some bus related operations can delay a device removal
-         * (in this case this can happen if device is added and then
-         * removed due to a configuration error)
-         * to a RCU callback, but user might expect that this interface
-         * will finish its job completely once qmp command returns result
-         * to the user
-         */
-        drain_call_rcu();
-
         qemu_opts_del(opts);
     }
     object_unref(dev);

-- 
2.55.0

