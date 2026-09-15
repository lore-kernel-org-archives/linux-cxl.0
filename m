Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9DB3DB994
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789485122; cv=none; b=bVHhyoq8kj9JcVKoob2MqlNMErnxwjLbEHG23Q/yVarGLcNgd81g+jntKsspQoC8qeVM9mrorA/7wbDeRkDAZ0KvL6xmtXgpVczvggXrhrA/6KSr0cu4mE29nalEXXFqKHLSh8VQaUR0Tw0vx0GcXEFlUoDL3N7d3zRVebwVNmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789485122; c=relaxed/simple;
	bh=wTwGo027G09ny0Oezhb8fiL95bd/OgKGCgd0x9bhGME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=kaBjAhlWo/jtasHRkQ6b5IPPS6FcsrwpFLbnc7BjmgLZZBheOWw5afRLMQcz7uTmqe8s1vDHclK/SadKUJkMA9Dmn/TPhLdi3gnIhjD4MU8nRnbksU5S035uaiZtFKYqcGpHKiDviGchUdVNmirOGjBqlHBO6vC1TirQwJyDVOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X4PyW0w0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4PyW0w0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789485120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kqnCn6G38OWUssJgOIyQiwhSLKRNKgZZBvo5dTe58DE=;
	b=X4PyW0w0pOCcmQwN7aGQvNwq6uXyMB7wRNvAQTppIdWVX6o8kYqwOXk3U50uPGSGF58FSs
	hJvVwq2GHrWsX4+inHOFDS8vCv8B7B4GDKJ/SfrMx+93rbJgHqp2T+ap2KJJ/6m1SO2a3N
	Zu/M79n4ngqO1vmqKnLmFtEalhRgMmg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-41nLmPF9My6Bm6Da_F6EBQ-1; Tue,
 15 Sep 2026 11:11:56 -0400
X-MC-Unique: 41nLmPF9My6Bm6Da_F6EBQ-1
X-Mimecast-MFC-AGG-ID: 41nLmPF9My6Bm6Da_F6EBQ_1789485114
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 171E7195604A;
	Tue, 15 Sep 2026 15:11:54 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B02D2195604C;
	Tue, 15 Sep 2026 15:11:48 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Wolf <kwolf@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Michael Roth <michael.roth@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Lukas Straub <lukasstraub2@web.de>,
	Eric Blake <eblake@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	linux-cxl@vger.kernel.org,
	Zhao Liu <zhao1.liu@intel.com>,
	qemu-block@nongnu.org,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v2 3/7] qapi: convert remaining simple intros for machine.json
Date: Tue, 15 Sep 2026 11:11:23 -0400
Message-ID: <20260915151127.1002244-4-jsnow@redhat.com>
In-Reply-To: <20260915151127.1002244-1-jsnow@redhat.com>
References: <20260915151127.1002244-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: P9Fd5sL44lcll_EseJywzUjfs58zZsQDud2Wd1Qs2J4_1789485114
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

These are either structs or unions that are used in an inlinable
context: i.e. the generated documentation is likely to feature a
version of this documentation block that does not include the intro in
context of another command, event, or structure.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine.json | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 0516112f8e8..13875fc4642 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -449,8 +449,7 @@
 
 ##
 # @NumaOptions:
-#
-# A discriminated record of NUMA options.  (for OptsVisitor)
+#     A discriminated record of NUMA options.  (for OptsVisitor)
 #
 # @type: NUMA option type
 #
-- 
2.55.0

