Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEE83AD509
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291832; cv=none; b=mexglolX948gQPHRF/UzQDryiREfJXpoO6Q0J81XFnfYomMWUmJsO+3Ws90KQeNWpZ6WU6R6qDad2aXr/y4mvlvXUCcU2WnNN+EwsspfTM/BwvEEccMccythBzB6/SEHihuWL//b2CLPwq6j0cIB+GScTMyYEgMr+5E/VQQ4vLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291832; c=relaxed/simple;
	bh=O91v6GVmN4vPqM9010HQNnNPqd+MwnLLA4TQVqY3O68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KIK7L7B3tqFlbsvckIIW6Pj7OnsgygXIXpbVIoWX3CdnlJVSxdYs9ZYZTzvi2al4q+jqeZ0UhUEevoMnXH0XoJZANo6oNwasOBsByTVTRYy2QJgksyIEYy1KspQRb58vBOb0mx6e9dxtB7dNgMvabq1Z5QOW/T6gVJ7kPJ0VZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HL9bk4WE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HL9bk4WE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788291829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDvvBQCtIfYP0uMu3S9DapRpMxcggXPa9nmItdhvSHg=;
	b=HL9bk4WES2beoh6t5yeoUn1OoWB/x0UgDE1GlpyI2/OAlRHrobMRDjTtM63Dmc5y7F1A6e
	cAU+4ktfV15dzxyg5DXaWg6AgrGqEHdVdP9sTb+kbFD1bFes+8jXi/GpB6HH7W5KCTVS2G
	XRoVeoBeUU3XhpuGuNmJ5Q5Ccqv1ybE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-zzKoeMejNe6WcujLu7Zo4g-1; Tue,
 01 Sept 2026 15:43:44 -0400
X-MC-Unique: zzKoeMejNe6WcujLu7Zo4g-1
X-Mimecast-MFC-AGG-ID: zzKoeMejNe6WcujLu7Zo4g_1788291822
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9469D1955BE0;
	Tue,  1 Sep 2026 19:43:41 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9860818005B8;
	Tue,  1 Sep 2026 19:43:37 +0000 (UTC)
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
Subject: [PATCH 02/12] qapi: convert simple command intros for yank.json
Date: Tue,  1 Sep 2026 15:43:14 -0400
Message-ID: <20260901194324.458482-3-jsnow@redhat.com>
In-Reply-To: <20260901194324.458482-1-jsnow@redhat.com>
References: <20260901194324.458482-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: CqghtnJJzJLQVVVvkUHE03gSmbABX8hdQeK2oU3DzvY_1788291822
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/yank.json | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/qapi/yank.json b/qapi/yank.json
index bc8c52bda74..9a5aea82f1d 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -73,9 +73,8 @@
 
 ##
 # @yank:
-#
-# Try to recover from hanging QEMU by yanking the specified instances.
-# See `YankInstance` for more information.
+#     Try to recover from hanging QEMU by yanking the specified
+#     instances.  See `YankInstance` for more information.
 #
 # @instances: the instances to be yanked
 #
-- 
2.55.0

