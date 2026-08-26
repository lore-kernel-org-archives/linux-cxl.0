Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5327A3515D9
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773284; cv=none; b=dI506wsyCxl0yb34dzBo0cqdLuqnS3CKYLGmz26q/oQxMmAKy2ydR3TRhVDsw+HKpEWNhXUIAHUhhBMoUURN9DsiE8FcwYwQh+CGlH72zmy4b7WyJWqPyDeEPpu+VYdtgz4nuYIsoFLCdEBqWxrdXstqf7YE/IWrZ0CBrZK9rfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773284; c=relaxed/simple;
	bh=ZcZXzcooLnhtT0WLB9Uprc5E5Mm/ckVcmXj0Rpgml5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=d93XIcEmbsEBdhkIe3wxVmBbYReO3E3FAOZQOHnb733uEXJXCYrldhi0SaLI3ltc32gEMTShJzxwXgVhCi/lr1ENdeALGYbwO5zUg+vJ0OM4wX2eFMjot13px+77/m1tjlsj/G8WrOWVwWIhEu+C92l9UaQJRCtElERDMp7tZkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HrVwadoB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrVwadoB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLnw42K1+V+Fl4KQBW783G0VH8D6uwH+UAZ7SFG2AyA=;
	b=HrVwadoBnMkgR7I9GZLDbMwHsdoIuUIPHRpzFS4vrhGa0YeRa0UV7boRM22ojr7libfGhk
	ZouaVH8hCoFuJycWF9pftmWVNF8uxJB7fx+RsuBCZMq20dpjcH7Ffz9oqYCLpB8KHmJG4z
	Gdm3ZD2nmfP7+mYH56d/P3sP3aywuMc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-WuyCK6o6NhyfNeFZLwOn-Q-1; Wed,
 26 Aug 2026 15:40:59 -0400
X-MC-Unique: WuyCK6o6NhyfNeFZLwOn-Q-1
X-Mimecast-MFC-AGG-ID: WuyCK6o6NhyfNeFZLwOn-Q_1787773252
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94CF5190FF98;
	Wed, 26 Aug 2026 19:40:52 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A90D1800577;
	Wed, 26 Aug 2026 19:40:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	John Snow <jsnow@redhat.com>,
	linux-cxl@vger.kernel.org,
	Markus Armbruster <armbru@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	qemu-trivial@nongnu.org,
	Fabiano Rosas <farosas@suse.de>,
	Kevin Wolf <kwolf@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Jiri Pirko <jiri@resnulli.us>,
	qemu-block@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	linux-edac@vger.kernel.org,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Zhao Liu <zhao1.liu@intel.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Lukas Straub <lukasstraub2@web.de>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 13/43] qapi: convert trivial intro sections for replay.json
Date: Wed, 26 Aug 2026 15:38:10 -0400
Message-ID: <20260826193840.2152000-14-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: e5g2hgtYcG4KpABZny7K4FkyM4QTFonUTXUFEg_5AF0_1787773252
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/replay.json | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/qapi/replay.json b/qapi/replay.json
index ccf84da68ef..66dff797553 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -12,8 +12,7 @@
 
 ##
 # @ReplayMode:
-#
-# Mode of the replay subsystem.
+#     Mode of the replay subsystem.
 #
 # @none: normal execution mode.  Replay or record are not enabled.
 #
@@ -30,8 +29,7 @@
 
 ##
 # @ReplayInfo:
-#
-# Record/replay information.
+#     Record/replay information.
 #
 # @mode: current mode.
 #
-- 
2.55.0

