Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C3E37F726
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782274; cv=none; b=UZhI/zB70sGWJljgLZivQqlWpbKINYSHhOXbY39SovwnAGHG6lvGrzkx+J82Gzb7dBxz3O+jS9Vohgh7FkjQYZmx149oS91j6rUtQylJ0Y1z12IJsVUNMBvanMGSJrvw/xC5TlLIa7TFtuBxzCpTm7h29wNPDfXSVt4JBTrVgnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782274; c=relaxed/simple;
	bh=qsW2IuxOW0Tc6hcH3fzGl3hASqAwyiPcHfmuAjgWNn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=aCiy0yJwE2WpwjTJgyR7tt4eaurvP+mCIlHlGKAVIZ/LJOIWwW3IL4mfPvq7Tmha2I5FY2Z63LNVAppfsYBM6BcUIlBl21i/INgcc7sumkw9TwFcx6zMlfzV1aRdyvV1fRDMUWBpWh+yus7BzOsoJijCSkhQ8CuF0j0dTYV78UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=La3NxwtK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="La3NxwtK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XX0MM67l2hTQkl3T1X4vh6I9bh96PpfSjiv2H/lU8Zg=;
	b=La3NxwtKkOiet9vkChN24M+b4pE/lFhf04uBYSwTgV4f7Ct07mwTJxVltZIeuc+uI39pKk
	gQSgW//V3GjnSJh1RWPXfnGD7FMiU1Dn2We9b61cw0WKcF1pJ3GaD4kGfovMFXkMB61wtI
	JN4AgZw1lwdfk26eXDH0PFOsbV2NlF8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-BCZ7n0D3Ptumtz7syo7Jjw-1; Thu,
 23 Jul 2026 00:50:50 -0400
X-MC-Unique: BCZ7n0D3Ptumtz7syo7Jjw-1
X-Mimecast-MFC-AGG-ID: BCZ7n0D3Ptumtz7syo7Jjw_1784782247
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C45F1800759;
	Thu, 23 Jul 2026 04:50:47 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 823A018002AE;
	Thu, 23 Jul 2026 04:50:37 +0000 (UTC)
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
Subject: [PATCH v2 15/44] qapi: convert trivial intro sections for machine-s390x.json
Date: Thu, 23 Jul 2026 00:47:36 -0400
Message-ID: <20260723044805.527643-16-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 4CuOLF03S89W5C95fTHAfjhfmPgLeeOM0qwNN8ZhABE_1784782247
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine-s390x.json | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
index ea430e1b889..2d40629683f 100644
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
@@ -21,10 +20,9 @@
 
 ##
 # @set-cpu-topology:
-#
-# Modify the topology by moving the CPU inside the topology tree, or
-# by changing a modifier attribute of a CPU.  Absent values will not
-# be modified.
+#     Modify the topology by moving the CPU inside the topology tree,
+#     or by changing a modifier attribute of a CPU.  Absent values
+#     will not be modified.
 #
 # @core-id: the vCPU ID to be moved
 #
@@ -94,8 +92,7 @@
 
 ##
 # @CpuPolarizationInfo:
-#
-# The result of a CPU polarization query.
+#     The result of a CPU polarization query.
 #
 # @polarization: the CPU polarization
 #
@@ -122,9 +119,8 @@
 
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

