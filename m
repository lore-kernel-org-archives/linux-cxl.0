Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721F337FF4E
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782403; cv=none; b=fKAsvdlWpIdvPYaSDs5d38ZbL7OxOY4yAnPe2Y+thjK5Iz30fCV794qSIBIeoZQ1Di2zIpJ0HaSCGuN6h1O8ELt/F9m1ruKj8XgUyRsuEhUIknflFHonqyhRQq3Ag8lAwNV2w/CAZJB2jmtZuPEPMzpPGqdGRvzr8GwAccsi9TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782403; c=relaxed/simple;
	bh=HFHzEvr20N8mbkFQJGSIYei8K90IICTBIU/XQ2h/97I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QGBTlJQEQCh9GLenV6kUBN1Gw9Es/lphBAv/vL52SLA5B1XbuR7m+DjTq+81UF9KT2pZasKc9lA+T8CcugZQVE81FgsJOFnkraFIETNyD7WR/2rkkCr/xZ4ynL7cXVrcgET0p47WDHVqqABx+o7rpsvLuSaSsmIWbG5Juv89hSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DmywqsS9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmywqsS9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZNZu5l6HDHHmDozotlg5GKJJCb4xlZSAIjE4YcKWdo=;
	b=DmywqsS9nccRS2SdO4jb4w2YEJ+pGdynWPbVWpv/pQpCvj2WE3kgYU5dNdPtm/rWP89JBa
	BwKaQDLUUqHYt++qLf6IXMPfsHZEyngxA99QRyUOQMia/JE07UURMtc/60HXvl/SOIJVAc
	8fD38O1VK8IYweXhn6QEq9Qp/Kr9oAU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-JDYUe2VaNfGJJkoGCkgShQ-1; Thu,
 23 Jul 2026 00:53:08 -0400
X-MC-Unique: JDYUe2VaNfGJJkoGCkgShQ-1
X-Mimecast-MFC-AGG-ID: JDYUe2VaNfGJJkoGCkgShQ_1784782385
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD0971944DCE;
	Thu, 23 Jul 2026 04:53:05 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A71CC18002AE;
	Thu, 23 Jul 2026 04:52:57 +0000 (UTC)
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
Subject: [PATCH v2 29/44] qapi: convert trivial intro sections for misc-i386.json
Date: Thu, 23 Jul 2026 00:47:50 -0400
Message-ID: <20260723044805.527643-30-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: OrSAZJraLFvMyg66naucBKeMkSstN29N_KYsemCMLXQ_1784782385
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/misc-i386.json | 52 ++++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 34 deletions(-)

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 05a94d6c416..78ec9aec647 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -25,8 +25,7 @@
 
 ##
 # @SevState:
-#
-# An enumeration of SEV state information used during `query-sev`.
+#     An enumeration of SEV state information used during `query-sev`.
 #
 # @uninit: The guest is uninitialized.
 #
@@ -52,8 +51,7 @@
 
 ##
 # @SevGuestType:
-#
-# An enumeration indicating the type of SEV guest being run.
+#     An enumeration indicating the type of SEV guest being run.
 #
 # @sev: The guest is a legacy SEV or SEV-ES guest.
 #
@@ -66,8 +64,7 @@
 
 ##
 # @SevGuestInfo:
-#
-# Information specific to legacy SEV/SEV-ES guests.
+#     Information specific to legacy SEV/SEV-ES guests.
 #
 # @policy: SEV policy value
 #
@@ -81,8 +78,7 @@
 
 ##
 # @SevSnpGuestInfo:
-#
-# Information specific to SEV-SNP guests.
+#     Information specific to SEV-SNP guests.
 #
 # @snp-policy: SEV-SNP policy value
 #
@@ -93,8 +89,7 @@
 
 ##
 # @SevInfo:
-#
-# Information about Secure Encrypted Virtualization (SEV) support
+#     Information about Secure Encrypted Virtualization (SEV) support
 #
 # @enabled: true if SEV is active
 #
@@ -144,8 +139,7 @@
 
 ##
 # @SevLaunchMeasureInfo:
-#
-# SEV Guest Launch measurement information
+#     SEV Guest Launch measurement information
 #
 # @data: the measurement value encoded in base64
 #
@@ -180,9 +174,8 @@
 
 ##
 # @SevCapability:
-#
-# The struct describes capability for a Secure Encrypted
-# Virtualization feature.
+#     The struct describes capability for a Secure Encrypted
+#     Virtualization feature.
 #
 # @pdh: Platform Diffie-Hellman key (base64 encoded)
 #
@@ -252,9 +245,8 @@
 
 ##
 # @SevAttestationReport:
-#
-# The struct describes attestation report for a Secure Encrypted
-# Virtualization feature.
+#     The struct describes attestation report for a Secure Encrypted
+#     Virtualization feature.
 #
 # @data: guest attestation report (base64 encoded)
 #
@@ -294,8 +286,7 @@
 
 ##
 # @SgxEpcSection:
-#
-# Information about intel SGX EPC section
+#     Information about intel SGX EPC section
 #
 # @node: the numa node
 #
@@ -309,8 +300,7 @@
 
 ##
 # @SgxInfo:
-#
-# Information about intel Safe Guard eXtension (SGX) support
+#     Information about intel Safe Guard eXtension (SGX) support
 #
 # @sgx: true if SGX is supported
 #
@@ -333,8 +323,7 @@
 
 ##
 # @query-sgx:
-#
-# Return information about configured SGX capabilities of guest
+#     Return information about configured SGX capabilities of guest
 #
 # Since: 6.2
 #
@@ -350,8 +339,7 @@
 
 ##
 # @query-sgx-capabilities:
-#
-# Return information about SGX capabilities of host
+#     Return information about SGX capabilities of host
 #
 # Since: 6.2
 #
@@ -367,8 +355,7 @@
 
 ##
 # @EvtchnPortType:
-#
-# An enumeration of Xen event channel port types.
+#     An enumeration of Xen event channel port types.
 #
 # @closed: The port is unused.
 #
@@ -389,8 +376,7 @@
 
 ##
 # @EvtchnInfo:
-#
-# Information about a Xen event channel port
+#     Information about a Xen event channel port
 #
 # @port: the port number
 #
@@ -419,8 +405,7 @@
 
 ##
 # @xen-event-list:
-#
-# Query the Xen event channels opened by the guest.
+#     Query the Xen event channels opened by the guest.
 #
 # Returns: list of open event channel ports.
 #
@@ -456,8 +441,7 @@
 
 ##
 # @xen-event-inject:
-#
-# Inject a Xen event channel port (interrupt) to the guest.
+#     Inject a Xen event channel port (interrupt) to the guest.
 #
 # @port: The port number
 #
-- 
2.55.0

