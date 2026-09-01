Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E94B3C2788
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291850; cv=none; b=T4Vm9KGqfxKwL3KeePUhKrV15tdWsPtySyd/hd2McitkQeYY2woZiIZj9U/H2TraDEL/nWwydgtxlpogD6Snp9xCCKGMWzOfQdRmqtjesNVqkTuoR6O14+eBlXF/muEHLFwym00G0SJqzlTibt/rLQUG7jju5Oe/dWkC7bWBtsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291850; c=relaxed/simple;
	bh=UH0u0qgx8pWbTNNH2nL0xI2QtdkF0x6LWNQ4mhOUjD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Bj6oy6ryMdy3YaNmxGYWKyKoJLCfvSTLmJLjEB4fLNwhTpj37A7C7SAs+h/H7eToA7OArRARxUwlYoYgla9NP6rd5+6VUAP+gsUHGDm27s4fx3AztpoVkVI0yp94Fha8a6wDrPJlyriCIUvfxNR3efH9dl0JzSRpmn+W+tTaDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hoCarAPe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoCarAPe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788291848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EhEPoJOfAPJl4Q3bWi/DoXMalBBiohSqVhqdrnGXTGk=;
	b=hoCarAPeCAUt+iiB8Cu4wYwHLsxfDlru+KRvGoRU+fmhp68VkXXDPogbLKV7s7KJpZGqeo
	iuY1rDcCbXeCva7tTJWYNFCeTJ1X4JDrNBLDus5sGCa1sbGh+p6CwzseQzUiv/2Zco9nMa
	Krz1uVLyTvrvJf0jHIuFD4KDeadZ/1A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-005aYDdtPKyfxZWVS1Ysrg-1; Tue,
 01 Sept 2026 15:44:06 -0400
X-MC-Unique: 005aYDdtPKyfxZWVS1Ysrg-1
X-Mimecast-MFC-AGG-ID: 005aYDdtPKyfxZWVS1Ysrg_1788291845
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4514B1844069;
	Tue,  1 Sep 2026 19:44:05 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C92B18005B8;
	Tue,  1 Sep 2026 19:44:00 +0000 (UTC)
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
Subject: [PATCH 07/12] qapi: convert simple command intros for block.json
Date: Tue,  1 Sep 2026 15:43:19 -0400
Message-ID: <20260901194324.458482-8-jsnow@redhat.com>
In-Reply-To: <20260901194324.458482-1-jsnow@redhat.com>
References: <20260901194324.458482-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: xQL5oKLvtrUMiIMJAgQvUhPgyedGwTMiXCmdnO3NprU_1788291845
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block.json | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 189f2e28204..9569afc6e0f 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -261,10 +261,10 @@
 
 ##
 # @blockdev-insert-medium:
-#
-# Inserts a medium (a block driver state tree) into a block device.
-# That block device's tray must currently be open (unless there is no
-# attached guest device) and there must be no medium inserted already.
+#     Inserts a medium (a block driver state tree) into a block
+#     device.  That block device's tray must currently be open (unless
+#     there is no attached guest device) and there must be no medium
+#     inserted already.
 #
 # @id: The name or QOM path of the guest device
 #
-- 
2.55.0

