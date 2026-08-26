Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375E73D25AD
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773240; cv=none; b=VaeddadLJIbyc3xJ/1NbaPOrFWY+ApMykkt6e5WLxoVLEviP2bO9pp6W0rDqwAenzdqfgeVNxCCYHvUN3/RUGFjYIrWW+3+O6oDhf5XL4sJLzDt88SwxXh/YIGHkldfvBGTR8iog24eNS2EK5aXC1I+aN9APenDI5koIoFSzwXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773240; c=relaxed/simple;
	bh=LbkPrHFQBzHD/gmfnCZppN6CrMiPt81VBDoO/D7VMSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Ftmzvg7pYfaVRiZhs+hWOIiwyq+RCg24OfpVE+hhTTKGiTNxWDUeh1keotvQ4EsTwNGMEM6nurymmeISjRnowvRHqwWnWXoaPTnC2SAzcQ5PBWMfWXaSw4GUfWU0xbOX0/ZPByKlNPxQ2ZneYCrFOX2tyOo27YBxMl/skS38rBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3sjZybe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3sjZybe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKAT3AByQqAPEWNoFggUat7b+8Hak/kL/bR6Gv1FXr8=;
	b=F3sjZybePSuLuJq/UOZxrTi1y56WMfqCfxENnj4323zH6FR64p3o+GSUF0Y1Bf82eYiVeO
	K9cG4lgD7yRzmPZic/PFbxZSWzq55pvZ8TXsxtyPwkwnxOFWi8sdxO1DDe/ejzJDqGlENo
	q09p/Uawit3bJXiuQYFqc1XGeSZzw58=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-7EJ0nng3MHmnWgtVU44T1Q-1; Wed,
 26 Aug 2026 15:40:21 -0400
X-MC-Unique: 7EJ0nng3MHmnWgtVU44T1Q-1
X-Mimecast-MFC-AGG-ID: 7EJ0nng3MHmnWgtVU44T1Q_1787773218
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A51C195DBA0;
	Wed, 26 Aug 2026 19:40:18 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7AD5718005AC;
	Wed, 26 Aug 2026 19:40:10 +0000 (UTC)
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
Subject: [PATCH v3 09/43] qapi: convert trivial intro sections for machine-common.json
Date: Wed, 26 Aug 2026 15:38:06 -0400
Message-ID: <20260826193840.2152000-10-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: TzKPpenENHDg3iCtG-rq9B0YPvcMVqIopay9F-NioiY_1787773218
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine-common.json | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/qapi/machine-common.json b/qapi/machine-common.json
index aca98e994af..fdb0e68d9e6 100644
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
@@ -84,8 +82,7 @@
 
 ##
 # @SmpCacheProperties:
-#
-# Cache information for SMP system.
+#     Cache information for SMP system.
 #
 # @cache: Cache name, which is the combination of cache level and
 #     cache type.
@@ -103,8 +100,7 @@
 
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

