Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ECB78F4F;
	Sat, 11 Apr 2026 20:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775940722; cv=none; b=niEmBTt1fnpri/AeKxtUAdpzF+aL+JMyBYUt4bHctPQLyqcOe3lyq14nMQVGWEeCwusYdN5+sQO5DuvXPyALfsiO1s9yBpbcyACJ5xa1edKtVlm+aQNeNFIBVK7VS/Kg/jCN9eB8EuIPPGYwhFKfW/2zrG0n4dNUrmZcPpGubuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775940722; c=relaxed/simple;
	bh=mfV1FNvrjdVUzdm+i9nkmb3Qv/azNgVd3U3y7TrWUQM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iUqfrcDUyWlW43tMDnOt/QrLf8vg2NYg3dxZKfpqIF11oG3dzLK+MUQ1+IJ3AXWz7Tvika65SKSNkkRHhoiEo3OJ00Oe8AjRb0IPbiMRH5R7MZ/Xei9dDoHfa0dHPtpN56xtNq9LHgLhjcgPFZ0pRHok2OKrQYBkzD2N80IZKO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY64dye5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY64dye5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E187C2BCAF;
	Sat, 11 Apr 2026 20:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775940722;
	bh=mfV1FNvrjdVUzdm+i9nkmb3Qv/azNgVd3U3y7TrWUQM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ZY64dye5dPD3M3IacT/nYTmEFi6NNeUXdVtel2V/oN5+m+2J8B4rivsKdGM28g2sy
	 iHYmjp0iwhhYxHTRDMPWB5ZHh7996Niif/te6ipMFeRvf/m9fmK+Gf1pFcg0hcRS4m
	 5Dfoi9suYzVvGh8e4wzS3l5XZK0jDPtO9nP7bCXXCKsIYEGbr8FSYu0OJowiDyeX8v
	 M5G9elqNthInZon9wfTBQ29zpTiuqeIPOHFChPoH6/ZMn8mQ9C+8FVEME8JLQDsKMz
	 BpP4VBR85VOtj3NjA/hbJwEd5twMOQF1FT0i8wijweIOxVjOA5pFQrAwWHSF7rsFxq
	 +if2zy3GWpIew==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 34A2EF40071;
	Sat, 11 Apr 2026 16:52:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 11 Apr 2026 16:52:01 -0400
X-ME-Sender: <xms:cbTaafBEZpJTB6yjbtUwqbAQnzuY-MykZcAmyY7j8hxell6JISY5Sw>
    <xme:cbTaaXE3aRfkxE23TnQWiITY366BOk8-GBbQPU-hUvtfqeXEUVQBUGPUuU-E4S2Fh
    2EITMGA5fZyWs2QyenQsSc7nzVzXks2v4bJOr8MVKBc-pZ03d17jTA>
X-ME-Received: <xmr:cbTaaZ23UuCd-V2T2uK46elEuCZv51INdUTqSNsG7Cb3x-t_oavxIjdrYXmHoeUVu9JFkf4fLUPkGipZGTVUP116s_5M4skRiZ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeffeefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtjeertddttdejnecuhfhrohhmpeffrghnucghihhl
    lhhirghmshcuoegujhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elhfeiudfgvdeijedtleeltdduueekffejjedvjefhgeevjeefueejledtleetjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegujhgsfidomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudejjedvfedtgeehhedqfeeffeel
    gedtgeejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgv
    sehlihhnuhigrdgsvggruhhthidprhgtphhtthhopegurghvvgesshhtghholhgrsghsrd
    hnvghtpdhrtghpthhtohepjhhonhgrthhhrghnrdgtrghmvghrohhnsehhuhgrfigvihdr
    tghomhdprhgtphhtthhopegurghvvgdrjhhirghnghesihhnthgvlhdrtghomhdprhgtph
    htthhopegrlhhishhonhdrshgthhhofhhivghlugesihhnthgvlhdrtghomhdprhgtphht
    thhopehvihhshhgrlhdrlhdrvhgvrhhmrgesihhnthgvlhdrtghomhdprhgtphhtthhope
    hirhgrrdifvghinhihsehinhhtvghlrdgtohhmpdhrtghpthhtohepthgvrhhrhidrsgho
    fihmrghnsegrmhgurdgtohhmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cbTaaYMN6mntUGy9XLnVVFXtDzilXvOLGOAQz1MJ3bUjp_SfwQzIeA>
    <xmx:cbTaaZaAKDmoG4Lq7sZWI0RMfuDaSZ1gPdOZSYyWcgD4SPT-suvC0w>
    <xmx:cbTaaWwCeKrCzUE6R5PcL2QYPxc7KWD8i08W6iXPYEov2xpy4GBaJg>
    <xmx:cbTaaYMxxsf9YNGIcFMxyHiQFCFi9hquJZ1boXRDcucQemUZBgKVTg>
    <xmx:cbTaaVdmEMRfOxqgodk44QMtIiyuOnxsSojp7ikXJxR_97AIZUuV4Mo6>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Apr 2026 16:52:00 -0400 (EDT)
Date: Sat, 11 Apr 2026 13:51:59 -0700
From: Dan Williams <djbw@kernel.org>
To: Li Chen <me@linux.beauty>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>, 
 Terry Bowman <terry.bowman@amd.com>, 
 Kees Cook <kees@kernel.org>, 
 linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Message-ID: <69dab46f79b12_fdcb410071@djbw-dev.notmuch>
In-Reply-To: <20260325062051.3777413-1-me@linux.beauty>
References: <20260325062051.3777413-1-me@linux.beauty>
Subject: Re: [PATCH v1] cxl/pmem: Defer nvdimm bridge attachment failures
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Li Chen wrote:
> cxl_acpi is initialized before cxl_pmem registers

Should be fixed since:

be5c5280cf2b cxl: Adjust the startup priority of cxl_pmem to be higher than that of cxl_acpi
