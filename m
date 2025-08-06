Received: from cyan.elm.relay.mailchannels.net (cyan.elm.relay.mailchannels.net [23.83.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AEB51C5A
	for <linux-cxl@vger.kernel.org>; Wed,  6 Aug 2025 06:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754460188; cv=pass; b=lDgQmkkmj3I+JDCjDaqNVz0Fno1KQ1ftcQYADjvm2IY4SjclA1r37PuBPlAEBc5Y5AwY0A5GE1Gcawan/D2X4D7jkOe6p8Y1RVuUueK0nrQsbSKwGUf9TAGOVip2N2Up1PfI9AAo4ke37NPWtojVsrRNhMjLOmAAL4dMJnNXNDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754460188; c=relaxed/simple;
	bh=yDb0pBC3IOiCAEfAZSKOVOyvg9zQCtqeMfsL4o75vN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Meof2k9GXQ7dbQFiXnvqnp9GOFofV3Dh6hK8hbEjIx5kWSQVBSiLxWVi/dwiDft4VCbGUr3cpcp8CW7Jo5eCzf6YkznwObsC2ujUqLwVJAXhNRdPJDxaGK9oTEx2IxvxlNo4HpbaVzInb5Uc7BniDm2nMnOrN68eeg3SFpfxZ3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=TlwuneFB; arc=pass smtp.client-ip=23.83.212.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="TlwuneFB"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9D2198A4C55;
	Wed,  6 Aug 2025 05:57:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com (100-96-62-154.trex-nlb.outbound.svc.cluster.local [100.96.62.154])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 443418A4E00;
	Wed,  6 Aug 2025 05:57:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754459844; a=rsa-sha256;
	cv=none;
	b=k9MUS5i5V9IdEA8nmwhvm3c0fCmzBv+Uio0AIM6Zp1qkqFSvtUbDSA/PydjwF1f4+n88LS
	iXh7QjT9HpDMopag7yQMgQqhs3kDmihFabK5rlsuU1SecEKvkyz71E330lL0RlgBNn0uYg
	yWBbC4JGprXCNuSNMJYoHa8fBXMSlpn9Dy3AqY6Nwb3rJ2axzMcE+wTWbnFl0vZ8HOyRD+
	V9/gAG3y7hbjOfx78V3bnrwA0w3tQK1SVKM/A5RmOnni66Ugh5GowptwaYsqGNZmnqvVqH
	u3CZgQAqFqE4tyeBybWA44MqwWQ3odgaxIXpHhxDpNW5AL0tI3TC15g0/ukKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1754459844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Mg4xOVl2HlHkcIXq+xCTdZDC3cs4yQ8nl9mbIyMKKCM=;
	b=L2FUOSUo39OReVenZGsJo4NmAMh/M88Vli1XnrCnIcIMr4IJ7pZrqN3Do9TdYzqi+fHr7C
	leEeKQkwbg5G9FQojf+XbU3OQSJu4Et5fR51bo0d5JIG9FSj1tbRkOY/Gj7moFnXlSjhSz
	RwTwmVPuEhssrXHpKlzAAMv8njZFypHCGBLeGc6CL2EWtVeMUhjm2zy4H1i5l+jznWUyIG
	Ad+R6WoRLz3YrP+eBkWnhRiDl4Qo4p9j9DGhBQ/MUY4+bUD5eiCnSJgYcdLDElLvnD5/MM
	2LhBPBA7n6Zv4sJ+cYDS5wwuSI2wtuWMWJ+9q46R1hBhr8XfMXLugcCGOTuqXA==
ARC-Authentication-Results: i=1;
	rspamd-648c9d5b94-9lmmc;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Industry-Trail: 4bc6cb09212906db_1754459844531_947622207
X-MC-Loop-Signature: 1754459844531:2212034592
X-MC-Ingress-Time: 1754459844531
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.62.154 (trex/7.1.3);
	Wed, 06 Aug 2025 05:57:24 +0000
Received: from localhost.localdomain (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4bxfhM5GY1z55;
	Tue,  5 Aug 2025 22:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1754459844;
	bh=Mg4xOVl2HlHkcIXq+xCTdZDC3cs4yQ8nl9mbIyMKKCM=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=TlwuneFBzty3urQk9QTPWDWHCa/CP8Hrd8uTVyGxX7hp6JavEkexDjiVaD2aYI//q
	 Z8WTAtfbFX2JObthXME6oQdKH16rbCW2U+XmO+6RNhyYgGqGlB8C7jK8C2aG+cc0Hi
	 FC3p8Y7kjZujBji/LYceXIkedDVQGEw5Ym+23Tm5lVGPcpLQ8Ooi0rkkyE9z24FZOV
	 gp2B1Ec7KC2EoE1N0LwsDoWY6w2iO6JcfZzv67mUOUb9EXpygll0vtcHmM74gOXCyZ
	 SrG1RHmIoX5ru/JGkfnSplmIMKYi12G1JMzyym5WJ0vrLzN89Qsk//pXYX+n/FueWw
	 7lBrEoleqbReg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com,
	alucerop@amd.com,
	a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 3/4] hw/cxl: Allow BI by default in Window restrictions
Date: Tue,  5 Aug 2025 22:57:07 -0700
Message-Id: <20250806055708.196851-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250806055708.196851-1-dave@stgolabs.net>
References: <20250806055708.196851-1-dave@stgolabs.net>
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
index 1f862b19a676..ef6072bd8b59 100644
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
 
+	``restrictions=restrictions`` bitmask of restrictions of the CFMW.
+
         Example:
 
         ::
-- 
2.39.5

