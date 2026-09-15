Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24FB4508EB
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 21:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506907; cv=none; b=g76nkY507JkGqK5gQ3vF73/hxwS1q1kLzVGYovSXmsHc+3ZihWdPBe9/TQ2B2qBRIqVBOwhi2+W/2brSRbiZ1xzJyG2JxoCy05JNYW+2GxdE3HYbDnIAOK5FXvuFGQQwGIdvESSl+DcH5QxOkmtIT1wUcr1OpvCAD0O00d9tPxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506907; c=relaxed/simple;
	bh=eIK9WpF+eRAOvzAMoBh/7Gj01xt7ap8sY0vUmBPiat0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=LS+YtgoyKg4A54PC0AYiHv354Ks9m2cKbvv28FXaq/s7LpcRVfmi/8vJlwcQzD2yhO07+O0Pejhw7uNTBgWdsai3NKGqHkshYanzSOpofRROa2gIaY/vI9tO1atD9ZWNSncMTdzCf+QUzKCoFPPLC5tzZiXOoUjcOkSKbJlwWfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qga3Kx5h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qga3Kx5h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789506905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBhz2UZF8bOOsvlTvTMmJ20/Eqyxkh0IEGurbSrhuto=;
	b=Qga3Kx5hCREjBllCmON8bw9SMw9mphMTNUsT0SGrJ37LVjEvKkHTt+WdfD2P+P3tZqZPAr
	jMuNgZp74bwwYHFKErjDXKSv+FYZjmoa71Bs9SXDQ1Ccf/FQePMXIBTFKv6M5BGdDfU1HH
	H9N2oJe3ks4kHeDJ1CwW3C3eK2DJ+AE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-8TXqaac9OUGBwGpMIUjstw-1; Tue,
 15 Sep 2026 17:15:01 -0400
X-MC-Unique: 8TXqaac9OUGBwGpMIUjstw-1
X-Mimecast-MFC-AGG-ID: 8TXqaac9OUGBwGpMIUjstw_1789506899
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B54CF19540C3;
	Tue, 15 Sep 2026 21:14:59 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1EC551956042;
	Tue, 15 Sep 2026 21:14:57 +0000 (UTC)
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
Subject: [PATCH v3 6/7] qapi: convert intro sections with "TODO" markers
Date: Tue, 15 Sep 2026 17:14:33 -0400
Message-ID: <20260915211434.3511110-7-jsnow@redhat.com>
In-Reply-To: <20260915211434.3511110-1-jsnow@redhat.com>
References: <20260915211434.3511110-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: xwzZQQx6kMkRaMS3YHrJ1IOMmJMlcgpMmyBesxhRpo4_1789506899
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

