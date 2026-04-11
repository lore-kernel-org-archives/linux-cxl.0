Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD85F282F00
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935401; cv=none; b=IUquGMngArS1BVXjqSiWAZF1E3l5p+3+hrpwOgBj+l+8AK7eWbh1mMc09aY4UYCKj+nXGiRQGQcopQRvadOPe/YUEc+IW/i+cZnFkOzL1gUM6jMex4LbeRU6D830F3yj+FHDblEKzaGRd8llNgwpbe/bZDqbVEgI0A5hzOohnBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935401; c=relaxed/simple;
	bh=qya5uqpvgIUd7+QRZN3R1QXtOBc6L9zzRRlirnmUS9k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=h1iaSBLQ7lY/qoPobHZ1LZhgg1QwOsQ6+3FzdaVzEkI1dBcmAEMs82eFffnk9xJ+yt5mxdVO8zT97ZK5YRpU3LJ0eco9sM3vQjgpf8ZTxWqyirtjBkyvz1e1Y46SuYjteBb3MSeXhvHacoTv7zCmF/TzcpweoToADke+MddGfnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtLSEtXJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtLSEtXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B6EC4AF09;
	Sat, 11 Apr 2026 19:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775935401;
	bh=qya5uqpvgIUd7+QRZN3R1QXtOBc6L9zzRRlirnmUS9k=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=PtLSEtXJ/ld5QXsFcbdy6DJFkw66bZHmHuUoeuowTcuXrAbriutuOm/muOKNO8oLR
	 tcn3Us9jZhQoK75Xgqb7k3TlIXiG0YdrzJEv4RyRjeqJBHmW6kHz2fnBuEcETFAcoY
	 G/q30qZTA6LhP0SJQiw0LDPmbP8B4PILTO6gVlhSUSd02IIBNbRHJJYSMcc3C9smx5
	 F9kFr2Jjesdadhk6QaQSV9PGQdxOdG/yXAKYJJ/5JJNkJIQSaI2GPh0USH4fkyY3OV
	 JTXNh8vIFwRt30eYZ4vCCllUzB+gb+Ed/fRM6aAYUqe1/EJ9ftceRjO4A7C+xJKUUB
	 fppu+jQ7luEAA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5636AF4006F;
	Sat, 11 Apr 2026 15:23:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 11 Apr 2026 15:23:20 -0400
X-ME-Sender: <xms:qJ_aae8tesTscOfeCYEz-pAv2mOihgDstOT-Ue10bGo2QDUGWL8_XA>
    <xme:qJ_aabaUSBVsNvN8D-VYV7pg8Q0mVqazGl6ehNYtBBSy_jZQXzQxsmvfHrKuIGiMt
    7YPVgiqWlJ3AXOlvL9CkZuQuxdHpF9KrdiAAju-_IVoF500mRB5Y9D1>
X-ME-Received: <xmr:qJ_aaX64OKtv7yi963de_yPiR6LIw9_5KQzwkCkkMajcNWmc4PhPRMhfzZUnseRg9OQzCUtZ-pIUgg_ncs0A5JHwuuwPWPPUGLY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeffedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefkjghfufggtgfgsehtqhertddttdejnecuhfhrohhmpeffrghnucghihhl
    lhhirghmshcuoegujhgsfieskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    dukeelueetjeekgeeiheelvdehleekgeejvdejvdetgfdugffgveefgfejhffhvdenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepughjsgifodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqddujeejvdeftdegheehqdeffeefleegtdegjedqughjsgifpeepkhgvrhhnvg
    hlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepudefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegurghvvgdrjhhirghnghesihhnthgvlhdrtg
    homhdprhgtphhtthhopegurhhivhgvrhdqtghorhgvsehlihhsthhsrdhlihhnuhigrdgu
    vghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqtgiglhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
    dprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhr
    rgdrfigvihhnhiesihhnthgvlhdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qJ_aaQm11dJjnnXj7m-gghZ8SO9FQRQhjVySatnDjjPTcqvYlWr6Bg>
    <xmx:qJ_aaXF4Zz9WinWQjSMZCedesPs7cIiz_l37_7EiiTe33b50Xu_Rzg>
    <xmx:qJ_aaZgV8CtNFL9VHSv7wpe-mKi-ku-w1nzNua4ut8D1jlC6DKhz5g>
    <xmx:qJ_aachJKkDxzGz1xKTCwuXzYiAQJUqcczO4enG6ALMpCGEPojV8bQ>
    <xmx:qJ_aaUlZyWKJ2T5IaCanx80bvZrkaRX8GLLgD-l4eYy_EzUOR1e_OKIL>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Apr 2026 15:23:19 -0400 (EDT)
Date: Sat, 11 Apr 2026 12:23:18 -0700
From: Dan Williams <djbw@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Ira Weiny <ira.weiny@intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 Ben Cheatham <benjamin.cheatham@amd.com>
Message-ID: <69da9fa696d0f_6c31a100e8@djbw-dev.notmuch>
In-Reply-To: <dfc0979a-b01a-4c90-8bc8-7a60fb795dc7@intel.com>
References: <20260314-fix_access_endpoint_without_drv_check-v2-0-4c09edf2e1db@zohomail.com>
 <20260314-fix_access_endpoint_without_drv_check-v2-2-4c09edf2e1db@zohomail.com>
 <c784d84c-e8ac-4c87-abec-3d4e64f074a2@intel.com>
 <d2ed94ec-e5c7-4b6b-9fe8-68f22bd632ad@zohomail.com>
 <dfc0979a-b01a-4c90-8bc8-7a60fb795dc7@intel.com>
Subject: Re: [PATCH v2 2/4] cxl/memdev: Hold memdev lock during memdev poison
 injection/clear
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dave Jiang wrote:
> =

> =

> On 3/18/26 4:59 AM, Li Ming wrote:
> > =

> > =E5=9C=A8 2026/3/17 23:00, Dave Jiang =E5=86=99=E9=81=93:
> >>
> >> On 3/14/26 12:06 AM, Li Ming wrote:
> >>> CXL memdev poison injection/clearing debugfs interfaces are visible=

> >>> before the CXL memdev endpoint initialization, If user accesses the=

> >>> interfaces before cxlmd->endpoint updated, it is possible to access=
 an
> >>> invalid endpoint in cxl_dpa_to_region().
> >>>
> >>> Hold CXL memdev lock at the beginning of the interfaces, this block=
s the
> >>> interfaces until CXL memdev probing completed.
> >>>
> >>> The following patch will check the given endpoint validity in
> >>> cxl_dpa_to_region().
> >>>
> >>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> >>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> >>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> >>> Signed-off-by: Li Ming <ming.li@zohomail.com>
> >> Hi Ming, I dropped this patch with Dan's comments [1] and updated cx=
l/next. Please check and make sure everything looks ok to you. Thanks!
> >>
> >> [1]: https://lore.kernel.org/linux-cxl/69b8b81621e16_452b100e@dwilli=
a2-mobl4.notmuch/
> > =

> > Hi Dave,
> > =

> > I think there is no change needed in this patch, just need a independ=
ent patch for holding memdev lock in cxl_region_debugfs_poison_inject/cle=
ar.
> > =

> > Or you want to review this patch again?
> =

> No. Maybe I misunderstood the comment from Dan. So we should keep this =
patch?

tl;dr: yes, this patch is *now* valid.

As originally structured having patch2 before patch3 added no value.
Going forward I would say do not structure a series such that a new lock
taken in patch N starts being useful in patch N+1.

I assume that is what:

"The following patch will check the given endpoint validity in
cxl_dpa_to_region()."

...is trying to say, but when commits are applied to the tree it is
difficult to see that this commit was from a series.

So do pick this one up, but the changelog needs adjusting. Something
like:

"cxl_dpa_to_region() assumes that it is running a context where it is not=

racing changes to "cxlmd->dev.driver". Acquire the memdev device lock in
the debugfs entry points to preclude debugfs usage racing cxl_mem driver
detach."

With that you can add:

Reviewed-by: Dan Williams <djbw@kernel.org>=
