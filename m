Received: from eastern.birch.relay.mailchannels.net (eastern.birch.relay.mailchannels.net [23.83.209.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32462940D
	for <linux-cxl@vger.kernel.org>; Tue, 30 Sep 2025 03:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.209.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759202565; cv=fail; b=u1IxuEdtd26kJWxe2KMYNrsxGyyqEcJM7rYh4gubO/10qZYUGqtSLIABSNh99lNd6nDMC5rXe/EUgfU62mSCQCpfwInAV1vxvRDmxpjV/zgDh+VaXf4Tu9g4/cDL2RW21jW0JokALcqNPnUi4c3R/A31b8zrx5t68LZTNLEq1TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759202565; c=relaxed/simple;
	bh=ey0l94xpBFJb30QVjbGLSqlzqpxRJwfsQVqgQcdckcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c713HF6Y0SeZepwDKK+m7Sg4kKygNABn/Zh7DwIGgWJeeGYJvnaJuEvFpauuy7XLKMWhCVjd1jeB6eShHNkWjLGQfYgDjafNz240SdxADyBfGbKVe86O5hxmlY6NG1ebShTzFM9HeKFSY5FQ5Eb93v5ejqXiUH6TMaJ8W4vP9fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=njfYoZsX; arc=fail smtp.client-ip=23.83.209.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="njfYoZsX"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 182597402BA;
	Tue, 30 Sep 2025 03:22:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com (100-111-81-207.trex-nlb.outbound.svc.cluster.local [100.111.81.207])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B1262740EAA;
	Tue, 30 Sep 2025 03:22:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1759202556; a=rsa-sha256;
	cv=none;
	b=E7hDx0vGgmiqhFsI5gSArmieBCgEvhcWlzDzi0Dttj8LF7YFMp0PCNFWfxZnbq/IaloDWR
	ZOJ0UcLlzqgt2esnL47P5xdE1UH1z38X4pkU1AAOpQrgYqXLocTwcLYESLqyv+OmshXfDI
	FON/IvUN74dcvijiClsMygDEgDFqjUfMIaSgVCF/BQYiua9Ye6OX7p6HPBcTwpV424Rxf1
	UcDIVBwVO/J3utsTg2Opbrsjfj6/pM33qi0psHvBNLk721h5y+Nh+JA77pG0aq7tovDvGO
	hAo2D9WFP4DxkRMA7vNNACjZcCOim9xad+5OATZAz7GOd4IdZ+QnBI1KZFAUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1759202556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JN0+GXZnlRcIr53jJwwDjRJANTOrAhEiLSRgFnV4B/8=;
	b=Q8Iw+3ZGZgxQUkgpthDVGsJzap79UJAUoRcFFgv3XPdhD5Dmibn0VcU1QEcQPI0TeaLa1a
	DJVdJy8orJZ6L6isZW8O/fS9aDLvtxHE8Yn8spmepSDh/++5oHPGlmSKdBEDHXjV2YPS2+
	UC9wwbcTV5iVTFPYix5wnohH5vd+CES2WKqUl3Ytd9ktSoDBJo9w0FE8F8KRhc2FNv7HGT
	juEJeipsNFhkbxxz6ApOwP+BIjJeIKuHlc9n9LXzMhn/rJmZWeNZe6VstYA2AHNYwBvihv
	x1+m1rYNvDUNb/QrmE85HG46nHVaRHYY9A3sM7xLBg5iGaq5o90A1r9lJbqksA==
ARC-Authentication-Results: i=1;
	rspamd-867694b6c6-mmmr6;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Madly-Oafish: 2be22a7027bed86c_1759202556998_3643016461
X-MC-Loop-Signature: 1759202556998:2878416865
X-MC-Ingress-Time: 1759202556997
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.81.207 (trex/7.1.3);
	Tue, 30 Sep 2025 03:22:36 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4cbNfM5pBNzGS;
	Mon, 29 Sep 2025 20:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1759202556;
	bh=STfZcHxoRXw28XWRwgLmWXwMCu5bClVaJbQlLpEDfx8=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=njfYoZsXSTmZOzCItbosjsJ0VRbF4ToJfSjL0nlxpa1mDSEr21rxMwBiEeObNlnL5
	 LqbGrCOYcxIpnQiqYYpFxy19aIcbBUmgE0P/M+8h5ze17mW+E2KHdGPDJz2mRa3vhM
	 Vt7oLSctonGT0th5nHO845JpMcjJUYDIHfUinXHlvgdn0dG2KOJbomRG7j6C7p/V+V
	 V9ufzGYTKp/QustxhpR0lhowLRLO2I1xX+xN5ckAylJl7CILBtsuoODjQy/AXzrxTi
	 BZuzTZWgHOxIxm91JvyPdSUlf4XQxLy6q9dkOjB4Q91OVxLk4tglSDlorzmO0AZXOs
	 FtTVbCObNAY0w==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com,
	lucerop@amd.com,
	a.manzanares@samsung.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com,
	armbru@redhat.com,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net,
	Jonathan.Cameron@huawei.com
Subject: [PATCH 5/5] hw/cxl: Remove register special_ops->read()
Date: Mon, 29 Sep 2025 20:21:53 -0700
Message-Id: <20250930032153.1127773-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250930032153.1127773-1-dave@stgolabs.net>
References: <20250930032153.1127773-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... this is unused, unlike its write counterpart.

Suggested-by: <Jonathan.Cameron@huawei.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-component-utils.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 2098e9999a88..47a8d905f5b7 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -69,10 +69,6 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
 
     switch (size) {
     case 4:
-        if (cregs->special_ops && cregs->special_ops->read) {
-            return cregs->special_ops->read(cxl_cstate, offset, 4);
-        }
-
         QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
 
         if (offset == A_CXL_BI_RT_STATUS ||
-- 
2.39.5

