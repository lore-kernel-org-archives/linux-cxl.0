Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590206;
	b=Q4QvB2KViviSUIPMqZKZON3oqs4enXaXAVNLRKEmorL3qD9yV3Dca2yT+C4RwBhvX4FR
	 D0jKi2Jc7Snh5pgV6ffW7IKKB2bjN3iUOARzJteX7Wrnb81ABT1GMh7PWuCa5AMZDr44i
	 oSdfYwwxUndk+zZVvy2FJ2O7aeZGrh56CC5uNiLxzhU7UTtcSBTOvzlNdW8PRoeOP0Vm2
	 wxV27UYuf/JFwT8c0Q+ImdNZorlXDA6IoZ+3yL9Kj3/Qn9ed1GLd5ntG49YKLJnNMBu+Z
	 u405gnnE1nVgDR4ulDywXMvbRBtF7KBPOkLwkrNJ3XgVgWQm/Lh1ZI51+1hBW02z0TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590206;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=CJtIkUwKAHRMFbCqlRT+jmos7RFyZsLqSWXxdWy2N0w=;
	b=v6nrwcNCvbpMVrQBhSXiOX+mLbGSA3ELh8vJjKV5mm2TMF/Y3adkJKKYz39C4RNyrcKT
	 +UUsRWYyGSgBy4VDKdmDFscBKGxrnVg/p1p9tRtnr4XwQ33FWsqsy1FKakGI8oN1xY+C9
	 /nE1YOiWI+i9APQW6bIXDEdG8jXWjJzVWzZ1ELEU31pVMHSsfKqVbL+LF0SMQaURfp+5V
	 07PHRd6FZfTVCQAwWb49oKgOGFlHiLQwSU9SVZZcYm5rwa4Uc1dnulre+Yo+pva38PIcL
	 GND95rr0dScDthc4dHzbuQgqBSfa29lfK8E7Lq1Jo3ZNF24Wjp3KjGHS07kY/I+e2bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nFbgUrWb;
	arc=none smtp.remote-ip=95.215.58.113
Received: from mta1.migadu.com (out-113.mta1.migadu.com [95.215.58.113])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744DA606A319
	for <linux-cxl@vger.kernel.org>; Wed, 21 Oct 2026 13:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 744DA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nFbgUrWb
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Fi4BNJYMdbjLdv/SNYLVVVzqaRaqc5624TRAWZaYcdo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792590202; v=1; x=1793195002;
 b=nFbgUrWbyIKRRtNBc38/0PaQ7R5YFdqpbMx83gBHrzs8s2TslcSIZ5NTGb8YoKk2e31yhS8z
 DRW+xGmpL/urolNm3bSHgPNiXILmGbfcHUtIXZTUQEs8HE1bpuo7JKGxwm48G4NoMwMiHXbfJ2y
 wLXZkuDsIIQJGRQsIqYqlE00=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ed41e90ce60f5e09;
	Wed, 21 Oct 2026 13:43:22 +0000
X-Mizu-Trace-ID: ed41e90ce60f5e09
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: jic23@kernel.org,
	mst@redhat.com,
	anisa.su@samsung.com,
	linux-cxl@vger.kernel.org,
	junjie.cao@linux.dev,
	junjie.cao@intel.com
Subject: [PATCH] MAINTAINERS: Update Junjie Cao's email address
Date: Wed, 21 Oct 2026 13:43:07 +0000
Message-ID: <20261021134307.874867-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update my email address to junjie.cao@linux.dev for future correspondence.
I'll continue contributing and reviewing CXL patches.

Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d9209f043f..2b78316436 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3370,7 +3370,7 @@ F: docs/devel/migration/CPR.rst
 
 Compute Express Link
 M: Jonathan Cameron <jic23@kernel.org>
-R: Junjie Cao <junjie.cao@intel.com>
+R: Junjie Cao <junjie.cao@linux.dev>
 R: Anisa Su <anisa.su@samsung.com>
 L: linux-cxl@vger.kernel.org
 S: Supported
-- 
2.43.0

