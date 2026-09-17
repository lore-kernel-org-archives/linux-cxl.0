Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBDC3EB102
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789674394; cv=none; b=Cys1kRjtgfzZau9zGHLXoKrp+yzjrqZAp5Ec4P/vzG7qlwfUbdJUnFGehgj14InI96yQYcpRz7olrCFytbUO949I+NTPE9SwwFuptjgtLlTW9EA8ij11evJ3fHrqQSPyA3Q14qm1CuQfEaeARhdHEn6xZqRDXfWWtvEjT8kK0UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789674394; c=relaxed/simple;
	bh=U1yCt9xVIuKkmViiKjtR9RmQVDxAoNwM4rZRLI1rr6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=D1/5oht0KFq5xdBiJ9gj/lsYZ5o1sRsZcm26V0rY7W4tqYkfZVuZLO2Jf+Gs+ObOUesCcqF+CVtdxvU1Ocd5PvhJylv4UgZ0lxbJ+4Wd4B6OZf3FAjCUiCKS70zDclj/HMjLroM4dYPW/9BFIcB5MfMzp87wQICOp3LlR5TUu7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+yFPVDz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+yFPVDz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789674391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ClPV5sIPWojjTAynGwc1mftqvUQ/Gr/l3qbEvnYoawE=;
	b=f+yFPVDzWFOVKkgJov8HaC5wY06cBXGUGOl7mFKt6FBVpp2302bbwjUnzFMEu3FoyPUdbx
	xLsdRbcCW0nQEAKTLTzJQaD0Xg9UvcAf6ar+YGPi/EdSDzSk6qdAF7LMLC75FkItGLZark
	oIejSiLJp4AwpJeNFxBPIVQKcbWgY2k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-kF7sXa3VNxm8FKNkD_5-hA-1; Thu,
 17 Sep 2026 15:46:28 -0400
X-MC-Unique: kF7sXa3VNxm8FKNkD_5-hA-1
X-Mimecast-MFC-AGG-ID: kF7sXa3VNxm8FKNkD_5-hA_1789674386
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 142D61912C44;
	Thu, 17 Sep 2026 19:46:26 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.85])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3747019AC047;
	Thu, 17 Sep 2026 19:46:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Junjie Cao <junjie.cao@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	linux-cxl@vger.kernel.org,
	Jason Wang <jasowangio@gmail.com>,
	Eric Blake <eblake@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	qemu-block@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Lukas Straub <lukasstraub2@web.de>,
	Jonathan Cameron <jic23@kernel.org>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v5 2/7] qapi: convert remaining simple intros for cxl.json
Date: Thu, 17 Sep 2026 15:46:09 -0400
Message-ID: <20260917194614.549584-3-jsnow@redhat.com>
In-Reply-To: <20260917194614.549584-1-jsnow@redhat.com>
References: <20260917194614.549584-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: pUml5R8kYubJ9sxws7ZJCy8_QvgC0m2zUdNlAmQzMIQ_1789674386
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

