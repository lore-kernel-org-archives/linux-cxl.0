Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B7447ECC5
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773465; cv=none; b=joNMhE1eWTgoyremNGd6lZGE615vpsUBIZIRscUrmTxnhAzL9Xvw2BMO63OuBg/OSsAZzuJZhn7973EbLc3JaDgkmaAQN+soaD+LS/LOf/1KA3ZhqE2Drz9AkK4DKflbv9UCvoBTCjg7KLLlnoBA9R6gYPiP3LuRszhlSTTXWmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773465; c=relaxed/simple;
	bh=esSfvE3+7/P7ya51PfBNKPTUbnV/xG/9pEJC8GXz/Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Cwc3puReJF2DAJbbQgBPvWkz/mph6oim4pn8o2D0RoJ4uo/vxTFFr3CAbAZFKvndo0O72uDh3Asol5zY3hRvIxQ+oLSE4/84GMQa5L1/ORPGTI2hnY2Qh6q8x4hQX8xuChFJ62rsbCebPF8aZVk9qkI3Huyoy2APiw4h8HcHLa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PcNfKCXW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcNfKCXW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pS3gWzM2OpSimpBSFZGIbBPCkdQIT5l3gW1iVRp02q8=;
	b=PcNfKCXWmbROQWNSsztLlVqFWFBAy2+agDY6iwyRwimwD6IEnY1d1Idmbu/S2LqDgiV2Mf
	8g9aUlQV9hOVbNuGYDFdF/4nhPE8LhI8E0eoGZv8ganfGhxGCjbpjsdGyudj7MROXfq7vz
	B+IK6w6Mx+t1fV+DwBjf7GcfTPnxRnw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-9hQ9G9TcMpC1SM688cQ5Cw-1; Wed,
 26 Aug 2026 15:44:02 -0400
X-MC-Unique: 9hQ9G9TcMpC1SM688cQ5Cw-1
X-Mimecast-MFC-AGG-ID: 9hQ9G9TcMpC1SM688cQ5Cw_1787773439
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F9621855124;
	Wed, 26 Aug 2026 19:43:59 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79D201800577;
	Wed, 26 Aug 2026 19:43:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	John Snow <jsnow@redhat.com>,
	linux-cxl@vger.kernel.org,
	Markus Armbruster <armbru@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	qemu-trivial@nongnu.org,
	Fabiano Rosas <farosas@suse.de>,
	Kevin Wolf <kwolf@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Jiri Pirko <jiri@resnulli.us>,
	qemu-block@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	linux-edac@vger.kernel.org,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Zhao Liu <zhao1.liu@intel.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Lukas Straub <lukasstraub2@web.de>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 37/43] qapi: convert trivial intro sections for virtio.json
Date: Wed, 26 Aug 2026 15:38:34 -0400
Message-ID: <20260826193840.2152000-38-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: ENjIR69eaJvTRn5l-1HIi6Z3uvDrcW4_iTvw_6pFPn0_1787773439
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/virtio.json | 54 ++++++++++++++++++------------------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

diff --git a/qapi/virtio.json b/qapi/virtio.json
index 1fc4e38a44d..9aafc3a212f 100644
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
@@ -189,8 +187,7 @@
 
 ##
 # @x-query-virtio-status:
-#
-# Poll for a comprehensive status of a given virtio device
+#     Poll for a comprehensive status of a given virtio device
 #
 # @path: Canonical QOM path of the VirtIODevice
 #
@@ -442,9 +439,8 @@
 
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
@@ -460,9 +456,8 @@
 
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
@@ -503,9 +498,8 @@
 
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
@@ -556,8 +550,7 @@
 
 ##
 # @x-query-virtio-queue-status:
-#
-# Return the status of a given VirtIODevice's VirtQueue
+#     Return the status of a given VirtIODevice's VirtQueue
 #
 # @path: VirtIODevice canonical QOM path
 #
@@ -640,9 +633,8 @@
 
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
@@ -682,8 +674,7 @@
 
 ##
 # @x-query-virtio-vhost-queue-status:
-#
-# Return information of a given vhost device's vhost_virtqueue
+#     Return information of a given vhost device's vhost_virtqueue
 #
 # @path: VirtIODevice canonical QOM path
 #
@@ -746,8 +737,7 @@
 
 ##
 # @VirtioRingDesc:
-#
-# Information regarding the vring descriptor area
+#     Information regarding the vring descriptor area
 #
 # @addr: Guest physical address of the descriptor area
 #
@@ -797,9 +787,8 @@
 
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
@@ -822,8 +811,7 @@
 
 ##
 # @x-query-virtio-queue-element:
-#
-# Return the information about a VirtQueue's VirtQueueElement
+#     Return the information about a VirtQueue's VirtQueueElement
 #
 # @path: VirtIODevice canonical QOM path
 #
@@ -933,8 +921,7 @@
 
 ##
 # @IOThreadVirtQueueMapping:
-#
-# Describes the subset of virtqueues assigned to an IOThread.
+#     Describes the subset of virtqueues assigned to an IOThread.
 #
 # @iothread: the id of IOThread object
 #
@@ -973,9 +960,8 @@
 
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

