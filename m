Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A0399899
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291848; cv=none; b=Qc/tVnOdm2rgB2BF9Sl1hDhxYAzGc3qo57VekRFn2bRVq8x28KsvJL5RJLaPn6sN9Lue1Hm2HrbChN3Sy+4zBrXgt4e3+CZ7m252TlOZqICyzsnwXRfkSQGV4dIhE9Htvjd3To//Qc7R/j9HytW9vwGr+PpfrL+E1ihbPqxZYfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291848; c=relaxed/simple;
	bh=iyqrM+w11tmm6lbhJQxDuSNU3jpIIP9gr95duWj/3FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=S8iW0MRIEbCIr0a2fJy1kvIX2ChQB1oe7dhue1F353w1JFI5VWWaprXqHx9k15Bi7jRhw2zS3AJRxbKT4KIgxcp46bAnZ98YflQn+deZaPRObeEx/+VjX+UMAS966/MXQRnkeh7Gv/HsI+UbNySw3YKrh9E4C8r6wu6qWdwfK8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SGERhPyr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGERhPyr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788291845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CwbTdgzzUcSwy+hrITS+w+5qh1jOhaXlKQFQTMXAMTU=;
	b=SGERhPyrnI9s+tATr63BzArR4WXQG+nqmn1kLQ/Myt5IW+XVNhHutv60cEBNNkK7uEcZnR
	5+6famPyZbHSqTqRBzfHjzB6t34wi608qWYi/WVyZ1xk1VVtHpNtuKloP+3qJwks4VPewA
	UhDR3t8BPwS/MEjO72gpqZ0P64pTFDM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-gVkqrcZfMzmZFn-HpUeEpw-1; Tue,
 01 Sept 2026 15:44:02 -0400
X-MC-Unique: gVkqrcZfMzmZFn-HpUeEpw-1
X-Mimecast-MFC-AGG-ID: gVkqrcZfMzmZFn-HpUeEpw_1788291841
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBC041955BE0;
	Tue,  1 Sep 2026 19:44:00 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C00118005BD;
	Tue,  1 Sep 2026 19:43:56 +0000 (UTC)
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
Subject: [PATCH 06/12] qapi: convert simple command intros for block-export.json
Date: Tue,  1 Sep 2026 15:43:18 -0400
Message-ID: <20260901194324.458482-7-jsnow@redhat.com>
In-Reply-To: <20260901194324.458482-1-jsnow@redhat.com>
References: <20260901194324.458482-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: OGwZ4WFIbVw9OIoskE6uiPB94P48NTHJWLrlUM_2A9Q_1788291841
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-export.json | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 154f07b0b95..2893c6456d5 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -63,11 +63,11 @@
 
 ##
 # @nbd-server-start:
-#
-# Start an NBD server listening on the given host and port.  Block
-# devices can then be exported using `nbd-server-add`.  The NBD server
-# will present them as named exports; for example, another QEMU
-# instance could refer to them as "nbd:HOST:PORT:exportname=NAME".
+#     Start an NBD server listening on the given host and port.  Block
+#     devices can then be exported using `nbd-server-add`.  The NBD
+#     server will present them as named exports; for example, another
+#     QEMU instance could refer to them as
+#     "nbd:HOST:PORT:exportname=NAME".
 #
 # Errors:
 #     - if the server is already running
@@ -435,10 +435,10 @@
 
 ##
 # @block-export-del:
-#
-# Request to remove a block export.  This drops the user's reference
-# to the export, but the export may still stay around after this
-# command returns until the shutdown of the export has completed.
+#     Request to remove a block export.  This drops the user's
+#     reference to the export, but the export may still stay around
+#     after this command returns until the shutdown of the export has
+#     completed.
 #
 # @id: Block export id.
 #
-- 
2.55.0

