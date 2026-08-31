Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F238C402
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 20:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207816; cv=none; b=EwJJkI2j7TxLJb0D0XO00HPBFc13hkHTu8a1p1QipJr7TZxcVw2dSvjTv4EOraJjnOmPelC/ZNzd7ol5XHmFFSCk5FwLW0iKakZ/4N96qTmwSvq4rzT3/Sz0N4u4t9VCBQovVp12dM2S2hUoCVk+QFTvri9UIujaKq3ll3O+WJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207816; c=relaxed/simple;
	bh=jIoEXhfg3T5FbpS85BDVzA2NIGSIWpX9vSusWDNKkcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Pap/ApYgvro0GUlJfGT8NYk9c+tnGXAW+keHuSaL4dGKE/ZH8wTQian6mywRHZIW6JZCMXRHFn8ItaahCOuxWA353HA4dINFzfAATxfr8IK4CBbF5uOR8bVxE+nl2M1fErcxdVKNZc/e2m8VZRU+JfyvkaKQaK2k7EIMjdDpc5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZmGZeXy/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmGZeXy/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788207813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=paUL78gCdpaCrvbsmed4HTHvmj42cb8WXYX01ka0V0s=;
	b=ZmGZeXy/VoqdAlszX+feZw3W1jxVaEEKjkxIKXcc8EjjJhHrhIMZ2uRltGUAYA1EtV8Mp9
	uZ56GBj1W2+P8fo88TcamGk48N8aKtqu9O7LgOoZv9kQYHlt9onGMe6pq1RV8s9lFsm2UW
	3CZwR2Qks8M7aTiHCRFPWx4ZvA0mgc4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-1POLMyqEOI2R_KshbGM8_A-1; Mon,
 31 Aug 2026 16:23:28 -0400
X-MC-Unique: 1POLMyqEOI2R_KshbGM8_A-1
X-Mimecast-MFC-AGG-ID: 1POLMyqEOI2R_KshbGM8_A_1788207804
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24F14196F741;
	Mon, 31 Aug 2026 20:23:16 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2DA391800347;
	Mon, 31 Aug 2026 20:23:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Jiri Pirko <jiri@resnulli.us>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	qemu-block@nongnu.org,
	Ani Sinha <anisinha@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	linux-cxl@vger.kernel.org,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	linux-edac@vger.kernel.org,
	Michael Tokarev <mjt@tls.msk.ru>,
	John Snow <jsnow@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Zhao Liu <zhao1.liu@intel.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	Eric Blake <eblake@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	qemu-trivial@nongnu.org,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 20/43] qapi: convert trivial intro sections for common.json
Date: Mon, 31 Aug 2026 16:19:22 -0400
Message-ID: <20260831201945.287730-21-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: QoR0aU4f0iYITa4ovyrmF1VNQiKEgsXwyauxtz4OMzg_1788207804
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/common.json | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index af7e3d618a7..c1bbed21e7f 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -9,8 +9,7 @@
 
 ##
 # @IoOperationType:
-#
-# An enumeration of the I/O operation types
+#     An enumeration of the I/O operation types
 #
 # @read: read operation
 #
@@ -23,8 +22,7 @@
 
 ##
 # @OnOffAuto:
-#
-# An enumeration of three options: on, off, and auto
+#     An enumeration of three options: on, off, and auto
 #
 # @auto: QEMU selects the value between on and off
 #
@@ -39,8 +37,7 @@
 
 ##
 # @OnOffSplit:
-#
-# An enumeration of three values: on, off, and split
+#     An enumeration of three values: on, off, and split
 #
 # @on: Enabled
 #
@@ -72,8 +69,7 @@
 
 ##
 # @OffAutoPCIBAR:
-#
-# An enumeration of options for specifying a PCI BAR
+#     An enumeration of options for specifying a PCI BAR
 #
 # @off: The specified feature is disabled
 #
@@ -98,8 +94,7 @@
 
 ##
 # @PCIELinkSpeed:
-#
-# An enumeration of PCIe link speeds in units of GT/s
+#     An enumeration of PCIe link speeds in units of GT/s
 #
 # @2_5: 2.5GT/s
 #
@@ -120,8 +115,7 @@
 
 ##
 # @PCIELinkWidth:
-#
-# An enumeration of PCIe link width
+#     An enumeration of PCIe link width
 #
 # @1: x1
 #
@@ -144,8 +138,7 @@
 
 ##
 # @HostMemPolicy:
-#
-# Host memory policy types
+#     Host memory policy types
 #
 # @default: restore default policy, remove any nondefault policy
 #
@@ -164,9 +157,8 @@
 
 ##
 # @NetFilterDirection:
-#
-# Indicates whether a netfilter is attached to a netdev's transmit
-# queue or receive queue or both.
+#     Indicates whether a netfilter is attached to a netdev's transmit
+#     queue or receive queue or both.
 #
 # @all: the filter is attached both to the receive and the transmit
 #     queue of the netdev (default).
@@ -184,8 +176,7 @@
 
 ##
 # @GrabToggleKeys:
-#
-# Key combinations to toggle input-linux between host and guest.
+#     Key combinations to toggle input-linux between host and guest.
 #
 # @ctrl-ctrl: left and right control key
 #
-- 
2.55.0

