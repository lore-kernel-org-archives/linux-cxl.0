Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD97A4AA3F0
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567171; cv=none; b=W65PqEvgjR698POLlh4yVCeojLpSsrNAn44OFcR4QoptX5oIOWSeeDmobIGS8i9xvD33g4IGIM87aPKB6HZkF3R2j50z+dmOJ6yNTv0OlsJA2hfISCdTKNT3+zDX8C7tsZSoNIK6ymzQAl3wK7sh6cnZa/zUimF0/7gppgllIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567171; c=relaxed/simple;
	bh=eIK9WpF+eRAOvzAMoBh/7Gj01xt7ap8sY0vUmBPiat0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=FQMp+1S1PkCcNs3fUwDehFNBgsM3GioKUTn9xTbZFZjxW3OWSsI4dogLIPOb/e2nYC2pzgBiF7JUTvIrTld+nT6ymJFGKOg3AOURo+3wFU8DXPKOYvlmLcFRnpWjMipXV0t2o0P+r5ozBBLOMHif8Fpeu60VlSMblDVfvdGz8ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBrE3ixd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBrE3ixd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789567168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBhz2UZF8bOOsvlTvTMmJ20/Eqyxkh0IEGurbSrhuto=;
	b=CBrE3ixdc76q0D1tV6PJE5tIimeAA0yMAvbMNHJN3jGVa/TBeMWU3btm8cru0dgWI7HJuG
	vON1mhIkCYlkHtgh1A+0+6Wf1eiRqvda5OPGeq+Dbx7ZphTyZSwH5YNHDbmG2Jaa8Mw8/s
	SKsDrpSRzL7Q72HYByDSVRRlov56bYc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-JU3eWqANNrGMRE1KkVn9jA-1; Wed,
 16 Sep 2026 09:59:24 -0400
X-MC-Unique: JU3eWqANNrGMRE1KkVn9jA-1
X-Mimecast-MFC-AGG-ID: JU3eWqANNrGMRE1KkVn9jA_1789567162
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E6731956076;
	Wed, 16 Sep 2026 13:59:22 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 097B71956054;
	Wed, 16 Sep 2026 13:59:16 +0000 (UTC)
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
Subject: [PATCH v4 6/7] qapi: convert intro sections with "TODO" markers
Date: Wed, 16 Sep 2026 09:58:40 -0400
Message-ID: <20260916135841.3614495-7-jsnow@redhat.com>
In-Reply-To: <20260916135841.3614495-1-jsnow@redhat.com>
References: <20260916135841.3614495-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: hHwlYY23xEC5wAL5plBbyFFzCL05v517Bd_f39pqMEQ_1789567162
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
index a58e373dd70..84d95c8d87f 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1244,11 +1244,8 @@
 
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
index 0428f777882..d571c06fc20 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1617,10 +1617,7 @@
 
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
@@ -1670,10 +1667,7 @@
 
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
index 526108ca0bb..d0bacb4dcfe 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1159,12 +1159,9 @@
 
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

