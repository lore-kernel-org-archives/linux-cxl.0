Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7173D38AC8E
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782313; cv=none; b=B8aXWPfgQI2O/zRJHUJppPsXxLoub+9ZrjzSoqWsRRN1tyCC6zI5cOEQaVsRNLpmshNXr+sHGz8KCDPW+wYigIAIOST29H2RGmM/uZjn4dAkYEdQMgm2dJANe3MmS12Tm2lINwSxyGyadFy+KgYZYQdcwtZpa2arXg4Im2MY3u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782313; c=relaxed/simple;
	bh=QBxM1wNgzfm0orZotjL7nP+s8THSCYCT7IJXfbAanbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=WYA8xS6BG59C7iwqiyFYqN/hGp0up/ElGIXJk4yXIIMPnXIGHjsCRB6nzkmpdMibkbFUJ3km09RpGtF2jdX7P/abOodw5VP91PcC90Jomat4d1Nj59oFRv2krINwNA0Z4ApjGv7NgK0APZWvtr7HSOGv/UnnteOjk0qoErnzkCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ffkAypO+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffkAypO+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQBoRfguD8OLDOwj7R7RrWifXT5ev1UlWkcynySt+sw=;
	b=ffkAypO+Ki2L3nLpje7UolsWI1qVUSp4zL86bIk9glfBnFs1v+n+Hwab9qyO+036/9vvkn
	CifQ+hTD75VXLfc511cDAV2JCF7CimTr6lAFjq952niSveFyc1UU6d2lzRzZJY/1mLhV2n
	f+SD153TCLEVxgJLWZwi2Dozfk5Zqlw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-bvW1v_QYP0e3J7-uD-0_Kg-1; Thu,
 23 Jul 2026 00:51:32 -0400
X-MC-Unique: bvW1v_QYP0e3J7-uD-0_Kg-1
X-Mimecast-MFC-AGG-ID: bvW1v_QYP0e3J7-uD-0_Kg_1784782290
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA0CF18007FB;
	Thu, 23 Jul 2026 04:51:29 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DAFF318002B5;
	Thu, 23 Jul 2026 04:51:19 +0000 (UTC)
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
Subject: [PATCH v2 19/44] qapi: convert trivial intro sections for control.json
Date: Thu, 23 Jul 2026 00:47:40 -0400
Message-ID: <20260723044805.527643-20-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: JTslzTFnX67vhlVtIH51rcZUpPL13b64d0-LVC1N9oE_1784782290
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/control.json | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/qapi/control.json b/qapi/control.json
index 9a5302193d6..0fc465936d8 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -10,8 +10,7 @@
 
 ##
 # @qmp_capabilities:
-#
-# Enable QMP capabilities.
+#     Enable QMP capabilities.
 #
 # @enable: An optional list of `QMPCapability` values to enable.  The
 #     client must not enable any capability that is not mentioned in
@@ -41,9 +40,9 @@
 
 ##
 # @QMPCapability:
-#
-# Enumeration of capabilities to be advertised during initial client
-# connection, used for agreeing on particular QMP extension behaviors.
+#     Enumeration of capabilities to be advertised during initial
+#     client connection, used for agreeing on particular QMP extension
+#     behaviors.
 #
 # @oob: QMP ability to support out-of-band requests.  (Please refer to
 #     qmp-spec.rst for more information on OOB)
@@ -55,8 +54,7 @@
 
 ##
 # @VersionTriple:
-#
-# A three-part version number.
+#     A three-part version number.
 #
 # @major: The major version number.
 #
@@ -71,8 +69,7 @@
 
 ##
 # @VersionInfo:
-#
-# A description of QEMU's version.
+#     A description of QEMU's version.
 #
 # @qemu: The version of QEMU.  By current convention, a micro version
 #     of 50 signifies a development branch.  A micro version greater
@@ -92,8 +89,7 @@
 
 ##
 # @query-version:
-#
-# Return the current version of QEMU.
+#     Return the current version of QEMU.
 #
 # Returns: An object describing the current version of QEMU.
 #
@@ -118,8 +114,7 @@
 
 ##
 # @CommandInfo:
-#
-# Information about a QMP command
+#     Information about a QMP command
 #
 # @name: The command name
 #
@@ -129,8 +124,7 @@
 
 ##
 # @query-commands:
-#
-# Return a list of supported QMP commands by this server
+#     Return a list of supported QMP commands by this server
 #
 # Returns: A list of all supported commands
 #
@@ -177,8 +171,7 @@
 
 ##
 # @MonitorMode:
-#
-# An enumeration of monitor modes.
+#     An enumeration of monitor modes.
 #
 # @readline: HMP monitor (human-oriented command line interface)
 #
@@ -190,8 +183,7 @@
 
 ##
 # @MonitorOptions:
-#
-# Options to be used for adding a new monitor.
+#     Options to be used for adding a new monitor.
 #
 # @id: Name of the monitor
 #
-- 
2.55.0

