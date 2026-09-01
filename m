Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6ED3C3C02
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291868; cv=none; b=WdSgJXao9v3Guh2q0sC2sQwCZ2d/CVB3kHwG17B+Luqjvm3pN96hsa2CmRtJy81GUbG4+m5uwCWea73Ko0TfeABFFtrA3PscQ4r7hSFr16efZgg3hb21c6Lgq3Vvj98oq5jnvBsMo1FNAbVVtsxypFIyuM2LqZQIh5t4lJCtUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291868; c=relaxed/simple;
	bh=TeDd9mBeSTKbm9i91yShqI1Reqt5Yav4Rs7+hzFoEPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=TdhCuqmKw8dPa1EfYpyMN8oMwzTxzymrH8wl1nDqk+F3Vkw3TMMT3UzSG5ni7IhoUQ+xipwvE0KGeVlXI/HagGCHNAXw0mOVCvCOHUI1ZfJgZqQ5Efv2rcvlkIVG8yJhYH7d7IueeofUmqLslXcwOuR8lBhRfkQX8q8BpZPsTdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MfIma69D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfIma69D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788291866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEm3jbhfxEfB9NqFt69UcYB9HksOABz3KkUOOO4fawM=;
	b=MfIma69D4gosjqRFG7LCZxT43XZzvaChl+iiDUyi1w7sD13OAEEsAktxzxMfZ480fb/eUU
	6uUDy7LSwkKysquSmXFw97oJKVO3ltYxqhwZn/z/wG12lp2wUeWnh6K+xQH0TqbKUitmzY
	iMCOilH14y11d30VThJVRimLhIt8cNo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-HA_aESQJPDaboUZWStkTRA-1; Tue,
 01 Sept 2026 15:44:21 -0400
X-MC-Unique: HA_aESQJPDaboUZWStkTRA-1
X-Mimecast-MFC-AGG-ID: HA_aESQJPDaboUZWStkTRA_1788291860
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3482F1801318;
	Tue,  1 Sep 2026 19:44:20 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D5DB18005B8;
	Tue,  1 Sep 2026 19:44:17 +0000 (UTC)
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
Subject: [PATCH 11/12] qapi: convert simple command intros for machine.json
Date: Tue,  1 Sep 2026 15:43:23 -0400
Message-ID: <20260901194324.458482-12-jsnow@redhat.com>
In-Reply-To: <20260901194324.458482-1-jsnow@redhat.com>
References: <20260901194324.458482-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: WAwKheBpbQGmxRsngT-0XhfW7mFtBpVnXzDChy3hmNQ_1788291860
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine.json | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 8ef12504d65..9d709cb53e0 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -363,11 +363,10 @@
 
 ##
 # @system_wakeup:
-#
-# Wake up guest from suspend.  If the guest has wake-up from suspend
-# support enabled (wakeup-suspend-support flag from
-# `query-current-machine`), wake-up guest from suspend if the guest is
-# in SUSPENDED state.  Return an error otherwise.
+#     Wake up guest from suspend.  If the guest has wake-up from
+#     suspend support enabled (wakeup-suspend-support flag from
+#     `query-current-machine`), wake-up guest from suspend if the
+#     guest is in SUSPENDED state.  Return an error otherwise.
 #
 # Since: 1.1
 #
@@ -415,11 +414,10 @@
 
 ##
 # @inject-nmi:
-#
-# Injects a Non-Maskable Interrupt (machine specific: for example on
-# s390x CCW only the first vCPU receives the NMI, but on x86 machines
-# all vCPUs receive it).  The command fails when the guest doesn't
-# support injecting.
+#     Injects a Non-Maskable Interrupt (machine specific: for example
+#     on s390x CCW only the first vCPU receives the NMI, but on x86
+#     machines all vCPUs receive it).  The command fails when the
+#     guest doesn't support injecting.
 #
 # Since: 0.14
 #
-- 
2.55.0

