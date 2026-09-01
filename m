Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FED389105
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291844; cv=none; b=pGhim4cuk24V8k1ocrPxyyizYaB1xN7yTJdUzeQz/boBouXkjQFbMjeBbIOyfxNhRg4n9sCHq4G0enZu2jwl5VpwKc7DsmdqguJE+T3Q8NWi9T0pOaqp6AqBszakbUeaxJ65iWdQrYpXblCn3uUSdWxLlQXaTwGn8j46f7+ByPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291844; c=relaxed/simple;
	bh=kqLHOZ/o+r+aBYsoWfrx2LZqsxo3VVGIPhWjjDwkXDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=pcct/6XSgVjTN158+KMm5iaH9NJ6XXRs6w2VyqYoiP1Ol8QCsFoUvzG0nsmrrxNqSfeVTg2rAnMNNq+NMo7j2qA9t5NfIXVAp6fdc2SS6V941Att31RLAmFpuknKlAPCdn5ZETUjscDvVGxQu/M7GG5DP6oXcg4um3XE1sTl2x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIZewL9M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIZewL9M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788291842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PLha+7PewegdkE2Btz3GxWtud+GwitOxT671J1gZ+4Y=;
	b=TIZewL9M4u2FA+YmsIpu3mn3kI+X2J6jhZHcfh3ZJZWMqNfmQKqz1sd+YeQi/68Inq0vts
	H7ZVk03QaV0kQiSk1HcDMIWC1KTpnmV8RFevh2n9HP2Iw+gQB8I+GSd/EsvaiO4oY9nyOz
	WxwcpoWuXEhtEgkbgonY8SsQcIU4nBQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-TIYfuV6uMYyStR5lg2BKOg-1; Tue,
 01 Sept 2026 15:43:57 -0400
X-MC-Unique: TIYfuV6uMYyStR5lg2BKOg-1
X-Mimecast-MFC-AGG-ID: TIYfuV6uMYyStR5lg2BKOg_1788291836
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 125B81835AC4;
	Tue,  1 Sep 2026 19:43:56 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3F9FB1800258;
	Tue,  1 Sep 2026 19:43:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Ani Sinha <anisinha@redhat.com>,
	qemu-block@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>,
	Fabiano Rosas <farosas@suse.de>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Peter Xu <peterx@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 05/12] qapi: convert simple command intros for dump.json
Date: Tue,  1 Sep 2026 15:43:17 -0400
Message-ID: <20260901194324.458482-6-jsnow@redhat.com>
In-Reply-To: <20260901194324.458482-1-jsnow@redhat.com>
References: <20260901194324.458482-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: koATTXK22CnYR65ICiCXUQTApK6jfjeM6QsrVLWSh2o_1788291836
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/dump.json | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/qapi/dump.json b/qapi/dump.json
index 520c58cbcd8..9e97e8431f4 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -55,9 +55,8 @@
 
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
-- 
2.55.0

