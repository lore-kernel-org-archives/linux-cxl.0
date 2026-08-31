Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27CB3845A9
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207824; cv=none; b=a8rIv0zWI/kJz5b+IxWkXDPtGTFlzk8fefNuXR/p2bd22xbbaREcyFXnMBdy501njr2f02qjImhWugiHDYxbv39YpT84v7e1ifXvnec8PpIqXpzmle2h6r5+XnK9pLpEM5tJDsPakulPgWuRBiQpHH8d+2QCbXnH2kQAAvF5XfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207824; c=relaxed/simple;
	bh=VEfOx7DWPVqAUE8BqOEyhUTl01T82RFViwPhAgBmVf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=oUW6fkmnpAFF28THpgewupjutASK/9vWtzR+Muv8IPZRwY1RDg39cG0hcqYLdIinXi5PoFTrdNtJlb2hzn9y/4kbQPWO7wWBlyruyU0Kt2gfmkqijVE7yPo9eH4K2ZF/Po/4zq6Q4tNTPepS8u9sw6tvNXtHLursQ7eaqbDCQA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2MPbt1o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2MPbt1o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788207820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8AG+94F77edoTiPAI8IPsNpOPrIzUtI0R/Rih5SccE=;
	b=M2MPbt1omDPxG93D8xzfEPLZ7uSUnoy/XLZOoh0wTQlzjDmDh6Za/jnccX3y0DbN01PWFw
	4uYnSPT4jQZdYYPlbrmAgHzJRXgr1uaSvyTR3AGmQWnrzqPQtgcdLcF5lmEkbAAm7/j+6T
	XVBvRw61n9179PVzCSCMuZDj80su9B8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-3a7aqxNSMtKAQ5-ch_pvGQ-1; Mon,
 31 Aug 2026 16:23:34 -0400
X-MC-Unique: 3a7aqxNSMtKAQ5-ch_pvGQ-1
X-Mimecast-MFC-AGG-ID: 3a7aqxNSMtKAQ5-ch_pvGQ_1788207811
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 817AB191FCE2;
	Mon, 31 Aug 2026 20:23:31 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3DD3B1800577;
	Mon, 31 Aug 2026 20:23:24 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Jiri Pirko <jiri@resnulli.us>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	qemu-block@nongnu.org,
	Ani Sinha <anisinha@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	linux-cxl@vger.kernel.org,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	linux-edac@vger.kernel.org,
	Michael Tokarev <mjt@tls.msk.ru>,
	John Snow <jsnow@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Zhao Liu <zhao1.liu@intel.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	Eric Blake <eblake@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	qemu-trivial@nongnu.org,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 22/43] qapi: convert trivial intro sections for transaction.json
Date: Mon, 31 Aug 2026 16:19:24 -0400
Message-ID: <20260831201945.287730-23-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 8I31cd8vgedw0peQyzNAFjbEIvjhBvvgscJciigZAIY_1788207811
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/transaction.json | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/qapi/transaction.json b/qapi/transaction.json
index 4b4eb09bf38..c0dc811ba61 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -12,8 +12,7 @@
 
 ##
 # @Abort:
-#
-# This action can be used to test transaction failure.
+#     This action can be used to test transaction failure.
 #
 # Since: 1.6
 ##
@@ -22,8 +21,7 @@
 
 ##
 # @ActionCompletionMode:
-#
-# An enumeration of transactional completion modes.
+#     An enumeration of transactional completion modes.
 #
 # @individual: Do not attempt to cancel any other Actions if any
 #     Actions fail after the Transaction request succeeds.  All
@@ -156,9 +154,8 @@
 
 ##
 # @TransactionAction:
-#
-# A discriminated record of operations that can be performed with
-# `transaction`.
+#     A discriminated record of operations that can be performed with
+#     `transaction`.
 #
 # @type: the operation to be performed
 #
@@ -184,8 +181,7 @@
 
 ##
 # @TransactionProperties:
-#
-# Optional arguments to modify the behavior of a Transaction.
+#     Optional arguments to modify the behavior of a Transaction.
 #
 # @completion-mode: Controls how jobs launched asynchronously by
 #     Actions will complete or fail as a group.  See
-- 
2.55.0

