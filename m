Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E891139B943
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 19:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291861; cv=none; b=eJYL2bw96M9uHwp+ND9OSboW1zieDYILIWMyTPOput4Pr8xMSDGKGftxHma8aNg5RGstXQXiaZ1ldSYFEV7jMAX9sikMNWt6y8TGOWgU5ovfdXK9riQ+AxYVbiTXvqNHNujzSy7TJ8duTI55Rz2FUqpVl04EJkjppUijLxdmh60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291861; c=relaxed/simple;
	bh=mIiD9tJRaVkH75tRkRjDrs55hesbT/c0Ikqmqx9ESYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=JkIVoMLJm3Ef7ahAmPrEVMUnC8ciVl1221Xvcp9mUFF6icWJnHEK1f0A92WDrKug0M+OWGivvbhyFk68mNDfL9H9W2ErpGqRP4X1G9D0ks/uE3DPcDuzggEULxcuQyeBXBjKWnck35wWCK9mHpCrdvD7f4CGjXAjGTjsfXdwutw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HnEuXBfO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnEuXBfO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788291859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56GpzzxQkj4sqOVcxXu8qG8xkGqe1TldQRWukquGXYg=;
	b=HnEuXBfOmSIgjkqB3aaGBq2ixZcD3fLmZAMhQr2d5wofhd6gfIT2qGgdqdz+2wCZgzf68o
	MvGE8oTe4e/YoqXvWnQsS/G7CTAUpIEuQyFkODC5mWz5+3s5aqE8h7NTInJ2Fhl1DQj6kr
	jyOr5NlCdhNle5RYDnlvErkD9YG95AM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-4yXmz6RVPZOCKP_t5qIgjA-1; Tue,
 01 Sept 2026 15:44:14 -0400
X-MC-Unique: 4yXmz6RVPZOCKP_t5qIgjA-1
X-Mimecast-MFC-AGG-ID: 4yXmz6RVPZOCKP_t5qIgjA_1788291853
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48B4519560BB;
	Tue,  1 Sep 2026 19:44:13 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B8B2318005B8;
	Tue,  1 Sep 2026 19:44:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Ani Sinha <anisinha@redhat.com>,
	qemu-block@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>,
	Fabiano Rosas <farosas@suse.de>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Peter Xu <peterx@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 09/12] qapi: convert simple command intros for ui.json
Date: Tue,  1 Sep 2026 15:43:21 -0400
Message-ID: <20260901194324.458482-10-jsnow@redhat.com>
In-Reply-To: <20260901194324.458482-1-jsnow@redhat.com>
References: <20260901194324.458482-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: rnk2EJU-lTYDTlWFhVbkTkjLv6Qkrh1KJfbAjJusDqs_1788291853
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/ui.json | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 960d02d1429..a59cd635774 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -656,8 +656,7 @@
 
 ##
 # @query-vnc-servers:
-#
-# Return a list of vnc servers.  The list can be empty.
+#     Return a list of vnc servers.  The list can be empty.
 #
 # Since: 2.3
 ##
@@ -1634,10 +1633,10 @@
 
 ##
 # @client_migrate_info:
-#
-# Set migration information for remote display.  This makes the server
-# ask the client to automatically reconnect using the new parameters
-# once migration finished successfully.  Only implemented for SPICE.
+#     Set migration information for remote display.  This makes the
+#     server ask the client to automatically reconnect using the new
+#     parameters once migration finished successfully.  Only
+#     implemented for SPICE.
 #
 # @protocol: must be "spice"
 #
-- 
2.55.0

