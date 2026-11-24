Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795511754;
	b=LDBKG5ywll+cTo8YOPfoBz68ewSfi1dIPwrHWZPp/hB6vI9e9TON1s+ZrbFjrOfxbjEx
	 uEIjzuN75n1pe7Sz5zE0DIklL1Kvu+MCbXGYB1KcpZ1J1F9NDu+bprSz4mvdhg3EyKmxr
	 6NfUfxa3351xM/egd4QjCoMn+mDXKIzqn5gvMAR54BsxXMn+1ykOnFqn5tub6yalTU4W9
	 jQVHbSnKvquB4xheoxgYFl66bCsO76JJvpQBuvdMsDuxL6sJCb20dmefkmjYuStZldcz+
	 5YEOqEORpmVJEOEgyPZYWNoJwrptbg/y7N0MmkmKmeQQHDEJy6pd2mqf/O1YHPN69Hg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511754;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7w+ZeqJR+6IaJn4T6XZ3gYHHfDq8mJeeSEhNRMXpwhI=;
	b=oVqR7sRCU9h5CcQPdrMm9A4+la9zLK3UeWLwEVz3BUMLsuN60JWcGOQag9RnJ+sL5v//
	 pHlnwoVrOQj0ylIJaJChDBgAQaZxi1aYWUkPuNBiYVmmt/CmHY0liBQVvnA3mlWtGyw0q
	 Gx1PZQyNLHmFcqZo9VsSwIiJ+9PC/7nLeFTyJGbT2d1WC150GtwTUN+Z1hm92v2t4OHae
	 zOA5P2nakQiLO9cDyzaHF7US8kKPFESsvgev1iyewardWUTY2avtRp5B5dDWTf1SbF7z/
	 Dxvloud/X1xkFJdQmDv3KON6DxF+nk802GJ7qVWB1nTwDRz/VTRJ1N8RlSC1t/I6aSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qufg0X2D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDC2606A31E;
	Tue, 24 Nov 2026 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qufg0X2D
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795511754;
	b=wpa8Cb11+QtQN+qQl14okCs9iy+S1FRHHd1hTibSgwXYZHGxU3NNhdzHWFRx+DflEb40
	 tBObSfk/qkWD+A6G4Nwx/dkToyYy2dR9R5UnJiGcA65RfZYFB/jPPatWCraBdCxmEwxJ1
	 uJsiXsr/ON+XvzILZfe6cmqQt4Y192z1mD8bDHSQnHwcfXd8px9tzvKqeYE+s+KMjvgpO
	 u20kYae5OAVQpsZCXYmX/p5g8Bvv1dqFwJ666aCKzqBeHOoj6byqUJHiGSRizn8LkcdbU
	 99iE4/MFr2453r9+J1ISx68dsm56GezyDYO9+L08GYKZay+lCPFpxV/YlE7w2HbOs6g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795511754;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7w+ZeqJR+6IaJn4T6XZ3gYHHfDq8mJeeSEhNRMXpwhI=;
	b=GPxyAIxLigYjh5RdwrMT5noh86V4mwj8ap0qMY6vFNekUOdYRGUSaZ14vUQGf86Qhx0w
	 GbCEl12UnxzIbcs2NkPAl59XRzrkp19TGZ8GCAxncGSlBiKzkJ9MP+FnF9Qmph0yVrEkt
	 tPiXDpyMjB5R1/CijcWDAIeQaEqn9F3SmGsiff/BztNChr67z7JzGIcUTd0nIMTw0cE6P
	 +mew8KzwaDZH2VBS2uYiFtekEvqy6tTqAawVqqwFfXM0syX1DHMWt4zhqAdZIPY3OE0Yb
	 qrLaQt/cijA5UKDl/fqdY8Bm2EhyN2lGzkPDtJxJbdF0IbSrIc2XbLMmms87Wldmq9Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 02ACE1F000CA;
	Tue, 24 Nov 2026 09:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795511754;
	bh=7w+ZeqJR+6IaJn4T6XZ3gYHHfDq8mJeeSEhNRMXpwhI=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Qufg0X2D2FwFrFrY8GGgG6zkSEfYE8DI24cGA0ExHA833ONxH4T2aUdXmTEDbbJx7
	 gHlWkF6BV6VQvEJ4qyVOsJ32HuDXNsF3Oa1bcQ+Np8YDv4IatfrnhMM7yXKYQ6lJP7
	 CHSPQhARkf+3sa2ww4vA7hHH/psORc/Su2LbRiFp8HCazJEJ4Sz+6l0QgTt4nEmNtq
	 PhIiiqF0wgniXLfDeV3ISmAZ/JCQRWo0u40uJ40FBRlv5qZW9K2uvJ5OTc0CmA5BGR
	 r5hc8Cj6z0/D038FyGrXmmyxXanLihcYwdkD68uG+DeEztliuzzZHn3lkrufpktyQD
	 NlZGglpEFCQdw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 507BD4C97C;
	Tue, 24 Nov 2026 09:15:47 +0000 (UTC)
From: Junho Cha via B4 Relay <devnull+junho.cha.xcena.com@kernel.org>
Date: Tue, 24 Nov 2026 18:15:47 +0900
Subject: [PATCH] cxl/region: Reject freeing the HPA of a region with
 attached targets
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261124-junhomax-fix-cxl-region-free-hpa-targets-v1-1-9229ae407595@xcena.com>
X-B4-Tracking: v=1; b=H4sIAMJVBWsC/yWNwQ6CMBBEf4Xs2Y1QiKK/Yjxsy9KWaCHbYpoQ/
 t2ixzeZebNBZPEc4V5tIPzx0c+hQHOqwDgKltEPhUHV6tI0qsNpDW5+U8bRZzT5hcK2bHAUZnQ
 LYSKxnCLWfdvTlTq+tQMU3SJcJr+rx/PPcdUTm3T4j4amyKiFgnFHVOTnwDnBvn8BCleAoKcAA
 AA=
X-Change-ID: 20261124-junhomax-fix-cxl-region-free-hpa-targets-0838a7a4e93d
To: linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Cc: Li Ming <ming.li@zohomail.com>, Vishal Verma <vishal.l.verma@intel.com>, 
 Richard Cheng <icheng@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Ben Cheatham <benjamin.cheatham@amd.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Ira Weiny <iweiny@kernel.org>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795511746; l=2089;
 i=junho.cha@xcena.com; s=20261113; h=from:subject:message-id;
 bh=+shOErfbEre4hWHhIGr07nm3Q4E88vlfKVuH7VEIVN0=;
 b=Ge33xovHF4kL3qvaSeua03PXbWl189Ali97k6c0IKfwT5MsoMTw2ugPgYv7y4m36Rs2A0/Dbp
 GkWNGdbPA8NAccyrj3JxeFGeKlETm7M4BfZIDNdJhAzXOQ1CmEp9aVs
X-Developer-Key: i=junho.cha@xcena.com; a=ed25519;
 pk=OkFm4PnuJSze1AVqDdvnpHO7nnDQIheH2qYwg2a6Dyc=
X-Endpoint-Received: by B4 Relay for junho.cha@xcena.com/20261113 with
 auth_id=1507
X-Original-From: Junho Cha <junho.cha@xcena.com>
Reply-To: junho.cha@xcena.com
Content-Transfer-Encoding: 7bit

From: Junho Cha <junho.cha@xcena.com>

free_hpa() only refuses once the region is CXL_CONFIG_ACTIVE. With
some targets attached, root can write 0 to size, which returns the
region to CXL_CONFIG_IDLE and lets interleave_ways,
interleave_granularity and size change while the attached endpoint
decoders keep their old settings.

The region can then be committed with endpoint decoders that do not
match it. If interleave_ways shrinks so that an attached target's
position is out of range, attaching targets until nr_targets reaches
the new interleave_ways can lead to a NULL dereference in
cxl_region_setup_targets(). Deleting the region and later unbinding
that target's memdev can lead to a use-after-free in
__cxl_decoder_detach(). All three were reproduced with cxl_test.

Refuse to free the HPA while any target is attached. libcxl never
writes 0 to size, so cxl-cli is not affected.

Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
Cc: stable@vger.kernel.org
Signed-off-by: Junho Cha <junho.cha@xcena.com>
---
Tested with cxl_test before and after the change on cxl/next, v6.12 and
v6.16. The patch applies unchanged to v6.1, v6.6, v6.12 and v6.18.
Writing 0 to size after detaching all targets still works. Before
commit b3a88225519c ("cxl/region: Consolidate cxl_decoder_kill_region()
and cxl_region_detach()"), the use-after-free case only triggers a
warning.
---
 drivers/cxl/core/region.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 237172b33f55..53965f1e4719 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -772,6 +772,10 @@ static int free_hpa(struct cxl_region *cxlr)
 	if (!p->res)
 		return 0;
 
+	/* Attached targets hold the current geometry, detach them first */
+	if (p->nr_targets)
+		return -EBUSY;
+
 	if (p->state >= CXL_CONFIG_ACTIVE)
 		return -EBUSY;
 

---
base-commit: 32af7819352bae9c690ebe277a44eceb501d5c68
change-id: 20261124-junhomax-fix-cxl-region-free-hpa-targets-0838a7a4e93d

Best regards,
--  
Junho Cha <junho.cha@xcena.com>


