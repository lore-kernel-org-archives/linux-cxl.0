Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF7039A04A
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 20:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789072764; cv=none; b=qflsYaMpRqk6QVA7z56sJ8Wv64TaPeyWkclZD5IZ67EBLoCKjr5GZ8KVoYnlWeOb9R6uGGCt0jXWXz0tk+JMIimopwn3rrn622Zxg9TMZitBB20sP8z5n6qBk1S+R8/eiSqy3qXeIrB8GdbKKVM1M5RB8KbMbI+vgCz5Ix4eAW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789072764; c=relaxed/simple;
	bh=BuuWCR/Se/BplPyE39gcT2TwcrfEZc3DbhMC5A5yp9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=gcfOUNz5fT+eRpSO3DlOtV7jgs7hlUjujfzjQPrAXz6eGRAJtUHxZD68TYDbziFhP8Cgp2k5JvIydgqs2o2LrBsi80pEQwNsVUevOOG7+xp3FL9/F9R2mdGk81ihxnr76XFnidHAS8cNlKUdYm21asdGxoXsuJyWWBKmcb4wsx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/TPdVv9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/TPdVv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789072760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M057Hq5CuXfmeH7PfoJqacdVQJKl6DJDfCDGYRxoALE=;
	b=P/TPdVv954YayBb9kba3W9O+Q0huQxwMO0QYgJOlcqYtBTGaLa5vURffm1N+H5sgAHgVIc
	4VEu/PA2+s3xzliZeSyYt8AuyPel/hHnmfmVGm+aGvDS7OZ8TiMvDG982M5j2uM5rt47EJ
	IscSTHFDjfO1C+Gmzw3M5FxavLmgTvU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-p8kDDwrqOqykuAsyUbNN5A-1; Thu,
 10 Sep 2026 16:39:17 -0400
X-MC-Unique: p8kDDwrqOqykuAsyUbNN5A-1
X-Mimecast-MFC-AGG-ID: p8kDDwrqOqykuAsyUbNN5A_1789072755
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 713F21800BDB;
	Thu, 10 Sep 2026 20:39:15 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.67])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A26D41B;
	Thu, 10 Sep 2026 20:39:11 +0000 (UTC)
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
Subject: [PATCH 03/10] qapi: convert simple data struct intros for acpi.json
Date: Thu, 10 Sep 2026 16:38:49 -0400
Message-ID: <20260910203856.99003-4-jsnow@redhat.com>
In-Reply-To: <20260910203856.99003-1-jsnow@redhat.com>
References: <20260910203856.99003-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: P8PSiwWs4ryh4atOyiPqiQ1ZBw7HJ3Q7PzfS3hBFDoU_1789072755
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/acpi.json | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/qapi/acpi.json b/qapi/acpi.json
index d2c59df30b2..291a04a7ea4 100644
--- a/qapi/acpi.json
+++ b/qapi/acpi.json
@@ -81,10 +81,9 @@
 
 ##
 # @ACPIOSTInfo:
-#
-# OSPM Status Indication for a device.  For description of possible
-# values of @source and @status fields see "_OST (OSPM Status
-# Indication)" chapter of ACPI5.0 spec.
+#     OSPM Status Indication for a device.  For description
+#     of possible values of @source and @status fields see "_OST (OSPM
+#     Status Indication)" chapter of ACPI5.0 spec.
 #
 # @device: device ID associated with slot
 #
-- 
2.55.0

