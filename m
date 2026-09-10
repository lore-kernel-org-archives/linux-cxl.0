Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14463939C8
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789072791; cv=none; b=KnLqTMn1Skw/sY4PcGOnmm1L6m9FWKjGcDanQoYVW7tBKpDvWOh0Qp8vu10eVBNK7JKn+ZI+AsGzyOVRBPkTjY+Rx5hUM0WJqR5sdD6LT0lJFrchoo2NEtZB7w8jiPZZtsHIBAflO9iswDlMIupQyHyIrJRGK8DZfRA5XDkphk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789072791; c=relaxed/simple;
	bh=gG97QGHja+EvRekKZdlluYv+6wWUZNOi+LViJRdZxW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=qNF29z+L7TWaJWmEEYBUfbSqWwj2kACwCJXN3qgbPwiF1WiucuxUXEEDHl/pjNDq3g8o3BNeUXiLCwQy1puiILcrkOnNbiqX+pTZyCemvfIbyS6e95dz2fZ00qZOaxqeWcZeSGy/3Cbj/qem3Z9ZpxGge6Y+bxH0A+95QRBWjWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAjCM4En; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAjCM4En"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789072788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1ILG/43iGdLfltvWdkkiXj2gLIAVEJqveoYs9xtFPY=;
	b=NAjCM4EntNITqt2+urYIJ0ggn6uaCkHiY+bdJ8mUoV6gYP+NpstGrJNG0CoyZ/oGH1zPDT
	qRbNGpIP/0chVM6VH1RWlbvsyECgelF5d7T3iqcElAvtDpz1/to37xqCRJDJkB+7qcAvtq
	KRezrYxpDMu7q6vMI8RvaIYlUQCSmWI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-OPv73Z_LNVCQfFaAy4ycJA-1; Thu,
 10 Sep 2026 16:39:45 -0400
X-MC-Unique: OPv73Z_LNVCQfFaAy4ycJA-1
X-Mimecast-MFC-AGG-ID: OPv73Z_LNVCQfFaAy4ycJA_1789072784
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 077701800BD7;
	Thu, 10 Sep 2026 20:39:44 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.67])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C077641B;
	Thu, 10 Sep 2026 20:39:38 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-cxl@vger.kernel.org,
	Zhao Liu <zhao1.liu@intel.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>,
	Markus Armbruster <armbru@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	qemu-block@nongnu.org,
	Ani Sinha <anisinha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 09/10] qapi: convert simple data struct intros for block-core.json
Date: Thu, 10 Sep 2026 16:38:55 -0400
Message-ID: <20260910203856.99003-10-jsnow@redhat.com>
In-Reply-To: <20260910203856.99003-1-jsnow@redhat.com>
References: <20260910203856.99003-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: A4ji6V-wmzsFV0FoQuz2loIPn3eCMtkwmvQX-nET8hs_1789072784
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5b1eaa8e786..1ca147285e7 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -417,10 +417,9 @@
 
 ##
 # @BlockGraphInfo:
-#
-# Information about all nodes in a block (sub)graph in the form of
-# `BlockNodeInfo` data.  The base `BlockNodeInfo` struct contains the
-# information for the (sub)graph's root node.
+#     Information about all nodes in a block (sub)graph in the form of
+#     `BlockNodeInfo` data.  The base `BlockNodeInfo` struct contains
+#     the information for the (sub)graph's root node.
 #
 # @children: Array of links to this node's child nodes' information
 #
@@ -768,9 +767,8 @@
 
 ##
 # @BlockInfo:
-#
-# Block device information.  This structure describes a virtual device
-# and the backing device associated with it.
+#     Block device information.  This structure describes a virtual
+#     device and the backing device associated with it.
 #
 # @device: The device name associated with the virtual device.
 #
@@ -1607,9 +1605,8 @@
 
 ##
 # @BackupPerf:
-#
-# Optional parameters for backup.  These parameters don't affect
-# functionality, but may significantly affect performance.
+#     Optional parameters for backup.  These parameters don't affect
+#     functionality, but may significantly affect performance.
 #
 # @use-copy-range: Use copy offloading.  Default false.
 #
@@ -2705,11 +2702,10 @@
 
 ##
 # @ThrottleLimits:
-#
-# Limit parameters for throttling.  Since some limit combinations are
-# illegal, limits should always be set in one transaction.  All fields
-# are optional.  When setting limits, if a field is missing the
-# current value is not changed.
+#     Limit parameters for throttling.  Since some limit combinations
+#     are illegal, limits should always be set in one transaction.
+#     All fields are optional.  When setting limits, if a field is
+#     missing the current value is not changed.
 #
 # @iops-total: limit total I/O operations per second
 #
@@ -3492,12 +3488,11 @@
 
 ##
 # @Qcow2OverlapCheckFlags:
-#
-# Structure of flags for each metadata structure.  Setting a field to
-# 'true' makes QEMU guard that Qcow2 format structure against
-# unintended overwriting.  See Qcow2 format specification for detailed
-# information on these structures.  The default value is chosen
-# according to the template given.
+#     Structure of flags for each metadata structure.  Setting a field
+#     to 'true' makes QEMU guard that Qcow2 format structure against
+#     unintended overwriting.  See Qcow2 format specification for
+#     detailed information on these structures.  The default value is
+#     chosen according to the template given.
 #
 # @template: Specifies a template mode which can be adjusted using the
 #     other flags, defaults to 'cached'
-- 
2.55.0

