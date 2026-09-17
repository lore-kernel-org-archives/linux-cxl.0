Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0380C3DAAA9
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789674402; cv=none; b=MCmSMoQ83wJmGAMovOUlDo/K5KHeC+iBeIldekbvKWjc269E1rkyg6H7WSfW38poQxmcvTs0unDE5I5pNFWpmA1cLdlgncoMR288LOxIXokhZzAF7vJRPja1uVfYv8XMXBd3rGb8+9mbnukLejEcRQnVVJKhNbVA3tc276Cs8yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789674402; c=relaxed/simple;
	bh=MMI64xyxYPlr1TwA5dvuptIk4b19Pt29eBW/IiAeuEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UIXjU09DULQ6e5BUAfRUq4q48bEEjIAoNPSrXOROklNOD4SXglrKHSqJrmG9DEuICI+RpLrldBjD2WoATv3LL9PehskUJmc9gInYnk3U/aje3zPmYVqtONbNvE0Dusv7Hl7nnDbEwdMYsKza/JRq0GuSdB5BTlehnGk3bz89jb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUZ8kd9l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUZ8kd9l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789674398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZAVusv6m/bEGGSvcwML1ZDmyHw8pmyH0ioJKtxzotI=;
	b=JUZ8kd9ljH/YtJlcD1YP+kXrzuysPEzhaFbtNtz5GuGEWjHFKeUxzlvKlDznqoP5hR24ja
	m6xBtHkoowbhLV4hll8k7pZ7LphZx6qjFhwuyYrfLLmpTjgIMHh7KMN7BuIrKZj4xMy1Yn
	5lqXkKTEGG+n72jxabP506Q8OOO1v7Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-XRN2gd4AOfyppiFoVK7CjQ-1; Thu,
 17 Sep 2026 15:46:37 -0400
X-MC-Unique: XRN2gd4AOfyppiFoVK7CjQ-1
X-Mimecast-MFC-AGG-ID: XRN2gd4AOfyppiFoVK7CjQ_1789674395
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D27218F0F2B;
	Thu, 17 Sep 2026 19:46:35 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.85])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5584119AC049;
	Thu, 17 Sep 2026 19:46:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Junjie Cao <junjie.cao@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	linux-cxl@vger.kernel.org,
	Jason Wang <jasowangio@gmail.com>,
	Eric Blake <eblake@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	qemu-block@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Lukas Straub <lukasstraub2@web.de>,
	Jonathan Cameron <jic23@kernel.org>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v5 5/7] qapi/parser: fix intermediate "intro" detection
Date: Thu, 17 Sep 2026 15:46:12 -0400
Message-ID: <20260917194614.549584-6-jsnow@redhat.com>
In-Reply-To: <20260917194614.549584-1-jsnow@redhat.com>
References: <20260917194614.549584-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: lt1skHyCCdHklyj379laUyav_5xXZibwP6vszWVxq1I_1789674395
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
 scripts/qapi/parser.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 9e14c2f7921..dcc04b2663e 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -845,6 +845,14 @@ def _insert_after_intro(
         needed and ``_insert_near_kind(QAPIDoc.Kind.INTRO, ...)`` will
         be sufficient.
         """
+        first = self.all_sections[0]
+        if first.text and first.kind == QAPIDoc.Kind.INTRO:
+            # First section is introduction and is non-empty: insert here.
+            # Rest assured all of this ugliness will very soon go away.
+            # Pinkie-swear.
+            self.all_sections.insert(1, section)
+            return
+
         index = 0
         for index, ref_section in enumerate(self.all_sections):
             if ref_section.kind.name in ("PLAIN", "INTRO"):
-- 
2.55.0

