Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E90A38D3F0
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506896; cv=none; b=QGd29V1iIpH6OTsw/XmEUdx+gefQ6pWaVhMzVrOg5U6m47Btbg05JpRiJCUComt0cERwYiRYad92MbcbvHJrwu1P0jpljKNwE3Wt9LuLvloiEjmFqL4VbbNZvUD0/Tds/wKYN0v1SwHpHqfTzhqKqPcGS+7CkzKGy9OQFKXiKQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506896; c=relaxed/simple;
	bh=U1yCt9xVIuKkmViiKjtR9RmQVDxAoNwM4rZRLI1rr6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=oLNUqjWw/E46efxZdTWVU2SFLjYzS82EQBY4yvd2CIt5yGbY1S/F4L5yXFAif1YsqH62bJDC+0Dvemcv2Ol/k3+7fiS4K5sCoT/ayFt3Qo8FJvGYcwYLaupoGyQM1amW4yiPuxXRFKdOPqp/kf/mvR/JX9ifV8zvO+odgFhNTJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZF06C6rE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZF06C6rE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789506894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ClPV5sIPWojjTAynGwc1mftqvUQ/Gr/l3qbEvnYoawE=;
	b=ZF06C6rEIGkWDPMWOk3P4PHB8H2BbNEBhksEOUwHFAkmdpNycDqMvpMokCzWoLOQX4ycnb
	OXHpXyDGpd4wBNFrAuTRk4o4RsxtT5luJewKuEMBm6Hd5SRQZtfDAd4lQHkbbEswPQdxja
	6Hy4b6t5lVSHIjCoUo/TlrfWrlSamu8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-JSKvkBwFMaaijDl_wZzByw-1; Tue,
 15 Sep 2026 17:14:49 -0400
X-MC-Unique: JSKvkBwFMaaijDl_wZzByw-1
X-Mimecast-MFC-AGG-ID: JSKvkBwFMaaijDl_wZzByw_1789506888
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85C4F1944B30;
	Tue, 15 Sep 2026 21:14:47 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C5CCD1956095;
	Tue, 15 Sep 2026 21:14:44 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Markus Armbruster <armbru@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Hanna Reitz <hreitz@redhat.com>,
	qemu-block@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>,
	linux-cxl@vger.kernel.org,
	Lukas Straub <lukasstraub2@web.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Michael Roth <michael.roth@amd.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eric Blake <eblake@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Junjie Cao <junjie.cao@intel.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v3 2/7] qapi: convert remaining simple intros for cxl.json
Date: Tue, 15 Sep 2026 17:14:29 -0400
Message-ID: <20260915211434.3511110-3-jsnow@redhat.com>
In-Reply-To: <20260915211434.3511110-1-jsnow@redhat.com>
References: <20260915211434.3511110-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: KAgPYu2GBlNeCpmEqrKMGuuIVuhJsC5SMzq0vcluHUI_1789506888
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

