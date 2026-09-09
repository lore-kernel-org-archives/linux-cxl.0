Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBD31A262A
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 04:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927432; cv=none; b=EtVo9j/60fefpg2KtngwOGfIG6b3TijayJmjarv2F8LvVuQr2H2qfCk/mekCaG8xuVyGiXF1XU3jL3nTYd3TIWZipEhgEjeUMBxrzipd/I4812CMAhJj3g/l5CPk+IG4m/jTrqz/iXGS4TYzPtOB/9nI1pq/V5RbuBTP+Z2eLUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927432; c=relaxed/simple;
	bh=T59IVaYH1OweZbV63V8DJksW4vlzCL72gDR+VZIJmVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=uLoM0dJ3KGuzunrggEtIIT3WGrpFQa/ucttccFtf/tr8jzPiLFunrfmghEpDCh3N1KgR4zuZReJEeocc1FjPx/+UXjHnQ1lwK/LXYnMHvzn5agh0wOVYbyWEXnHVZ4QDu0YZnYunOOcK/FXCseBTqjWxsla2KrNOhSgJjHGINe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUnJkiUU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUnJkiUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788927430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GJv7qyWi217tPFTj0YVcoCML2GVR1dwSHdfok6KPC5Q=;
	b=UUnJkiUUOzTTNlgQruG6VoBmTEexKRiuooOAMBMrKNE8IiXA/9tTPVZwIrFkknMkZVVx2E
	bo8pkFUK+Xlf4/uA1NFqKIai3oiA1Y0XYYHHN0gi9i+c9G554dI+91Ykn8Q7Im+iaOsnoC
	wDMe9+PWoIcrWvWYtbTpbKEiZYfZm3U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-XM9bn1eIO6eZXovImfyStg-1; Wed,
 09 Sep 2026 00:17:06 -0400
X-MC-Unique: XM9bn1eIO6eZXovImfyStg-1
X-Mimecast-MFC-AGG-ID: XM9bn1eIO6eZXovImfyStg_1788927425
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FC4D1955D81;
	Wed,  9 Sep 2026 04:17:05 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.38])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A159E18004D4;
	Wed,  9 Sep 2026 04:17:02 +0000 (UTC)
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
Subject: [PATCH 05/10] qapi: convert simple enum intros for cypto.json
Date: Wed,  9 Sep 2026 00:16:35 -0400
Message-ID: <20260909041640.69080-6-jsnow@redhat.com>
In-Reply-To: <20260909041640.69080-1-jsnow@redhat.com>
References: <20260909041640.69080-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: X3Vc6sbNJJrDtjWLdazyh9TqxYIIKv5RMmKqvmpAgvA_1788927425
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/crypto.json | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index 5e395bc10c7..f85d1cebed3 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -10,10 +10,10 @@
 
 ##
 # @QCryptoTLSCredsEndpoint:
-#
-# The type of network endpoint that will be using the credentials.
-# Most types of credential require different setup / structures
-# depending on whether they will be used in a server versus a client.
+#     The type of network endpoint that will be using the credentials.
+#     Most types of credential require different setup / structures
+#     depending on whether they will be used in a server versus a
+#     client.
 #
 # @client: the network endpoint is acting as the client
 #
@@ -126,11 +126,11 @@
 
 ##
 # @QCryptoIVGenAlgo:
-#
-# The supported algorithms for generating initialization vectors for
-# full disk encryption.  The 'plain' generator should not be used for
-# disks with sector numbers larger than 2^32, except where
-# compatibility with pre-existing Linux dm-crypt volumes is required.
+#     The supported algorithms for generating initialization vectors
+#     for full disk encryption.  The 'plain' generator should not be
+#     used for disks with sector numbers larger than 2^32, except
+#     where compatibility with pre-existing Linux dm-crypt volumes is
+#     required.
 #
 # @plain: 64-bit sector number truncated to 32-bits
 #
-- 
2.55.0

