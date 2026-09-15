Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB13CA49A
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789485131; cv=none; b=TYt6Wiolv38EQxKxpjkUe4w3vHn5CRNHnu9PrBwsYIbDJ/c5tPg1stbXEDwZo6VMW8xCRoh+ugXSvgC9Mk5Tm0do6NK8eZ6RXX8qzC/ZiUa53pu0hR2MDZJ7SAzI8FEg4oj2L3qkhWZilaUo7TD4e5bU1CI7xsbCS5Js6GR3lmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789485131; c=relaxed/simple;
	bh=PlInlaoSQ2TYK3E0aYB5EFRIERIM/ePqnj4j9J6f3x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=kCpqB73I3AqmNy0fQFp71NCxq497pMjKf99BZkAo+CrclShuoHbZZzGXfqsncsSv+kGdiCcA/4YqtqS1RSpNN8T7CAt/FHGLWx8vg96f5O9B5TwXM9LGB6H0LUSN9JOg8fGucIuGcVwx4KOAs4fSjuU9kp1mVMmEL0RDsgCPbAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWOIfK8J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWOIfK8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789485128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+/TEs6WfoqvbeLKb/7GlRm0zX4tMP9iSW1sKdXtrjYQ=;
	b=GWOIfK8JizI5ZvFX2Gm0WsVFGaQ5fj4YYd607Np1cvFMxpsVL+rmiyPoSEV6jkb13nnJtc
	oMc3KvXr5YIu1jcRQllZ0Ars5nhr38/Zl65HwAsx5u62miotee7RBdyOzrDEH8fOEb1P3n
	W2teUDj+WZOD6liwgdzZdjviN0J68VE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-8zwyUbarOoeWSs4bnphLzQ-1; Tue,
 15 Sep 2026 11:12:05 -0400
X-MC-Unique: 8zwyUbarOoeWSs4bnphLzQ-1
X-Mimecast-MFC-AGG-ID: 8zwyUbarOoeWSs4bnphLzQ_1789485123
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 608141956077;
	Tue, 15 Sep 2026 15:12:03 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 93C33195604E;
	Tue, 15 Sep 2026 15:11:59 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Wolf <kwolf@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Michael Roth <michael.roth@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Lukas Straub <lukasstraub2@web.de>,
	Eric Blake <eblake@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	linux-cxl@vger.kernel.org,
	Zhao Liu <zhao1.liu@intel.com>,
	qemu-block@nongnu.org,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v2 5/7] qapi/parser: fix intermediate "intro" detection
Date: Tue, 15 Sep 2026 11:11:25 -0400
Message-ID: <20260915151127.1002244-6-jsnow@redhat.com>
In-Reply-To: <20260915151127.1002244-1-jsnow@redhat.com>
References: <20260915151127.1002244-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: rbc1ksgG9TCSlSUYhXPSwQieDon7FX4F0OdE7FdihEs_1789485123
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In 43e7ad1a3fa5, I adjusted the insertion algorithm for inserting
something after the "introduction" to cope with both the old and new
syntax while we converted QAPI to the new syntax. There's a bug in
that code that only shows up in a handful of cases and only when using
the new syntax while this affordance/flex code is still enabled.

In the case that we do actually have a real bona-fide intro section,
we want to insert directly after that real-deal intro section, not
after any plaintext sections that may follow it. This code adjusts the
temporary code to strongly prefer inserting after the actual intro
section if it exists.

Once again: once conversion is done, you will be delighted by how much
of this ugly code goes away.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 9e14c2f7921..6ded504835d 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -845,6 +845,16 @@ def _insert_after_intro(
         needed and ``_insert_near_kind(QAPIDoc.Kind.INTRO, ...)`` will
         be sufficient.
         """
+        first = self.all_sections[0]
+        if first.text and first.kind == QAPIDoc.Kind.INTRO:
+            # First section is introduction and is non-empty: insert here.
+            # Rest assured all of this ugliness will very soon go away.
+            # Pinkie-swear.
+            return self._insert_near_kind(
+                QAPIDoc.Kind.INTRO, section, after=True
+            )
+
+
         index = 0
         for index, ref_section in enumerate(self.all_sections):
             if ref_section.kind.name in ("PLAIN", "INTRO"):
-- 
2.55.0

