Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEA537B007
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782319; cv=none; b=pfM6zGhjEoAl5giqUeas7RxQEJQBqIxWkqF6GPRyGR7d3ZtekeYDdcQrgQYme2wQaDa5lzvd4T6L6QtY0ZqzFhzPxh1Rv0+ry1fTyB+ty1fu9RQ0jIIARJLDGbroaFmZIOlHGYJsx/NTuDFRRjEKnGVyLLXd5w3vcOUcbNwxACg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782319; c=relaxed/simple;
	bh=vMlVC7jvU3Gem/HWMlfCLISAxmgdJIiWpjRuLWf+Ogk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=rNcTTdslWTqzJVhIteMXP+S84ca1M+xPnkuUIv+3E7GpksApJZweQ/W0q7IweXw+24Mvns+0zkj6wZ+ISpZkZFsl392xFJuUwEM4QIZcE+OP6X9wvxktVduXgCDmuzeIpP2Ww9Y6mL5pJ6q1PxhpELQ9rhqb6tmvwFUjFYCLkjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TPncDVxs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPncDVxs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2M2DNHzDsbrmW/HGNuaaemkcJAWL2ZJ96wipo50CoA=;
	b=TPncDVxs9AwE9TyTpRz00mM3gk1viWBuw/e7lJc4nd63VHM4zFcj+H3CfN0rZdZvHol+r8
	CbMolnEz/+lVxw8KvekKm2boUlHOfOFbfbd8qkNj3WcDePbKgdrK5RSa/s1/JP0a5fcanc
	RDv+T+NI9sr3p7tShv2wKsmC7Zliq3s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-DTqSLi1KOLirIKpVr7DHyA-1; Thu,
 23 Jul 2026 00:51:43 -0400
X-MC-Unique: DTqSLi1KOLirIKpVr7DHyA-1
X-Mimecast-MFC-AGG-ID: DTqSLi1KOLirIKpVr7DHyA_1784782300
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B5ED1800578;
	Thu, 23 Jul 2026 04:51:40 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BB8318002AE;
	Thu, 23 Jul 2026 04:51:30 +0000 (UTC)
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
Subject: [PATCH v2 20/44] qapi: convert intro sections for dump.json
Date: Thu, 23 Jul 2026 00:47:41 -0400
Message-ID: <20260723044805.527643-21-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: RVqPgLhomaRMf9HqdF0PyX7EycujT18vlOthHEV0JI0_1784782300
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/dump.json | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/qapi/dump.json b/qapi/dump.json
index 726b5208703..c96dd2364bb 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -12,8 +12,7 @@
 
 ##
 # @DumpGuestMemoryFormat:
-#
-# An enumeration of guest-memory-dump's format.
+#     An enumeration of guest-memory-dump's format.
 #
 # @elf: elf format
 #
@@ -49,9 +48,8 @@
 
 ##
 # @dump-guest-memory:
-#
-# Dump guest's memory to vmcore.  It is a synchronous operation that
-# can take very long depending on the amount of guest memory.
+#     Dump guest's memory to vmcore.  It is a synchronous operation
+#     that can take very long depending on the amount of guest memory.
 #
 # @paging: if true, do paging to get guest's memory mapping.  This
 #     allows using gdb to process the core file.
@@ -109,8 +107,8 @@
 
 ##
 # @DumpStatus:
-#
-# Describe the status of a long-running background guest memory dump.
+#     Describe the status of a long-running background guest memory
+#     dump.
 #
 # @none: no `dump-guest-memory` has started yet.
 #
@@ -127,8 +125,7 @@
 
 ##
 # @DumpQueryResult:
-#
-# The result format for `query-dump`.
+#     The result format for `query-dump`.
 #
 # @status: enum of `DumpStatus`, which shows current dump status
 #
@@ -145,8 +142,7 @@
 
 ##
 # @query-dump:
-#
-# Query latest dump status.
+#     Query latest dump status.
 #
 # Returns: An object showing the dump status.
 #
@@ -162,8 +158,7 @@
 
 ##
 # @DUMP_COMPLETED:
-#
-# Emitted when background dump has completed
+#     Emitted when background dump has completed
 #
 # @result: final dump status
 #
@@ -196,8 +191,7 @@
 
 ##
 # @query-dump-guest-memory-capability:
-#
-# Return the available formats for `dump-guest-memory`
+#     Return the available formats for `dump-guest-memory`
 #
 # Returns: An object listing available formats for `dump-guest-memory`
 #
-- 
2.55.0

