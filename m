Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB4F35F8AB
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782362; cv=none; b=juTjd+wFWjlLUn/zMV0DkDfhJw0h6HeJRilOUlu9CYm3pqQUON/X3ktQNcCNP7cKVw74K+OyVYKPAcno/JRG8U0O1tK9IqtBF/jkwcTGAm4VoOTyM1/aIUYGJfWFdS0X1S78/EQVhyN3COFqdX+ubNn1NE8aQrL2bBLBrolFYVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782362; c=relaxed/simple;
	bh=OUqqk5VJothEl5PF1iiQRt/tK9pAueZ219CMNu100pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Q8J+z5+Wo8++XGqWl0PAZVa7mSky51JRPDPKyEU2KtkS4BHsVSt0YhZ/53xxWsmw1lJ0LdN9Oq+npVdNCvAHUdIgBpHKLIDFtle5EavRoj+j09vNxCIJARdNhlbOAY98G5O74gv9Sw8Ynfy+oZKPcRflaamO0Bck2Jr40/w2V0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctsjTCqa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctsjTCqa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qna4Kk34qAEZX+aFniaTwQbeBYZCyqG8FCN8r26Wd5s=;
	b=ctsjTCqaLZ9deAVpF3tgA4wai51ON9EjLu1JvbS5LzyE+FdW47ua7e2Mi7l1ZL8HCH/8i6
	+8oQLu3Be+1Yp/VEoRI74R5T8SI5CxOT+I9WNqoPo4EAAeXgvZpNeLQDVqo0Nme+PXF0xN
	ClIcNLvbg5vnj1yUAaO+IY52EQzW6UE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-SIM3_0RqMgO2nvYLk4Ic4Q-1; Thu,
 23 Jul 2026 00:52:24 -0400
X-MC-Unique: SIM3_0RqMgO2nvYLk4Ic4Q-1
X-Mimecast-MFC-AGG-ID: SIM3_0RqMgO2nvYLk4Ic4Q_1784782341
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12CB8180A8E0;
	Thu, 23 Jul 2026 04:52:21 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 63B04180029D;
	Thu, 23 Jul 2026 04:52:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Lukas Straub <lukasstraub2@web.de>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Zhao Liu <zhao1.liu@intel.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Markus Armbruster <armbru@redhat.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Alex Williamson <alex@shazbot.org>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hanna Reitz <hreitz@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	qemu-block@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	linux-cxl@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	Fabiano Rosas <farosas@suse.de>,
	John Snow <jsnow@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Igor Mammedov <imammedo@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-edac@vger.kernel.org,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	qemu-trivial@nongnu.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 24/44] qapi: convert trivial intro sections for stats.json
Date: Thu, 23 Jul 2026 00:47:45 -0400
Message-ID: <20260723044805.527643-25-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: G1uMIcPuBaooAYHHvMbEKagpVjSf2pn6iaefKFirGnQ_1784782341
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

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

