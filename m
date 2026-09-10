Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF2C399361
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789072775; cv=none; b=T5yBF9KsYU6Qd9umpMmY+YrjO5yt602kpn+hDQO+l7KzKWgeJKEtjsQl/WMkwPR5uNXd91Fe3TeZ8acq3/BcMjjeOEMel4ii+4IqtpEGhL/SZlOpJmxbYNxHJzX3Oz/37wn6QUrU26joD3JMGgN98kjLsXA3AB2huOuNpleIDlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789072775; c=relaxed/simple;
	bh=2WSqgAK5Zq+AmsqYFBd7/K4USpL0gjGL8J9yySCoH1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=GXmQmkUqIlksuhp2Gt4nrCO9QYKp1ceBBSrvIZLANvdA48l6UU/iBrUq013c8h55DQo9DhuJq7sbGo9ElwWdZPjmTw0BJ2yUvgxiriM8aa0asoaT1dBpXTVGGXoF+PPX1q+iPBHBYKkCCjjreSASvBKB0FYIn7Pn1VIymLzrI8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHZdM0T8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHZdM0T8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789072766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fUABu7BlZs5TOGp+cN1u54H1gvnduOJJab7bG8qikK0=;
	b=cHZdM0T8cw52hi8KKm4kMjKqb4w6xS79IkhzthIC1504f9/YRG9K56QiqN/qRca/M8SSsK
	HQ0dBD5yIxkXYejAA/wBC6RU9p0uULhttLyW8xt2BjT0Jm/dRrAeDfGG2/65u4fVtrtKVs
	K+9loLHf4m5po8jjS4Wr3oTrlfi1gtY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-lO1aYYb9M-eGA6ApJdREQw-1; Thu,
 10 Sep 2026 16:39:23 -0400
X-MC-Unique: lO1aYYb9M-eGA6ApJdREQw-1
X-Mimecast-MFC-AGG-ID: lO1aYYb9M-eGA6ApJdREQw_1789072760
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A70821953999;
	Thu, 10 Sep 2026 20:39:20 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.67])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D69346E;
	Thu, 10 Sep 2026 20:39:15 +0000 (UTC)
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
Subject: [PATCH 04/10] qapi: convert simple data struct intros for run-state.json
Date: Thu, 10 Sep 2026 16:38:50 -0400
Message-ID: <20260910203856.99003-5-jsnow@redhat.com>
In-Reply-To: <20260910203856.99003-1-jsnow@redhat.com>
References: <20260910203856.99003-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: yT1DHAZSGiE5r4VYEaMn6jNiC9PZwGLPtciMFeYZQI8_1789072760
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/run-state.json | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index 2a968a6bc0b..703ca1bb5b9 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -585,10 +585,9 @@
 
 ##
 # @GuestPanicInformationTdx:
-#
-# TDX Guest panic information specific to TDX, as specified in the
-# "Guest-Hypervisor Communication Interface (GHCI) Specification",
-# section TDG.VP.VMCALL<ReportFatalError>.
+#     TDX Guest panic information specific to TDX, as specified in the
+#     "Guest-Hypervisor Communication Interface (GHCI) Specification",
+#     section TDG.VP.VMCALL<ReportFatalError>.
 #
 # @error-code: TD-specific error code
 #
-- 
2.55.0

