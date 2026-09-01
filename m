Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE504389105
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291826; cv=none; b=RZt4sRr6e6KsgAgVA9C3TWsw2qPsCxG7/goR/X3SttrgXPyzKVTv3XZdSXD/zgDYKxL5J0mBR2aW27WDx8rj33+gnRJJNubPfN+uQHR6h0hksjlGj8BUFY9uFRFuhxKJhn3C5f0bGv8JB1bMymJWbZxMuF9Mn5v4srO1wfxryWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291826; c=relaxed/simple;
	bh=orlEtchgsigRedRs8IkaE0SILDZxAyaN0eJRqruzQo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=j9kRB11Y3gL/9FjQKdL+27d9+0q/Ghg1ye3Sl2AROieEr2k+Q7EJOLhiiZBZEStVt2oDh63+A/A5hg2EtjDmb/GTXeds8/WLK/W0qVU6gCuMCMcbOolYQ4RFjwCp4HbVpJtKG8B2Kin0GMOY3MbDkF13SIZx8xJjRVmHhDLcM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=atKv5Wl4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atKv5Wl4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788291824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ixjfcHYhmoMDBKwTU1Nma2C2fjxsG3CZ5mXp8+rh7K4=;
	b=atKv5Wl4pQ59WmYevOZHgot8hy9LOdccKxmMs2lZsI46mgKmIL55nEXX8ZpjPczV3bzHap
	mGh+HqcC+Lj4lXOeTMThJ+o+8FSMZnwhAOvAezZ7E9nfL5Y6hLHzcEtI1qaL5AUqmHctXX
	l++zevpRbrQeXg+5YA4SVlHCrV3nPl4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-Iw_Rr4sZMLScosyFq4ZxVg-1; Tue,
 01 Sept 2026 15:43:39 -0400
X-MC-Unique: Iw_Rr4sZMLScosyFq4ZxVg-1
X-Mimecast-MFC-AGG-ID: Iw_Rr4sZMLScosyFq4ZxVg_1788291818
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B2B118417F6;
	Tue,  1 Sep 2026 19:43:37 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9DF4118005BD;
	Tue,  1 Sep 2026 19:43:32 +0000 (UTC)
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
Subject: [PATCH 01/12] qapi: convert simple command intros for ebpf.json
Date: Tue,  1 Sep 2026 15:43:13 -0400
Message-ID: <20260901194324.458482-2-jsnow@redhat.com>
In-Reply-To: <20260901194324.458482-1-jsnow@redhat.com>
References: <20260901194324.458482-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: sSKXskMpnW4XTeBvnTw5Cw-xnfK0rI2PUlTQjVdVaFc_1788291818
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/ebpf.json | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/ebpf.json b/qapi/ebpf.json
index 951516b121f..1f7a4d5c126 100644
--- a/qapi/ebpf.json
+++ b/qapi/ebpf.json
@@ -47,10 +47,10 @@
 
 ##
 # @request-ebpf:
-#
-# Retrieve an eBPF object that can be loaded with libbpf.  Management
-# applications (e.g. libvirt) may load it and pass file descriptors to
-# QEMU, so they can run running QEMU without BPF capabilities.
+#     Retrieve an eBPF object that can be loaded with libbpf.
+#     Management applications (e.g. libvirt) may load it and pass file
+#     descriptors to QEMU, so they can run running QEMU without BPF
+#     capabilities.
 #
 # @id: The ID of the program to return.
 #
-- 
2.55.0

