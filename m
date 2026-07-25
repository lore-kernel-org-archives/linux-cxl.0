Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5F73B1B3
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jul 2026 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784988065; cv=none; b=lfu9fgKguKMkOQZODXB7pjGMz4sdaMsf/1J2HMkFzwqOcjQb/OM16ZAIWnGDGiotgeN7g3A37604Eh13aOkr287VVZ1VPub3mxtF56d8J3R1OWph6VpaphcW5Dyc7PBrbHzxba9R09W1FKE9kzEBDDpgNidD3h+hkmZGC8+h3q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784988065; c=relaxed/simple;
	bh=tc59tpUIOnJATfZj0Ow9IZihAQ/ju8XXCdAihZfGr0Q=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=Q744oR7sgO3dwI8NMMjHaY0e0gF1bdLm95Ww7Hj5cdANPyI2EeikCw5QoibaWz91Rvgr+EuVXZvhs45bEghRf8We785XvnvtCnx+ucbyl3GuyCPTRRBp5glZTQJEXiUUseIGpBLnipaeBOcJy9lRYE4yeD5Gc/ZmzJHFyfjvedw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HsjoIGuD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsjoIGuD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784988063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ayGYuMqLtdZ4tO4DWqG//BYWp/04yuY/5uhQAQdO2WU=;
	b=HsjoIGuDYYZNq0vIkmLmRnPOe/3FCiFsNZcpgV3M2DrAFA640wtdoDOcfxm2qRFlnvLGLt
	KQcRWhxpyAmXZD5nSMc82P/hrjdZLdGuk38nAyknPE9CHDej3Gik2ztqh5XBPD39cXa2b1
	6TZbVcGD2m4yDWTTWzX12or92U0XJgk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-UIgTjnWwPw-WTRys6eze3Q-1; Sat,
 25 Jul 2026 10:00:59 -0400
X-MC-Unique: UIgTjnWwPw-WTRys6eze3Q-1
X-Mimecast-MFC-AGG-ID: UIgTjnWwPw-WTRys6eze3Q_1784988057
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4366E1800366;
	Sat, 25 Jul 2026 14:00:57 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9723B300019F;
	Sat, 25 Jul 2026 14:00:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 18:00:08 +0400
Subject: [PATCH 7/7] qdev-monitor: drain RCU callbacks in
 qdev_device_add_from_qdict
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260725-fix2-v1-7-5c9a6ce7b96a@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2906;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=tc59tpUIOnJATfZj0Ow9IZihAQ/ju8XXCdAihZfGr0Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZMFmg2IQSzXLgb1HeD4VQxrb08w/yBiPzE55j
 2UdhTQdlO+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamTBZgAKCRDa6OEJdZac
 5RgpD/46Kwqoedezh17/7AwZORHSgHU7hKbFErb7X4Ikhq1/dLQSkXBtm5abklnGQO7N8TO4sS8
 OfbbNBDS/aeA+btHMl5bLz/O7y3tWsqLYR76CbHnw+iWqxre97mP4BVZzLr1YyhxzsGM6xMQndb
 zV+npve/xAPguVU5RtwD4l9qK3BQAhLagSqG5zWC0otLwxithRDCHnVRVtDGpiO0i3QkmlzLTjq
 HHuCMUOKjJZNHFuCej8YbXh78jDonklWR/aBbeONo2zlTo9k5vGjOp2unuKBB+SftjxALcevMGu
 e4ivmu6IKX83FV9zzfo8M3bshxBabng6IzOITBfuDh7KTAdHyC0F+H9CuS5aCIk3eHXJebdYcDK
 fi51MqFwAukd/0ePcpgm8loFqF6gJGoeiaA7n6SmkYtdV6mlkpyzw3BWftmoxMWob+6QU2OIszu
 LHsbC3TBB/suz8NCRQLpuLIf6f3HmO7pcUW6FLP5S4UvKX73xCwh+wuJCz1Db50DpTvwbiPJfEH
 S8S9v0H9tD1SNUuPILRTVH6U7iSfQ+6zUXRBfKDebGFmsgypyReuwWpSODYgP/qEJdet3krd74m
 GHVq0aVf0YH7DTRUU1zmpI6q3tLCdRl9XlD+PZAVfuFqiSonRAF9X5dJ6qwv2bvDia/Dx+5FmJ/
 GijtQUiJ8r6cJCg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: _xgHbn_Qrqz1OusSTXzJRcMmRN9QqGFGOXrdR6rIFBo_1784988057
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
so it always runs, and drop the now-redundant calls in qmp_device_add()
and hmp_device_add().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/qdev-monitor.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 00fed791cce1..884d407d60d4 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -746,6 +746,16 @@ err_del_dev:
     object_unparent(OBJECT(dev));
     object_unref(OBJECT(dev));
 
+    /*
+     * Drain all pending RCU callbacks. This is done because some bus
+     * related operations can delay a device removal (in this case this
+     * can happen if device is added and then removed due to a
+     * configuration error) to a RCU callback, but a caller might expect
+     * the failed device to be fully torn down once this function
+     * returns.
+     */
+    drain_call_rcu();
+
     return NULL;
 }
 
@@ -870,18 +880,6 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
     DeviceState *dev;
 
     dev = qdev_device_add_from_qdict(qdict, true, errp);
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
     object_unref(OBJECT(dev));
 }
 
@@ -1017,17 +1015,6 @@ void hmp_device_add(Monitor *mon, const QDict *qdict)
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

