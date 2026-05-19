Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62184369208
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 22:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779228728; cv=none; b=EmBfQj8F7M09dw/bE51Ox8PWsYjnahVOui6CtfgQL01cT0gUwoLQ+lHClCU7AHgNGnD4x3wVt1UIAQxzx/ainqI+9P0ltM9WBtanlOTp4VXF5RpFHJ589/EnfIDJm7TGEp/liCevxM4Lkvrg2ETd3DW8xZDotaTdM+ASnxbT0Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779228728; c=relaxed/simple;
	bh=HQEZdLGjeluo2wO51AZzpw5lelhNMan1fM6MwTw9FUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OfvALxxPokMtWxlr2msVNzv+YFlmG/UyRG8l6uRf/532H18Ztx6Pk7YgZTVD4qY4ExZrGJXOInPQaOQCIdO99KN09gkp8NTiaBE4PQRBeJ7znfsZ6R65+n0Y7VKFF3yezDurqUuXR93OYTjdZEgncQ5ApIV2MCfK3Vi69Mno7nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV/MYhia; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV/MYhia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3291F00894;
	Tue, 19 May 2026 22:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779228726;
	bh=QTfkQhzW3iELm04n2Y9Xi9Gsw+VX2xfnNHuBcBDakz4=;
	h=From:To:Cc:Subject:Date;
	b=FV/MYhiaHuk4V/hxD0d7fQu4HkKVLDWyRKIxC1z7iD2KxCZQDNIJ8IsI9wGvXVqu7
	 P5AHWi0WcJxaogTYXUosJiLbzCYvyy1DXblFn5vHQJ0VL6+Kjmmb15+7ZiH3mHGeVt
	 lP/5wBgevv8pR40cVStY2iYpDkCjE+445ybH6yiBnkB5K8KeWuW96iLTaBKzf8SzId
	 Z7jM7pAIZIsmKbHEzkGb2BhTShdYz+mFBIqk80/iJhKsyYHWXxswqvcKWlQXqfiA9S
	 MNLkZZSwn8I1GlpioFwnpNkmH1HPzToIuVKLUzJfDfErBjNcq9+viY7TTVyS93/FWk
	 EP7xzVnhyFRVw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id F267EF4007C;
	Tue, 19 May 2026 18:12:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 19 May 2026 18:12:05 -0400
X-ME-Sender: <xms:NeAMajt4B-_Gt7j7e_MKH231fIX6gJnJ7nxpMVjHvTgjDNbf0k1f_w>
    <xme:NeAMarfzxd90p2uuT2J7tZ3vtGF9GPGs-agCAeYtxqMJYBOZ6b5BPf1lBzeKmVCli
    vNqnyKY9G7ES-YH-_0xKugil8NsNCtvFNeVtML_DrDPD7mWokOAql8>
X-ME-Received: <xmr:NeAMarw83ezH1re8QQ8RB47WCyDLEcTUkh1NjORESqSzaveomI83U0j42_5vNtofG-ifXP3hKkvVP7Emp8XXpivV_VOQjFJLLaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedvledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeffrghnucghihhllhhirghmshcuoegujhgsfieskhgvrhhnvghlrdho
    rhhgqeenucggtffrrghtthgvrhhnpedtheeufefhuddtiefggfeuueejkefhhfetjedtke
    eggfehvdfgueejhfehgeevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegujhgsfidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthi
    dqudejjedvfedtgeehhedqfeeffeelgedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhr
    ghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepuggrvhgvrdhjihgrnhhgsehinhhtvghlrdgtohhmpdhrtghpth
    htoheprghlihhsohhnrdhstghhohhfihgvlhgusehinhhtvghlrdgtohhmpdhrtghpthht
    ohepughjsgifsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NeAMahHSM31fWzr_XObz3ldd1cNVhcpJr0GOgPqE7-2SJT5f1o3M9w>
    <xmx:NeAMavzsuPDFxOS_oWpNaxVjQkBWv1L_vovT2IKMMwTjoBooVGRD2Q>
    <xmx:NeAMaiudjfJ-G20FYEl_PC0HT-9_kT5HZB5eoPW58kAy2mUFW7iOOQ>
    <xmx:NeAMas2gDzfu_XKAQaagPVkKWTtKejuxcqhT_MNcNeqKDbRIoI0xaw>
    <xmx:NeAMat-LSJoX-WZqnF2AlYkQMMpxDUiWsK8JA-mwowFK6BkZHxI-1Wl0>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 18:12:05 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com,
	alison.schofield@intel.com
Subject: [PATCH 0/2] cxl: fortify string fixups
Date: Tue, 19 May 2026 15:12:02 -0700
Message-ID: <20260519221204.1517773-1-djbw@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems nobody is running cxl_test with CONFIG_FORTIFY_SOURCE=y. A
couple instances of __fortify_panic can be triggered.

Move some counted_by initialization before associated buffer /
object-array access so that it does not falsely assume a buffer overflow
is occurring.

Dan Williams (2):
  cxl/fwctl: Fix __fortify_panic
  cxl/test: Fix __fortify_panic

 drivers/cxl/core/features.c            | 2 +-
 tools/testing/cxl/test/cxl_translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.53.0

