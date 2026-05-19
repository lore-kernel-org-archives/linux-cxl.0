Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92BB3B19BC
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779228729; cv=none; b=YZ71nuYUjdkJZllCaqZxAW23jAkTjnQfo5id35fpbFIBXhqLLGraksSNM3j4uKGc4ppmqx0Ewt+TryP6LmMd0Frmsh7DFfZ25gmy6xXGnaNpHHCMaK7vGUPncAdmQozNL2buaeUhZHTNhmso0NaO4PSlWViMRc06KDWw79xYJl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779228729; c=relaxed/simple;
	bh=Qlchm/9CYEH+oPpfwaLQUCt1T+iuiceNO55EJEXmwsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGpooN2Xx5culqaZkGbmjYkWyLKu6gx9FCtglBKJVHHWrJIrEd7GYUyS2KOCvuDm5qS/z2lH7iid36l4z8dTJagntdtt0vaYTMJ6L3d2nLPq0m+Rktf2GtLyaQQQNmr4QoE/9hRUSjH0+AJRNQlefLRltNxUyBlX2fLQrnLbZqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii5E4tRE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii5E4tRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF621F00893;
	Tue, 19 May 2026 22:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779228728;
	bh=jcOQdz6GvYQnR7rbF4oRJVU2lytzcmKYuNsY9FkBIzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ii5E4tREe5VN5qliJfz6yb2dA/Gpqdu0Vhu+Eafo1dI/i9BeCiE17taFFtSCszWRk
	 Dw8iE3OW9cCZ5/AB2kIuT6u6W5BwKsS+FPhReqodtmw96+IhqTaod0X4vLu6wJvSzq
	 TtQESCqNCxTqg9sgDhYy47wpS/HwlIba3V6MnQX3oepb2qw0XXnt/5CACyMnsGdrNE
	 QWOHDWGi4dz57kCYenXtT53e+ZChujI49Jx5vuSVD17p5sOiY0+p2POpO3YaJvAsXX
	 MGyvzQrh/uJjhem27XUF63oBvt7DuVDXNxn64J603LqAhhqHmi16CmzJk6oDWWl1jd
	 B7DS9xRZDRCeQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id B0675F4007C;
	Tue, 19 May 2026 18:12:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 19 May 2026 18:12:07 -0400
X-ME-Sender: <xms:N-AMagp5aJIZXH89ZAwVnIlVA16uTGPuoooMqUjjhAqLIQc5r-fM8g>
    <xme:N-AMatpFodeS8MGbRNbE_CnE7IuJ-MS0Glo_Vi9UELr1uqKznwYmb3hN1l_wMhwJl
    2NgPd8rlHjhcI6_86L7jmKwy2elb4gbkMnm_EzxaAWlXgfYDSdGwJk3>
X-ME-Received: <xmr:N-AMaqOnTpNhqMmiUbBU3Ms0ktOxx4yZgOLcLc7G8xudlKou93RQXqNBNZ0GLCAXh5GOkzKu7grJ2lJSzed51UN26visPjfHKMI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedvledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeffrghnucghihhllhhirghmshcuoegujhgsfieskhgvrhhnvghl
    rdhorhhgqeenucggtffrrghtthgvrhhnpeeuheffhfelleelgedutdfhleefjeejvedtke
    fgjeefgfettdeljeefvefhueeiveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegujhgsfidomhgvshhmthhprghuthhhphgvrhhsohhnrghlih
    hthidqudejjedvfedtgeehhedqfeeffeelgedtgeejqdgujhgsfieppehkvghrnhgvlhdr
    ohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepuggrvhgvrdhjihgrnhhgsehinhhtvghlrdgtohhmpdhrtg
    hpthhtoheprghlihhsohhnrdhstghhohhfihgvlhgusehinhhtvghlrdgtohhmpdhrtghp
    thhtohepughjsgifsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:N-AMamzgfSB-SgQfAAGfxIG4nqTMPt7A-ElIevsw38IwPkhVWJg1-g>
    <xmx:N-AMarvLCiZVzUNTC8FfZwI2arZievTn2PbTzoKabKqBqqAmHfDLNw>
    <xmx:N-AMan4OnS4w9TivZjKK2SNVfuDVTAW2U7hj9_23MpSIfBds4t-_Ew>
    <xmx:N-AMaiRz9xto1R7MBDqw9EsAsuht_VEwDOVclTjzNs0vO2Qf-bGGgQ>
    <xmx:N-AMaupEK7L4vpb8Yp6Xy87xkN_sJP0xnmyuqWEcDhCMS1-Q9xo3vRmx>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 18:12:07 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com,
	alison.schofield@intel.com
Subject: [PATCH 1/2] cxl/fwctl: Fix __fortify_panic
Date: Tue, 19 May 2026 15:12:03 -0700
Message-ID: <20260519221204.1517773-2-djbw@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519221204.1517773-1-djbw@kernel.org>
References: <20260519221204.1517773-1-djbw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a runtime assertion in cxlctl_get_supported_features(). Fortify
complains that it is potentially overflowing the entries array per
__counted_by_le(num_entries). Quiet the false positive by initializing
@num_entries earlier.

 memcpy: detected buffer overflow: 48 byte write of buffer size 0
 WARNING: lib/string_helpers.c:1036 at __fortify_report+0x4d/0xa0, CPU#7: fwctl/1398
 RIP: 0010:__fortify_report+0x50/0xa0
 Call Trace:
  __fortify_panic+0xd/0xf
  cxlctl_get_supported_features.cold+0x23/0x35 [cxl_core]

Fixes: 4d1c09cef2c2 ("cxl: Add support for fwctl RPC command to enable CXL feature commands")
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 drivers/cxl/core/features.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 3435db9ea6b1..85185af46b72 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -423,6 +423,7 @@ static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
 
 	rpc_out->size = struct_size(feat_out, ents, requested);
 	feat_out = &rpc_out->get_sup_feats_out;
+	feat_out->num_entries = cpu_to_le16(requested);
 
 	for (i = start, pos = &feat_out->ents[0];
 	     i < cxlfs->entries->num_features; i++, pos++) {
@@ -444,7 +445,6 @@ static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
 		}
 	}
 
-	feat_out->num_entries = cpu_to_le16(requested);
 	feat_out->supported_feats = cpu_to_le16(cxlfs->entries->num_features);
 	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
 	*out_len = out_size;
-- 
2.53.0

