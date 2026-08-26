Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE86472F8D
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773431; cv=none; b=GFguQ4lkxm1wQRoIMqQlgXygjOMoHy3cLc+Vw8cF1wsxYPJk/s+x4Z9DWkWE0RpjRrbFOaQGgoQ1naFnOj3C+qVfT5O6KJ6T1ntxQmKrrL2E0/jWhonm23Oqnu71H9hH89FngbIB5YDXUWGM8xRWVb2GRHlh4YS8rtbOnOkZhLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773431; c=relaxed/simple;
	bh=N9bSsKNQ5Mc9wmAyNVq3Z8J/wjZavAiUd+dt1ZbBE/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Nwe7V5FCszdoOolCl7YRsCeGrrMK1048CdWACtHdGJhrrLO5Q+WcjXVEoCyJr1cORdtbMyYfTs1JBGZcrBFU/QRt7gDAQ49xo17OWDf8zWnpxjB6n889s8hHdZABDeITL0a47TW3uso7QEAX+S1hGFVo2M9Yr84VIeDD2qCjUpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WnI8cHDc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnI8cHDc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+b4OT3j/K4d4s6nmaAGr51pQkyEJxm8NVd9Otcg/Ht8=;
	b=WnI8cHDcW5+Y0/VQ1v8/laz7OXvXmYYuUiTjcJkrPQ4Y4PtCccurJwIGsWPGudtAb2oLRG
	9KPts54xQUQPhsb0KwxYcNORdUB78KDpMPXbrIdIXvO+qcR2IJVA4Z1/heFsvQ+Mm8NGft
	xn6U6bRXRQ8dNudvR9oa+iSmI4lVOoY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-TyFWylgeMi-q5nftPBH_9A-1; Wed,
 26 Aug 2026 15:42:20 -0400
X-MC-Unique: TyFWylgeMi-q5nftPBH_9A-1
X-Mimecast-MFC-AGG-ID: TyFWylgeMi-q5nftPBH_9A_1787773336
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4ECC5185513E;
	Wed, 26 Aug 2026 19:42:16 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CEA5B18005AC;
	Wed, 26 Aug 2026 19:42:07 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	John Snow <jsnow@redhat.com>,
	linux-cxl@vger.kernel.org,
	Markus Armbruster <armbru@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	qemu-trivial@nongnu.org,
	Fabiano Rosas <farosas@suse.de>,
	Kevin Wolf <kwolf@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Jiri Pirko <jiri@resnulli.us>,
	qemu-block@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	linux-edac@vger.kernel.org,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Zhao Liu <zhao1.liu@intel.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Lukas Straub <lukasstraub2@web.de>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 23/43] qapi: convert trivial intro sections for stats.json
Date: Wed, 26 Aug 2026 15:38:20 -0400
Message-ID: <20260826193840.2152000-24-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: J-0yUyAEw5rhUSaFnDOvhESuXbujEL8NZui1MFisFQ4_1787773336
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/stats.json | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/qapi/stats.json b/qapi/stats.json
index a98624531c3..af57ec08546 100644
--- a/qapi/stats.json
+++ b/qapi/stats.json
@@ -16,8 +16,7 @@
 
 ##
 # @StatsType:
-#
-# Enumeration of statistics types
+#     Enumeration of statistics types
 #
 # @cumulative: stat is cumulative; value can only increase.
 #
@@ -38,8 +37,7 @@
 
 ##
 # @StatsUnit:
-#
-# Enumeration of unit of measurement for statistics
+#     Enumeration of unit of measurement for statistics
 #
 # @bytes: stat reported in bytes.
 #
@@ -56,8 +54,7 @@
 
 ##
 # @StatsProvider:
-#
-# Enumeration of statistics providers.
+#     Enumeration of statistics providers.
 #
 # @kvm: since 7.1
 #
@@ -70,8 +67,7 @@
 
 ##
 # @StatsTarget:
-#
-# The kinds of objects on which one can request statistics.
+#     The kinds of objects on which one can request statistics.
 #
 # @vm: statistics that apply to the entire virtual machine or the
 #     entire QEMU process.
@@ -87,9 +83,8 @@
 
 ##
 # @StatsRequest:
-#
-# Indicates a set of statistics that should be returned by
-# `query-stats`.
+#     Indicates a set of statistics that should be returned by
+#     `query-stats`.
 #
 # @provider: provider for which to return statistics.
 #
@@ -113,10 +108,9 @@
 
 ##
 # @StatsFilter:
-#
-# The arguments to the `query-stats` command; specifies a target for
-# which to request statistics and optionally the required subset of
-# information for that target.
+#     The arguments to the `query-stats` command; specifies a target
+#     for which to request statistics and optionally the required
+#     subset of information for that target.
 #
 # @target: the kind of objects to query.  Note that each possible
 #     target may enable additional filtering options
@@ -200,8 +194,7 @@
 
 ##
 # @StatsSchemaValue:
-#
-# Schema for a single statistic.
+#     Schema for a single statistic.
 #
 # @name: name of the statistic; each element of the schema is uniquely
 #     identified by a target, a provider (both available in
@@ -236,8 +229,7 @@
 
 ##
 # @StatsSchema:
-#
-# Schema for all available statistics for a provider and target.
+#     Schema for all available statistics for a provider and target.
 #
 # @provider: provider for this set of statistics.
 #
@@ -255,8 +247,8 @@
 
 ##
 # @query-stats-schemas:
-#
-# Return the schema for all available runtime-collected statistics.
+#     Return the schema for all available runtime-collected
+#     statistics.
 #
 # @provider: a provider to restrict the query to.
 #
-- 
2.55.0

