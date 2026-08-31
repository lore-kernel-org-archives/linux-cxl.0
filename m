Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9470B3AA504
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207716; cv=none; b=Vfc16/6KTdOgz5YqqTLBUyfjptd+alqAC5OBFD7i/7iKHwtl3Hx+xwR59SXaORVEX38Ic81UqmPelqpzsX5Y0O8JFaz9oR2qOGnSoVML1peoY3PoDfk547V0aQi8KuDpTOpdKAzfHR+7GLb2XHNY/CN8/oynwxj6mZYDpftVHQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207716; c=relaxed/simple;
	bh=K+3mbVdH8oSa9Hwbjy5sYNWefrITF+2y/K8zXITd66Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=uC552Pb7745U54h0VHTRXr9GyOPRxnIhbnl0HpntCsmlMnwoora0NNBniDleTOsdRUDepf4owm4UYk98bJ1fcjnRiQTNOpi2bJxl6xTjtzIh4xmFxEPrepdGgzGGGW0eM4jdGf7aOxHAycwVwK6O7UjoSBrHLXdaBBoUnOgeV7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ehia032D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ehia032D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788207713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lt8Io7cWByPIErcfVsv8eiRTyjtcP7E9KBqJ4x3KU5A=;
	b=Ehia032D2XBSm0n5Uqx4tTj1d74ZwNw/oz1oTL2o8ZN3rvhBgOkk908p//IqelDw0eeTgU
	wmUmewucSamCGELcQ81YeVv5elL8T6Z6Abu6J/ar3ozeYPvtU8Ydyxrf4NhYUvHeUYeXz8
	k17JrKEX/qdgYEAAiLOrwrhAE7FXxfU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-JbaarNQYNFqYxJioJR3jNg-1; Mon,
 31 Aug 2026 16:21:47 -0400
X-MC-Unique: JbaarNQYNFqYxJioJR3jNg-1
X-Mimecast-MFC-AGG-ID: JbaarNQYNFqYxJioJR3jNg_1788207704
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26558190B19F;
	Mon, 31 Aug 2026 20:21:24 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0496B180063D;
	Mon, 31 Aug 2026 20:21:07 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Jiri Pirko <jiri@resnulli.us>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	qemu-block@nongnu.org,
	Ani Sinha <anisinha@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	linux-cxl@vger.kernel.org,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	linux-edac@vger.kernel.org,
	Michael Tokarev <mjt@tls.msk.ru>,
	John Snow <jsnow@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Zhao Liu <zhao1.liu@intel.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	Eric Blake <eblake@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	qemu-trivial@nongnu.org,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 08/43] qapi: convert trivial intro sections for cryptodev.json
Date: Mon, 31 Aug 2026 16:19:10 -0400
Message-ID: <20260831201945.287730-9-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: sYideI5YB6E3bRD2e2LLzMy2jV-1wKo8HmmJeQiCOlo_1788207704
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/cryptodev.json | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
index eb309c22f86..d0c1e6c8944 100644
--- a/qapi/cryptodev.json
+++ b/qapi/cryptodev.json
@@ -12,8 +12,7 @@
 
 ##
 # @QCryptodevBackendAlgoType:
-#
-# The supported algorithm types of a crypto device.
+#     The supported algorithm types of a crypto device.
 #
 # @sym: symmetric encryption
 #
@@ -26,8 +25,7 @@
 
 ##
 # @QCryptodevBackendServiceType:
-#
-# The supported service types of a crypto device.
+#     The supported service types of a crypto device.
 #
 # @cipher: Symmetric Key Cipher service
 #
@@ -46,8 +44,7 @@
 
 ##
 # @QCryptodevBackendType:
-#
-# The crypto device backend type
+#     The crypto device backend type
 #
 # @builtin: the QEMU builtin support
 #
@@ -62,8 +59,7 @@
 
 ##
 # @QCryptodevBackendClient:
-#
-# Information about a queue of crypto device.
+#     Information about a queue of crypto device.
 #
 # @queue: the queue index of the crypto device
 #
@@ -77,8 +73,7 @@
 
 ##
 # @QCryptodevInfo:
-#
-# Information about a crypto device.
+#     Information about a crypto device.
 #
 # @id: the id of the crypto device
 #
@@ -95,8 +90,7 @@
 
 ##
 # @query-cryptodev:
-#
-# Return information about current crypto devices.
+#     Return information about current crypto devices.
 #
 # Since: 8.0
 ##
-- 
2.55.0

