Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A983BB130
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 21:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224523; cv=none; b=EAc5GKdG6F+JpYtHAJs+CBE7a/DEl22POw2Gjb/hm1pf3E9z9dmpO5aRLq0BeT/XS7or5IPNQOx234YV1WqB1fZe9+m6Wn72xkq6vlC4wUxBoR/i/tzAtanANcLNbmtSPy0yDfdAzdYh0/KrjUETtDtoL4V+E0M3NTBHi/nsgpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224523; c=relaxed/simple;
	bh=CZDp9y1Wl81H7L3ji4bhQEGmrD+g/yxlxuKv5ZK3VCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uMEDgThiz2Q445a+PnKr8aafs+NgOpHVzm0bmmcssroKv5La3OMojm06k2qYqr2lhWCWvodMZT2QXN15s+G8pS1i7Niq/DBbescCmaGA5UULydCOGBfFDHZ/Hb3XDZ7AvBh0sFB7j1eZ7SYLr2pLdmd5plZeLkoNM0wom5FsTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjLHO2Tv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjLHO2Tv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7470C1F000E9;
	Tue, 19 May 2026 21:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779224521;
	bh=/ONO6gg5HUS50D3uiBgzj8WIyYIV6vzfgTCd1W++JXI=;
	h=From:To:Cc:Subject:Date;
	b=IjLHO2TvLhhBgrUSNNAWQp//7cg/6cY4uTKyGroqG+zd6kAxHF2hk/bedakX9+FuN
	 y/ENQa167bfLuEievibqrJYRq8KW/J8X8ReIJsCM8kmSEFv1kEVMJF6yVNoDqArP8y
	 Gj3SAiGY8s4o6Bdiwb95gW90sXdW3yBR1MDuFRQsC2emfJ5m21HKKcqlaKPnJSQFFI
	 uHhghxD+qTvpare3vpYH+wRzp6y6SrZJFzQus+XZgpf/ZfspNrhd+jc9xE0pS6Hw4M
	 qDOH4XCy8OxVllRdMeOyT8UB1lVZaLM2CkQdgp9i06NjttVR7T+VJxRNoat4s1v067
	 SoopraqHv91Uw==
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id D4940F40075;
	Tue, 19 May 2026 17:02:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 19 May 2026 17:02:00 -0400
X-ME-Sender: <xms:yM8MapfY73mm0wqzjCG-yTqBso_NPvkceZg9J795Ib2m-isx2ZagQA>
    <xme:yM8MapfmuANZ-SvZNQEZbc7k5mw-lMPOKSXtbs9pwsmmq0tu7FuUMOVxwnJBbM64J
    g0NWZ93_2gmz-4xCoopRApLcBrRX1KrmTDomUZhDwGsWVtYuOPs_upH>
X-ME-Received: <xmr:yM8Maky0XSULtIxKE7r_f-fhoRAUjAPkAiPLI6jD00hYfGW1zahFuttb71-D-E5nWlbNFsM6rSZvvMAoHtFetDxxnnwXY-fqojs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedvjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeffrghnucghihhllhhirghmshcuoegujhgsfieskhgvrhhnvghlrdho
    rhhgqeenucggtffrrghtthgvrhhnpefgfedvkeffgfeileejgedvveevfefhteffiedtle
    ehvedtfeeghfdvjeeuheevueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepughjsgifodhmvg
    hsmhhtphgruhhthhhpvghrshhonhgrlhhithihqddujeejvdeftdegheehqdeffeefleeg
    tdegjedqughjsgifpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhu
    gidqtgiglhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvgdrjh
    hirghnghesihhnthgvlhdrtghomhdprhgtphhtthhopegrlhgvjhgrnhgurhhordhluhgt
    vghrohdqphgrlhgruhesrghmugdrtghomhdprhgtphhtthhopehjihgtvdefsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrlhhutggvrhhophesrghmugdrtghomhdprhgtphht
    thhopehirghmsehsuhhnghdqfihoohdrkhhimhdprhgtphhtthhopegujhgsfieskhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:yM8Mao96ocUY-N8JLgz-__mJ3DVSnUJz40bkDmZqNsWVSJg1BCwLNw>
    <xmx:yM8Makh9Zn_yQZHpMWL5N84-5SHvjiNs2hFSLcZ11HcWqHUKla-YQQ>
    <xmx:yM8ManFn35M0TDsv4itX0cKC_V-F5Xk-0iRbO7eNhSO2mDC9_qKFYA>
    <xmx:yM8Mar_sFHuoYzGyZmgGS-GvktHN2Rz4QpMwHVv7EfN5PVr_zTRD7w>
    <xmx:yM8MamxiGaXBP1vrAk8LcEUdIIgDioYkSfCOalTnBi5AWJn72EAH7D3e>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 17:01:59 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com,
	alejandro.lucero-palau@amd.com,
	jic23@kernel.org,
	Alejandro Lucero <alucerop@amd.com>,
	Sungwoo Kim <iam@sung-woo.kim>
Subject: [PATCH 0/5] cxl: Introduce devm_cxl_probe_mem() and fix region deletion
Date: Tue, 19 May 2026 14:01:53 -0700
Message-ID: <20260519210158.1499795-1-djbw@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The devm_cxl_probe_mem() helper creates a memdev and retrieves a mapped
HPA range for the device. At present the retrieved region information is
expected to be established by platform firmware. A future update will
auto-establish a region if one is not already present. This arranges for a
simple CXL topology detach == Accelerator driver detach scheme.

Now, automatic region establishment on behalf of an accelerator driver
also requires automatic region teardown. The existing scheme of
triggering devm_release_action() of a cxl root device to destroy a
region is racy [1].  There is no path to coordinate multiple devres
actions, or conflicting devres actions, without using the
devm_remove_action_nowarn() workaround.

Instead, move final region cleanup responsibility to the root decoder
teardown path (devres action cxld_unregister()). Expand the root decoder
@range_lock, renamed @regions_lock, to coordinate region creation, sysfs
manageability, and deletion. The @regions_lock also prevents regions
from disappearing mid-auto-assembly.

Changes from the initial RFC [2]:
* tested with Dave's type2 cxl_test
* fix region remove by endpoints (Dave, Alejandro)
* fix user triggered region remove (Sungwoo)
* fix lifetime of the @attach ops (Alison, sashiko)
* hide @attach details inside the CXL core

[1]: http://lore.kernel.org/20260427032010.916681-2-iam@sung-woo.kim
[2]: http://lore.kernel.org/20260403210050.1058650-1-dan.j.williams@intel.com

Dan Williams (5):
  cxl/region: Block region delete during region creation
  cxl/region: Resolve region deletion races
  cxl/memdev: Pin parents for entire memdev lifetime
  cxl/memdev: Introduce cxl_class_memdev_type
  cxl/region: Introduce devm_cxl_probe_mem()

 drivers/cxl/core/core.h      |   2 +
 drivers/cxl/cxl.h            |   8 +-
 drivers/cxl/cxlmem.h         |  27 +++--
 include/cxl/cxl.h            |   3 +
 drivers/cxl/core/memdev.c    |  20 +++-
 drivers/cxl/core/port.c      |   7 +-
 drivers/cxl/core/region.c    | 194 ++++++++++++++++++++++++++++++-----
 drivers/cxl/mem.c            |  95 +++++++++++++----
 drivers/cxl/pci.c            |   2 +-
 tools/testing/cxl/test/mem.c |   2 +-
 10 files changed, 297 insertions(+), 63 deletions(-)


base-commit: 5d6919055dec134de3c40167a490f33c74c12581
-- 
2.53.0

