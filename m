Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659F01A262A
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 04:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927426; cv=none; b=IH+slbqAPwNPTptRChlbH76rKpnUObBvK9u4bvjcUyA9L4JoP28wb3IH83pDzoS2yPaZHrcRWixuQ56csxnENjYe3NzR5RHzFl/GCAA1V8QdTEHNVJxm6yWpWhleypbLPxxjiiIjwn8+Dbd+LjoJpLu2AJmsrWYcu2+v3+QQ96I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927426; c=relaxed/simple;
	bh=sXgGScBvCwz87Cs7VhTkaO+rzVXbSSySsS3TOnEdIPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rF1r9u+absv106hLBjEUf6HdPKsR0fDcTNr4nig3kgifSJCdYoa4XqFD1MN7ydo4c7aNfQWK59SlNCaGK5qIr77awLklKI4NHAJZ91mEbOT1lvoXPet3XBG5oJkXe+y1qmdwSFMxgkYiNMfm9dS+2IPP+J6fheLP5DtzM4HT0I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jEYHDHfA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEYHDHfA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788927423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQEfE5iZfkOn00N2sK76lX2cnib3m/GbdAsw9h0W70k=;
	b=jEYHDHfAFHEje8OLrOFaVmKranNp7LZGaVCwZGuNhHPj3M7Lr/CF+z1ky9vKYIowsJk/nj
	U3Sx2SsJbihuu2ieOFz3I0LQbC7sYH0AfZXKhLM+eSTOHkoUE4LdYPwQkqyfdHyjd8IaYn
	ol9Q842IGT9fqKnGufSWmG/2trn4Jdg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-fAd8-FnVNmC-Ei6srGyIjw-1; Wed,
 09 Sep 2026 00:17:00 -0400
X-MC-Unique: fAd8-FnVNmC-Ei6srGyIjw-1
X-Mimecast-MFC-AGG-ID: fAd8-FnVNmC-Ei6srGyIjw_1788927418
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B5611800473;
	Wed,  9 Sep 2026 04:16:58 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.38])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C82D1800473;
	Wed,  9 Sep 2026 04:16:54 +0000 (UTC)
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
Subject: [PATCH 03/10] qapi: convert simple enum intros for introspect.json
Date: Wed,  9 Sep 2026 00:16:33 -0400
Message-ID: <20260909041640.69080-4-jsnow@redhat.com>
In-Reply-To: <20260909041640.69080-1-jsnow@redhat.com>
References: <20260909041640.69080-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: G2dkMUIRt1wACol-YW1X1pkpI2Smj9m6ty25XnMDOes_1788927418
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/introspect.json | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index 172ed389997..bd42aac3358 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -55,9 +55,8 @@
 
 ##
 # @SchemaMetaType:
-#
-# This is a `SchemaInfo`'s meta type, i.e. the kind of entity it
-# describes.
+#     This is a `SchemaInfo`'s meta type, i.e. the kind of entity it
+#     describes.
 #
 # @builtin: a predefined type such as 'int' or 'bool'.
 #
-- 
2.55.0

