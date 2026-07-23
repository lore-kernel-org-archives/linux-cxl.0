Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8505A38B7D7
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782347; cv=none; b=G5hlD8I+0jj3Gh+rlwIzpYtAo5VzRuXrIoTIAj4u6ePdpUKpTyBbyKdBAX5qVIe0ydtKyxOt9hIfRK6Rf6nA3J01+4E/4lWLMvTw2QHKnZKu608TlXcb79zSbtdK0FQ3gA8yCiQI3pDgYwO9eVrMzEwTiZggU5rzu9NTdinxqss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782347; c=relaxed/simple;
	bh=X4LjTSVGy4WxcDY5opsXOr2uolaPpeYwTGcIKwYrGpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=FaBOq6XtZWfykfpU0JLiDvf1VlcXSFRGr+DJADWrhDZs1ufCd6wwCvIAecN94EBPc7w8T/xjxqYkW45qOJTthn06eEGVIDr0op+EGRYQY6aCDTa2hXM86uYS7gXC7aidr4zBtACg5704sAxyxIkbc/AP/Vfb1/IAIyVnstrvMUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Af/6Ai34; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Af/6Ai34"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyTl9kx/Ys42L67iPX5XzMmfFhlEjbDrKuvT6ahrYho=;
	b=Af/6Ai34TPLM62/h0IhK3SLFeUUIonj5EUwJgl3zS4AhZCfBKGRykh8F67q155NlsLlWVP
	HCSIrrxLNQKc2dnp8LTyCQ57kL+avzy6sRM0RHVrpNfYviVCNiv8bgr1S9fSWqiJFp97xR
	SlGtaNmbWJUvhe6h85hGdRQessgmJJ8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-J48cmPRvPPiUaFUWwiqSjA-1; Thu,
 23 Jul 2026 00:52:04 -0400
X-MC-Unique: J48cmPRvPPiUaFUWwiqSjA-1
X-Mimecast-MFC-AGG-ID: J48cmPRvPPiUaFUWwiqSjA_1784782322
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C16351944EBC;
	Thu, 23 Jul 2026 04:52:01 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD19D180029D;
	Thu, 23 Jul 2026 04:51:49 +0000 (UTC)
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
Subject: [PATCH v2 22/44] qapi: convert intro sections for sockets.json
Date: Thu, 23 Jul 2026 00:47:43 -0400
Message-ID: <20260723044805.527643-23-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: VO6m-jLDW3rcTvkwriO--oqPvkofB0fAG7tNdOc9Buw_1784782322
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/sockets.json | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/qapi/sockets.json b/qapi/sockets.json
index 473be2ac58a..210d07b5ef2 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -9,8 +9,7 @@
 
 ##
 # @NetworkAddressFamily:
-#
-# The network address family
+#     The network address family
 #
 # @ipv4: IPV4 family
 #
@@ -41,9 +40,8 @@
 
 ##
 # @InetSocketAddress:
-#
-# Captures a socket address or address range in the Internet
-# namespace.
+#     Captures a socket address or address range in the Internet
+#     namespace.
 #
 # @numeric: true if the host/port are guaranteed to be numeric, false
 #     if name resolution should be attempted.  Defaults to false.
@@ -98,8 +96,8 @@
 
 ##
 # @UnixSocketAddress:
-#
-# Captures a socket address in the local ("Unix socket") namespace.
+#     Captures a socket address in the local ("Unix socket")
+#     namespace.
 #
 # @path: filesystem path to use
 #
@@ -121,8 +119,7 @@
 
 ##
 # @VsockSocketAddress:
-#
-# Captures a socket address in the vsock namespace.
+#     Captures a socket address in the vsock namespace.
 #
 # @cid: unique host identifier
 #
@@ -140,8 +137,7 @@
 
 ##
 # @FdSocketAddress:
-#
-# A file descriptor name or number.
+#     A file descriptor name or number.
 #
 # @str: decimal is for file descriptor number, otherwise it's a file
 #     descriptor name.  Named file descriptors are permitted in
@@ -197,9 +193,8 @@
 
 ##
 # @SocketAddressLegacy:
-#
-# Captures the address of a socket, which could also be a named file
-# descriptor
+#     Captures the address of a socket, which could also be a named
+#     file descriptor
 #
 # @type: Transport type
 #
@@ -219,8 +214,7 @@
 
 ##
 # @SocketAddressType:
-#
-# Available `SocketAddress` types
+#     Available `SocketAddress` types
 #
 # @inet: Internet address
 #
@@ -237,9 +231,8 @@
 
 ##
 # @SocketAddress:
-#
-# Captures the address of a socket, which could also be a socket file
-# descriptor
+#     Captures the address of a socket, which could also be a socket
+#     file descriptor
 #
 # @type: Transport type
 #
-- 
2.55.0

