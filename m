Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458D03AD509
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291855; cv=none; b=e89YfAgRK4/VD4dxOHNAsfRrZzsky5GpIPaTtV5omtULQzJZFpp/AnnAgZ7kW6hKr2sr2XVbFtlgng9Wn8AVYL/cBbpnPFiIvfQmSr4o/6rTIH7OqGvjB4Rap3cVG8wn7EGi2ybxSIPUJRNjbKU0vTs1huKTvSD6db3tOHTmRvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291855; c=relaxed/simple;
	bh=a6wuDyCEx8i2FtKE+mm6o4VdM29rZIKrcyFc/WBDBYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=PTAkw+wT5HS+1pPtHH7nrwtTDCXTHS1/GFfTX0vMRAp6dJM2FV6bFLkyjHNuCyQST9TPPxjmdhcwrEyQatXu5cMMLc0tc3mLn4TD79Ri36mn3tOHeBZoj1IC2Wq9t6Z4Jrs/Fo3Xs7xaGiM54QFdSvXOHSUx8Ubsl3H48mL2Ogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QatW64y5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QatW64y5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788291853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oxB0WnpYsMCA8Y8mBhhLF3LrR7eMjZay6oToephObeY=;
	b=QatW64y5vJb6s0AePjp3Km3S3R+tUIWuQ9l3BS8SV4aArflmjOScJhR3wrTOt+uU4YBC5X
	fp03BGkb07fPNCy5lDUVoESdmwD+AXvy62m+tkg3L5miwSRK1q8KIcFXvsqC/8Vl623yzg
	TCGQxcp+4cN/jA03MkwkrW2C9jIKvtU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-6GnqxVBPM3SQ0s9wKS0RBg-1; Tue,
 01 Sept 2026 15:44:11 -0400
X-MC-Unique: 6GnqxVBPM3SQ0s9wKS0RBg-1
X-Mimecast-MFC-AGG-ID: 6GnqxVBPM3SQ0s9wKS0RBg_1788291850
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 818AD1809C8B;
	Tue,  1 Sep 2026 19:44:09 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8DA8A18005BD;
	Tue,  1 Sep 2026 19:44:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Ani Sinha <anisinha@redhat.com>,
	qemu-block@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>,
	Fabiano Rosas <farosas@suse.de>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Peter Xu <peterx@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 08/12] qapi: convert simple command intros for cxl.json
Date: Tue,  1 Sep 2026 15:43:20 -0400
Message-ID: <20260901194324.458482-9-jsnow@redhat.com>
In-Reply-To: <20260901194324.458482-1-jsnow@redhat.com>
References: <20260901194324.458482-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: ogT7deLrly-rm5utZrrMdC_pT9TNFuHZBNK13Mf8Svk_1788291850
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/cxl.json | 74 +++++++++++++++++++++++----------------------------
 1 file changed, 34 insertions(+), 40 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index aef849a4c2a..58ad82c2dc7 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -118,10 +118,9 @@
 
 ##
 # @cxl-inject-general-media-event:
-#
-# Inject an event record for a General Media Event (CXL r3.2
-# 8.2.10.2.1.1).  This event type is reported via one of the event
-# logs specified via the log parameter.
+#     Inject an event record for a General Media Event (CXL r3.2
+#     8.2.10.2.1.1).  This event type is reported via one of the event
+#     logs specified via the log parameter.
 #
 # Since: 8.1
 ##
@@ -201,10 +200,9 @@
 
 ##
 # @cxl-inject-dram-event:
-#
-# Inject an event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
-# This event type is reported via one of the event logs
-# specified via the log parameter.
+#     Inject an event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
+#     This event type is reported via one of the event logs specified
+#     via the log parameter.
 #
 # Since: 8.1
 ##
@@ -267,10 +265,9 @@
 
 ##
 # @cxl-inject-memory-module-event:
-#
-# Inject an event record for a Memory Module Event (CXL r3.2
-# 8.2.10.2.1.3).  This event includes a copy of the Device Health info
-# at the time of the event.
+#     Inject an event record for a Memory Module Event (CXL r3.2
+#     8.2.10.2.1.3).  This event includes a copy of the Device Health
+#     info at the time of the event.
 #
 # Since: 8.1
 ##
@@ -279,13 +276,12 @@
 
 ##
 # @cxl-inject-poison:
-#
-# Poison records indicate that a CXL memory device knows that a
-# particular memory region may be corrupted.  This may be because of
-# locally detected errors (e.g. ECC failure) or poisoned writes
-# received from other components in the system.  This injection
-# mechanism enables testing of the OS handling of poison records which
-# may be queried via the CXL mailbox.
+#     Poison records indicate that a CXL memory device knows that a
+#     particular memory region may be corrupted.  This may be because
+#     of locally detected errors (e.g. ECC failure) or poisoned writes
+#     received from other components in the system.  This injection
+#     mechanism enables testing of the OS handling of poison records
+#     which may be queried via the CXL mailbox.
 #
 # @path: CXL type 3 device canonical QOM path
 #
@@ -382,9 +378,8 @@
 
 ##
 # @cxl-inject-uncorrectable-errors:
-#
-# Command to allow injection of multiple errors in one go.  This
-# allows testing of multiple header log handling in the OS.
+#     Command to allow injection of multiple errors in one go.  This
+#     allows testing of multiple header log handling in the OS.
 #
 # @path: CXL Type 3 device canonical QOM path
 #
@@ -430,12 +425,11 @@
 
 ##
 # @cxl-inject-correctable-error:
-#
-# Command to inject a single correctable error.  Multiple error
-# injection of this error type is not interesting as there is no
-# associated header log.  These errors are reported via AER as a
-# correctable internal error, with additional detail available from
-# the CXL device.
+#     Command to inject a single correctable error.  Multiple error
+#     injection of this error type is not interesting as there is no
+#     associated header log.  These errors are reported via AER as a
+#     correctable internal error, with additional detail available
+#     from the CXL device.
 #
 # @path: CXL Type 3 device canonical QOM path
 #
@@ -510,12 +504,12 @@
 
 ##
 # @cxl-add-dynamic-capacity:
-#
-# Initiate adding dynamic capacity extents to a host.  This simulates
-# operations defined in Compute Express Link (CXL) Specification,
-# Revision 3.1, Section 7.6.7.6.5.  Note that, currently, establishing
-# success or failure of the full Add Dynamic Capacity flow requires
-# out of band communication with the OS of the CXL host.
+#     Initiate adding dynamic capacity extents to a host.  This
+#     simulates operations defined in Compute Express Link (CXL)
+#     Specification, Revision 3.1, Section 7.6.7.6.5.  Note that,
+#     currently, establishing success or failure of the full Add
+#     Dynamic Capacity flow requires out of band communication with
+#     the OS of the CXL host.
 #
 # @path: path to the CXL Dynamic Capacity Device in the QOM tree.
 #
@@ -576,12 +570,12 @@
 
 ##
 # @cxl-release-dynamic-capacity:
-#
-# Initiate release of dynamic capacity extents from a host.  This
-# simulates operations defined in Compute Express Link (CXL)
-# Specification, Revision 3.1, Section 7.6.7.6.6.  Note that,
-# currently, success or failure of the full Release Dynamic Capacity
-# flow requires out of band communication with the OS of the CXL host.
+#     Initiate release of dynamic capacity extents from a host.  This
+#     simulates operations defined in Compute Express Link (CXL)
+#     Specification, Revision 3.1, Section 7.6.7.6.6.  Note that,
+#     currently, success or failure of the full Release Dynamic
+#     Capacity flow requires out of band communication with the OS of
+#     the CXL host.
 #
 # @path: path to the CXL Dynamic Capacity Device in the QOM tree.
 #
-- 
2.55.0

