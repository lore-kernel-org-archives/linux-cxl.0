Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C460238A702
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789072753; cv=none; b=suXoqJdojsDLEnefsnqXF7kXp7oHIs6wo9VrGpW/wqMrjm+X1K8WKhEYuPYrqBtQ+zpHjQovsxLI6nAlNd2ry98aYRiB5NzaVSa+uarcXoBHO2tS5kSFYSaqliSo0il5xGVOq9jpNzer00S2z+gwkedGfZ7BWlPM1K35N1Ic31c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789072753; c=relaxed/simple;
	bh=Mc6j9DF+IzYeARsqNN84YhjpH8NuwfZkHSZBcAs6FH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=g7CL+Ku+cFx+Lbyuy095P7rd6nmApA4DZoKHF+1lm1M+O4IvjiDvg+8utQv7Kl2GQ/mLe7vO1VuT8k+xB7VPlK9/JuWEIK+8g4TW303B2xTtT4zLKI2SnBB2Lq3doD2ZkRQo913Io2TwCxEz8FkiYRGnlygU6bearaax6gtHPCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PwzU+8id; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PwzU+8id"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789072750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Nm3OTx4IoHqK9pSr515r7Gsq8ERTZqAYPIc8XjC8d8=;
	b=PwzU+8idKolX1u356Y5PaM3Ol0QiLvr72p/HKD1QzDM5Ni5UKNJAijwTQw2szMV9l1DFUx
	d7kOQJMi6c8eGUtUO2HpEBjNa3PSbJd/egHYFDVEsPDMDLCS1sU4zQFuYYCGvmuqyPc3WB
	s8w4W6BFh/R2A0/mKlXQER+GwO6llEs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-IK6MoQh5POmZpaI9Nzs9aA-1; Thu,
 10 Sep 2026 16:39:08 -0400
X-MC-Unique: IK6MoQh5POmZpaI9Nzs9aA-1
X-Mimecast-MFC-AGG-ID: IK6MoQh5POmZpaI9Nzs9aA_1789072747
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86E1819540DB;
	Thu, 10 Sep 2026 20:39:06 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.67])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F0A6F427;
	Thu, 10 Sep 2026 20:39:01 +0000 (UTC)
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
Subject: [PATCH 01/10] qapi: convert simple data struct intros for uefi.json
Date: Thu, 10 Sep 2026 16:38:47 -0400
Message-ID: <20260910203856.99003-2-jsnow@redhat.com>
In-Reply-To: <20260910203856.99003-1-jsnow@redhat.com>
References: <20260910203856.99003-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: R-3Rn6PM3MoTWMsWCTxqxeBhSiy0HuNrIJ-SxSE960k_1789072747
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/uefi.json | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/qapi/uefi.json b/qapi/uefi.json
index 86f33b234ba..cb2b5e1f531 100644
--- a/qapi/uefi.json
+++ b/qapi/uefi.json
@@ -17,9 +17,8 @@
 
 ##
 # @UefiVariable:
-#
-# UEFI Variable.  Check the UEFI specification for more detailed
-# information on the fields.
+#     UEFI Variable.  Check the UEFI specification for more detailed
+#     information on the fields.
 #
 # @guid: variable namespace GUID
 #
-- 
2.55.0

