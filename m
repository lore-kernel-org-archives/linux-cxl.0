Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7510449CF42
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147342; cv=none; b=pRPcfkzlzYmwT1hn+yyWVmt0KdxyXgAXwnF3VHLmvpWRTuhX/2FIZeifLBj7Hou/PotDthaotpwRoY/eGo8PyWgsOpc8kbFIx4kwb8hw1ZtINPHTbjGpQyus3weA+V0MSv+DktNSFENO5VrcYvyrVYJ3jJKGrbFMZ/shP+HmrME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147342; c=relaxed/simple;
	bh=wTwGo027G09ny0Oezhb8fiL95bd/OgKGCgd0x9bhGME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Fb1vN1x/XnbB88VZW4hLmR06+62bbKWK6rZTD0vMlLOVobrj63YZRJxDb+yMwM4ViOFP4px7FtAZ42+zpSNzqlqkmiCZ1mCiS22QxeWFlNktUK/Y97g1LdPwMZwS6WmOC7KsT5lDP2JiAOHiOeI1fzlgRoAyi7dpiDYBLJmPehE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fo/FV7Zq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fo/FV7Zq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789147340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kqnCn6G38OWUssJgOIyQiwhSLKRNKgZZBvo5dTe58DE=;
	b=fo/FV7ZqsvB8QZ5Nj7PBGBQylctcDGgw1eFQ+mScJnwmh456MT+zcBfOpiakfeU954e6pI
	WTlcz6kMU2lBm9ciTglAFF1LNYM2ALievN20xIcMIgijrpA2pJfYa8Nl4navxk6hzcLwvV
	3cqrNhLNogj7AMTOrST5iQbToXRl7bk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-1SOw62vbNAGvNNb27isq2w-1; Fri,
 11 Sep 2026 13:22:19 -0400
X-MC-Unique: 1SOw62vbNAGvNNb27isq2w-1
X-Mimecast-MFC-AGG-ID: 1SOw62vbNAGvNNb27isq2w_1789147337
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02B14180134B;
	Fri, 11 Sep 2026 17:22:17 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.222])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B1ABF195608F;
	Fri, 11 Sep 2026 17:22:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	Kevin Wolf <kwolf@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Eric Blake <eblake@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lukas Straub <lukasstraub2@web.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	linux-cxl@vger.kernel.org,
	Jason Wang <jasowangio@gmail.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 3/6] qapi: convert remaining simple intros for machine.json
Date: Fri, 11 Sep 2026 13:21:57 -0400
Message-ID: <20260911172200.227914-4-jsnow@redhat.com>
In-Reply-To: <20260911172200.227914-1-jsnow@redhat.com>
References: <20260911172200.227914-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: zA3DSxrZvKQ94qNS2NcQJcex9DH_BWMo9mCgr-L4cGk_1789147337
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

These are either structs or unions that are used in an inlinable
context: i.e. the generated documentation is likely to feature a
version of this documentation block that does not include the intro in
context of another command, event, or structure.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine.json | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 0516112f8e8..13875fc4642 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -449,8 +449,7 @@
 
 ##
 # @NumaOptions:
-#
-# A discriminated record of NUMA options.  (for OptsVisitor)
+#     A discriminated record of NUMA options.  (for OptsVisitor)
 #
 # @type: NUMA option type
 #
-- 
2.55.0

