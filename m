Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5791A2F7F00
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153177; cv=none; b=agEsaVKRdyiswYnBQ38Pa7uwB8Jha5Aj2/g6feG2q/X1mZQUMjDGEzSff+PYzGLXwmRVjPmtN+GeVAM69AIObcgvZFKufXt9Mr76kqK6Przq6eyRMuuIiA1JJBdu1x8m9YzG4WgC+J7dTq5wiRhDr5FR/QZDJqaYvhHuYPmit+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153177; c=relaxed/simple;
	bh=fAZjMS/5LPJsdxD5l3VZWDpjLs9glFNuH9tNjnRelIg=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=XpTkSBSM/jxLkFgrutTQdEgXlpCzzg3ChB42fp9p1+hkZUxAMOlNTlECXb8s9rwdjZ9KNSAlVzKmQPbwB3hNCWTexl7c26zBYuhGHScHf23tU7HZYHrgXwsdmVcOjda0yLZhNMLzhPPl5EWRPsilnLyeUOe1HvcXrCX9zj7OGb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CZ97lTYW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZ97lTYW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785153175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hg/6mZLwJawyAIaPx/2xXdNrUgeKWONDLxGhJl1XA4c=;
	b=CZ97lTYWr4yxg1at6YJuFnBRO93TDCZKHaaUrV8jWWwoVqv8rEqcbv3qiDfWtXtYIccaNz
	39Daj2vZmU40SUjHLIZ61LpSIhPgf5xraQ30a93APBS++p2/+EXzTEFUZ4qc7GnPivfh4U
	hdpUVz4nOBaWR2Fj6G2XbPqLEfqRc6o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-ZNuW-qaZP16ddG1vwbwRcg-1; Mon,
 27 Jul 2026 07:52:52 -0400
X-MC-Unique: ZNuW-qaZP16ddG1vwbwRcg-1
X-Mimecast-MFC-AGG-ID: ZNuW-qaZP16ddG1vwbwRcg_1785153171
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A0C11954122;
	Mon, 27 Jul 2026 11:52:51 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B17130010C8;
	Mon, 27 Jul 2026 11:52:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:23 +0400
Subject: [GIT PULL 14/23] hw/cxl: fix invalid free on early return
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260727-fix-v1-14-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=fAZjMS/5LPJsdxD5l3VZWDpjLs9glFNuH9tNjnRelIg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y/z2GfSRvUfq832eIkZAZ9baw2wDMnXXDVF
 Ptc/4DpMi6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPwAKCRDa6OEJdZac
 5So4EACytTrT2zL/32GNr4CYt7t+p5UsdAPXmE8zgMekfkzkHcwIDdrN1bUK+l6eIS3QTJa6Ugn
 46S8qnnSOOa1djm4ny4ROA9vsf13XH7MsAmGJ5PHLzbc9qOynLqkDgjd4DIttknnBrjMop7/Q6H
 o/Y2dJ4BHhtKjoNpnD45ltCv5EzyTV8diCPoIn9zGrzOIaT18AK+Do0WV2od3W77OCDNoTl6wo+
 CRDryNJc6mFXvyOTm8K4Yn1+ppkUlhGo0T5anCnFid68SkeOTz3CQXA87fHALz3hPv0E1C7MtcN
 L13Me8YgGexcstDIk2WRKiwbImzrcLyqdKcbJbnW2w8ZBs4nMpOJ50qlwLUSjd1+FpA4MjD0gCs
 AnyAwvj9epcsrV5JodelzRpi+3FEfIiUqcNgTkFLCHO/h2CT+uiqnvxg/CbMjDJTU2pIlZuehL7
 gKSkBLKzWAbIOxbvThxfxHR1/nfui3SYUbIbKPsD6PrfaVtt5ikAgr300Vk9u5eE4+jL5DUDXFL
 Re9/IM2IsdooC+OPHnSJhOw3Pxx3WAuDpYMNsRtAFAJTki1icR+pE4xKmLejkec56RCrZqW+nI/
 CV7MnpDl8mqOvIV5nBbGQPDVO0XXFsn3TB7iaVxtg2zTXC80KqYdnr9MlewM2921bCCKeYRVhfF
 9+4mPPBLGVq/N/w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: TI5fDY94_pPYcU0O1sfT-awHtwYSBc2D8QBJC4ND7Zc_1785153171
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

docs/devel/style.rst:

 * Variables declared with g_auto* MUST always be initialized,
   otherwise the cleanup function will use uninitialized stack memory

Fixes: 680935c9a6ff ("hw/cxl: Add a performant (and correct) path for the non interleaved cases")
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/cxl/cxl-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 7e744312f1d8..eba13c9e7cba 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -279,7 +279,7 @@ static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
     MemoryRegion *mr = NULL;
     uint64_t vmr_size = 0, pmr_size = 0, offset = 0;
     MemoryRegion *direct_mr;
-    g_autofree char *direct_mr_name;
+    g_autofree char *direct_mr_name = NULL;
     unsigned int idx = state->hdm_decoder_idx;
 
     if (ct3d->hostvmem) {

-- 
2.55.0

