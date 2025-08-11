Received: from aye.elm.relay.mailchannels.net (aye.elm.relay.mailchannels.net [23.83.212.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95930239E8B
	for <linux-cxl@vger.kernel.org>; Mon, 11 Aug 2025 03:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754883279; cv=pass; b=DtfWwxIqFGrw01Oq8x73R3HAsjAVYdZJuhZ2k6gT/yfPAvp2waikTXpLoodODO4ExNnfFy60ddwRBoldPDjhVu9V4mkj7XnYlFJKiQXa3/p7saX4P7QXJpzyNLdB7L2VtQ9+UcTEZZVT4ozj3wux5w8EB3LrwBRrDpMwLwlodwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754883279; c=relaxed/simple;
	bh=49dX/45Mizzg+eh+rwbGpo6pMN2mUNfn5MujbFjYpA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ST+SS5r+6Bn0YpCcUODSIb7LpqSJJa2BLYdUKfjlsQ2XIXsWzchfwR3TLN7SMGp9uWec1mqUyTDxdawuu+S9eYw6jm5kjPS683/cwFLag+s9Ik13wBmkWP6nG6sQLwuYQ1m6WJV7MdyRAyBMcT2m2oLTtjHIkEYuEdWgCOZR8UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=FZyVd+XC; arc=pass smtp.client-ip=23.83.212.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="FZyVd+XC"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CFA2541D5E;
	Mon, 11 Aug 2025 03:34:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a236.dreamhost.com (trex-blue-7.trex.outbound.svc.cluster.local [100.96.43.79])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7ABAF437A7;
	Mon, 11 Aug 2025 03:34:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754883268; a=rsa-sha256;
	cv=none;
	b=Nb2ilMRgRC2Re0fbJVGj1rtly8hG2b8mTINNToaQ/xX4H7+a3MIfTvq6doo+2wgvFq37ib
	oP9yV7ECKVoB/mbAwuZG8tO7v27llvmCR9ak3itjhYeNA31DyyPKbwtxqviDQ9FkzRIskH
	fJzp8WFziY4roTIYu3L3qvPHSRQkfnp3W+jrtTnz2jAeyu65Grs/jY3J4NslcBGQ/vBgxu
	VGDYc3Oossh8LxBhRODGo6ml2xJpMK8MZhtrfdyU11A9XdZyBc27vSSr9S8KYV43FRQt19
	+m/PrJsrSczERMZOd4nuFYG3Yo8QUZZM7Tkt2Zn8OyzRA5ArZvqeO2p3iU6zDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1754883268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=F0QSnTgOLesF0aCE7qfgqoYpipQeSin3zJuG38HwYM8=;
	b=w7mGWLeKWrwBQiFNa6skAwShcNJrMOTlvazIkQkJYpGOW41Smogab70021W/gQsdgt6mtH
	8ZoHaFFXYE5MA74mRaWjnomHn4AMXuu10zrGgt1SopYB5QtHZR2dG/PrnrJYrXn/2uLWXs
	T42JjOmuzOUbIebcAsd674HCGrotBCa4RA9Hf9Gvy8B7SKfKucFywcV7XvXoYzWEcPzX4j
	Ik10fGWGpOTY1QkGdLyQK04i8S0Pwi+wyELMUxQbemnm1g1327rW6zyuGj3aJamWZDnMOC
	pa/HoY0KFmNiLzFyrxxtsyL7NXNoBJOBctGDaUimdf2+vh8mnXUKLJftr35rsg==
ARC-Authentication-Results: i=1;
	rspamd-64567b6586-nb9n5;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Reaction-Harbor: 3ba9798a7bf89247_1754883268761_600204874
X-MC-Loop-Signature: 1754883268761:3584875587
X-MC-Ingress-Time: 1754883268761
Received: from pdx1-sub0-mail-a236.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.43.79 (trex/7.1.3);
	Mon, 11 Aug 2025 03:34:28 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a236.dreamhost.com (Postfix) with ESMTPSA id 4c0gH76dDNz6v;
	Sun, 10 Aug 2025 20:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1754883268;
	bh=F0QSnTgOLesF0aCE7qfgqoYpipQeSin3zJuG38HwYM8=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=FZyVd+XCoFqlGgKVRgH6E8JBMBt9OZklwkkmE8/Ug3xNLp7PDT8vxYdpFMO6jxvHH
	 HaiPpMOgcRTBx2OK+2Ni+pNvlwShrgvOJLWmhrsi6ovVRQsj5hWVOA882AjI+zm4em
	 8PUnNy7VOmuApiXTtTxK3xvk2FsVdr6EyVHuW8eifsaExY6wOlIQ2SmZqo/qgEV0B9
	 bfbIZggWO6PBH7HUmPtzf/zJ/LwP0Ra9oHQVbwhXZmRVfXRQtAvJEAfKFXab5f5yuc
	 mL1AbxUD3ViMp5/Q/yC1i3UO+EHNTUKrN7PkC+pwbK4t7MSSKOdKiZ7zRGDZ4fBk96
	 3XVJ6HP5rO+mA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com,
	alucerop@amd.com,
	a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 3/4] hw/cxl: Allow BI by default in Window restrictions
Date: Sun, 10 Aug 2025 20:34:04 -0700
Message-Id: <20250811033405.332295-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811033405.332295-1-dave@stgolabs.net>
References: <20250811033405.332295-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the CFMW restrictions to also permit Back-Invalidate
flows by default, which is aligned with the no-restrictions
policy.

While at it, document the 'restrictions=' option.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-host.c | 2 +-
 qapi/machine.json | 3 ++-
 qemu-options.hx   | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index def2cf75be61..0d17ea3e4c26 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -64,7 +64,7 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
     if (object->has_restrictions) {
         fw->restrictions = object->restrictions;
     } else {
-        fw->restrictions = 0xf; /* No restrictions */
+        fw->restrictions = 0x2f; /* No restrictions */
     }
 
     fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
diff --git a/qapi/machine.json b/qapi/machine.json
index ac258578e4ab..ea8ba71305b0 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -589,7 +589,8 @@
 #     BIT(2) - Volatile
 #     BIT(3) - Persistent
 #     BIT(4) - Fixed Device Config
-#     Default is 0xF
+#     BIT(5) - BI
+#     Default is 0x2F
 #
 # @targets: Target root bridge IDs from -device ...,id=<ID> for each
 #     root bridge.
diff --git a/qemu-options.hx b/qemu-options.hx
index 1f862b19a676..2da65fad3c9f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -142,7 +142,7 @@ SRST
             -machine memory-backend=pc.ram
             -m 512M
 
-    ``cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]``
+    ``cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity,restrictions=restrictions]``
         Define a CXL Fixed Memory Window (CFMW).
 
         Described in the CXL 2.0 ECN: CEDT CFMWS & QTG _DSM.
@@ -168,6 +168,8 @@ SRST
         interleave. Default 256 (bytes). Only 256, 512, 1k, 2k,
         4k, 8k and 16k granularities supported.
 
+        ``restrictions=restrictions`` bitmask with the restrictions of the CFMW.
+
         Example:
 
         ::
-- 
2.39.5

