Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B01218EBA
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 04:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927422; cv=none; b=kkFr4Q2Qz8f79IH8ZzFmjw6FvO4E/xJnLPx4dIwFrtVNHNnm6D26up4m5RJjXkAWVyF+IPpzRneMHkFSRSgH4a+LVBYM3cs3L6RmciMZZj2DxUiO5ZpYeN8I9wwkmJ1PrQ4iUKXUHS/ttuekM6CLs1amkjVwaVQchfpPnJszIrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927422; c=relaxed/simple;
	bh=fR+EQkQh8ybETesOTNvV9IQmw9osn9djxtwhxR6Tr6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=mLzlDTUZhoc7h2YwhvOnXZcnm/JtmIFi2VejvDShkKZNG32KE6kZDEWLKx1ionRl9M4ZPaX8l9ny+XCLSOgaeYxyKGCd7OcbNVW3sWGYQZNNsTNlTEAB4sIlfsr0RbZrxOMqGQRxoAzqNo5iPvYHeNdiNCSicQWegJ83eNs6TSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M45SigEV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M45SigEV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788927419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0zoPscChtOxc0zZggbWSi1wZ6T3QilBg/gBHqx9rDU=;
	b=M45SigEVVWhR++NTmQFd47LwPYxz0XLRdzL2yEArVzDD+olyx1oThfTzmbJUZRLWxbBKS1
	UMtW5SMDhKc9a0qau5LmT5FPy/LLHrqUZ4WrwBSldWQuPhkqPOrEFgan0iSGMtYl48zmow
	MfR4UIGNl8godV3s6wUUuI50iJEH0r8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-AyVIHJdwMam5Hdf66tbFBA-1; Wed,
 09 Sep 2026 00:16:56 -0400
X-MC-Unique: AyVIHJdwMam5Hdf66tbFBA-1
X-Mimecast-MFC-AGG-ID: AyVIHJdwMam5Hdf66tbFBA_1788927415
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D943F19541B8;
	Wed,  9 Sep 2026 04:16:54 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.38])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 736AB1800370;
	Wed,  9 Sep 2026 04:16:51 +0000 (UTC)
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
Subject: [PATCH 02/10] qapi: convert simple enum intros for machine-common.json
Date: Wed,  9 Sep 2026 00:16:32 -0400
Message-ID: <20260909041640.69080-3-jsnow@redhat.com>
In-Reply-To: <20260909041640.69080-1-jsnow@redhat.com>
References: <20260909041640.69080-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: PHpYxtp783nbbCe0nUjrtVR7pPsBsUbMKMp1HayOoKM_1788927415
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine-common.json | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/qapi/machine-common.json b/qapi/machine-common.json
index fdb0e68d9e6..0b07811df07 100644
--- a/qapi/machine-common.json
+++ b/qapi/machine-common.json
@@ -63,9 +63,8 @@
 
 ##
 # @CacheLevelAndType:
-#
-# Caches a system may have.  The enumeration value here is the
-# combination of cache level and cache type.
+#     Caches a system may have.  The enumeration value here is the
+#     combination of cache level and cache type.
 #
 # @l1d: L1 data cache.
 #
-- 
2.55.0

