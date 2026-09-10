Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F7F39A81B
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 20:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789072789; cv=none; b=OEwQiah+SWrVhyzvMwlCoZlub6QPm874kvi958TpccXl1nBZJopLq/hv+yF18qqEiPr0Cp/6izFD81pz2YlC/mhbVMHAs2xIeL7p2ONb0ORLxJ7JuuWd4OXORjaVb3J0+Ryn33VjPEj0cECctqyCTYAFVHbi9RcHhvxU6nbRGO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789072789; c=relaxed/simple;
	bh=FpZEyceg16BPcQba/kBQrj6Er4+V9rExFrl0UESXUC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=YLP6s32Iv/dNEXwhbpavhkkk0eSDXXts3ez1F9CKvpBSmMrh5YISXDj0NVGo5S/XzX5vkV2Hc9CZ0+Btfe6NhI0fYZgitrA6YOj8+95s90ueg9P7NO+pQey8ESa9Wow2BJNP9c2UBYTfc8SdYeU5gSFTGTJi0fcyaaGrFV4EpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SiIN3gmm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiIN3gmm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789072784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+6vOvXgswz2L9Ze3Uf1dz+X4Fype2lplTzI0Oj4goY=;
	b=SiIN3gmmWQdfH8YSsq7fBoAFZ1RJH86bW2Ngxf9LN8cke3QPjk5v2EuJ7B10MlXrkFHb29
	DKkIop9pJnVbDxjsAlN3zyoJLudIeUJdDEJcmCAjdNO7FCcdDdax6Q1/HsUOsdqN1dVFtf
	HF31pY3f9syaPF0lPGVnZw2Fq1Duvvs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-C81ozPSzP5yrp8OW1JpNww-1; Thu,
 10 Sep 2026 16:39:39 -0400
X-MC-Unique: C81ozPSzP5yrp8OW1JpNww-1
X-Mimecast-MFC-AGG-ID: C81ozPSzP5yrp8OW1JpNww_1789072778
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56EF61956040;
	Thu, 10 Sep 2026 20:39:38 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.67])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4844C46E;
	Thu, 10 Sep 2026 20:39:34 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-cxl@vger.kernel.org,
	Zhao Liu <zhao1.liu@intel.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>,
	Markus Armbruster <armbru@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	qemu-block@nongnu.org,
	Ani Sinha <anisinha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 08/10] qapi: convert simple data struct intros for machine.json
Date: Thu, 10 Sep 2026 16:38:54 -0400
Message-ID: <20260910203856.99003-9-jsnow@redhat.com>
In-Reply-To: <20260910203856.99003-1-jsnow@redhat.com>
References: <20260910203856.99003-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 1iTZJbE9YvzEtsChodZixx7KYYQPHmfmUsT6-eBLDWI_1789072778
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine.json | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 942d35d7275..0516112f8e8 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -468,8 +468,7 @@
 
 ##
 # @NumaNodeOptions:
-#
-# Create a guest NUMA node.  (for OptsVisitor)
+#     Create a guest NUMA node.  (for OptsVisitor)
 #
 # @nodeid: NUMA node ID (increase by 1 from 0 if omitted)
 #
@@ -596,11 +595,10 @@
 
 ##
 # @NumaCpuOptions:
-#
-# Option "-numa cpu" overrides default cpu to node mapping.  It
-# accepts the same set of cpu properties as returned by
-# `query-hotpluggable-cpus[].props <query-hotpluggable-cpus>`, where
-# node-id could be used to override default node mapping.
+#     Option "-numa cpu" overrides default cpu to node mapping.  It
+#     accepts the same set of cpu properties as returned by
+#     `query-hotpluggable-cpus[].props <query-hotpluggable-cpus>`,
+#     where node-id could be used to override default node mapping.
 #
 # Since: 2.10
 ##
-- 
2.55.0

