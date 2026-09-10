Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8423911DC
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789072783; cv=none; b=u2DiNAO4i/+HH/48mDt7gSE8yjlBtzMw9cdX715Tjx00jYkPLMBmHNOt5HzDYSiruqOw8m+Wv4IfWnFRQoyF36O3iCLpjY1UcPGcmnqNN7cnpII96GYXDMSObiJZ8owdk5oBgPB25b+qiystVCF9wjlDy0ry9Q2bRztasgciBKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789072783; c=relaxed/simple;
	bh=oUzm/cdNQt5tv3mPnb0UMOMH5EoIGTLYVUwA4/YF8XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=R4oVQfVImeoIJKmuN8zWtFxNspAFIA7t+4+MWlFIkxZkfdVfI5V7fuIYd7lp1raN4JHU2LdfeKLOb5YX/Qh4IMWkTgfhMdk0eHS4WtBWoy0EBo7WQCR8LsrmJ7/gIG53IvW8m8XnUlqM2atQcd/bFTZffNBhQptg+rxg7ROeSuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTDvIK8G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTDvIK8G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789072778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nw7JEpbtaai2fySGK5XqeVhBPUXDsLTe8heCM5m/fpo=;
	b=JTDvIK8G/s080OsBnO3ND9D0tyI0jkAIEbukWXZpeUiXOJRf1wOgwnUzXkRlB7xW8rXSgn
	ngqWLAuebwFbP/kHgJfZ8pdnWebz2K77TP3LKLWHJZnWMCMvfbBg76kL+rZtBSw8kJAOyc
	15zhd9z1h6TbxouJlLR7QQ/zW5AGuCo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-wzACXLQ3M8G_wjvS3J720w-1; Thu,
 10 Sep 2026 16:39:35 -0400
X-MC-Unique: wzACXLQ3M8G_wjvS3J720w-1
X-Mimecast-MFC-AGG-ID: wzACXLQ3M8G_wjvS3J720w_1789072774
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02E51180067B;
	Thu, 10 Sep 2026 20:39:34 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.67])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 37B4046E;
	Thu, 10 Sep 2026 20:39:31 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-cxl@vger.kernel.org,
	Zhao Liu <zhao1.liu@intel.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>,
	Markus Armbruster <armbru@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	qemu-block@nongnu.org,
	Ani Sinha <anisinha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 07/10] qapi: convert simple data struct intros for virtio.json
Date: Thu, 10 Sep 2026 16:38:53 -0400
Message-ID: <20260910203856.99003-8-jsnow@redhat.com>
In-Reply-To: <20260910203856.99003-1-jsnow@redhat.com>
References: <20260910203856.99003-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: E21ZreaIJ3m2AWqrJiplAzluIq5eqoAR4BJzVzV8gAk_1789072774
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/virtio.json | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/qapi/virtio.json b/qapi/virtio.json
index 9aafc3a212f..0a4753cc343 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -67,9 +67,8 @@
 
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
@@ -110,10 +109,9 @@
 
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
@@ -473,9 +471,9 @@
 
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
@@ -754,8 +752,7 @@
 
 ##
 # @VirtioRingAvail:
-#
-# Information regarding the avail vring (a.k.a. driver area)
+#     Information regarding the avail vring (a.k.a. driver area)
 #
 # @flags: VRingAvail flags
 #
@@ -772,8 +769,7 @@
 
 ##
 # @VirtioRingUsed:
-#
-# Information regarding the used vring (a.k.a. device area)
+#     Information regarding the used vring (a.k.a. device area)
 #
 # @flags: VRingUsed flags
 #
@@ -938,13 +934,12 @@
 
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
-- 
2.55.0

