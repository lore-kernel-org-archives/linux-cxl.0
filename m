Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374147D952
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773400; cv=none; b=P47kfj7/fJAkHWTX0OZyZROysj1RrMkfSB2bu9h6UZCxlsvWh22OyMgGSF6PPE5WZC4mTIH8tkOGtb3OA0UgLypO040jaF+3wnog0/T8h7u87QOtNdAvAlzpekTHhek0pSp6+UVA/hWomN5FvtNu0CTsAJA9Mr0v08p1vAN1jsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773400; c=relaxed/simple;
	bh=7GXJV9ItQtBWAgiWgOooTb0fgfb4niwoxPhBWZ4J3cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=CfFH+Dt57T43BgqGyYbVYYO07gVjRYVb9JWhWslnQWWcFOcSUPRieI89Xq6T0wWyWP5HzMMSpFIVf3lJqtVwrYTIsfUnN0lf04yZXxrJSLCBmC21nfjevJYMwKIv755KIFY4oFkdF5RZ7kZyC2iW4I3c3flTTzfLWMYJQDrntCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+v3Xf3Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+v3Xf3Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cMeGh8F13Z46uyER7y88/d0ISiPeR9CDwXqnRAPj7ik=;
	b=D+v3Xf3Ytp92iMhPwtw/0gW/FjG+2N53HpV0i/EAZm7ZDp9hTdG0PrMA5KPoVmZ73CGt28
	OCrU0xPBKLxzkjJhpmQR75K7t4euIzNYIVndNBIZ465Ig0t/xslqIQnMzcgQUcbiML/Mou
	X6XFDUwwkDZWGPN7KkiBWQNMVzR06rk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-RGEfCt-ZN6WwwuYaFA6nYg-1; Wed,
 26 Aug 2026 15:43:01 -0400
X-MC-Unique: RGEfCt-ZN6WwwuYaFA6nYg-1
X-Mimecast-MFC-AGG-ID: RGEfCt-ZN6WwwuYaFA6nYg_1787773377
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06932195396C;
	Wed, 26 Aug 2026 19:42:57 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4EFA61800577;
	Wed, 26 Aug 2026 19:42:49 +0000 (UTC)
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
Subject: [PATCH v3 28/43] qapi: convert trivial intro sections for misc-i386.json
Date: Wed, 26 Aug 2026 15:38:25 -0400
Message-ID: <20260826193840.2152000-29-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: upaIS2UfltkvSsG6jAOqUpjLXLo1N_4iZkl8TkFZSF8_1787773377
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

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

