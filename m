Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817EA332604
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773287; cv=none; b=tsyGJ9JxFm2FLdBdaHMDPxvBTkEIUrCW+SYYJH5ZIB28KBBXR0zDyPnr7GjkYj8eeMffuk3479JfDTWXYoEWNYOPoUgXNu4B1IkXnGnbqc7WVfzTri2YSZSISFB/7fGxwMzfKPNgF/Lb7FDB8+LBpQoyXgamknI6jmFiUm2o1Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773287; c=relaxed/simple;
	bh=n6xn0zYFhQZmcMmmuhcngle6IJ2CgrNMjR85aULdABQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=DCjrvdNBvXCSQwF+qSLTrz8AeMg5uaSgEAXjgkhcH1V5p+QRkcaH2ZRKivDGSaC20jcuydXpJIweXBTuGPMZSw5v2TAnELYaz+7kZIJmr5EEccNh17h3AkcmXCCYqIAuVrR4jeIzAnsQ+hyl5nescoi9a/dV9q1recGBHxxOttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gUjNZk+J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUjNZk+J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18x22lpIOMgbRbvwNB6lVwCay+xQAMls20hVgm6gsBg=;
	b=gUjNZk+Jtr2ZHmbgtvlJaHK0bXiWJX6gDYSsUNalzguoWWvtUr456xRo07kH/mrhlECWlT
	kJve2nSTD+vJO9QtRaU3KSigDYknpkY0reLZhhu4XsnIuAOa1VKYldLOm4sqEy+VAqjmgf
	RJekMRGUK7hSrQHtT6RAeeDc8paThAo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-7EttIfacMEex8jo2Js2EWg-1; Wed,
 26 Aug 2026 15:41:04 -0400
X-MC-Unique: 7EttIfacMEex8jo2Js2EWg-1
X-Mimecast-MFC-AGG-ID: 7EttIfacMEex8jo2Js2EWg_1787773261
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE4161954239;
	Wed, 26 Aug 2026 19:41:00 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 307A21800577;
	Wed, 26 Aug 2026 19:40:52 +0000 (UTC)
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
Subject: [PATCH v3 14/43] qapi: convert trivial intro sections for machine-s390x.json
Date: Wed, 26 Aug 2026 15:38:11 -0400
Message-ID: <20260826193840.2152000-15-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: hUpxoj6-zbEb_DrIGMOJyU9BSOMUexa4HM9N-lrzhc4_1787773261
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine-s390x.json | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
index ea430e1b889..0a3c7eeda9f 100644
--- a/qapi/machine-s390x.json
+++ b/qapi/machine-s390x.json
@@ -9,9 +9,8 @@
 
 ##
 # @S390CpuPolarization:
-#
-# An enumeration of CPU polarization that can be assumed by a virtual
-# S390 CPU
+#     An enumeration of CPU polarization that can be assumed by a
+#     virtual S390 CPU
 #
 # Since: 8.2
 ##
@@ -94,8 +93,7 @@
 
 ##
 # @CpuPolarizationInfo:
-#
-# The result of a CPU polarization query.
+#     The result of a CPU polarization query.
 #
 # @polarization: the CPU polarization
 #
@@ -122,9 +120,8 @@
 
 ##
 # @SCLP_CPI_INFO_AVAILABLE:
-#
-# Emitted when the Control-Program Identification data is available in
-# the QOM tree.
+#     Emitted when the Control-Program Identification data is
+#     available in the QOM tree.
 #
 # Features:
 #
-- 
2.55.0

