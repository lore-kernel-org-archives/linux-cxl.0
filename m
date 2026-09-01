Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1470F39B943
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291865; cv=none; b=uZ0wqrNCkKunu1VRc7YVW4h0x0XGSqIA9zU3WY3oytk17Z7L/MFAtUQIySEtAxa2Tgdhn/wVpD9CcKOP9EWTJrQHe4SvGgHOjp86jQgWkWEBghUyiUjJGB87TuBqc/fx9Tgt7arOSeXfFfsBJNAvLgXucEZ5aHNXWeu8Soemw8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291865; c=relaxed/simple;
	bh=z3dijg3HpUJjzfNewjTl2d5gN7AxuKOHHvr0ELHLq58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=nvXjJqzDrf14DtXdQtC88eg/jw40BC+T3XsXNHqjDsw0S3lJEbuPM/UcH375i+5C5SjFYGBbPQ4xbd0pBRgx1B+rFS9ZI6YC1soazOoR3D3GSdLIQlvTTeuFialIMGtP5jk2DoUNy4MrOBp6lxqUML18ySz/XEBQsoK3mdTYAaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMT72ScI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMT72ScI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788291863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjkSyZOR5UlGah9/I+f5WgT27XktokYJQ0TS7TR+kIg=;
	b=IMT72ScIDeL2uNxybFBnC/EWHkkgSzOoALS6CSKWVTFcXcHpW18lwgeGDZzwKWDYfqH+DV
	PxLKJIYHVYlYEkAhIjBmwzQ65IWIu3lEbUJw4jtqCUg7FCh9HfiWDYY9V5ZbOd8QxAai0r
	Qq8uMaJNzOlS7h/GtaNpN5j0VJr9Ixg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-yxqWWaFxPwm1TuWPR9D_sw-1; Tue,
 01 Sept 2026 15:44:18 -0400
X-MC-Unique: yxqWWaFxPwm1TuWPR9D_sw-1
X-Mimecast-MFC-AGG-ID: yxqWWaFxPwm1TuWPR9D_sw_1788291857
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF2A11933EA5;
	Tue,  1 Sep 2026 19:44:16 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7FF1518005B8;
	Tue,  1 Sep 2026 19:44:13 +0000 (UTC)
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
Subject: [PATCH 10/12] qapi: convert simple command intros for migration.json
Date: Tue,  1 Sep 2026 15:43:22 -0400
Message-ID: <20260901194324.458482-11-jsnow@redhat.com>
In-Reply-To: <20260901194324.458482-1-jsnow@redhat.com>
References: <20260901194324.458482-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: LuatXb8FarOV-ELpPFaFPA0PdrXIdOFCKm_8wxCGI8k_1788291857
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/migration.json | 51 +++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 8b6abcee2ca..e3beaea87bb 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -333,9 +333,9 @@
 
 ##
 # @query-migrate:
-#
-# Return information about current migration process.  If migration is
-# active there will be another json-object with RAM migration status.
+#     Return information about current migration process.  If
+#     migration is active there will be another json-object with RAM
+#     migration status.
 #
 # Since: 0.14
 #
@@ -824,8 +824,7 @@
 
 ##
 # @migrate-set-parameters:
-#
-# Set migration parameters.  All arguments are optional.
+#     Set migration parameters.  All arguments are optional.
 #
 # Since: 2.4
 #
@@ -1047,11 +1046,10 @@
 
 ##
 # @query-migrate-parameters:
-#
-# Return information about the current migration parameters.  Optional
-# members of the return value are always present, except
-# @block-bitmap-mapping, which is only present if it has been
-# previously set.
+#     Return information about the current migration parameters.
+#     Optional members of the return value are always present, except
+#     @block-bitmap-mapping, which is only present if it has been
+#     previously set.
 #
 # Since: 2.4
 #
@@ -1072,10 +1070,9 @@
 
 ##
 # @migrate-start-postcopy:
-#
-# Followup to a migration command to switch the migration to postcopy
-# mode.  The postcopy-ram capability must be set on both source and
-# destination before the original migration command.
+#     Followup to a migration command to switch the migration to
+#     postcopy mode.  The postcopy-ram capability must be set on both
+#     source and destination before the original migration command.
 #
 # Since: 2.5
 #
@@ -1222,12 +1219,11 @@
 
 ##
 # @x-colo-lost-heartbeat:
-#
-# Tell QEMU that heartbeat is lost, request it to do takeover
-# procedures.  If this command is sent to the PVM, the Primary side
-# will exit COLO mode.  If sent to the Secondary, the Secondary side
-# will run failover work, then takes over server operation to become
-# the service VM.
+#     Tell QEMU that heartbeat is lost, request it to do takeover
+#     procedures.  If this command is sent to the PVM, the Primary
+#     side will exit COLO mode.  If sent to the Secondary, the
+#     Secondary side will run failover work, then takes over server
+#     operation to become the service VM.
 #
 # Features:
 #
@@ -1442,9 +1438,8 @@
 
 ##
 # @migrate-incoming:
-#
-# Start an incoming migration.  QEMU must have been started with
-# -incoming defer.
+#     Start an incoming migration.  QEMU must have been started with
+#     -incoming defer.
 #
 # @uri: The Uniform Resource Identifier identifying the source or
 #     address to listen on
@@ -1514,9 +1509,8 @@
 
 ##
 # @xen-save-devices-state:
-#
-# Save the state of all devices to file.  The RAM and the block
-# devices of the VM are not saved by this command.
+#     Save the state of all devices to file.  The RAM and the block
+#     devices of the VM are not saved by this command.
 #
 # @filename: the file to save the state of the devices to as binary
 #     data.  See `xen-save-devices-state`.txt for a description of the
@@ -1554,9 +1548,8 @@
 
 ##
 # @xen-load-devices-state:
-#
-# Load the state of all devices from file.  The RAM and the block
-# devices of the VM are not loaded by this command.
+#     Load the state of all devices from file.  The RAM and the block
+#     devices of the VM are not loaded by this command.
 #
 # @filename: the file to load the state of the devices from as binary
 #     data.  See `xen-save-devices-state`.txt for a description of the
-- 
2.55.0

