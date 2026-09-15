Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF373DAAB8
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789485134; cv=none; b=KkUKJBBqxny+K0Txsr/Ip7poTnrgYBosaDa0EXQCKbNOMKqnipbw+/MycYdfboSz3yMazE2siZoXq2XkbC3cQD9x9Q7+BoN5xc0m1VX3+byV3vhTVHOBRGXQitJv2BQ3IdBDi6AAtRkdTiDM7Y9ds8ItsfHchPIgd+ZcbQjty1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789485134; c=relaxed/simple;
	bh=cRhQ2aJpW5m0U7L7kR2287ijD2hZ5l7rQzttAhAPelg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=N2criKS7QLBzq2Z1ut6XrPnYG7xWeyCFoG5wx2fJ2XApa2sR3Tr3/5g/FN4JRldTx2xqmYInPyYiTB0LebrbC6V0tAgFl1qKk7+JhDEpBw646WJigxoDLQvcFIZ20QIRvXJli0vk0WfSZHxLpo36JY1KNQ9wCvPgnCYPaS9fJVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDfABJAH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDfABJAH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789485132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fVqJB7RA7wK1A3wU0gjI5S+gtvyNP6b0TlS+G7syIFw=;
	b=JDfABJAHoG6BxFyKLNNnwTMErgB2BWG4IIlUjU04YbGN+tZW5JWTSTL6iN/UJQusReSBwd
	VwNfHjiBAqC9DrUBD9PtD6ljxFS49kq2ZaEOW4akF8xLHuT/3SynT7HhTSNDRYqv9TQhZp
	auD1BcuvZhXWQXTSuTTLiXlPDrOP5jc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-b5gphxSzNg2L9JiAL5ofrw-1; Tue,
 15 Sep 2026 11:12:08 -0400
X-MC-Unique: b5gphxSzNg2L9JiAL5ofrw-1
X-Mimecast-MFC-AGG-ID: b5gphxSzNg2L9JiAL5ofrw_1789485126
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2BF11843AE4;
	Tue, 15 Sep 2026 15:12:05 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 99941195604C;
	Tue, 15 Sep 2026 15:12:03 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Wolf <kwolf@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Michael Roth <michael.roth@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Lukas Straub <lukasstraub2@web.de>,
	Eric Blake <eblake@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	linux-cxl@vger.kernel.org,
	Zhao Liu <zhao1.liu@intel.com>,
	qemu-block@nongnu.org,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v2 6/7] qapi: convert intro sections with "TODO" markers
Date: Tue, 15 Sep 2026 11:11:26 -0400
Message-ID: <20260915151127.1002244-7-jsnow@redhat.com>
In-Reply-To: <20260915151127.1002244-1-jsnow@redhat.com>
References: <20260915151127.1002244-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: ZfhJmyV3XYpRhkeJlHP1vJRBA1L6Cb09U0suxREQe2A_1789485126
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This patch converts intro sections that are immediately followed by a
"TODO:" that was formerly used to demarcate the stub member insertion
point.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine.json   |  7 ++-----
 qapi/migration.json | 10 ++--------
 qapi/net.json       |  9 +++------
 qapi/yank.json      |  5 +----
 4 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 13875fc4642..108033b6d64 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1216,11 +1216,8 @@
 
 ##
 # @query-memory-size-summary:
-#
-# Return the amount of initially allocated and present hotpluggable
-# (if enabled) memory in bytes.
-#
-# TODO: This line is a hack to separate the example from the body
+#     Return the amount of initially allocated and present
+#     hotpluggable (if enabled) memory in bytes.
 #
 # .. qmp-example::
 #
diff --git a/qapi/migration.json b/qapi/migration.json
index 8096ef64682..70a1854fb73 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1604,10 +1604,7 @@
 
 ##
 # @query-xen-replication-status:
-#
-# Query replication status while the vm is running.
-#
-# TODO: This line is a hack to separate the example from the body
+#     Query replication status while the vm is running.
 #
 # .. qmp-example::
 #
@@ -1657,10 +1654,7 @@
 
 ##
 # @query-colo-status:
-#
-# Query COLO status while the vm is running.
-#
-# TODO: This line is a hack to separate the example from the body
+#     Query COLO status while the vm is running.
 #
 # .. qmp-example::
 #
diff --git a/qapi/net.json b/qapi/net.json
index 7aabd8b9260..7a809d9a8a6 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1113,12 +1113,9 @@
 
 ##
 # @announce-self:
-#
-# Trigger generation of broadcast RARP frames to update network
-# switches.  This can be useful when network bonds fail-over the
-# active slave.
-#
-# TODO: This line is a hack to separate the example from the body
+#     Trigger generation of broadcast RARP frames to update network
+#     switches.  This can be useful when network bonds fail-over the
+#     active slave.
 #
 # .. qmp-example::
 #
diff --git a/qapi/yank.json b/qapi/yank.json
index 8ac4b773653..187a0952e66 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -96,10 +96,7 @@
 
 ##
 # @query-yank:
-#
-# Query yank instances.  See `YankInstance` for more information.
-#
-# TODO: This line is a hack to separate the example from the body
+#     Query yank instances.  See `YankInstance` for more information.
 #
 # .. qmp-example::
 #
-- 
2.55.0

