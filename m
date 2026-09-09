Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36A21D7E5C
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 04:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927439; cv=none; b=bYm9FREW7GDAQ/yx3dkIRuHbzVtObYzu8iv9NgP3K0iQcBNYvSfrxA+6VJFHa5dPWHGrC3OcRLU4KwgstE3dn/jg4OAlJ1o4/G4QZX28MVOr8nJE/14H/iJPR/SpaoCQQ41ol4PgWig0jQRRxxqy2+Rce3JIK5rQtdavrNInP+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927439; c=relaxed/simple;
	bh=OROzdXZR/mtpYbrPtbX+Vo2OzEHftdlXPcfu6gRNp3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=FMNvZRf6Su4bePQShuRKwlARU7ISaAG59hk3Uvh9HX0Gq3gKwX+Y5TsZeVbFeQsZ991v8NteIm/btWBVgzSutnuFHKfwn56WHirsUOXzSvN6Zv3EVWxtj/7q4JRFqcfqQy2HmuL3cFf/ZQ5sOaUNWRcEb9z2Ux6RFusY/30wePQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UnfHWKSs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnfHWKSs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788927436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cD0/lPIzLB41AJcIN2l3as2prTxPDaHKVriuFlT4wb8=;
	b=UnfHWKSs9CrfN/mpoUoJxJ2Ju4AASYSRMZuyYbDWbsZD9OSQtzlgZuozVFXtUf+FiljQCJ
	98viZeWFkTa40xfk0PtSx7xC7VdIiqNvYEOlYFx/jLWhVPmPysuJhyV9bRY7CDTJ/G3j2T
	1seFA+XBcaDrk3tILHU4X1//7H54SnA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-0he68DGEP_iZGAKHR4uZLA-1; Wed,
 09 Sep 2026 00:17:14 -0400
X-MC-Unique: 0he68DGEP_iZGAKHR4uZLA-1
X-Mimecast-MFC-AGG-ID: 0he68DGEP_iZGAKHR4uZLA_1788927433
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 085CC1954B08;
	Wed,  9 Sep 2026 04:17:13 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.38])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E5E41800473;
	Wed,  9 Sep 2026 04:17:08 +0000 (UTC)
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
Subject: [PATCH 07/10] qapi: convert simple enum intros for yank.json
Date: Wed,  9 Sep 2026 00:16:37 -0400
Message-ID: <20260909041640.69080-8-jsnow@redhat.com>
In-Reply-To: <20260909041640.69080-1-jsnow@redhat.com>
References: <20260909041640.69080-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: wkrE6Wul8CyUZHtUuRKn77SSPslyqq8BkXOGpbOpbus_1788927433
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/yank.json | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/qapi/yank.json b/qapi/yank.json
index 9a5aea82f1d..85a0c87719d 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -10,9 +10,8 @@
 
 ##
 # @YankInstanceType:
-#
-# An enumeration of yank instance types.  See `YankInstance` for more
-# information.
+#     An enumeration of yank instance types.  See `YankInstance` for
+#     more information.
 #
 # Since: 6.0
 ##
-- 
2.55.0

