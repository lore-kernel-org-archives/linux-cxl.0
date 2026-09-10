Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6647139CCEB
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 20:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789072762; cv=none; b=t5wPLi18AP+BdPzuBwHUlfLQMfytTaTBRHijruJzGR3QWFfnvkqKmcdzSKngre5eaFa2Mn7K2I2vGNr6PnQis7tGkg22FECmbr8XBLEuc/tGHuXP06quAmSrAWvImEbEtTSYS0cJzW3KBmdd23RLQmyw/BF/7zkjOB2sSg0tAnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789072762; c=relaxed/simple;
	bh=CsWIjAbkxHS3JOa34DgAc20I7bsUbDFeHAzuMKColEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Gy7urtuVM8U8PlUr/dNSeGokwB0atCfwp9A2GSiKpBdQNNcYmlUlb9/n0a77oraku8p+Zg4KCVA72q4QmGvBgR9S8vmajBrl9lxZqp9c7IkxQlD6wIMc9xOlbocefO85lfQXwB/e4U8sXfVgkbBv7hav6ugVicdiqHdjCuyeN/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WIn4Ms6x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIn4Ms6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789072758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXxWN3SU1s4iR8FDzmQ6WNtVB2u27GL/Dy+0nd++R64=;
	b=WIn4Ms6xcD+YBV36Ze20uUK19RQSVauctxHwN7KAujm5FFVdiz5zALjDkt+ujldzf7oTOx
	slK9M5gVTd7GKLn4D3fpLpDqHhacQzMJPrMA5c9ojafaDKvgEQzPcLe77fpeANEhRLHS2y
	f1qVxmaGrjjm5rw7Xp87GBejARwFp5c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-qkU6vMMWOlqn0BI8OF2XSw-1; Thu,
 10 Sep 2026 16:39:13 -0400
X-MC-Unique: qkU6vMMWOlqn0BI8OF2XSw-1
X-Mimecast-MFC-AGG-ID: qkU6vMMWOlqn0BI8OF2XSw_1789072751
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 461C61954226;
	Thu, 10 Sep 2026 20:39:11 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.67])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB37941B;
	Thu, 10 Sep 2026 20:39:06 +0000 (UTC)
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
Subject: [PATCH 02/10] qapi: convert simple data struct intros for misc-arm.json
Date: Thu, 10 Sep 2026 16:38:48 -0400
Message-ID: <20260910203856.99003-3-jsnow@redhat.com>
In-Reply-To: <20260910203856.99003-1-jsnow@redhat.com>
References: <20260910203856.99003-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: hoIQ1oZHn9NOuQrjifS8Mzktybq8qrXJk4NszEEpW-Q_1789072751
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/misc-arm.json | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
index a7b5498d2d3..8cb2ea77951 100644
--- a/qapi/misc-arm.json
+++ b/qapi/misc-arm.json
@@ -5,11 +5,10 @@
 
 ##
 # @GICCapability:
-#
-# The struct describes capability for a specific GIC (Generic
-# Interrupt Controller) version.  These bits are not only decided by
-# QEMU/KVM software version, but also decided by the hardware that the
-# program is running upon.
+#     The struct describes capability for a specific GIC (Generic
+#     Interrupt Controller) version.  These bits are not only decided
+#     by QEMU/KVM software version, but also decided by the hardware
+#     that the program is running upon.
 #
 # @version: version of GIC to be described.  Currently, only 2 and 3
 #     are supported.
-- 
2.55.0

