Received: from hamster.birch.relay.mailchannels.net (hamster.birch.relay.mailchannels.net [23.83.209.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E2F392C5F
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jun 2026 23:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444511; cv=none; b=OEz/ySIpOxkgPYGWoUKUuetWLgwLpFtSv3A8/VLkoJHSJT29iPhn+HTXvBiPQQQlprHUE0KGm2OOono7H+eY5XixV+98lOOd300/O35uIxkTWEb0cbT9jOKiJqDxlL0vetUgsZCAMP1XauvJOisYYKAxp5DlwE8244YEWUSynBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444511; c=relaxed/simple;
	bh=c1KemHOWAwq/hyATvH9YzwTlRHqdQltiYJz7qzpjZZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S8HsBtssHE0tYNluKcSmr59yFdK2joupSQRHt0fhEYrON5kv2+Gv8iE/mUomW9dXM2/qMZs3xhrpkh7z8e6ITGrjRoA1L//zwKSCsFnl8A6xdp4x5lGcPD2DsFzAtAO/u9zSEVFHkrU7mECh8HjEp0ffb6V0krsFkgtEF1mic2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Qsm48XZI; arc=none smtp.client-ip=23.83.209.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Qsm48XZI"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id AFC4C721ED6;
	Tue, 02 Jun 2026 23:18:49 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (100-109-199-18.trex-nlb.outbound.svc.cluster.local [100.109.199.18])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2DD507208C6;
	Tue, 02 Jun 2026 23:18:49 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Ski-Bored: 3126b925763d1e9f_1780442329622_3306041104
X-MC-Loop-Signature: 1780442329622:256772112
X-MC-Ingress-Time: 1780442329621
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.199.18 (trex/7.1.5);
	Tue, 02 Jun 2026 23:18:49 +0000
Received: from localhost.localdomain (unknown [181.212.92.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4gVRbW4jzTz107X;
	Tue,  2 Jun 2026 16:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780442329;
	bh=EUCYD7G0hS4r9cU0to/bYQKfqUIG9pVGYsJSpBxIsk8=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=Qsm48XZINYSgLbaLokaL/Wyj6m/ApOOvZssuEmoSBw2jF8zMhy56SZZRYg8BxGqxt
	 3p2kHGoGp1t2r3vGkWzyV08xSGxNcpLGYXeF2+RMiJK+PaZqsggAGLoVdahBTjs/GL
	 BiVrh4VN962urZ/lfrOyHiUeuE0I2f7NVsoq4/b1GJo8HZfNTt3p6w35JvrRp5wYHE
	 UwrW1iGJBbFdhD4fBESi3u037hCw2MJ17Y57SLfWYlPQ8RRHNH0UHhflC1GS5PePMO
	 vYe+F0+VSqNG8H6LUBYFEEwbYWvu6dAomrw4Lv/1iLJSfRLxAPQLFwuQQBb/eHjGIo
	 6JY9EEzm20i/w==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH 2/4] hw/cxl: Use host-only coherency for default CFMW restrictions
Date: Tue,  2 Jun 2026 16:18:04 -0700
Message-Id: <20260602231806.2469011-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260602231806.2469011-1-dave@stgolabs.net>
References: <20260602231806.2469011-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the default CXL Fixed Memory Window restrictions from 0x2f to
0xe, dropping Device Coherent and Back-Invalidate.

host-only coherent combined with Back-Invalidate is undefined behavior.
Device Coherent alongside host-only coherent is permitted by the spec
(multiple restriction bits may be set) but advertises conflicting
coherency modes; neither belongs in the host-only default.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/acpi/cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index f92f7fa3d558..5ce5e8e083ba 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -172,7 +172,7 @@ static void cedt_build_cfmws(CXLFixedWindow *fw, Aml *cedt)
     build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
 
     /* Window Restrictions */
-    build_append_int_noprefix(table_data, 0x2f, 2);
+    build_append_int_noprefix(table_data, 0xe, 2);
 
     /* QTG ID */
     build_append_int_noprefix(table_data, 0, 2);
-- 
2.39.5

