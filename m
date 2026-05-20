Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B963750DC
	for <linux-cxl@vger.kernel.org>; Wed, 20 May 2026 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315540; cv=none; b=S8MW/Tt48cL5VxiC8LzqmikUPI0KfvPyayTDBMwpfqkV1oI8wUCUW2rg4TMwICTDXpn8P8uEGt3bfSsoYw/US7e1NeLfypIndr8rdmMq8E/Z1dbMhrFc5/7GZ5BwJx9U+aDZ3ktqKm3utwI7jDtU08sp9ha96SOyDkFazlKpnKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315540; c=relaxed/simple;
	bh=oJVYG++22l0ZkD2EbUaq5Dd2xhzGpY7sGStvdPODp5M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pnEOl94EaJ4SwkBX1wk+mdAHRXO4G9ytLiyd3prG2BudR7BrFAZUR1RYp6NQED0pBkgfZ3ZPQclf/qs6iDcv1JxxOrQsAfctCWQ/Noljpt60OLFx1IlMdOUyoyevJF8mnmVxLoas1bv/6aCTxBYpgXV2LzAVACTdJMbU4ba3q5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cw5r1y+2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cw5r1y+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FD11F000E9;
	Wed, 20 May 2026 22:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779315539;
	bh=JA3E2ofh0uc68UvENOOKPqLGnS5zMobOtk7eMUlt5gU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Cw5r1y+2BEpzwrUqvnlHJAEFHgqpYq4MVY5Gg/3kFCK6vNP/dxO4ZvQHkmoAZaaSs
	 Xt/x6oQJVPeG+a9SsHErwVcxRYgpwCT7pBruY9cDH3PoY1M3yyGinHCxwG7i5Edja3
	 4DDErrvIgfs8ttSPga22MoxOJTpRfDdCEZqct0QGvspqXYzE5AZvBjEaL8rDxN0AJP
	 TwXxqBF1MQXQbuHadoTvIMBS+JddHto17nNEVM0Ka7Q1liTnRsjFZeag3hi3cT1cPU
	 4F8E7g6WdWBc7fL1gIsMOgi7eeq1p+Hv/0SuiigaaGdAfstsq78RiPjcObhou0BRyp
	 qofpCQEKw0Kqg==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2DCE4F40084;
	Wed, 20 May 2026 18:18:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 20 May 2026 18:18:58 -0400
X-ME-Sender: <xms:UjMOagHvBRrRI4ro8FXnpWdDqvq90UiSAlAcIBHFq3Bh4reQbUTDow>
    <xme:UjMOao7oSzpMvYW-9CqzXsIofYlJnymOxeTBg8gBzeUSGc-sjwGX9eByxhEYv5oWO
    UCj7SgtV3NI7CfUv09PL0r65pdKr-rSgfMPGM5jzPwJvVsn4aNGDg>
X-ME-Received: <xmr:UjMOaucrpW6fv7R4Y7YZK7fRsPNnwW-vBSF3dxNVAgxcD9mp4XFQXC4hKIovPF35JjFWaMDip3P1Dmj7c9iMyHYpsNZk7GPbbuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevkfgjfhfugggtgfesthejredttddtjeenucfhrhhomhepfdffrghnucgh
    ihhllhhirghmshculdhnvhhiughirgdmfdcuoegujhgsfieskhgvrhhnvghlrdhorhhgqe
    enucggtffrrghtthgvrhhnpedvgeehieekteelueffueehfeejjedvjedvveetfefgffev
    hedvuedvffevffdvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegujhgsfidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudej
    jedvfedtgeehhedqfeeffeelgedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfh
    grshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepthgvrhhrhidrsghofihmrghnsegrmhgurdgtohhmpdhrtghpth
    htohepmhgthhgvhhgrsgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvrdhj
    ihgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhmihhtrgdrkhhorhgrlhgrhh
    grlhhlihgthhgrnhhnrggsrghsrghpphgrsegrmhgurdgtohhmpdhrtghpthhtoheprhhr
    ihgthhhtvghrsegrmhgurdgtohhmpdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepughjsgifsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    hhhijhhurdhjohhsvgeshhhurgifvghirdgtohhmpdhrtghpthhtohepshgrthhhhigrnh
    grrhgrhigrnhgrnhdrkhhuphhpuhhsfigrmhihsehlihhnuhigrdhinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:UjMOakm7mY3JO6gCNTs7GGeusOVzAvuSNjEHkgb-reDRSclH3N7Oew>
    <xmx:UjMOaj_lv6DlAv4DAxw6mfA9jZp4QskQ1s82SFrTbZJl7eb6z2CPSw>
    <xmx:UjMOaqFK9Fg18XMLBQSaEg8e8Nocf-c6sGSPOHJiwtXgZJYO3h3hwA>
    <xmx:UjMOanIMQ3KrUzIEQ6VBZfjIwy42kqMxVyj1mfhqpZMyMltzYoObrg>
    <xmx:UjMOaqncOVSoMAKJ4wjBWT9kBCr5KQbC936_sgYlhsoNeidcMoTFJ8V->
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 18:18:57 -0400 (EDT)
Date: Wed, 20 May 2026 15:18:56 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: "Bowman, Terry" <terry.bowman@amd.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Smita Koralahalli <smita.koralahallichannabasappa@amd.com>, 
 Robert Richter <rrichter@amd.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 "Dan Williams (nvidia)" <djbw@kernel.org>, 
 Shiju Jose <shiju.jose@huawei.com>, 
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
 Ben Cheatham <Benjamin.Cheatham@amd.com>, 
 Lukas Wunner <lukas@wunner.de>, 
 "PradeepVineshReddy.Kodamati@amd.com" <PradeepVineshReddy.Kodamati@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <6a0e33507e961_1717cc100f6@djbw-dev.notmuch>
In-Reply-To: <51a77746-5199-44a2-aa2e-d04cdd6084e7@amd.com>
References: <51a77746-5199-44a2-aa2e-d04cdd6084e7@amd.com>
Subject: Re: RFC: CXL: How to handle trace event ABI break from
 CXL_HEADERLOG_SIZE fix?
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Bowman, Terry wrote:
> Hi Mauro and Everyone,
> 
> During development of the CXL protocol series [1], the Sashiko tool 
> identified an issue in the CXL RAS UCE trace logging for Ports and Endpoints. 
> Specifically, the CXL RAS UCE header log size is incorrectly defined in 
> drivers/cxl/cxl.h.
> 
> The UCE header log size is currently defined as 128 u32s (512 bytes),
> whereas it should be 16 u32s (64 bytes) per CXL r4.0 8.2.4.17.7. Correcting 
> this will change the trace format and break the existing ABI contract 
> with rasdaemon.
> 
> How would you recommend proceeding to resolve this?

Split the definitions into one that reads from the register space and
once that passes the parsed log to the trace buffer.

Something like:

u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32];

...zero-fill that and put a comment about how userspace has already
grown a dependency on the buggy size.

In other words, keep the userspace compatibility, but fix the iomem
overflow.
