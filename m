Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F5832D0EE
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782493; cv=none; b=RdZL07wF0CS4j8ptarjbfKsXe4h65os4+5p2iT/wDHubPrz3wubJQW93FybQEdiLeqnGve0QIXoV5AEmk455y2zyxZPomE9K0AiusYS35qCeCY6d7204rp9Pyi+hStYgwWr6UG7kn4P3ac96msTKkpDxD3EJYmbt0va3FkLyMdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782493; c=relaxed/simple;
	bh=KlaF9DSO2l0BcOC3OpAIjCXR1N+yfK3z8b4Zf507cxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=afAZx7eDaQeSZa9GcKMr2rY+M55kBKorqoYsw2WdVjY3irWa1qWq0TmCFJI9nJKcx2e/TegY7TCMAWqJf1g/RrCzKXOlG7NRyv5TL/XQ3bc9P6OkNFO0thtacblkN02hF84XTgeFHGvrTRUAcaEp+wNIS9KRw/psLTrd1ZLiRUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B3crg3Yn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3crg3Yn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYJwMcbrtQiolDG35OJu9PXoTbvWWWpVq26QLgHqBgg=;
	b=B3crg3YnmgV8Jy+OfP5MgCRqV7O1+2H5L7fGXX3JgaVKBkYv5d+5TRXa3evkiQCZ92HFLF
	AI3ArHtjoJlQkbCfHt3eKOoP5LdrAhRndYgs3sMEWmADYPzDs3WkwmBXFoTl4dnfcxt2Tt
	EKuJbs8M1g15lalUmh3033oHS+PdK9k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-olmRqzpzNQO5IiURxRhHVA-1; Thu,
 23 Jul 2026 00:54:35 -0400
X-MC-Unique: olmRqzpzNQO5IiURxRhHVA-1
X-Mimecast-MFC-AGG-ID: olmRqzpzNQO5IiURxRhHVA_1784782473
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E00118E6A47;
	Thu, 23 Jul 2026 04:54:33 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 61D61180029D;
	Thu, 23 Jul 2026 04:54:24 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Lukas Straub <lukasstraub2@web.de>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Zhao Liu <zhao1.liu@intel.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Markus Armbruster <armbru@redhat.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Alex Williamson <alex@shazbot.org>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hanna Reitz <hreitz@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	qemu-block@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	linux-cxl@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	Fabiano Rosas <farosas@suse.de>,
	John Snow <jsnow@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Igor Mammedov <imammedo@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-edac@vger.kernel.org,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	qemu-trivial@nongnu.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 38/44] qapi: convert intro sections for virtio.json
Date: Thu, 23 Jul 2026 00:47:59 -0400
Message-ID: <20260723044805.527643-39-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: Wd8Qge0lACvV9EQNyCLCtpsG0Hls6GU8BvZX1svBBU0_1784782473
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/virtio.json | 91 +++++++++++++++++++-----------------------------
 1 file changed, 36 insertions(+), 55 deletions(-)

diff --git a/qapi/virtio.json b/qapi/virtio.json
index 1fc4e38a44d..0a4753cc343 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -10,8 +10,7 @@
 
 ##
 # @VirtioInfo:
-#
-# Basic information about a given VirtIODevice
+#     Basic information about a given VirtIODevice
 #
 # @path: The VirtIODevice's canonical QOM path
 #
@@ -25,8 +24,7 @@
 
 ##
 # @x-query-virtio:
-#
-# Return a list of all realized VirtIODevices
+#     Return a list of all realized VirtIODevices
 #
 # Features:
 #
@@ -69,9 +67,8 @@
 
 ##
 # @VhostStatus:
-#
-# Information about a vhost device.  This information will only be
-# displayed if the vhost device is active.
+#     Information about a vhost device.  This information will only be
+#     displayed if the vhost device is active.
 #
 # @n-mem-sections: vhost_dev n_mem_sections
 #
@@ -112,10 +109,9 @@
 
 ##
 # @VirtioStatus:
-#
-# Full status of the virtio device with most VirtIODevice members.
-# Also includes the full status of the corresponding vhost device if
-# the vhost device is active.
+#     Full status of the virtio device with most VirtIODevice members.
+#     Also includes the full status of the corresponding vhost device
+#     if the vhost device is active.
 #
 # @name: VirtIODevice name
 #
@@ -189,8 +185,7 @@
 
 ##
 # @x-query-virtio-status:
-#
-# Poll for a comprehensive status of a given virtio device
+#     Poll for a comprehensive status of a given virtio device
 #
 # @path: Canonical QOM path of the VirtIODevice
 #
@@ -442,9 +437,8 @@
 
 ##
 # @VirtioDeviceStatus:
-#
-# A structure defined to list the configuration statuses of a virtio
-# device
+#     A structure defined to list the configuration statuses of a
+#     virtio device
 #
 # @statuses: List of decoded configuration statuses of the virtio
 #     device
@@ -460,9 +454,8 @@
 
 ##
 # @VhostDeviceProtocols:
-#
-# A structure defined to list the vhost user protocol features of a
-# Vhost User device
+#     A structure defined to list the vhost user protocol features of
+#     a Vhost User device
 #
 # @protocols: List of decoded vhost user protocol features of a vhost
 #     user device
@@ -478,9 +471,9 @@
 
 ##
 # @VirtioDeviceFeatures:
-#
-# The common fields that apply to most Virtio devices.  Some devices
-# may not have their own device-specific features (e.g. virtio-rng).
+#     The common fields that apply to most Virtio devices.  Some
+#     devices may not have their own device-specific features
+#     (e.g. virtio-rng).
 #
 # @transports: List of transport features of the virtio device
 #
@@ -503,9 +496,8 @@
 
 ##
 # @VirtQueueStatus:
-#
-# Information of a VirtIODevice VirtQueue, including most members of
-# the VirtQueue data structure.
+#     Information of a VirtIODevice VirtQueue, including most members
+#     of the VirtQueue data structure.
 #
 # @name: Name of the VirtIODevice that uses this VirtQueue
 #
@@ -556,8 +548,7 @@
 
 ##
 # @x-query-virtio-queue-status:
-#
-# Return the status of a given VirtIODevice's VirtQueue
+#     Return the status of a given VirtIODevice's VirtQueue
 #
 # @path: VirtIODevice canonical QOM path
 #
@@ -640,9 +631,8 @@
 
 ##
 # @VirtVhostQueueStatus:
-#
-# Information of a vhost device's vhost_virtqueue, including most
-# members of the vhost_dev vhost_virtqueue data structure.
+#     Information of a vhost device's vhost_virtqueue, including most
+#     members of the vhost_dev vhost_virtqueue data structure.
 #
 # @name: Name of the VirtIODevice that uses this vhost_virtqueue
 #
@@ -682,8 +672,7 @@
 
 ##
 # @x-query-virtio-vhost-queue-status:
-#
-# Return information of a given vhost device's vhost_virtqueue
+#     Return information of a given vhost device's vhost_virtqueue
 #
 # @path: VirtIODevice canonical QOM path
 #
@@ -746,8 +735,7 @@
 
 ##
 # @VirtioRingDesc:
-#
-# Information regarding the vring descriptor area
+#     Information regarding the vring descriptor area
 #
 # @addr: Guest physical address of the descriptor area
 #
@@ -764,8 +752,7 @@
 
 ##
 # @VirtioRingAvail:
-#
-# Information regarding the avail vring (a.k.a. driver area)
+#     Information regarding the avail vring (a.k.a. driver area)
 #
 # @flags: VRingAvail flags
 #
@@ -782,8 +769,7 @@
 
 ##
 # @VirtioRingUsed:
-#
-# Information regarding the used vring (a.k.a. device area)
+#     Information regarding the used vring (a.k.a. device area)
 #
 # @flags: VRingUsed flags
 #
@@ -797,9 +783,8 @@
 
 ##
 # @VirtioQueueElement:
-#
-# Information regarding a VirtQueue's VirtQueueElement including
-# descriptor, driver, and device areas
+#     Information regarding a VirtQueue's VirtQueueElement including
+#     descriptor, driver, and device areas
 #
 # @name: Name of the VirtIODevice that uses this VirtQueue
 #
@@ -822,8 +807,7 @@
 
 ##
 # @x-query-virtio-queue-element:
-#
-# Return the information about a VirtQueue's VirtQueueElement
+#     Return the information about a VirtQueue's VirtQueueElement
 #
 # @path: VirtIODevice canonical QOM path
 #
@@ -933,8 +917,7 @@
 
 ##
 # @IOThreadVirtQueueMapping:
-#
-# Describes the subset of virtqueues assigned to an IOThread.
+#     Describes the subset of virtqueues assigned to an IOThread.
 #
 # @iothread: the id of IOThread object
 #
@@ -951,13 +934,12 @@
 
 ##
 # @VirtIOGPUOutput:
-#
-# Describes configuration of a VirtIO GPU output.  If both @xres and
-# @yres are set, they take precedence over root virtio-gpu resolution
-# configuration and enable the corresponding output.  If none of @xres
-# and @yres are set, root virtio-gpu resolution configuration takes
-# precedence and only the first output is enabled.  Only setting one
-# of @xres or @yres is an error.
+#     Describes configuration of a VirtIO GPU output.  If both @xres
+#     and @yres are set, they take precedence over root virtio-gpu
+#     resolution configuration and enable the corresponding output.
+#     If none of @xres and @yres are set, root virtio-gpu resolution
+#     configuration takes precedence and only the first output is
+#     enabled.  Only setting one of @xres or @yres is an error.
 #
 # @name: the name of the output
 #
@@ -973,9 +955,8 @@
 
 ##
 # @DummyVirtioForceArrays:
-#
-# Not used by QMP; hack to let us use IOThreadVirtQueueMappingList and
-# VirtIOGPUOutputList internally
+#     Not used by QMP; hack to let us use IOThreadVirtQueueMappingList
+#     and VirtIOGPUOutputList internally
 #
 # Since: 9.0
 ##
-- 
2.55.0

