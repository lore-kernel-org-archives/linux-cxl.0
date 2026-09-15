Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB938D3F0
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506902; cv=none; b=F+ablSYSDYHpOpAl5UIv8Brg/V56J3uPR2VvRU88rhMaKa12ciHzoHQnTVt/NkEKXzJazne0MWo7C5IqIkYm8/8Fwj3tDLfeFv7bdDqyr9BxrVNlLILKHlkTgbI0F3IuYfn6oDwX7Yr8o4IhNlKUPwetD/wOnR83s679TnZ34to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506902; c=relaxed/simple;
	bh=5G+3lgNhEYW+ikKwfUWQvNbCkx83D5U3XM12Ty0dWJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=ampj+weeNCj8cTUtzoc6hy3SsVy0Ld3tiTxSquVXFqbkVq7y1DnjhlX/xgvzIS+E/MYJse/xFj9rNv7ukH83D8AN74vciUT9SQsJRfcvsKy5yCTa+BQU3z8kt4Df/k63FLk75LbPNuxbjnZjMhfZbT+tVK7n/FBiCsh418lBKxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbOdOaTG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbOdOaTG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789506900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7QdFm9LDvqAFy3p/IgsBk+V7Q79uGRWxYsexXB//xro=;
	b=IbOdOaTGRtR4nxkQFGPjNUBf2PMkxTETJbQ6kGsUSTy5MnpgYXLFAWZn+Q9XZ909+zas4j
	tBuaUNTbyA6Nri6UzOD1JD4ndw7wZFESV29Hlo4H10aC/33uSPtS3XCu9ZDsPBDtzoOA5K
	zbGRF5pMQFEF2D/qiNR31B+xvLXdNzA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-GspPt5eINne1f4y3mnmvGA-1; Tue,
 15 Sep 2026 17:14:58 -0400
X-MC-Unique: GspPt5eINne1f4y3mnmvGA-1
X-Mimecast-MFC-AGG-ID: GspPt5eINne1f4y3mnmvGA_1789506897
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD9691843AC3;
	Tue, 15 Sep 2026 21:14:56 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1C031956095;
	Tue, 15 Sep 2026 21:14:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Markus Armbruster <armbru@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Hanna Reitz <hreitz@redhat.com>,
	qemu-block@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>,
	linux-cxl@vger.kernel.org,
	Lukas Straub <lukasstraub2@web.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Michael Roth <michael.roth@amd.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eric Blake <eblake@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Junjie Cao <junjie.cao@intel.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v3 5/7] qapi/parser: fix intermediate "intro" detection
Date: Tue, 15 Sep 2026 17:14:32 -0400
Message-ID: <20260915211434.3511110-6-jsnow@redhat.com>
In-Reply-To: <20260915211434.3511110-1-jsnow@redhat.com>
References: <20260915211434.3511110-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: _z5RqN2yRv4HCtKlTtH_LIVt_G35qMaNJH2rBsV8oiA_1789506897
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
 scripts/qapi/parser.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 9e14c2f7921..79f03062eea 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -845,6 +845,13 @@ def _insert_after_intro(
         needed and ``_insert_near_kind(QAPIDoc.Kind.INTRO, ...)`` will
         be sufficient.
         """
+        first = self.all_sections[0]
+        if first.text and first.kind == QAPIDoc.Kind.INTRO:
+            # First section is introduction and is non-empty: insert here.
+            # Rest assured all of this ugliness will very soon go away.
+            # Pinkie-swear.
+            self._insert_near_kind(QAPIDoc.Kind.INTRO, section, after=True)
+
         index = 0
         for index, ref_section in enumerate(self.all_sections):
             if ref_section.kind.name in ("PLAIN", "INTRO"):
-- 
2.55.0

