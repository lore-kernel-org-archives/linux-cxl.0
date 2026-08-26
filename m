Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB02734C815
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773251; cv=none; b=kWX5K8irg1PS2I+I9aoxjm+4y7jNnD3XPsBT1b9vsH6v3nYe2Yh9eUbE6XUbH/wyW57gQ9v+0nHJRZrZxRc3rhIoc6VvFiaM77b/DiMBtZ1b0+mqOPwX1GSuG8MjG45cTFJYz5TFaFq7gce9OMmWvp5miByYD/y73Nk5ClFYTSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773251; c=relaxed/simple;
	bh=uOnf/P0OhLDoQz059nKqY8FxATv5BMoN2IWUr5cW+ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=qfkyAZkGpXpAVrOmtfb5htMmdqDz68m0aDgdcrf6kjjUmHNaamldG9BATOledQw/zqrS7vWf6KQvEI7JwyqKaYg7U9ir4Uw9kxWWUAbY/f9L5EKjwsB/Z1JXBnGVSkxB7PuCfrVOARDrgjBw6DOTPrCqHU6w02QKtkubrdx6ANE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QO2IIG9z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QO2IIG9z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LP0y4v8jmqtQgtGKTsDsubE5wWn5Ceq68Y6ZJT6Kt38=;
	b=QO2IIG9zfruu9NG8JnJl9RRSAWeXozxIcbKLBDrad/YTgiktzHbbh2r3V6HdMZaYf8/+Tk
	CiTTi9jEThNzBTLfaNSNh1E+Njw8qyb9+xNdUH7VS7m0z1JZqRGwTRaC3RsoX2OVAm2Y3B
	761nyCo3TXDZTgJrBWgFsSCV7cYHF2M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-Jlghz7u6NxC2k85RWtN2vw-1; Wed,
 26 Aug 2026 15:40:32 -0400
X-MC-Unique: Jlghz7u6NxC2k85RWtN2vw-1
X-Mimecast-MFC-AGG-ID: Jlghz7u6NxC2k85RWtN2vw_1787773229
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B2771955F16;
	Wed, 26 Aug 2026 19:40:28 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1739F1800598;
	Wed, 26 Aug 2026 19:40:18 +0000 (UTC)
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
Subject: [PATCH v3 10/43] qapi: convert trivial intro sections for accelerator.json
Date: Wed, 26 Aug 2026 15:38:07 -0400
Message-ID: <20260826193840.2152000-11-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: X3vCYO2yb_sBj2haMmC4AImZ6JmA2aLfvVhYIGfCsZk_1787773229
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/accelerator.json | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/qapi/accelerator.json b/qapi/accelerator.json
index b59df378664..efc0fa81418 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -13,8 +13,7 @@
 
 ##
 # @KvmInfo:
-#
-# Information about support for KVM acceleration
+#     Information about support for KVM acceleration
 #
 # @enabled: true if KVM acceleration is active
 #
@@ -26,8 +25,7 @@
 
 ##
 # @query-kvm:
-#
-# Return information about KVM acceleration
+#     Return information about KVM acceleration
 #
 # Features:
 #
@@ -46,8 +44,7 @@
 
 ##
 # @x-accel-stats:
-#
-# Query accelerator statistics
+#     Query accelerator statistics
 #
 # Features:
 #
@@ -63,8 +60,7 @@
 
 ##
 # @Accelerator:
-#
-# Information about support for MSHV acceleration
+#     Information about support for MSHV acceleration
 #
 # @hvf: Apple Hypervisor.framework
 #
@@ -88,8 +84,7 @@
 
 ##
 # @AcceleratorInfo:
-#
-# Information about support for various accelerators
+#     Information about support for various accelerators
 #
 # @enabled: the accelerator that is in use
 #
@@ -102,8 +97,7 @@
 
 ##
 # @query-accelerators:
-#
-# Return information about accelerators
+#     Return information about accelerators
 #
 # Returns: @AcceleratorInfo
 #
-- 
2.55.0

