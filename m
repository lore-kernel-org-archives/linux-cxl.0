Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3070339AD2A
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789072782; cv=none; b=lmwE1mt5vBOBaoUkUGS3RJcz7d95y8I5Wbx0mdQaRC529ttFS2B9Ik/9C775GajMNxDBvEWjU3sd2OUgsuRQVHd18RfuTmV2+cict2I0uHGxD8WI1D2DnPdDUBCFzT4h9CsFxPBnhKed8ulUYTHfJch7rqc132QILCvHVTCv6lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789072782; c=relaxed/simple;
	bh=GM3HKFEUB3Qed1v98g6nrrNQhu1HVQAPp8LpGuYMIsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=vDL68EqzKPM4BwBePzXqhlgFX+iIQlS46SIViX8plXdzYV0jWPPg7ypTjTsznC+kQfDdIcDOKU32WcVdqh+PdKdmtBZGyWoc6PBAYTSEeyX2u57fVaEUG63x0W6arb2YUudh/4l6SfL0lXN0sbLtELYaMZkTEJkArH1HkF6vqMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I0yWobAf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0yWobAf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789072773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dkspHl+60G3ymT/5cuF1ktqEwiLZnnAHHPw1Oy9ihXQ=;
	b=I0yWobAf4so0Bqf+haGpfHJxfW3vPQmKHH53OdxmppE0EBK7icqcuJ+zTuoHfd5izXz3cI
	CLFdQ3Bpw+3DEvfV5+gS5OGgcPewBKHgzp5ZGL2R2vQbnQfohh6JluH59U7GwMCCm5Bkds
	DqGvfWA/cRj0qRp2KEDlQESJ1tA1pvk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-QpK1D99PPZWAXT0tXPdFQQ-1; Thu,
 10 Sep 2026 16:39:32 -0400
X-MC-Unique: QpK1D99PPZWAXT0tXPdFQQ-1
X-Mimecast-MFC-AGG-ID: QpK1D99PPZWAXT0tXPdFQQ_1789072770
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C865C1800BCF;
	Thu, 10 Sep 2026 20:39:30 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.67])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D852341B;
	Thu, 10 Sep 2026 20:39:25 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-cxl@vger.kernel.org,
	Zhao Liu <zhao1.liu@intel.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>,
	Markus Armbruster <armbru@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	qemu-block@nongnu.org,
	Ani Sinha <anisinha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 06/10] qapi: convert simple data struct intros for cxl.json
Date: Thu, 10 Sep 2026 16:38:52 -0400
Message-ID: <20260910203856.99003-7-jsnow@redhat.com>
In-Reply-To: <20260910203856.99003-1-jsnow@redhat.com>
References: <20260910203856.99003-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 6f0DcOZJsCPA8EJF3-Fm2YXBLR8ZHTyWf-8P_9XJjTc_1789072770
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/cxl.json | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 82524f47cdf..631d4def2ac 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -441,10 +441,9 @@
 
 ##
 # @CxlDynamicCapacityExtent:
-#
-# A single dynamic capacity extent.  This is a contiguous allocation
-# of memory by Device Physical Address within a single Dynamic
-# Capacity Region on a CXL Type 3 Device.
+#     A single dynamic capacity extent.  This is a contiguous
+#     allocation of memory by Device Physical Address within a single
+#     Dynamic Capacity Region on a CXL Type 3 Device.
 #
 # @offset: The offset (in bytes) to the start of the region where the
 #     extent belongs to.
-- 
2.55.0

