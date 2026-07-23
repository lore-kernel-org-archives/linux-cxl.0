Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD9A37F726
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782464; cv=none; b=TgAp/Osbs3xKxBe+nYP34zQNqDCXqU59Gv2DrtLYc+sJkJH/d4DqkRSux6RvnNmHEGaEMIIpfKg7LaaIalFief6oRCtwQtjBq01zLp+71DOwHNRXpezvo2Q9tjA4kvBuWr5++4kVYqAT1G4rfzQSVJhDw3oSBXgcQcIuZO2tADI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782464; c=relaxed/simple;
	bh=Fq+3O29G5SBOq9+tHB8zjfnpsao/PF4MUjhaJbRCYZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=SdgRIGpUipLMApY60Usxw4YgYx6rHZi5b3MiIgB98nmoKAgeEuoR+O8AhnoBs0i8J41UBTXVjYBz4fMsQXJ1PDYs3AZoQhMxtslIyYmxGBS9C0rk077FKX1uuR4vHXxqcy7gqEqK1KuqNkA+S3+45C4hjf8q070kaYG3/ogwqss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iA/LCEzA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iA/LCEzA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QarlhGnhBJh2uFLeYPSVEUbavGwmNcs8TuDveYf+Ky0=;
	b=iA/LCEzAfAmQO2YDPdq4JA0l4Q3dOAXk3JWa+qzDGdl79iEPrMCdNgxUuV9/8YUnyZvIjt
	jgSb19qNdxRrfrRxrnIfAYdnfue8Y3wA7EDo0PQTWnik0lo+S6KKD82iL8aJz5QazRQJAF
	5RY5IZnr3VooxD/xk0zf7dfUMM4Dg6Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-ZDwcKhefPIqMArqUkbP7BQ-1; Thu,
 23 Jul 2026 00:54:09 -0400
X-MC-Unique: ZDwcKhefPIqMArqUkbP7BQ-1
X-Mimecast-MFC-AGG-ID: ZDwcKhefPIqMArqUkbP7BQ_1784782446
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DF79182E6BB;
	Thu, 23 Jul 2026 04:54:06 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D89C18002AE;
	Thu, 23 Jul 2026 04:53:56 +0000 (UTC)
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
Subject: [PATCH v2 35/44] qapi: convert intro sections for cxl.json
Date: Thu, 23 Jul 2026 00:47:56 -0400
Message-ID: <20260723044805.527643-36-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: Ec5dbKZXS8C9BsRZ24v1r1mc1qLT3RdUB9Gff2T9qxc_1784782446
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/cxl.json | 128 ++++++++++++++++++++++----------------------------
 1 file changed, 56 insertions(+), 72 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 81d6198ba03..9422d5a0e2d 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -9,9 +9,9 @@
 
 ##
 # @CxlEventLog:
-#
-# CXL has a number of separate event logs for different types of
-# events.  Each such event log is handled and signaled independently.
+#     CXL has a number of separate event logs for different types of
+#     events.  Each such event log is handled and signaled
+#     independently.
 #
 # @informational: Information Event Log
 #
@@ -32,9 +32,8 @@
 
 ##
 # @CXLCommonEventBase:
-#
-# Common event base for a CXL Event (CXL r3.2 8.2.10.2.1
-# Table 8-55 Common Event Record Format).
+#     Common event base for a CXL Event (CXL r3.2 8.2.10.2.1 Table
+#     8-55 Common Event Record Format).
 #
 # @path: CXL type 3 device canonical QOM path
 #
@@ -63,8 +62,7 @@
 
 ##
 # @CXLGeneralMediaEvent:
-#
-# Event record for a General Media Event (CXL r3.2 8.2.10.2.1.1).
+#     Event record for a General Media Event (CXL r3.2 8.2.10.2.1.1).
 #
 # @dpa: Device Physical Address (relative to @path device).  Note
 #     lower bits include some flags.  See CXL r3.2 Table 8-57 General
@@ -118,10 +116,9 @@
 
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
@@ -130,8 +127,7 @@
 
 ##
 # @CXLDRAMEvent:
-#
-# Event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
+#     Event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
 #
 # @dpa: Device Physical Address (relative to @path device).  Note
 #     lower bits include some flags.  See CXL r3.2 Table 8-58 DRAM
@@ -201,10 +197,9 @@
 
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
@@ -213,8 +208,7 @@
 
 ##
 # @CXLMemModuleEvent:
-#
-# Event record for a Memory Module Event (CXL r3.2 8.2.10.2.1.3).
+#     Event record for a Memory Module Event (CXL r3.2 8.2.10.2.1.3).
 #
 # @type: Device Event Type.  See CXL r3.2 Table 8-59 Memory Module
 #     Event Record for bit definitions for bit definiions.
@@ -267,10 +261,9 @@
 
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
@@ -279,13 +272,12 @@
 
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
@@ -300,10 +292,9 @@
 
 ##
 # @CxlUncorErrorType:
-#
-# Type of uncorrectable CXL error to inject.  These errors are
-# reported via an AER uncorrectable internal error with additional
-# information logged at the CXL device.
+#     Type of uncorrectable CXL error to inject.  These errors are
+#     reported via an AER uncorrectable internal error with additional
+#     information logged at the CXL device.
 #
 # @cache-data-parity: Data error such as data parity or data ECC error
 #     CXL.cache
@@ -365,8 +356,7 @@
 
 ##
 # @CXLUncorErrorRecord:
-#
-# Record of a single error including header log.
+#     Record of a single error including header log.
 #
 # @type: Type of error
 #
@@ -383,9 +373,8 @@
 
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
@@ -399,8 +388,7 @@
 
 ##
 # @CxlCorErrorType:
-#
-# Type of CXL correctable error to inject
+#     Type of CXL correctable error to inject
 #
 # @cache-data-ecc: Data ECC error on CXL.cache
 #
@@ -432,12 +420,11 @@
 
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
@@ -450,10 +437,9 @@
 
 ##
 # @CxlDynamicCapacityExtent:
-#
-# A single dynamic capacity extent.  This is a contiguous allocation
-# of memory by Device Physical Address within a single Dynamic
-# Capacity Region on a CXL Type 3 Device.
+#     A single dynamic capacity extent.  This is a contiguous
+#     allocation of memory by Device Physical Address within a single
+#     Dynamic Capacity Region on a CXL Type 3 Device.
 #
 # @offset: The offset (in bytes) to the start of the region where the
 #     extent belongs to.
@@ -471,10 +457,9 @@
 
 ##
 # @CxlExtentSelectionPolicy:
-#
-# The policy to use for selecting which extents comprise the added
-# capacity, as defined in Compute Express Link (CXL) Specification,
-# Revision 3.1, Table 7-70.
+#     The policy to use for selecting which extents comprise the added
+#     capacity, as defined in Compute Express Link (CXL)
+#     Specification, Revision 3.1, Table 7-70.
 #
 # @free: Device is responsible for allocating the requested memory
 #     capacity and is free to do this using any combination of
@@ -512,12 +497,12 @@
 
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
@@ -558,10 +543,9 @@
 
 ##
 # @CxlExtentRemovalPolicy:
-#
-# The policy to use for selecting which extents comprise the released
-# capacity, defined in the "Flags" field in Compute Express Link (CXL)
-# Specification, Revision 3.1, Table 7-71.
+#     The policy to use for selecting which extents comprise the
+#     released capacity, defined in the "Flags" field in Compute
+#     Express Link (CXL) Specification, Revision 3.1, Table 7-71.
 #
 # @tag-based: Extents are selected by the device based on tag, with
 #     no requirement for contiguous extents.
@@ -578,12 +562,12 @@
 
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

