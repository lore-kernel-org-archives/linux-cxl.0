Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1E83BE179
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 21:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506899; cv=none; b=sCvkUp0BAzfW3JJRVlYL6BlRogG6svlVL0hP2HNW7BIRDYUuP52hwGjN1Wq8YotRlt6sR917jUzPovJ2QLdsb/Yy9dTZSvlaKNJgR65cnpLscF0OsoCFj0B01aOEB5BfMbe0FjCx3zmg/SgXlwBuNJJFZMVLusSuawWgbVq6na8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506899; c=relaxed/simple;
	bh=+Uecn/7AEcMwlaJLMyGZB5C4sB1cwq/g6+vKLPPgUfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=jX8B+shRQ0DCm424ji34HgR70TYQG6Tj98gIaqMq3gPyaIwec8TODbhHGtamwrv7+CeBlElDJnhTzeN2rlQfLKw5hBhJ7OKIa9nozYWdBwn4cEYUyEWTn1nzqcW+ljs576xEL7n76EbGUjULL0aTI0b1YM9+XytnW4ib9yunaLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ft++zJqw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ft++zJqw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789506897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBLyZXbXlsOC8SLLzAeTtyZ5ri1ynYIY6/I844l2vDU=;
	b=Ft++zJqwFVTBisUYQS/uUL2tquiMOr9LGOa277nITi75SjllmA9Orms5XgvrxFHfQwJ7nD
	G+K8fVI1OqfKL5RS1XDI+nYszZXr86h4bFlYA+XzZpTqNrf+v26OV3id+e96hdb83lfqrJ
	FXrWT+9T7qR/xTdAnu5D+SuZZ+QhwBM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-bMw2B6MmOmSnpJxSHceQbg-1; Tue,
 15 Sep 2026 17:14:55 -0400
X-MC-Unique: bMw2B6MmOmSnpJxSHceQbg-1
X-Mimecast-MFC-AGG-ID: bMw2B6MmOmSnpJxSHceQbg_1789506893
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D9BF1800591;
	Tue, 15 Sep 2026 21:14:53 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E15CA1956095;
	Tue, 15 Sep 2026 21:14:50 +0000 (UTC)
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
Subject: [PATCH v3 4/7] qapi: convert remaining simple intros for block-core.json
Date: Tue, 15 Sep 2026 17:14:31 -0400
Message-ID: <20260915211434.3511110-5-jsnow@redhat.com>
In-Reply-To: <20260915211434.3511110-1-jsnow@redhat.com>
References: <20260915211434.3511110-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: VZRDQGBXcbNNhbE6i98VXAV0nMzebjU1BrerNdQpKVc_1789506893
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

These are either structs or unions that are used in an inlinable
context: i.e. the generated documentation is likely to feature a
version of this documentation block that does not include the intro in
context of another command, event, or structure.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json | 45 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1ca147285e7..88218e38d02 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4462,9 +4462,8 @@
 
 ##
 # @BlockdevOptionsCurlHttp:
-#
-# Driver specific block device options for HTTP connections over the
-# curl backend.  URLs must start with "http://".
+#     Driver specific block device options for HTTP connections over
+#     the curl backend.  URLs must start with "http://".
 #
 # @cookie: List of cookies to set; format is "name1=content1;
 #     name2=content2;" as explained by CURLOPT_COOKIE(3).  Defaults to
@@ -4488,9 +4487,8 @@
 
 ##
 # @BlockdevOptionsCurlHttps:
-#
-# Driver specific block device options for HTTPS connections over the
-# curl backend.  URLs must start with "https://".
+#     Driver specific block device options for HTTPS connections over
+#     the curl backend.  URLs must start with "https://".
 #
 # @sslverify: Whether to verify the SSL certificate's validity
 #     (defaults to true)
@@ -4503,9 +4501,8 @@
 
 ##
 # @BlockdevOptionsCurlFtp:
-#
-# Driver specific block device options for FTP connections over the
-# curl backend.  URLs must start with "ftp://".
+#     Driver specific block device options for FTP connections over
+#     the curl backend.  URLs must start with "ftp://".
 #
 # Since: 2.9
 ##
@@ -4515,9 +4512,8 @@
 
 ##
 # @BlockdevOptionsCurlFtps:
-#
-# Driver specific block device options for FTPS connections over the
-# curl backend.  URLs must start with "ftps://".
+#     Driver specific block device options for FTPS connections over
+#     the curl backend.  URLs must start with "ftps://".
 #
 # @sslverify: Whether to verify the SSL certificate's validity
 #     (defaults to true)
@@ -4643,14 +4639,13 @@
 
 ##
 # @BlockdevOptionsCbw:
-#
-# Driver specific block device options for the copy-before-write
-# driver, which does so called copy-before-write operations: when data
-# is written to the filter, the filter first reads corresponding
-# blocks from its file child and copies them to @target child.  After
-# successfully copying, the write request is propagated to file child.
-# If copying fails, the original write request is failed too and no
-# data is written to file child.
+#     Driver specific block device options for the copy-before-write
+#     driver, which does so called copy-before-write operations: when
+#     data is written to the filter, the filter first reads
+#     corresponding blocks from its file child and copies them to
+#     @target child.  After successfully copying, the write request is
+#     propagated to file child.  If copying fails, the original write
+#     request is failed too and no data is written to file child.
 #
 # @target: The target for copy-before-write operations.
 #
@@ -4686,9 +4681,8 @@
 
 ##
 # @BlockdevOptions:
-#
-# Options for creating a block device.  Many options are available for
-# all block devices, independent of the block driver:
+#     Options for creating a block device.  Many options are available
+#     for all block devices, independent of the block driver:
 #
 # @driver: block driver name
 #
@@ -5473,9 +5467,8 @@
 
 ##
 # @BlockdevAmendOptionsQcow2:
-#
-# Driver specific image amend options for qcow2.  For now, only
-# encryption options can be amended
+#     Driver specific image amend options for qcow2.  For now, only
+#     encryption options can be amended
 #
 # @encrypt: Encryption options to be amended
 #
-- 
2.55.0

