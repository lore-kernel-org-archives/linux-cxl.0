Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015374E3233
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789674404; cv=none; b=EZVriHWLBaFYpJwS4JH9ym/2RC/IQuMFZqpArIJmidBlqKb5T/69Cdv9ZP3wnlEW2QzlEmmW8FrB6pNXluxDeZzMhTjHjTMnbDjKj92SyvniWrxbpMqED+fj2WX/vHPdLaRlztVfLgTHzklvKSqzRtsWKYmzVTvl2Dy8JG49eOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789674404; c=relaxed/simple;
	bh=fDljSzgrNnQtRgA7SuOqWiBnZlqG6LcSJWHtEF1NlM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=OySC4m1Caa2LxUS7z60mE7RIrHRc4COA+JKqH9WQaIfST93bnS2me03XbUwR8O7CxQ8FWqB1pn2+Ks1kpkX4LHeJ/56HmFhawt6QIFQb6PaDK2vWgTARn4aKpsgkt803qCu0dDQilBSGDxa7OKeJ2dDSbP1xYli5tC1oRAyvjqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BBUakgLs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBUakgLs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789674400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiMHSbMYaSoCftUUaFNfoKY7hKh6/HrfQ1cDf7jEy/s=;
	b=BBUakgLs1i5kJdogT1jp/h19Wv3w9V8fgFlXetYfl5yqIMrvVCKaI93bML7/FdM25xVzS4
	3d+SBXw80b5hvXyl8Ct0cUilR3i3uh+/I21xdIR2RI1RGzpANDa159qCChE7JY8c+bxesY
	zY8uWrrm4VUqsqx02MqWfppe9LEP8VY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-t74_p71_NcGmyTQhXq5UZg-1; Thu,
 17 Sep 2026 15:46:34 -0400
X-MC-Unique: t74_p71_NcGmyTQhXq5UZg-1
X-Mimecast-MFC-AGG-ID: t74_p71_NcGmyTQhXq5UZg_1789674392
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 215A61912C63;
	Thu, 17 Sep 2026 19:46:32 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.85])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E8B819AC047;
	Thu, 17 Sep 2026 19:46:29 +0000 (UTC)
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
Subject: [PATCH v5 4/7] qapi: convert remaining simple intros for block-core.json
Date: Thu, 17 Sep 2026 15:46:11 -0400
Message-ID: <20260917194614.549584-5-jsnow@redhat.com>
In-Reply-To: <20260917194614.549584-1-jsnow@redhat.com>
References: <20260917194614.549584-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 2Lhd13yLdpC1ikwkqMBKEEdetoJ9j6miXwjLZT2j8VE_1789674392
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
index da7b5c7fe35..802a4af74ed 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4502,9 +4502,8 @@
 
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
@@ -4528,9 +4527,8 @@
 
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
@@ -4543,9 +4541,8 @@
 
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
@@ -4555,9 +4552,8 @@
 
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
@@ -4683,14 +4679,13 @@
 
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
@@ -4726,9 +4721,8 @@
 
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
@@ -5513,9 +5507,8 @@
 
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

