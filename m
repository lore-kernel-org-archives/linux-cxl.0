Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F922257E
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 01:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779155561; cv=none; b=jEeXUAQhlhNzdskYAn1HYgpROu0kr0wTtFZ3EaFJ+7F+TERIqj9AYj3Op9XEIbO8chqykoEUNr1Xj9WoD0b1A+duPmIsUGT7SYvNzm/OBxwLawmeSOlBZ9ev5tiCHvq1HHiW+DkBEQnf629czCjL8rCMJapA4zqTc5XMSjg05u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779155561; c=relaxed/simple;
	bh=0rPrw3ccWuBEQ2kO2cNKbJyKeWEWgW28QZIFqOcIpZM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jNmFkwPnbjtmQBMjRQL5lpn8ETnICcIkDj9tbJlr1Fwj3AqFXU68jpj29M1A0fhfdUUsuu579y4nQisd/u3S/+3QLYsXTnbJWcA9zs1PKt+1Omi/vrm+QF8WaZ4Oa6vbC3DUpRcVr+wfOl59MbNhe7vpZPtGkMVBT72H3+s44XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzw1YKFw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzw1YKFw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AD3C2BCB7;
	Tue, 19 May 2026 01:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779155561;
	bh=0rPrw3ccWuBEQ2kO2cNKbJyKeWEWgW28QZIFqOcIpZM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=hzw1YKFweE6S8kXmR7fs2QYTJcjU/UykA9/A2CyMkXh29bHKoRfRTlQQlhKPVttlv
	 3jLiP16Me/Wv1nZ/o7a5wrEeWh4NlDQPj6yFmGRpIa/9jUfY1IZrFfEGT0v3F/EqOG
	 ZqJ3MhfU83aW5CLzZdqmQQQcS8zzYqTLdLHtV8Ee182UCvpXTMZxox0T3bEOWBEUOt
	 bJJMSoR/Bc4HMwzMv03s9iDIWFdvRd3Av18TOPCT+OZ1Wt07zthY19kGDdL5EQv8HA
	 d3A/pLrcWx0JDWw/mx8nOYqj+6cpiNd7GpABLDm0niiq9NuoUrfc1qIfHNNBc4DuD1
	 PyN9HPTH8/3qw==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id DA138F40089;
	Mon, 18 May 2026 21:52:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 18 May 2026 21:52:39 -0400
X-ME-Sender: <xms:Z8ILaqUNk3K-CWy1m_DflujZjws1LVtBeAzVFAaFrJbc0V3YJugqJg>
    <xme:Z8ILasgu6w2wBUwRWbND3tfbcnY17z4SA5cWVH2QOhxzyD2lFrONFZiJDJmZuf6xc
    pBK0nxCDWErBxY5pVGT-z3whysiXf1u9a4EJxiayJTqpc3QLGUmlo0>
X-ME-Received: <xmr:Z8ILarg6-C7kCI-fCr0Qmuy80SuBXIY91rWu7hfGySt7DpP493PZ_Jz9D9WiOn-EpofavfLoj0lsR-Vgi6Wk0jQFDzBWGGp8YxM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedtgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefkjghfufggtgfgsehtjeertd
    dttdejnecuhfhrohhmpedfffgrnhcuhghilhhlihgrmhhsucdlnhhvihguihgrmddfuceo
    ughjsgifsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepvdegheeikeetle
    euffeuheefjeejvdejvdevteefgfffveehvdeuvdffveffvdehnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepughjsgifodhmvghsmhhtphgruh
    hthhhpvghrshhonhgrlhhithihqddujeejvdeftdegheehqdeffeefleegtdegjedqughj
    sgifpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpth
    htohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvgesshhtghho
    lhgrsghsrdhnvghtpdhrtghpthhtohepuggrvhgvrdhjihgrnhhgsehinhhtvghlrdgtoh
    hmpdhrtghpthhtohepughjsgifsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihgt
    vdefsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnjhgrmhhinhdrtghhvggrth
    hhrghmsegrmhgurdgtohhmpdhrtghpthhtoheprghluhgtvghrohhpsegrmhgurdgtohhm
    pdhrtghpthhtoheprghlihhsohhnrdhstghhohhfihgvlhgusehinhhtvghlrdgtohhmpd
    hrtghpthhtohepihhrrgdrfigvihhnhiesihhnthgvlhdrtghomhdprhgtphhtthhopehg
    ohhurhhrhiesghhouhhrrhihrdhnvght
X-ME-Proxy: <xmx:Z8ILaiFb_E6b46nS1fBw7tU5b1wigR2jLDvCYR0IToPh6rVRJul60g>
    <xmx:Z8ILagC_aAkKonp5wg2P-TBzWQt0hD3Xa0iXpjXzH8W8ai2VVJmhWg>
    <xmx:Z8ILagA2Ias7JRE5nMv6fTSOVHhMckb0IpFG9YIThiXCQ0E5GJKSoA>
    <xmx:Z8ILamPxbRkoDvmfRf6VyckR7GPmAD_DwxlwUsW6aLQ7E87aSwMbAw>
    <xmx:Z8ILasMGasMxHWhvUyQ5YXeLickxEpmCcEN1OYP6DB8R_taespwNucRg>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 21:52:38 -0400 (EDT)
Date: Mon, 18 May 2026 18:52:38 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>, 
 dave.jiang@intel.com, 
 djbw@kernel.org
Cc: jic23@kernel.org, 
 benjamin.cheatham@amd.com, 
 alucerop@amd.com, 
 alison.schofield@intel.com, 
 ira.weiny@intel.com, 
 gourry@gourry.net, 
 dongjoo.seo1@samsung.com, 
 anisa.su@samsung.com, 
 dave@stgolabs.net, 
 linux-cxl@vger.kernel.org
Message-ID: <6a0bc26656f_128d711001f@djbw-dev.notmuch>
In-Reply-To: <20260516022037.1761453-1-dave@stgolabs.net>
References: <20260516022037.1761453-1-dave@stgolabs.net>
Subject: Re: [PATCH v2 0/5] cxl: Support Back-Invalidate
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Davidlohr Bueso wrote:
> Hello,

Hi Davidlohr,

> The idea is for Type 3 memdevs and future Type 2 devices to make use
> of cxlds->bi when committing HDM decoders, such that different device
> coherence models can be differentiated as:
[..]
> o Patch 4 adds ABI (sysfs) for HDM-DB region creation.

I am skeptical about needing new region creation uapi for this. A
question from the example below:

[..]
> Testing has been done with the qemu HDM-DB Type 3 counterpart (now
> merged).
[..]
> 2. On a Type 3 HDM-DB volatile device, create one BI and one regular region.
> ---------------------------------------------------------------------------
[..]
> # echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_bi_region
[..]
> # echo region1 > /sys/bus/cxl/devices/decoder0.0/create_ram_region

...how can a single root decoder support mixed operation?

The root decoder restrictions specify the endpoint decoder requirements.
There is no flexibility to entertain beyond picking the root decoder
resource, right? Linux can avoid all the configuration corner cases by
making the endpoint decoder inherit settings by topology configuration.
