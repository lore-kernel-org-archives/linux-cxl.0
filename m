Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FD047D927
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773397; cv=none; b=gDm27wYvN0KqYuDKbGZ0wTvZNgAaAgfaq5Zaw2GQingGLszHHluyc8YE6ZlpBWrbenOxfhOLt+9qmpcWBx9BCNV7d0u5NRLmEzsj9qZEg6sZiVjG+A0BzsyC1fO1zQPuDsQh0gi2raSHTiGqPhlyugREZsU/yUwTe0UDf1yvCYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773397; c=relaxed/simple;
	bh=iwQHT562HYJD5dgzDhWkBNTaVVgGFgmPFJ+3/wgIL3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UoBTyq09ZL3qNVu8rORhSfXFpbDnOBq8Q9Zh8cus/DJ3hRBgsD4UrUj/Y+WBh9MbOqNkEAirsgrqNLklGVv95jMv2cZ70TY7Y8H0nF5iKSqKmvnOWjKbGaI5JURm9BK6DmdOLTQOveZlV5chAh906J7PYh76PhR6lKJKBy20vIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=We4hOYuB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="We4hOYuB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8wW2V1gmq4U2oGifMr03OEbp6q8ZFZvEQ5q6kHXpZc=;
	b=We4hOYuB5g+8RTjASFPhnEICc8+dy414hCeW6IgFd6wIUFKxMn6SvwNLE5uNFUrB0euIpK
	ZJXRYwowjntyzWsrUy4wWFGaRKBA6iT5WyducSMlXUL24IMfP0RYsrg96ybOn1sGadJY0l
	cI44+yCrzVfE4tnCWUXyfNtgK0MN7Ng=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-DrxEYY6pOaGJXFAtcdIs2A-1; Wed,
 26 Aug 2026 15:42:52 -0400
X-MC-Unique: DrxEYY6pOaGJXFAtcdIs2A-1
X-Mimecast-MFC-AGG-ID: DrxEYY6pOaGJXFAtcdIs2A_1787773369
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0974D1855127;
	Wed, 26 Aug 2026 19:42:49 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 382B91800598;
	Wed, 26 Aug 2026 19:42:41 +0000 (UTC)
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
Subject: [PATCH v3 27/43] qapi: convert trivial intro sections for rocker.json
Date: Wed, 26 Aug 2026 15:38:24 -0400
Message-ID: <20260826193840.2152000-28-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: rabhOd5jbaD5AM2QGtldQxDp-xK6bYiFxc30MxPGTbM_1787773369
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/rocker.json | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/qapi/rocker.json b/qapi/rocker.json
index 5d2dbd26034..7eb0a88dafd 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -9,8 +9,7 @@
 
 ##
 # @RockerSwitch:
-#
-# Rocker switch information.
+#     Rocker switch information.
 #
 # @name: switch name
 #
@@ -25,8 +24,7 @@
 
 ##
 # @query-rocker:
-#
-# Return rocker switch information.
+#     Return rocker switch information.
 #
 # @name: switch name
 #
@@ -43,8 +41,7 @@
 
 ##
 # @RockerPortDuplex:
-#
-# An enumeration of port duplex states.
+#     An enumeration of port duplex states.
 #
 # @half: half duplex
 #
@@ -56,8 +53,7 @@
 
 ##
 # @RockerPortAutoneg:
-#
-# An enumeration of port autoneg states.
+#     An enumeration of port autoneg states.
 #
 # @off: autoneg is off
 #
@@ -69,8 +65,7 @@
 
 ##
 # @RockerPort:
-#
-# Rocker switch port information.
+#     Rocker switch port information.
 #
 # @name: port name
 #
@@ -93,8 +88,7 @@
 
 ##
 # @query-rocker-ports:
-#
-# Return rocker switch port information.
+#     Return rocker switch port information.
 #
 # @name: port name
 #
@@ -115,8 +109,7 @@
 
 ##
 # @RockerOfDpaFlowKey:
-#
-# Rocker switch OF-DPA flow key
+#     Rocker switch OF-DPA flow key
 #
 # @priority: key priority, 0 being lowest priority
 #
@@ -153,8 +146,7 @@
 
 ##
 # @RockerOfDpaFlowMask:
-#
-# Rocker switch OF-DPA flow mask
+#     Rocker switch OF-DPA flow mask
 #
 # @in-pport: physical input port
 #
@@ -182,8 +174,7 @@
 
 ##
 # @RockerOfDpaFlowAction:
-#
-# Rocker switch OF-DPA flow action
+#     Rocker switch OF-DPA flow action
 #
 # @goto-tbl: next table ID
 #
@@ -209,8 +200,7 @@
 
 ##
 # @RockerOfDpaFlow:
-#
-# Rocker switch OF-DPA flow
+#     Rocker switch OF-DPA flow
 #
 # @cookie: flow unique cookie ID
 #
@@ -230,8 +220,7 @@
 
 ##
 # @query-rocker-of-dpa-flows:
-#
-# Return rocker OF-DPA flow information.
+#     Return rocker OF-DPA flow information.
 #
 # @name: switch name
 #
@@ -261,8 +250,7 @@
 
 ##
 # @RockerOfDpaGroup:
-#
-# Rocker switch OF-DPA group
+#     Rocker switch OF-DPA group
 #
 # @id: group unique ID
 #
@@ -305,8 +293,7 @@
 
 ##
 # @query-rocker-of-dpa-groups:
-#
-# Return rocker OF-DPA group information.
+#     Return rocker OF-DPA group information.
 #
 # @name: switch name
 #
-- 
2.55.0

