Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF3C318EE6
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 22:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779228731; cv=none; b=pZ9rs9RTEG2StnZzlX3j/6R2VIIkR1O9IdPTyrhrOeAqESng+dWz8kIa8HjmdpM5bUNpZxbT2aiPrUyyJ2HQzqOfvpTg0mwY8naQfWDdUlSbH4Eif//cCC4HdVzBeXPo40DPHD3mn5DLIkZce9UjVkVYVhcalZkDsYDQupzc9SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779228731; c=relaxed/simple;
	bh=OF9x35ITXJlCEtIrm6NP+6tZWbMAOrSNYXzlY+DfNNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEsLt11QHdWzRVhyXYW+jWvsQZ4J0gE8hOiRk9scenLM0SRdyb2pAMrRC4M/6jSENHKSECvZJuUZpraZkvwrPoqnHKytetlbCS56uYLUOpXiE3/Rp6bwy/3FsaC0MX1TgwJctKGFxvzRHpbNN8f7wF27tQn6buXCmI3ztciXZgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDuQEthw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDuQEthw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19DE1F00896
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 22:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779228730;
	bh=v1IgCpfroDrji0cS9MEmE18uSKcWeQFGBvuPbfPm9jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IDuQEthwxSTP2pxX7Lte2y/O5c6GSQRQZRMDQPa2rcwJlF/vhJ3eNl2PzKmj53i/x
	 ip0kxdUxqNLUFjhlxlxilDazVIZFbe+4CWXjM370NpGsMMOEIDizKNVwCi385a6wne
	 e5hcsOhCaWTHdL7mXPjabkTZ4YWrwPcu1gFeKjvEZz59S6NigQlGcp5KiLitIfBgsc
	 dG7ijEM78CmFw/YEREZYjUYioSls4BuXsx0TZN1NZTpl/bm/6CRQTWVR3DPG/M4VJf
	 PsI6NxTjxol5S7GGnIGQNHobFiCYL3Ow5A1LHHkboWt+vouDgcSmc8Lv4UzrONRPcR
	 C1vVlp+4z6i9w==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 55957F4007C;
	Tue, 19 May 2026 18:12:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 19 May 2026 18:12:09 -0400
X-ME-Sender: <xms:OeAMah1JfJft6qwe3zJAac4hin48EpASAiMmQRSAVKWTIUeHeJ5__Q>
    <xme:OeAMavHvhRmLXwf8C7wCSFYeKSB8rn83P6r1r3WkTNcMZZoDJxCgzTaWV7jSIOHz8
    5paP_LaP6qtO2sczCr9Yx1lto0PtvNGtMrzXchgB7POPWk70S2Mnko>
X-ME-Received: <xmr:OeAMam69r9FHdyAiPSmjTl7roQYuQiiDjqrxbXe5JG7n0Ha5Ovtsgx5F6nleT6-wPIOElWJbqvldl6dYgBhnzMVQA1KP4fJjWwA>
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
X-ME-Proxy: <xmx:OeAMatuJjAqN0m-akqBciphNbdNh8KEWbWPwFCnAivJ0Evrd6XMmMQ>
    <xmx:OeAMav6p1m6KYATnYWJQozx8OF_wm6dAuiCHzrbNe8KenVUuLzxU1A>
    <xmx:OeAMagXj3lb08yGzJuuM_dDsI2OxlOdaf9CQcMPFpGgCPuSAFbg9JA>
    <xmx:OeAMap86ZGPIpSLqPY5Eis0uyNEAEO05aGEWOQhlLWpywMa_ac9g1w>
    <xmx:OeAMakm2GGZdYDJBYIcUd_QGBc_y68SawESqizh1QeBfpvujp58Geehi>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 18:12:08 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com,
	alison.schofield@intel.com
Subject: [PATCH 2/2] cxl/test: Fix __fortify_panic
Date: Tue, 19 May 2026 15:12:04 -0700
Message-ID: <20260519221204.1517773-3-djbw@kernel.org>
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

Fix a runtime assertion in setup_xor_mapping(). Fortify complains that it
is potentially overflowing the xormaps array per __counted_by(nr_maps).
Quiet the false positive by initializing @nr_entries earlier.

 memcpy: detected buffer overflow: 32 byte write of buffer size 0
 WARNING: lib/string_helpers.c:1036 at __fortify_report+0x4d/0xa0, CPU#8: modprobe/2728
 Call Trace:
  __fortify_panic+0xd/0xf
  setup_xor_mapping+0x6c/0xa0 [cxl_translate]

Fixes: 06377c54a133 ("cxl/test: Add cxl_translate module for address translation testing")
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 tools/testing/cxl/test/cxl_translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl_translate.c b/tools/testing/cxl/test/cxl_translate.c
index 16328b2112b2..25a27e01ac21 100644
--- a/tools/testing/cxl/test/cxl_translate.c
+++ b/tools/testing/cxl/test/cxl_translate.c
@@ -236,8 +236,8 @@ static int setup_xor_mapping(void)
 	if (!cximsd)
 		return -ENOMEM;
 
-	memcpy(cximsd->xormaps, xormaps, nr_maps * sizeof(*cximsd->xormaps));
 	cximsd->nr_maps = nr_maps;
+	memcpy(cximsd->xormaps, xormaps, nr_maps * sizeof(*cximsd->xormaps));
 
 	return 0;
 }
-- 
2.53.0

