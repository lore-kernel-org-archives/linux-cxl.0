Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF84739EF27
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789072796; cv=none; b=YrbulNFVuvZgoBgiJ3RoDbKojdyskSSMzQHq8ThhfW/lQXmNyr37uraEzz8SkLOZXLs+bvRYIbLmNcC/q+A8iTr40wtZxZlM/jAE1uGpuZkmNJgLCPb00bLCwslgh3ELcftrZbfuv9Jd3bbtzORU1uYQxtGp936hqb4NgtTWqJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789072796; c=relaxed/simple;
	bh=UPQBhDMBCDEv8GUZqkRKmf/SYihujW8OK61doe7n3dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=nZ/Ed7h7KeNUmsWInSF1I1HD9SkikaHFeIBND7LeXTx9xr4L9BJGgWlKVYYslGzRMTe7IPePRzq5Kaos4SXmGJ/hJBwYfWvAEMyAxsOX2y5fx4uA2ilZBzPTXmOM8DPNVlvsJmrM1khr4QY7KxRlC+uJ+RH90FHIJMVE0dyAEmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RK6GuWve; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RK6GuWve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789072793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oVdh/U/hl+t1lNTOtBomlf0y6DWWKwSikhllmq16Uw=;
	b=RK6GuWvez2otDCqd+YUXTekdCP4uGPkbMOmAZRBbqWXRu+6UdTAg21UfXBWPV1N6cRa5Q/
	vf5sYJ7zeTHRUzhqeXfZb/3GxwHc2ddlQ9/eYOLT7p0x/OG/wPKfYpCLVYU6U7u5M1e6T4
	yKo6wFZYrEhQaa12rtsGx1ur7rSTKRE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-_j2irIpxMdmDeCCF0TJP5A-1; Thu,
 10 Sep 2026 16:39:50 -0400
X-MC-Unique: _j2irIpxMdmDeCCF0TJP5A-1
X-Mimecast-MFC-AGG-ID: _j2irIpxMdmDeCCF0TJP5A_1789072789
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35BD41955DE4;
	Thu, 10 Sep 2026 20:39:49 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.67])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9880046E;
	Thu, 10 Sep 2026 20:39:44 +0000 (UTC)
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
Subject: [PATCH 10/10] qapi: convert simple alternate intros for common.json
Date: Thu, 10 Sep 2026 16:38:56 -0400
Message-ID: <20260910203856.99003-11-jsnow@redhat.com>
In-Reply-To: <20260910203856.99003-1-jsnow@redhat.com>
References: <20260910203856.99003-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: B2eJ6qbUMaP1kDm2U9a0AHm8gcZ47R7TE5gPW9FarLQ_1789072789
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/common.json | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index c1bbed21e7f..1352e664b23 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -52,10 +52,9 @@
 
 ##
 # @StrOrNull:
-#
-# This is a string value or the explicit lack of a string (null
-# pointer in C).  Intended for cases when 'optional absent' already
-# has a different meaning.
+#     This is a string value or the explicit lack of a string (null
+#     pointer in C).  Intended for cases when 'optional absent'
+#     already has a different meaning.
 #
 # @s: the string value
 #
-- 
2.55.0

