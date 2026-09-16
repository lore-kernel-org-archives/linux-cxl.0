Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B581C4FDE68
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567160; cv=none; b=lTDrUaf0o+Cd9QV8Q3TJQiz1ak7PBfYZjWggb4mWT4i32Z77sHs1O91cLoD6unTW2E3aqHcBwn6d8/HHrMCao2NV6kNxdeJqbTUyXchN+OTulF8iAKZWdZPlYFA3zH32PDq1mz6VisHAKDUU32Z5AjvAkR9qsppB7RO4ii78hMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567160; c=relaxed/simple;
	bh=+Uecn/7AEcMwlaJLMyGZB5C4sB1cwq/g6+vKLPPgUfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=S9emF7gYr+LZvd0oeOvR8jubZd0oDRmcjuUWFgYYK738o20gzzS1rFPxKbTD3Mwl36X7SZnTQGUw9z/2LRrOBR6tCWY/COWlXr7z7RW/t1MFspvuuofgJMI4ytfO4ov8CwaZ7T3tvqHSMi7bF55bNMh9RVLa80KD8grLemIYpZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ci34dtPb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ci34dtPb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789567156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBLyZXbXlsOC8SLLzAeTtyZ5ri1ynYIY6/I844l2vDU=;
	b=ci34dtPbTfxdJ8EH4QMpqXJQ81dY8osyIIbvSh3noRcjSCcZ9EVPc3mZOMi4qlePwQStgM
	lsr1g6hW5qKdDzzUT4SgOz8fHeK7fh4ARD3lUWOPGhYscexa1Ycr0BaRA8Wkm9w/rwqpP4
	mVhy9bRzsMsuI9OWrfXx8zFnGs+kRf8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-zdzQckuSNFmfj0yOOCC4vw-1; Wed,
 16 Sep 2026 09:59:13 -0400
X-MC-Unique: zdzQckuSNFmfj0yOOCC4vw-1
X-Mimecast-MFC-AGG-ID: zdzQckuSNFmfj0yOOCC4vw_1789567151
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41F771800598;
	Wed, 16 Sep 2026 13:59:11 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4FE7F1956054;
	Wed, 16 Sep 2026 13:59:06 +0000 (UTC)
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
Subject: [PATCH v4 4/7] qapi: convert remaining simple intros for block-core.json
Date: Wed, 16 Sep 2026 09:58:38 -0400
Message-ID: <20260916135841.3614495-5-jsnow@redhat.com>
In-Reply-To: <20260916135841.3614495-1-jsnow@redhat.com>
References: <20260916135841.3614495-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: i9dy2bafuTOmpKUvhHj0aqbdtQfNASv9s3WYQmxUmDA_1789567151
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

