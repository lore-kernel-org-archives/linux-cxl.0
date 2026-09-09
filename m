Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A96D2D73A6
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 04:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927445; cv=none; b=gryxkMwnEFbUs55vUZmpr5SlbbbXN5QBCrnvztp4C4eh2L/Mr/O1n72ELyqu2MUGNfNcVJySOrNthzt6p00R2Eksr2TbUBAH2M7WJRiUATcmpZFM7yJSF9IG7iU6fGZNISQm4U/vRuTMS7+UKmC1UdCbTbiFe0QzEFygPsLnAX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927445; c=relaxed/simple;
	bh=W5FvzArFR4weZBW02pS3M/6wqq4dWJhJijiWRTsoMlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=BJeDhdA3DZv+XdAxYDU+4PZjiNtPPy+ITZDeYdSl/JYnIZGsTT2UXqSxnphOIGUhzba2doO6rgdSja2fFGRqefLhGWEB487EG/muB1Whv0jJTdU2O6CJIP4NS0xyJ+n1w9bQwrzTZooSsqk6Fo0MiX/3fNfwPIZXd0tftM0Geio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PsQfQbRA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsQfQbRA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788927443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jejtr3gY5u2jkllDzpEBmv62g3OyMsBGD9D9SzjMFW0=;
	b=PsQfQbRAETXApF5z5EL4oVFLX2qua9DlapPO58FLfYgS9RJXhEP48wEOhoKJpCXx69krn9
	Iejy6mcPMK8ShAA0g22oZq6LSGfrfQH/yxLhYSk4HCH8QzjvmKCWGHNk8MWbWf6BUGYHon
	CGnyVV4pDJ/6ayqhOjcIUIOXhz3QnrI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517--T184KdeOjGooTp3o61M8A-1; Wed,
 09 Sep 2026 00:17:19 -0400
X-MC-Unique: -T184KdeOjGooTp3o61M8A-1
X-Mimecast-MFC-AGG-ID: -T184KdeOjGooTp3o61M8A_1788927437
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5931B1944B03;
	Wed,  9 Sep 2026 04:17:17 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.38])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 860E81800473;
	Wed,  9 Sep 2026 04:17:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	qemu-block@nongnu.org,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lukas Straub <lukasstraub2@web.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Hanna Reitz <hreitz@redhat.com>,
	linux-cxl@vger.kernel.org,
	Kevin Wolf <kwolf@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 08/10] qapi: convert simple enum intros for migration.json
Date: Wed,  9 Sep 2026 00:16:38 -0400
Message-ID: <20260909041640.69080-9-jsnow@redhat.com>
In-Reply-To: <20260909041640.69080-1-jsnow@redhat.com>
References: <20260909041640.69080-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: sGS7NMzYekt3IP8Zsqcb53e5dj3RY5CB0i9vA_VkaOI_1788927437
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/migration.json | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 5fbd604f995..8096ef64682 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -788,9 +788,8 @@
 
 ##
 # @MigrationParameter:
-#
-# Migration parameters enumeration.  The enumeration values mirror the
-# members of @MigrationParameters.
+#     Migration parameters enumeration.  The enumeration values mirror
+#     the members of @MigrationParameters.
 #
 # Features:
 #
@@ -1756,9 +1755,8 @@
 
 ##
 # @DirtyRateMeasureMode:
-#
-# Method used to measure dirty page rate.  Differences between
-# available methods are explained in `calc-dirty-rate`.
+#     Method used to measure dirty page rate.  Differences between
+#     available methods are explained in `calc-dirty-rate`.
 #
 # @page-sampling: use page sampling
 #
-- 
2.55.0

