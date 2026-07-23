Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6338C3515F7
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782182; cv=none; b=guRPvSGdWDVWgGDtDZrFc32ruM/S/PRPTRFryt0Pfphe7ZPmnrEhpKClXrBy7+N2yEmvQDhzTEBfCufpDTT1ppPFxOUyzTTOeCqYFAYJ6aCR43WsoVlhq6QRag0vD0K1lcWNZ0BBpr2TgDPNseA8q3v2hF/XA0oQ+UoaXfS/Faw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782182; c=relaxed/simple;
	bh=L+iOmQeNvN6QFgO0pttbSR4NbW1oz78TUpIlB66W63U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=n4nkQgTJG7Gk5upRi23S80DdE6hwmmRiQaspfxnHFgRC46q243wwunMdkWiIGqQke8HcWWgauz/nbH2fRpDnfcdTiHFRaQBbQ017eqiUtbRTWU55APu8RchKkIRvnJreTGuZShJomSqI+yaP7+ZRMSGaFSi00tut9BOaUp9bsT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MUkTQJ6W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUkTQJ6W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqN+pz/6fcmsONkCRkuffRAAiopB88H75SjiniCSIHM=;
	b=MUkTQJ6WlVsnUwtbvGEH8vj+baXlYwXDVcAgXEbnxLI1iTdKN/N6TvYDAEwvWKdMReWmfc
	NbSoJcayW+Rx2b5l/b3vr1I3JwWSBQy/aBd+CYQvCTbq/bBxSgVHItsorE0xLq7psL/fNA
	Rzdm/y63NPFgXnLEcls3+JV/f5rCdGw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-fnqsRcTpMmexNk4oM6rNiQ-1; Thu,
 23 Jul 2026 00:49:30 -0400
X-MC-Unique: fnqsRcTpMmexNk4oM6rNiQ-1
X-Mimecast-MFC-AGG-ID: fnqsRcTpMmexNk4oM6rNiQ_1784782168
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E34B91800A33;
	Thu, 23 Jul 2026 04:49:27 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3C5718002AE;
	Thu, 23 Jul 2026 04:49:19 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Lukas Straub <lukasstraub2@web.de>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Zhao Liu <zhao1.liu@intel.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Markus Armbruster <armbru@redhat.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Alex Williamson <alex@shazbot.org>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hanna Reitz <hreitz@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	qemu-block@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	linux-cxl@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	Fabiano Rosas <farosas@suse.de>,
	John Snow <jsnow@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Igor Mammedov <imammedo@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-edac@vger.kernel.org,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	qemu-trivial@nongnu.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 07/44] qapi: convert intro sections for trace.json
Date: Thu, 23 Jul 2026 00:47:28 -0400
Message-ID: <20260723044805.527643-8-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: Hjk1THJvpFrHzT0x5Ik-NApUD8xij9t_-LMdaY3cc0U_1784782168
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/trace.json | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/qapi/trace.json b/qapi/trace.json
index de369dae6b5..29c76256055 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -14,8 +14,7 @@
 
 ##
 # @TraceEventState:
-#
-# State of a tracing event.
+#     State of a tracing event.
 #
 # @unavailable: The event is statically disabled.
 #
@@ -30,8 +29,7 @@
 
 ##
 # @TraceEventInfo:
-#
-# Information of a tracing event.
+#     Information of a tracing event.
 #
 # @name: Event name.
 #
@@ -44,8 +42,7 @@
 
 ##
 # @trace-event-get-state:
-#
-# Query the state of events.
+#     Query the state of events.
 #
 # @name: Event name pattern (case-sensitive glob).
 #
@@ -65,8 +62,7 @@
 
 ##
 # @trace-event-set-state:
-#
-# Set the dynamic tracing state of events.
+#     Set the dynamic tracing state of events.
 #
 # @name: Event name pattern (case-sensitive glob).
 #
-- 
2.55.0

