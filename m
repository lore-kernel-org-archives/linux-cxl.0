Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088B0218EBA
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 04:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927419; cv=none; b=SfeT2Drajkl90gBhi/LF4Gx+JgpDwd4Z0CYdvliMiAG/rOmWF4xjQTIVS6+cNbhk/2+ugUOmjEugD7FY/ETnc7L7iWrA9wOze/q90GKFqZ2Rp5hsYfBCZjDHBU3F0UkcLQpH+Eop0lfVWLCfMAwRsveAE9JHBCwLmQYeXtMBBBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927419; c=relaxed/simple;
	bh=ZoehS5jFWFkjrpafgG5bFIw1HyKPkv9veUi44zZRG5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=bHwlHjblq0cYwJs4qiOvBNZeyCESJnlR1cCkOZz+q2TePhj3bjVHGjLvkQZ5ewpTh6LAoo9K0hjGvGQp8pvjv7hm2A5oN8g5Huzk5/SAUqV8vDOj7NRLBLW5fhnxPTqzD9CP9Y4qmoca72IeMcAH3Q/Phw2yvx1V+SVlimyySBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RlE6PHLh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlE6PHLh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788927416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0okPsmFlfs4ObwbiSd0f49NDtS1uvD+fABGHYmHcdII=;
	b=RlE6PHLhuehO4HgBTYuwPHhNtBQ7KUESh1hRcBawemPPw9BitquyO5S0Dimi+cXMmSZLOe
	syBmlSNBj4y8G6jono2lzbwj62JXJnWc0aXZ0Cnh1xqWDFf8PBaWi0GlVYM4WNJ/iIkwTc
	eP35KYvUlgdTPRToD2pYHrFsNgDgnGw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-sdsL5G-RPuuGPp-CqiOkkA-1; Wed,
 09 Sep 2026 00:16:53 -0400
X-MC-Unique: sdsL5G-RPuuGPp-CqiOkkA-1
X-Mimecast-MFC-AGG-ID: sdsL5G-RPuuGPp-CqiOkkA_1788927411
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B68A1800669;
	Wed,  9 Sep 2026 04:16:51 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.38])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 80F9D18004D4;
	Wed,  9 Sep 2026 04:16:47 +0000 (UTC)
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
Subject: [PATCH 01/10] qapi: convert simple enum intros for vfio.json
Date: Wed,  9 Sep 2026 00:16:31 -0400
Message-ID: <20260909041640.69080-2-jsnow@redhat.com>
In-Reply-To: <20260909041640.69080-1-jsnow@redhat.com>
References: <20260909041640.69080-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 0w11qiTCIKKYNp5E8HYv6cGQwm6oQ9yDa6xmKCi0zMo_1788927411
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/vfio.json | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/qapi/vfio.json b/qapi/vfio.json
index 3d61fc38ecd..47fff8b979d 100644
--- a/qapi/vfio.json
+++ b/qapi/vfio.json
@@ -10,14 +10,13 @@
 
 ##
 # @QapiVfioMigrationState:
-#
-# An enumeration of the VFIO device migration states.  In addition to
-# the regular states, there are prepare states (with 'prepare' suffix)
-# which indicate that the device is just about to transition to the
-# corresponding state.  Note that seeing a prepare state for state X
-# doesn't guarantee that the next state will be X, as the state
-# transition can fail and the device may transition to a different
-# state instead.
+#     An enumeration of the VFIO device migration states.  In addition
+#     to the regular states, there are prepare states (with 'prepare'
+#     suffix) which indicate that the device is just about to
+#     transition to the corresponding state.  Note that seeing a
+#     prepare state for state X doesn't guarantee that the next state
+#     will be X, as the state transition can fail and the device may
+#     transition to a different state instead.
 #
 # @stop: The device is stopped.
 #
-- 
2.55.0

