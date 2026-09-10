Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F92D33B970
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789072776; cv=none; b=nvBjbJqCRGmypOqmr1wBuT/FhRixM2lPahL0AE/pzaQDktub1826e/i4cuRcBB5Ihc1gNPqD3crP6F+qywCwrI0hluZpQ3uklxHFwXxQEImgeIVpSrXswc1cy9N+Ca19jVyrtaXVsuVhUyOCI7jRFivKemDkr83yTIC92mtNr7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789072776; c=relaxed/simple;
	bh=ht6+0telUXEGo5Yn5lgDAfWF2W+01KaOIrq5uSYqZ54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Fbq68aBMLkYwMZ1s7alcoTcpOnqTG0wR3UC22ZHmtXnApfba0RreCB3UzmWRp8XHEpkDWAe9q+TysUGAZtxF0t5RcLjr8LohpyBEsoO8iib94kQ8M22kh6G1GTGUJWuGBt/BpmJrQ8c1Vlmp/YS9bl6aGlmhoX0TCAAK1FdefhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJDdnIGM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJDdnIGM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789072770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FrWxswNFhkM6R2+/EkYMXSAdDqzGdHlar+jhDu2czbg=;
	b=AJDdnIGMhh10i63yRSwecanUGmN3gIsiucUilcP4Xn+fAAyfhmd1TDp8DBmIVFoyHSUzQ5
	zddKrXmSiDHB14zZk9w3WMWkFkqhiHKZKtM6OPuXukpPkTMjyXx9CXO9eFPBJneJRIE4Rx
	FIQ2vM9nIeu3y9UvFIKRpwb/2CItqoI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-7LN7M-RtPOeOtkFThUxsVw-1; Thu,
 10 Sep 2026 16:39:26 -0400
X-MC-Unique: 7LN7M-RtPOeOtkFThUxsVw-1
X-Mimecast-MFC-AGG-ID: 7LN7M-RtPOeOtkFThUxsVw_1789072765
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 495061955DE7;
	Thu, 10 Sep 2026 20:39:25 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.67])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 159A446E;
	Thu, 10 Sep 2026 20:39:20 +0000 (UTC)
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
Subject: [PATCH 05/10] qapi: convert simple data struct intros for yank.json
Date: Thu, 10 Sep 2026 16:38:51 -0400
Message-ID: <20260910203856.99003-6-jsnow@redhat.com>
In-Reply-To: <20260910203856.99003-1-jsnow@redhat.com>
References: <20260910203856.99003-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: ffqbx8I9BoYpSIe0G5X7o5TW_7e9oiU4ABwXmooupec_1789072765
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/yank.json | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/qapi/yank.json b/qapi/yank.json
index 85a0c87719d..8ac4b773653 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -20,9 +20,8 @@
 
 ##
 # @YankInstanceBlockNode:
-#
-# Specifies which block graph node to yank.  See `YankInstance` for
-# more information.
+#     Specifies which block graph node to yank.  See `YankInstance`
+#     for more information.
 #
 # @node-name: the name of the block graph node
 #
@@ -33,9 +32,8 @@
 
 ##
 # @YankInstanceChardev:
-#
-# Specifies which character device to yank.  See `YankInstance` for
-# more information.
+#     Specifies which character device to yank.  See `YankInstance`
+#     for more information.
 #
 # @id: the chardev's ID
 #
-- 
2.55.0

