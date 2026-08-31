Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0226B37DEB2
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207745; cv=none; b=kcGQWNTEuElWV3ffWtsC5IufIsIhhMIwTAdKXKUqOsuuY4pT4VXwvd5MCED+Rl3zlEZAn9qHFuY4wjlkoOqW7iSluKpM+NivohX8Vy/0wRr2S5WI8hyErr1nit1Tr8Lxea76TN8kgC/HIvpK23WW3WMvgfCb5Kc6tSu5TqmhvYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207745; c=relaxed/simple;
	bh=evKKAKGtF8BiofrQyzI+UNoOVv8K0JneDmPA3cX47AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8lLdYvRwaCPSNdj1U+qKAfT2l2gMHzlM6c/o15mfwhhw2kCvV9MiFonhW9iTqJjbHosPS9b+PaVwNER38eBa4KUiyBQmnK+PSF9GHiV94EHRzmoJ59KfUDfOPf6OheZjUw3vmPHzd8qtAfr3xEyPmisWlfayUvEmxxf+cchN3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IyVRTlBi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyVRTlBi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788207743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJj1tpPE8OM93bqYjizhdyFRUwlcEtSIS5cPqNRF9cY=;
	b=IyVRTlBi8lE07dFYy2MPEHCjWeY0As323SYBNX+bmT2OSao0RENGo+0tEOhgfrUw5H0T8Y
	MQOp8AbRI2zMrAZ1BBigllG3bLlEFvpxjXueWBwGmuRHmabEJnXdzR0RbJ56v4Wh24ivo7
	udcFh5DwMsbo9xgF198mBEMKDFCL+0c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131--hYo-e0KPKGM2YvaRZ_4EQ-1; Mon,
 31 Aug 2026 16:22:18 -0400
X-MC-Unique: -hYo-e0KPKGM2YvaRZ_4EQ-1
X-Mimecast-MFC-AGG-ID: -hYo-e0KPKGM2YvaRZ_4EQ_1788207735
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88313192013B;
	Mon, 31 Aug 2026 20:21:44 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 88D89180176D;
	Mon, 31 Aug 2026 20:21:29 +0000 (UTC)
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
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 10/43] qapi: convert trivial intro sections for accelerator.json
Date: Mon, 31 Aug 2026 16:19:12 -0400
Message-ID: <20260831201945.287730-11-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: mwh9yz9Zcq8I9dM0nEqYzBZEUleqdmq_5TNGE1nrkz0_1788207735
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 qapi/accelerator.json | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/qapi/accelerator.json b/qapi/accelerator.json
index b59df378664..efc0fa81418 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -13,8 +13,7 @@
 
 ##
 # @KvmInfo:
-#
-# Information about support for KVM acceleration
+#     Information about support for KVM acceleration
 #
 # @enabled: true if KVM acceleration is active
 #
@@ -26,8 +25,7 @@
 
 ##
 # @query-kvm:
-#
-# Return information about KVM acceleration
+#     Return information about KVM acceleration
 #
 # Features:
 #
@@ -46,8 +44,7 @@
 
 ##
 # @x-accel-stats:
-#
-# Query accelerator statistics
+#     Query accelerator statistics
 #
 # Features:
 #
@@ -63,8 +60,7 @@
 
 ##
 # @Accelerator:
-#
-# Information about support for MSHV acceleration
+#     Information about support for MSHV acceleration
 #
 # @hvf: Apple Hypervisor.framework
 #
@@ -88,8 +84,7 @@
 
 ##
 # @AcceleratorInfo:
-#
-# Information about support for various accelerators
+#     Information about support for various accelerators
 #
 # @enabled: the accelerator that is in use
 #
@@ -102,8 +97,7 @@
 
 ##
 # @query-accelerators:
-#
-# Return information about accelerators
+#     Return information about accelerators
 #
 # Returns: @AcceleratorInfo
 #
-- 
2.55.0

