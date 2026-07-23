Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237D386422
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782247; cv=none; b=UbjhmwZ2bgjtesBTZqUELt8h7dSdjMWQR5L0C8lKIbhTPff3TaBrMVZ5uFSNc06qqH1Vzywo89KaES0vSEp3pIMONIBbcf0sN4cvUVbXZCfqDrDnEaeYIrLukFhzEFjMNkGoJ0VRI/CUUhgA0XT8zdbKO+544w1hOyLizVSqnWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782247; c=relaxed/simple;
	bh=QklHG4QGnbeZVqQQc2mZa33Rdh9VXt92JaO0bQyHJJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UiXrSep/kfrX96y2i8clGqL2FX4oQRA4wpx9ehQ0oGGwNydrMhotjfOHtXX10LxXa9/tGF5snvuyVKaoRtr18Ic8vMVuOJEg0ujSKmv7W3YfjdQLYfU1+gCrKe/c00qtbWK0DvfN+rN8KXI7Rx8lrJYKMbgvZlIwIcnJ5JtlP44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0J8JF9b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0J8JF9b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3S3HWop+zR66RgFI+ulHeqmicEzYN7TvQjZvmrL1hCo=;
	b=F0J8JF9b1vU+/WrU8jf50DbmdL7GicEwGBCZ5YMqvnb1gjDdPxoz2xOe/qw1HfHmW20UdE
	xhG8SlixD+KAm/ifQWHtVD5VV0tq4qm2YNYdzioT+nNCa+wUpnTJ7ZGQnz4MbEQnhTsth2
	b0xPE1sM66MX5/4s+sHrLpA0DWDzBnY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-nXey0MRTM7WZ5yuVyDRzBA-1; Thu,
 23 Jul 2026 00:50:29 -0400
X-MC-Unique: nXey0MRTM7WZ5yuVyDRzBA-1
X-Mimecast-MFC-AGG-ID: nXey0MRTM7WZ5yuVyDRzBA_1784782226
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E6381800764;
	Thu, 23 Jul 2026 04:50:26 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3207218002AE;
	Thu, 23 Jul 2026 04:50:15 +0000 (UTC)
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
Subject: [PATCH v2 13/44] qapi: convert trivial intro sections for yank.json
Date: Thu, 23 Jul 2026 00:47:34 -0400
Message-ID: <20260723044805.527643-14-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: DfKrHtVrHSD1YSwKq0FC92qAsR04znlyf7NZCfysNvw_1784782226
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/yank.json | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/qapi/yank.json b/qapi/yank.json
index f3cd5c15d60..8ac4b773653 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -10,9 +10,8 @@
 
 ##
 # @YankInstanceType:
-#
-# An enumeration of yank instance types.  See `YankInstance` for more
-# information.
+#     An enumeration of yank instance types.  See `YankInstance` for
+#     more information.
 #
 # Since: 6.0
 ##
@@ -21,9 +20,8 @@
 
 ##
 # @YankInstanceBlockNode:
-#
-# Specifies which block graph node to yank.  See `YankInstance` for
-# more information.
+#     Specifies which block graph node to yank.  See `YankInstance`
+#     for more information.
 #
 # @node-name: the name of the block graph node
 #
@@ -34,9 +32,8 @@
 
 ##
 # @YankInstanceChardev:
-#
-# Specifies which character device to yank.  See `YankInstance` for
-# more information.
+#     Specifies which character device to yank.  See `YankInstance`
+#     for more information.
 #
 # @id: the chardev's ID
 #
@@ -47,9 +44,8 @@
 
 ##
 # @YankInstance:
-#
-# A yank instance can be yanked with the `yank` qmp command to recover
-# from a hanging QEMU.
+#     A yank instance can be yanked with the `yank` qmp command to
+#     recover from a hanging QEMU.
 #
 # @type: yank instance type
 #
@@ -74,9 +70,8 @@
 
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

