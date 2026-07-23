Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C3537E5D8
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782218; cv=none; b=hRW0fGSoIHYtpdht347NQDzTQiUy16sp7E37dBts16VYNLpp5KZApc1n7E8DdeLEU1OJ6htihSnwmcqOIoMLDHhO4HHXuqlqO+44mXRzQM4zSCZL+2Qy+PF6LDWHvQWxrjbPmJBdtrsT+3h/o8g0nexPNQOtKcY+15kfDzfuVbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782218; c=relaxed/simple;
	bh=nocpMY0DvE6m6a+uybU/cnYrO1dk/4FgHQaGoxpjrZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=gbYIOnB7bOuqm5IFcj7wtH2lQ9zUEPjeUJjfXl5tk/tQLAG6SFghz/Ubdc03VnKyqVJDcy8RtER+3CQVG/niBBJmfrtQzcUNJ4o48lRVd6BDVTTfHXLKQXKLE908gZHob1zMBjyy4wgkhbaEInGqnMEiU0Ps62Zf/T3rqyc/xU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9PgOEAm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9PgOEAm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUM+22WxDywCXikFEUBWpOnNWjGENT0mgqCEYZkslcs=;
	b=S9PgOEAmopk5wQyJc4BXj3LocOwn0S9qbHa+rbfNd9LIzRzphiI7YYiS2UKHYxx/fK2ERO
	W8EoG4k3vIHpbD5wfZ+FFLsbmZaBjBFMYb3xlryS7qDmaeVmTeKokCnK5LKzoCtD4sB1L2
	cePbtaSmlT3/vdP3DIZYhsu003dCS/A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-RSTknKbGMyOtFjgmvGgSGw-1; Thu,
 23 Jul 2026 00:49:59 -0400
X-MC-Unique: RSTknKbGMyOtFjgmvGgSGw-1
X-Mimecast-MFC-AGG-ID: RSTknKbGMyOtFjgmvGgSGw_1784782196
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AAAB195FE1B;
	Thu, 23 Jul 2026 04:49:56 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF08318002B5;
	Thu, 23 Jul 2026 04:49:46 +0000 (UTC)
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
Subject: [PATCH v2 10/44] qapi: convert intro sections for machine-common.json
Date: Thu, 23 Jul 2026 00:47:31 -0400
Message-ID: <20260723044805.527643-11-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 7pRkD3tsTra7x4j7DjPF3E_GEoJ_VjbnA6bPwZa5pLM_1784782196
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine-common.json | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/qapi/machine-common.json b/qapi/machine-common.json
index aca98e994af..0b07811df07 100644
--- a/qapi/machine-common.json
+++ b/qapi/machine-common.json
@@ -12,9 +12,8 @@
 
 ##
 # @S390CpuEntitlement:
-#
-# An enumeration of CPU entitlements that can be assumed by a virtual
-# S390 CPU
+#     An enumeration of CPU entitlements that can be assumed by a
+#     virtual S390 CPU
 #
 # Since: 8.2
 ##
@@ -23,8 +22,7 @@
 
 ##
 # @CpuTopologyLevel:
-#
-# An enumeration of CPU topology levels.
+#     An enumeration of CPU topology levels.
 #
 # @thread: thread level, which would also be called SMT level or
 #     logical processor level.  The @threads option in
@@ -65,9 +63,8 @@
 
 ##
 # @CacheLevelAndType:
-#
-# Caches a system may have.  The enumeration value here is the
-# combination of cache level and cache type.
+#     Caches a system may have.  The enumeration value here is the
+#     combination of cache level and cache type.
 #
 # @l1d: L1 data cache.
 #
@@ -84,8 +81,7 @@
 
 ##
 # @SmpCacheProperties:
-#
-# Cache information for SMP system.
+#     Cache information for SMP system.
 #
 # @cache: Cache name, which is the combination of cache level and
 #     cache type.
@@ -103,8 +99,7 @@
 
 ##
 # @SmpCachePropertiesWrapper:
-#
-# List wrapper of `SmpCacheProperties`.
+#     List wrapper of `SmpCacheProperties`.
 #
 # @caches: the list of `SmpCacheProperties`.
 #
-- 
2.55.0

