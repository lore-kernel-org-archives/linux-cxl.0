Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680AD4F30FA
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567149; cv=none; b=carlssdVHVgJPj2dyfRRXA550N/QfPCyPmj4hPnXImYR9XhvRaZ55WXIvvEXI2XRMO7ACfft441T8BaNwdzgBCLbrvuJUqDf8xQBJlAkNwSgalaK336Em+Dpq2VPPnYRd8inBnbCFNM2uFHtXEJalYPZli5BIbZ3Cghh+ZLz7HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567149; c=relaxed/simple;
	bh=U1yCt9xVIuKkmViiKjtR9RmQVDxAoNwM4rZRLI1rr6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=FfKOloWRSAqm2nYpauJpESKFUlmDGj8LKTcW3Xhjs87V+Z1qZRtZM6ZOnNitH9Wwo1gRoX7uc83LzmN+FEbhygvL9+9/xuGGNeQcZsRHrUG3Zr46WF/N83VTJzC/J9CWsX3xSwa3lb5yKPUaqZXvvcU6YdFA0zZkG9an8BbbFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i4Prqe66; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4Prqe66"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789567146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ClPV5sIPWojjTAynGwc1mftqvUQ/Gr/l3qbEvnYoawE=;
	b=i4Prqe66wVVLMUUDHctUzAhGsnBQl3ipVAoyc+5C3iBpD+EjyoeBnTMILOg0CEN5GeOZTN
	mrACwGcv3Aa/6LJfzwnQ7dp/ByvMkfNMM/4Y2oU9yuL2HVNSfUg0DHCqX2GQHJDHT9DwIe
	tyEOHc3AC3pUNWkAYGH96nJO7iwHhO0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-9rpq0ancMD-B5qO5Qr6Kbw-1; Wed,
 16 Sep 2026 09:59:02 -0400
X-MC-Unique: 9rpq0ancMD-B5qO5Qr6Kbw-1
X-Mimecast-MFC-AGG-ID: 9rpq0ancMD-B5qO5Qr6Kbw_1789567140
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A54B1809A02;
	Wed, 16 Sep 2026 13:59:00 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E704B1956054;
	Wed, 16 Sep 2026 13:58:55 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Peter Xu <peterx@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Eric Blake <eblake@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Kevin Wolf <kwolf@redhat.com>,
	Michael Roth <michael.roth@amd.com>,
	linux-cxl@vger.kernel.org,
	qemu-block@nongnu.org,
	Junjie Cao <junjie.cao@intel.com>,
	Lukas Straub <lukasstraub2@web.de>,
	Hanna Reitz <hreitz@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v4 2/7] qapi: convert remaining simple intros for cxl.json
Date: Wed, 16 Sep 2026 09:58:36 -0400
Message-ID: <20260916135841.3614495-3-jsnow@redhat.com>
In-Reply-To: <20260916135841.3614495-1-jsnow@redhat.com>
References: <20260916135841.3614495-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: e5npgL2Z21cCoCaYm3Lplh-Z9Z42Z_fSGM4w_osS0mA_1789567140
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

These are either structs or unions that are used in an inlinable
context: i.e. the generated documentation is likely to feature a
version of this documentation block that does not include the intro in
context of another command, event, or structure.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/cxl.json | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 631d4def2ac..9422d5a0e2d 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
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
@@ -129,8 +127,7 @@
 
 ##
 # @CXLDRAMEvent:
-#
-# Event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
+#     Event record for a DRAM Event (CXL r3.2 8.2.10.2.1.2).
 #
 # @dpa: Device Physical Address (relative to @path device).  Note
 #     lower bits include some flags.  See CXL r3.2 Table 8-58 DRAM
@@ -211,8 +208,7 @@
 
 ##
 # @CXLMemModuleEvent:
-#
-# Event record for a Memory Module Event (CXL r3.2 8.2.10.2.1.3).
+#     Event record for a Memory Module Event (CXL r3.2 8.2.10.2.1.3).
 #
 # @type: Device Event Type.  See CXL r3.2 Table 8-59 Memory Module
 #     Event Record for bit definitions for bit definiions.
-- 
2.55.0

