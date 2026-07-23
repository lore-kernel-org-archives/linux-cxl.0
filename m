Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C909A378824
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782398; cv=none; b=tGmfJadXpB0uCEJ4gG9eOVMvTMNcfrI+TtxhDAL8SzeNdz5MfutB3PcqK1Y6bVVfur635waGlmaf4k1cijyCtefkJe6+loi1C9jTVaN6TpWGtuCcxBglryrxyIhghzwxKv6msYoPTkPGNz0EdVYha2WSy12t+8NZAiRa9y36eLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782398; c=relaxed/simple;
	bh=QSwP5k8lm+kJRPLuPICnUYduiWsO2mfk15l2+jfguiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=GwkMXndPfxgS71Lcfzm+frxvQqEVpuG1hxPuy4BVCSis4DB+Rd6prL6yVHssvLbjfRlttMGM2kLlVlYMsCJl211V4gqaSC7XWY9lan2m+kZJm1j6jqngjavlSQ6pWAkPtg7I/EFRQSYQGaIiIwBum2CFMtgwZCaDBoMMfegvSy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IqqoqqAS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqqoqqAS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuLUJmRQbdL+tiBVb/y3st603k+nuJ/NK2BP1mGjFEM=;
	b=IqqoqqASdkQRI+R77welFyEcABVyWOKakwLcxRSUivq8MzaaABYN27IM5ljSDmLJZLaQff
	NOV557AlVHpJwFdesBpRAYUgNkQENS84bfphY7f2bD281xPep4yAYvQURYzRFMyYaTddFS
	2bqncjWY3s0U8YMsS9589OYwfR0vjww=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-CFvqc4DOO3CwZcM_zo-wjQ-1; Thu,
 23 Jul 2026 00:53:00 -0400
X-MC-Unique: CFvqc4DOO3CwZcM_zo-wjQ-1
X-Mimecast-MFC-AGG-ID: CFvqc4DOO3CwZcM_zo-wjQ_1784782377
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B2AC1805F18;
	Thu, 23 Jul 2026 04:52:57 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B996F18002B5;
	Thu, 23 Jul 2026 04:52:47 +0000 (UTC)
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
Subject: [PATCH v2 28/44] qapi: convert intro sections for rocker.json
Date: Thu, 23 Jul 2026 00:47:49 -0400
Message-ID: <20260723044805.527643-29-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: jbAj_E_eAtn0SG69EULKTXIz0KaxEcc8u9sZ6QmoTU8_1784782377
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/rocker.json | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/qapi/rocker.json b/qapi/rocker.json
index 5d2dbd26034..7eb0a88dafd 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -9,8 +9,7 @@
 
 ##
 # @RockerSwitch:
-#
-# Rocker switch information.
+#     Rocker switch information.
 #
 # @name: switch name
 #
@@ -25,8 +24,7 @@
 
 ##
 # @query-rocker:
-#
-# Return rocker switch information.
+#     Return rocker switch information.
 #
 # @name: switch name
 #
@@ -43,8 +41,7 @@
 
 ##
 # @RockerPortDuplex:
-#
-# An enumeration of port duplex states.
+#     An enumeration of port duplex states.
 #
 # @half: half duplex
 #
@@ -56,8 +53,7 @@
 
 ##
 # @RockerPortAutoneg:
-#
-# An enumeration of port autoneg states.
+#     An enumeration of port autoneg states.
 #
 # @off: autoneg is off
 #
@@ -69,8 +65,7 @@
 
 ##
 # @RockerPort:
-#
-# Rocker switch port information.
+#     Rocker switch port information.
 #
 # @name: port name
 #
@@ -93,8 +88,7 @@
 
 ##
 # @query-rocker-ports:
-#
-# Return rocker switch port information.
+#     Return rocker switch port information.
 #
 # @name: port name
 #
@@ -115,8 +109,7 @@
 
 ##
 # @RockerOfDpaFlowKey:
-#
-# Rocker switch OF-DPA flow key
+#     Rocker switch OF-DPA flow key
 #
 # @priority: key priority, 0 being lowest priority
 #
@@ -153,8 +146,7 @@
 
 ##
 # @RockerOfDpaFlowMask:
-#
-# Rocker switch OF-DPA flow mask
+#     Rocker switch OF-DPA flow mask
 #
 # @in-pport: physical input port
 #
@@ -182,8 +174,7 @@
 
 ##
 # @RockerOfDpaFlowAction:
-#
-# Rocker switch OF-DPA flow action
+#     Rocker switch OF-DPA flow action
 #
 # @goto-tbl: next table ID
 #
@@ -209,8 +200,7 @@
 
 ##
 # @RockerOfDpaFlow:
-#
-# Rocker switch OF-DPA flow
+#     Rocker switch OF-DPA flow
 #
 # @cookie: flow unique cookie ID
 #
@@ -230,8 +220,7 @@
 
 ##
 # @query-rocker-of-dpa-flows:
-#
-# Return rocker OF-DPA flow information.
+#     Return rocker OF-DPA flow information.
 #
 # @name: switch name
 #
@@ -261,8 +250,7 @@
 
 ##
 # @RockerOfDpaGroup:
-#
-# Rocker switch OF-DPA group
+#     Rocker switch OF-DPA group
 #
 # @id: group unique ID
 #
@@ -305,8 +293,7 @@
 
 ##
 # @query-rocker-of-dpa-groups:
-#
-# Return rocker OF-DPA group information.
+#     Return rocker OF-DPA group information.
 #
 # @name: switch name
 #
-- 
2.55.0

