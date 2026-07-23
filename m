Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275FA389460
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782267; cv=none; b=EV2j4CjsSWdacEgCHkKv/xota9vZM/RvhIWwHnuJ1X/nKdJkgUWZZc+uI5fuVP1TfhtJaeHJRIvKnWm2ntp6CPQYFZxDWp4LqRXDKH9PgWe5GTwpZp4yV/gAI4rKhLaawMorB+uwUGX3TdqzInVAVs7CcFWTL4faA+R7Gf4qWXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782267; c=relaxed/simple;
	bh=EEVA3DLc8WUgAWrFrVwZBRbr2tuhR7vD7oHOnr3UP/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=B4DnoY8ckqwRxncl9v4zHl6NX0jwv0trcAAihNhy8fJmLY/3XOhYxuRNkE3wVcNwVvsRaLv84TlP4jVjNGte+oFglctQO/j22ynX0Fmk5Pika59nK9H7Ry2RZA0iIapczkWVs+z8R3WXXfeVSTdLV6XSP9dx2qhNl6pjwoCZbAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qs8I7FEk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qs8I7FEk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMsbmtwIJsHsJ64Y/awhARhEChYJf52hplBgthhLPFc=;
	b=Qs8I7FEk2rdmkiohppYGCYgKG3wPxdwRMXEriU7t8WB62mTyffKMCsQA1jcHwziC35wTFw
	/Sc29ziPY7XbYRoWS+mI9DnfZBpDOPdxFz/AoaXMdRy8aXez2ccxRyPUn6DHo+flUqAIUK
	Yu9F1tD8NIvIfgPo/bKAqkYx82eNkYA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-H7AG1BgiOSiid6wo1RwJ1A-1; Thu,
 23 Jul 2026 00:50:40 -0400
X-MC-Unique: H7AG1BgiOSiid6wo1RwJ1A-1
X-Mimecast-MFC-AGG-ID: H7AG1BgiOSiid6wo1RwJ1A_1784782237
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 219EA1954B26;
	Thu, 23 Jul 2026 04:50:37 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4599F18002AE;
	Thu, 23 Jul 2026 04:50:26 +0000 (UTC)
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
Subject: [PATCH v2 14/44] qapi: convert intro sections for replay.json
Date: Thu, 23 Jul 2026 00:47:35 -0400
Message-ID: <20260723044805.527643-15-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: mP3AzebnqQmeFSji6J2Ip1OUNahs8NeK8RyBXNMTcYc_1784782237
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/replay.json | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/qapi/replay.json b/qapi/replay.json
index ccf84da68ef..db1440c09a6 100644
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
@@ -47,10 +45,9 @@
 
 ##
 # @query-replay:
-#
-# Retrieve the record/replay information.  It includes current
-# instruction count which may be used for `replay-break` and
-# `replay-seek` commands.
+#     Retrieve the record/replay information.  It includes current
+#     instruction count which may be used for `replay-break` and
+#     `replay-seek` commands.
 #
 # Returns: record/replay information.
 #
@@ -66,13 +63,13 @@
 
 ##
 # @replay-break:
-#
-# Set replay breakpoint at instruction count @icount.  Execution stops
-# when the specified instruction is reached.  There can be at most one
-# breakpoint.  When breakpoint is set, any prior one is removed.  The
-# breakpoint may be set only in replay mode and only "in the future",
-# i.e. at instruction counts greater than the current one.  The
-# current instruction count can be observed with `query-replay`.
+#     Set replay breakpoint at instruction count @icount.  Execution
+#     stops when the specified instruction is reached.  There can be
+#     at most one breakpoint.  When breakpoint is set, any prior one
+#     is removed.  The breakpoint may be set only in replay mode and
+#     only "in the future", i.e. at instruction counts greater than
+#     the current one.  The current instruction count can be observed
+#     with `query-replay`.
 #
 # @icount: instruction count to stop at
 #
@@ -87,9 +84,8 @@
 
 ##
 # @replay-delete-break:
-#
-# Remove replay breakpoint which was set with `replay-break`.  The
-# command is ignored when there are no replay breakpoints.
+#     Remove replay breakpoint which was set with `replay-break`.  The
+#     command is ignored when there are no replay breakpoints.
 #
 # Since: 5.2
 #
@@ -102,13 +98,12 @@
 
 ##
 # @replay-seek:
-#
-# Automatically proceed to the instruction count @icount, when
-# replaying the execution.  The command automatically loads nearest
-# snapshot and replays the execution to find the desired instruction.
-# When there is no preceding snapshot or the execution is not
-# replayed, then the command fails.  Instruction count can be obtained
-# with the `query-replay` command.
+#     Automatically proceed to the instruction count @icount, when
+#     replaying the execution.  The command automatically loads
+#     nearest snapshot and replays the execution to find the desired
+#     instruction.  When there is no preceding snapshot or the
+#     execution is not replayed, then the command fails.  Instruction
+#     count can be obtained with the `query-replay` command.
 #
 # @icount: target instruction count
 #
-- 
2.55.0

