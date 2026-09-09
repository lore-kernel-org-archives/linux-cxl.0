Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364B42FD1AA
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 04:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927435; cv=none; b=T8bKLUl4G51/iXU/Z//bOUBFmzLICqNDKzTZZT3FB5XuyaSC8599qlVGo4xCZWOllGOA0u3RP89TXCO35b+13WKLr3WCXVkkxoRKy3wfr/MF2ohdfWhAo8spMiTaIFtHppi0VE0zSeov2TUf82r9Ad+7OaKEb2Xm1CUdoP9ltrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927435; c=relaxed/simple;
	bh=7Oy/ktRt1TgcuwU2PT4V9z29jVG3P6ylFOispXW53Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=X1t8IecSreMZdnjsoWY2CxBP2q7CkRydlvN3e7v7mmck7d2e/2js7tjFWIXudu9xHvXUTNigBEO5whG2nnth3jlmjNKaSw+G7fECXbWZTVWz1oabphOStPpOjTG+zXvvaJedzOuy1V8dMEqtptIuCfdy5Chn45OYKm/ExIO1o0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VupJUIyB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VupJUIyB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788927433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=camL1mSnMPUm2RZCMdeat8czfawEGrMZ6U4V+dNjyYs=;
	b=VupJUIyBUzkeYbo9t7hHL2/48Paq7v7YTIwTca+NCNypPsHrsltkh1Tm8CYc2yaXRnJQ+5
	jlf04a1hHjPOjxUFR6qttMqgG2f9BcN+BQaBcLrAtGeLF9Mtv0eZJ837xdcHklKmijXhRG
	rbgwcniQYqBiQjY4qSw+cwjaQvLJd08=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-eK4mFDvsMlqAwO9xNV3YIw-1; Wed,
 09 Sep 2026 00:17:09 -0400
X-MC-Unique: eK4mFDvsMlqAwO9xNV3YIw-1
X-Mimecast-MFC-AGG-ID: eK4mFDvsMlqAwO9xNV3YIw_1788927428
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC24318004D8;
	Wed,  9 Sep 2026 04:17:07 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.38])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68C891800370;
	Wed,  9 Sep 2026 04:17:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	qemu-block@nongnu.org,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lukas Straub <lukasstraub2@web.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Hanna Reitz <hreitz@redhat.com>,
	linux-cxl@vger.kernel.org,
	Kevin Wolf <kwolf@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 06/10] qapi: convert simple enum intros for cxl.json
Date: Wed,  9 Sep 2026 00:16:36 -0400
Message-ID: <20260909041640.69080-7-jsnow@redhat.com>
In-Reply-To: <20260909041640.69080-1-jsnow@redhat.com>
References: <20260909041640.69080-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: v0ad8OyyNVlBOZFe1ehJJoI72uvK5MmOxl_hg7jBob8_1788927428
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/cxl.json | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 58ad82c2dc7..82524f47cdf 100644
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
@@ -296,10 +296,9 @@
 
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
@@ -463,10 +462,9 @@
 
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
@@ -550,10 +548,9 @@
 
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
-- 
2.55.0

