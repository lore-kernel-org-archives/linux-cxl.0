Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB41233956
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 04:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927449; cv=none; b=E1id6J0GZbuVsE8kkBGveAd0QU4nv85US7PblJzLTfc3gX+0o+xOO+ILDD6DWMDn+sHNMiLABNVj5njl1nJno8K4rOufEd0xwlQl9mkoL2zn0sGpDq2/+7bn1Lgh8QBEVK+bw6m4c37oNm73JlEIKSuj0OZNS9Y/2T7BGPIrzrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927449; c=relaxed/simple;
	bh=q7/+dSN6rLdG+nOFUj63NVLpDeAaTplSSME2+ULJDfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QuAbdmIYkmY3LlM06aZSiuK84h1JOqVlNVICWaYuOA1mhgdkCN19bc8Q3p8H/z2KyMCif5dEnyYBDBWfGf5En6aB1KjHpNXDBX+UiLKU6Hfu92W3PM3PbP5owuYhcTPm2TNra02nRdSgF1wca2Es0Cymd6fnT+iZEfuhstebx1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YkDVQo2j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkDVQo2j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788927447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7rIo6VrSOjFV+Zx64CXtmAc4SC5/M70BmQOUCPbWfts=;
	b=YkDVQo2jpE2XKL5W+ubUck66B5jxAH00HnnziXGkXOkO+1z1pQBVsPdHx5NhILAMcxTtnV
	9YhouJYscazfr03fwQHq/C1EMSbSgfYsbur1Go0onhUXumxwSVSIf8E2Wxn85W7TmiylK2
	6tfkorkHgDhdRV+Z4JdVP+i9ZGTzHxQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-ozfNNqKHOo2k9FHA1nyQcg-1; Wed,
 09 Sep 2026 00:17:25 -0400
X-MC-Unique: ozfNNqKHOo2k9FHA1nyQcg-1
X-Mimecast-MFC-AGG-ID: ozfNNqKHOo2k9FHA1nyQcg_1788927444
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F03A61954196;
	Wed,  9 Sep 2026 04:17:23 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.38])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73AA81800370;
	Wed,  9 Sep 2026 04:17:21 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	qemu-block@nongnu.org,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lukas Straub <lukasstraub2@web.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Hanna Reitz <hreitz@redhat.com>,
	linux-cxl@vger.kernel.org,
	Kevin Wolf <kwolf@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 10/10] qapi: convert simple enum intros for block-core.json
Date: Wed,  9 Sep 2026 00:16:40 -0400
Message-ID: <20260909041640.69080-11-jsnow@redhat.com>
In-Reply-To: <20260909041640.69080-1-jsnow@redhat.com>
References: <20260909041640.69080-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: XpWpvlAzqJM-IH3yUZJW8yYqEp10HJCmE1YSoKo_j3I_1788927444
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 84ef21736b8..5b1eaa8e786 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1357,10 +1357,9 @@
 
 ##
 # @BlockdevOnError:
-#
-# An enumeration of possible behaviors for errors on I/O operations.
-# The exact meaning depends on whether the I/O was initiated by a
-# guest or by a block job
+#     An enumeration of possible behaviors for errors on I/O
+#     operations.  The exact meaning depends on whether the I/O was
+#     initiated by a guest or by a block job
 #
 # @report: for guest operations, report the error to the guest; for
 #     jobs, cancel the job
-- 
2.55.0

