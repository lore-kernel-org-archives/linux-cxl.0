Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3D01A262A
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 04:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927429; cv=none; b=gO3FA0hxyJO3yTHzSD7CSVGFx9RoDC7N1FeaaPhZwcBolsjkmfWuWOouhxZJ1f5vmBEPINcNEhJqAzaCuJxoLxN+qqorSyJqFlh+ad3yDSnD1Ux1X+l25VT5Y9Y0u1zW/ycuqcouC8dL4Ake2nGY4EhEkkOuWWWPwjTX1XgG1dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927429; c=relaxed/simple;
	bh=q7ucN8Da0ONRSFSUiSGdf2NVlfdGfAomO+Jer3hzGQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=PC1mzpDuMybNBDtkO4EEVFvgka/Nj4z5aa5G3Vve9Kvu0zZTyQZlzUiQlvd0gELOAhl+BgBoQO0lpClmkKl3/90x7HPIb7PNVhrscdaZeXqzcnAiFj9hO28rHJeQHJryjr/siAC73mql6BkejkDh2DjrFzeNdIJN6csOLX0Oogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XqFmjyG7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqFmjyG7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788927427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=doB/hzjdp2X1hCumSaccX92yzBrODr0IkiwunZ8gXm0=;
	b=XqFmjyG7/Ec2UgFQMIAnS5AzMTlWpQ0w86bOYy9KuAbMCUfV/vBnqPuxzsl16o5GwQUpJA
	/qOv5KJUnUk0pPvdyerhBmp/s9jAX+uHcZndzast0Q7aDK3aUUeabziAKtAMxCCKt6KXr4
	uX5uu11RdbQS21Tr1/I1QWkV9q7A9Qg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-nHBk06jhMzye75B7v1Y6nw-1; Wed,
 09 Sep 2026 00:17:04 -0400
X-MC-Unique: nHBk06jhMzye75B7v1Y6nw-1
X-Mimecast-MFC-AGG-ID: nHBk06jhMzye75B7v1Y6nw_1788927422
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 691FE1954B08;
	Wed,  9 Sep 2026 04:17:02 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.38])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA00F1800473;
	Wed,  9 Sep 2026 04:16:58 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	qemu-block@nongnu.org,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lukas Straub <lukasstraub2@web.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Hanna Reitz <hreitz@redhat.com>,
	linux-cxl@vger.kernel.org,
	Kevin Wolf <kwolf@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 04/10] qapi: convert simple enum intros for block.json
Date: Wed,  9 Sep 2026 00:16:34 -0400
Message-ID: <20260909041640.69080-5-jsnow@redhat.com>
In-Reply-To: <20260909041640.69080-1-jsnow@redhat.com>
References: <20260909041640.69080-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 6zVTnFc2BX4bu5TeSRnUy4DOo5Z19ayHAyPpyXfz878_1788927422
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block.json | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 9569afc6e0f..e47592d5500 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -16,11 +16,10 @@
 
 ##
 # @BiosAtaTranslation:
-#
-# Policy that BIOS should use to interpret cylinder/head/sector
-# addresses.  Note that Bochs BIOS and SeaBIOS will not actually
-# translate logical CHS to physical; instead, they will use logical
-# block addressing.
+#     Policy that BIOS should use to interpret cylinder/head/sector
+#     addresses.  Note that Bochs BIOS and SeaBIOS will not actually
+#     translate logical CHS to physical; instead, they will use
+#     logical block addressing.
 #
 # @auto: If cylinder/heads/sizes are passed, choose between none and
 #     LBA depending on the size of the disk.  If they are not passed,
-- 
2.55.0

