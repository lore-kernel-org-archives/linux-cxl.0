Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3257936828B
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 19:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291833; cv=none; b=GztPlN30NcYtRgz/ZVJjhxezG8PrOEOwvK7npBQ5nMltxDm2oGO34LpvCn9vDhLxJ+qGSRLQW4T7QrscdJPy67O1kjoTOEnxJp8ERr4eOJGnsc8DwjFsRDo5Xyz9dZmX31w8wAYDLlrWwOa/1TmfBoDDp4HfqqqoYdkUzm42nxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291833; c=relaxed/simple;
	bh=k8yJgRDetA5ZFw81Ufj09dDQwWQQnYj4wJXIzvFRCSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QFq7FdJZkvq2ehJN/0ZtxK7D1mnc/kd1xCfxFxmv1Wktm+BbgeCYVtWPxWH3fgRqKPPaNU7r4mKTY9RDDwOyH3RGkWhVQRoRqoyAGIvoYSeZbwI3GatAz50EfH5aLATcX/fEh94OSzEzc1QpRe+/9RRnP3eaJtb4m/1Sxe+aMQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHU19TeW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHU19TeW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788291831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZRiJOI37FD1ZgS9gMKMSe0r96Tyek+mAWzJpuOKJFU=;
	b=CHU19TeWZK5csb3IYTfroBtihwS1I0yuskmZ+R0pLq+7OOxXu8vf9eFAXQH2xG6S5iKZDi
	/ZOCkFFB5Fiud2PrsBFHt7FeyrVW42+Wjwanh+bOSSJDE63AkOmofTLnQ4sHFQmxj3R9nb
	bubPIX+tOhfTUKY1pATDCm3rtxWCviw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-MMtjr78OO5eWiELBMYUTYA-1; Tue,
 01 Sept 2026 15:43:47 -0400
X-MC-Unique: MMtjr78OO5eWiELBMYUTYA-1
X-Mimecast-MFC-AGG-ID: MMtjr78OO5eWiELBMYUTYA_1788291826
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBCF21834579;
	Tue,  1 Sep 2026 19:43:45 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B59C818005BD;
	Tue,  1 Sep 2026 19:43:41 +0000 (UTC)
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
Subject: [PATCH 03/12] qapi: convert simple command intros for replay.json
Date: Tue,  1 Sep 2026 15:43:15 -0400
Message-ID: <20260901194324.458482-4-jsnow@redhat.com>
In-Reply-To: <20260901194324.458482-1-jsnow@redhat.com>
References: <20260901194324.458482-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: mk6eJHtRAhyYtW3ZdaOTH_WmzFKfl-CZg9Ev0ce7hdQ_1788291826
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/replay.json | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/qapi/replay.json b/qapi/replay.json
index 66dff797553..db1440c09a6 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -45,10 +45,9 @@
 
 ##
 # @query-replay:
-#
-# Retrieve the record/replay information.  It includes current
-# instruction count which may be used for `replay-break` and
-# `replay-seek` commands.
+#     Retrieve the record/replay information.  It includes current
+#     instruction count which may be used for `replay-break` and
+#     `replay-seek` commands.
 #
 # Returns: record/replay information.
 #
@@ -64,13 +63,13 @@
 
 ##
 # @replay-break:
-#
-# Set replay breakpoint at instruction count @icount.  Execution stops
-# when the specified instruction is reached.  There can be at most one
-# breakpoint.  When breakpoint is set, any prior one is removed.  The
-# breakpoint may be set only in replay mode and only "in the future",
-# i.e. at instruction counts greater than the current one.  The
-# current instruction count can be observed with `query-replay`.
+#     Set replay breakpoint at instruction count @icount.  Execution
+#     stops when the specified instruction is reached.  There can be
+#     at most one breakpoint.  When breakpoint is set, any prior one
+#     is removed.  The breakpoint may be set only in replay mode and
+#     only "in the future", i.e. at instruction counts greater than
+#     the current one.  The current instruction count can be observed
+#     with `query-replay`.
 #
 # @icount: instruction count to stop at
 #
@@ -85,9 +84,8 @@
 
 ##
 # @replay-delete-break:
-#
-# Remove replay breakpoint which was set with `replay-break`.  The
-# command is ignored when there are no replay breakpoints.
+#     Remove replay breakpoint which was set with `replay-break`.  The
+#     command is ignored when there are no replay breakpoints.
 #
 # Since: 5.2
 #
@@ -100,13 +98,12 @@
 
 ##
 # @replay-seek:
-#
-# Automatically proceed to the instruction count @icount, when
-# replaying the execution.  The command automatically loads nearest
-# snapshot and replays the execution to find the desired instruction.
-# When there is no preceding snapshot or the execution is not
-# replayed, then the command fails.  Instruction count can be obtained
-# with the `query-replay` command.
+#     Automatically proceed to the instruction count @icount, when
+#     replaying the execution.  The command automatically loads
+#     nearest snapshot and replays the execution to find the desired
+#     instruction.  When there is no preceding snapshot or the
+#     execution is not replayed, then the command fails.  Instruction
+#     count can be obtained with the `query-replay` command.
 #
 # @icount: target instruction count
 #
-- 
2.55.0

