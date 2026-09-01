Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF636828B
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291837; cv=none; b=Z5Ji5pP/n7QIyCw805khlWZlLtD9NflOlkVQ8SpPatc8picCpVwRkeLZJ2JSTkDlKDOK3omG8mOrq9fHvq+UWFCMnaeRhQ+WZz0s4LMvwJHimbE+zrEjWuUzCw1QndvwDHHFvyCXEHgSbBLNKojHrww0W1VrtKhJ9g52cZdwtkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291837; c=relaxed/simple;
	bh=fduQfwffbj7t71VjeAO4P2N35SMvZbHLqu7hZE7sVfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=YVJdx627I/x/wnaTThEZ4twsdxwf52WsixFryq8wcehRKjpHlLk+PWbWCbHQaBy4HzwtdnJQy3dBVNzK6bgO9+NwawKvHLZ3CkGJhOII+LVf/8TdPT0XdQDn+5JvCWyoDIzuH9urkH3CEhIAz5U5mdFJC+WrX8CSVQNKK9LonrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hxq3mTCj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxq3mTCj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788291835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BnLC4VOJCmUbPIjOYx2s4C2tAwLIElQ74vsGMaan2hc=;
	b=hxq3mTCjgY1S007FjXHVOveTpVLnnYaY9U5k/ujCKtZO8cVuUkjIOYW4kAqnpH343RfqgB
	XL+eN/coEZh4XLel9a+Jl3B8/8m6CMeQ57+7z2w/rhfM3jl+XKkljgIaAuXgGHZDVlwDsH
	oDfjCU+1TPktz71dLSzu771JMALVDO0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-UfFaRAPDPKeiV62mIaPfIQ-1; Tue,
 01 Sept 2026 15:43:52 -0400
X-MC-Unique: UfFaRAPDPKeiV62mIaPfIQ-1
X-Mimecast-MFC-AGG-ID: UfFaRAPDPKeiV62mIaPfIQ_1788291830
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08FEE18D6245;
	Tue,  1 Sep 2026 19:43:50 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36FFE18005B8;
	Tue,  1 Sep 2026 19:43:45 +0000 (UTC)
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
Subject: [PATCH 04/12] qapi: convert simple command intros for machine-s390x.json
Date: Tue,  1 Sep 2026 15:43:16 -0400
Message-ID: <20260901194324.458482-5-jsnow@redhat.com>
In-Reply-To: <20260901194324.458482-1-jsnow@redhat.com>
References: <20260901194324.458482-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 5meyrRDzqLrE9iDYcVY9Zdb5MRRtjjL-0_oIj-CktJY_1788291830
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine-s390x.json | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
index a83a258d6ce..dcbad9b4039 100644
--- a/qapi/machine-s390x.json
+++ b/qapi/machine-s390x.json
@@ -20,10 +20,9 @@
 
 ##
 # @set-cpu-topology:
-#
-# Modify the topology by moving the CPU inside the topology tree, or
-# by changing a modifier attribute of a CPU.  Absent values will not
-# be modified.
+#     Modify the topology by moving the CPU inside the topology tree,
+#     or by changing a modifier attribute of a CPU.  Absent values
+#     will not be modified.
 #
 # @core-id: the vCPU ID to be moved
 #
-- 
2.55.0

