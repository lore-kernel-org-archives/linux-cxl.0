Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980821D5174;
	Wed,  8 Apr 2026 02:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775615757; cv=none; b=lRF3J+KNCX5n/7UXhF8qqK8UB1tzfqrm5lRztJ2FWZX9iAPA8oN33ThZU2XZLG6vckqbTjydkON6pnV/mXHGuKa97qXcqVfVUkUEjeEb8DFqnbo+V0z9du5rf6j25VBBT7G3xKIwAWLSzGDZLMg5FJ5exaf8SGsp08IghhDdGx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775615757; c=relaxed/simple;
	bh=x+v/WG2GftoMBlJMi6E/znxkqCjwUXYr5lqBIrrZgxA=;
	h=Date:From:To:Cc:Message-ID:Subject:Mime-Version:Content-Type; b=jKTl2ha6XNSVPm6iGgFIDY73oofWqN4ujGdfTM8WN2k6a4OzIcTyzvwuWpuTpjZyTe0aPxnH0k91jhPU4kq2QoBpCcyyaZD6fYpNOFe4yrldAf5rJ4NDbPGoHiN3LdYlcGFJWOCmFjf8H5IwNMxqqYo+jDsRB5CHf5n+x2zgh7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjzcvJNT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjzcvJNT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D6EC116C6;
	Wed,  8 Apr 2026 02:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775615757;
	bh=x+v/WG2GftoMBlJMi6E/znxkqCjwUXYr5lqBIrrZgxA=;
	h=Date:From:To:Cc:Subject:From;
	b=MjzcvJNTGtX2eAUAX4l1OvT7c6/mxer5VUVKy4XqYDi1n6OhdY6iUMOcMRJUvb8UC
	 U0IFo0atnAaiNcnHd2ddDMoaQHr5PQN4dIXd7OXLMUzakIW/+qDIh3dx5vLXhL4gL6
	 H0fKXUSM/W/2efB56PzSRWVPlQ6Tywx88U0h9iZKsq+Z8S0T4OEoPfk/TRRC9uOL0w
	 1e20Xgb2x52zfuLTT/NCywruEWmGkc9aSkirDECimhPsB1LbesJqfUcznFTvMMVfVd
	 7IzuP6ULCrjV8vRjd0nNunvYIAb4m/EnW3hVEGhyEvveCg1CDCX3UOgyuJ+PcNPy1W
	 dZz+2CNDObw4g==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 327E3F40069;
	Tue,  7 Apr 2026 22:35:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 07 Apr 2026 22:35:56 -0400
X-ME-Sender: <xms:DL_VaSAZZAV53uxjsRoP8ApXqKPTHg7KaBhB7ifUm8g8fwFadW9NrA>
    <xme:DL_VaX_AR3Is1-h9xH8WUeuJcRC38pgF90y0A6m3yM7MpjDZARyngo-u9S3wPZIUJ
    4o2uNUJ3XyzvWXOV7ZIRoTYYLs56H9p8vJ4Izg_7XLDsypywO4IZt-R>
X-ME-Received: <xmr:DL_VaZEjfj4Ec1nGc6wYr8-0FSY_nr59Sbmj-g9KVnDM8g4QhUw4u2vAuTLe_YPrMBG6hOJEjQ11pfQsEQoj6sOtMtHkbSh7dLU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvvdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevkffugggtgfesthejredttddtje
    enucfhrhhomhepffgrnhcuhghilhhlihgrmhhsuceoughjsgifsehkvghrnhgvlhdrohhr
    gheqnecuggftrfgrthhtvghrnheptdfhtefhheekffekueetkeeuteelieffteetieegje
    evueevveefledugfefhfefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegujhgsfidomhgvsh
    hmthhprghuthhhphgvrhhsohhnrghlihhthidqudejjedvfedtgeehhedqfeeffeelgedt
    geejqdgujhgsfieppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlshhfqdhp
    tgeslhhishhtshdrlhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqtgiglhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvg
    hvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DL_VaVNRgpJOjWjXP8hbzVv3ecxHhcj4jkmX_hhlkwFAzGQIjjZfkA>
    <xmx:DL_VaTfFIwx3t5CasfjAMCpUsgvnb2MJXQ08a8_8Zi6o0Kvwehm6ZQ>
    <xmx:DL_VaauMv1Ry1BCjazIFh2eT6bby-rGeKEz16WKt5x9_EdDmbhHhmw>
    <xmx:DL_VaclDqlrxZWas45yv3xXH0aT9QZzYkg-JK7QuPGinkIOshHG8Jg>
    <xmx:DL_VaUzMrWI9WaBAGB14TgJZjrS71Tos5c9nOdNlAxbfV_njFljK-y-o>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 22:35:55 -0400 (EDT)
Date: Tue, 07 Apr 2026 19:35:54 -0700
From: Dan Williams <djbw@kernel.org>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-cxl@vger.kernel.org, 
 linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org
Message-ID: <69d5bf0ab2210_2b3110036@djbw-dev.notmuch>
Subject: [LSF/MM/BPF TOPIC] What's brewing in CXL?
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

For the summit I offered to organize a discussion on what has been
happening in CXL since Plumbers and a summary of the monthly CXL calls
since. The session goal is present top challenges, address concerns /
questions from the room, and perhaps introduce the CXL topics that have
their own session later in the day.

Please do comment, question, ack/nak, or add to the themes below to
highlight interest and help focus on the few topics we can cover in the
limited time.

* CXL vs MM:

  * Much of the angst of "CXL vs MM" has been harnessed by Gregory in
    his Private Memory Nodes proposal [1]. The meta discussion for this
    session would be questions like "how many former device-dax use cases
    can be subsumed by a mechanism like this?". In general, the game here is
    how to properly isolate memory that does not behave like locally
    attached DRAM.

  * The granularity of CXL hotplug vs memory_blocks vs various
    distribution hotplug policies stimulated a proposal to support full
    "region" hotplug [2].
 
* CXL vs Platform Firmware (ACPI/EFI/BIOS):

  * Attempts to use software interleaving to amortize the surprise of
    "memory that does not behave like locally attached DRAM", introduce
    firmware dependencies. The firmware descriptions of the performance need
    to be complete and match a shared understanding of the requirements.
    Surprise, sometimes this does not line up. [3].

  * Firmware, in trying to be helpful to pre-CXL aware OSes, pre-map CXL
    memory (whether public generic expansion or private belonging to an
    accelerator) into the system address map. This causes problems for a
    subsystem that wants to support hot remove and re-assignment of
    host-bridge resources. Lack of a specified protocol and the resulting
    problems it causes for accelerator reset and driver reload, need more
    thought.
 
* CXL vs PCI:

  * While CXL capabilities are enumerated over PCI, to software it is an
    additional optional protocol. The subsystem supports being built as a
    module. This has led to a design for error handling that sees the PCI
    core minimally involved to forward events over kfifo. This arrangement
    is raising ongoing questions for uAPI like PCI reset and vfio_pci
    that expect to be able to manage device with PCI core services alone
    [4].

* CXL vs Tooling / RAS:

  * Error injection, tests, and usability have continued to improve. For
    folks looking to deploy CXL in production what is cxl-cli missing?

  * While CXL Error isolation has a hard time justifying its utility for
    general purpose memory expansion, the accelerator use case at least
    has a reasonable chance to construct a recoverable scenario.

[1]: https://lore.kernel.org/linux-cxl/abwRu1FNqI3dVyqL@gourry-fedora-PF4VCD3F/
[2]: https://lore.kernel.org/linux-cxl/20260321150404.3288786-6-gourry@gourry.net/
[3]: http://lore.kernel.org/20260316051258.246-1-rakie.kim@sk.com
[4]: http://lore.kernel.org/20260401143917.108413-1-mhonap@nvidia.com

"CXL, making MM problems worse since 2021..." -- CXL subsystem tagline
