Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D076741F344
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185570; cv=none; b=bmbCXJmqYj8zLGTnaCApBvgPagpAIOnlWpLLOWc4Ty933hcdmcJW8cPFWlHXgxFuMo6ygmA0ijfaB6J/w7u7dTU2pYV+RopgyQUiX5tOaYK2ZEUjG9XIvOzLz5vPPL4mHCmLpBpurRuMERfScCSCPjDM7CT3FBqy6lE/t7dpwB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185570; c=relaxed/simple;
	bh=9oU8SbOVrsfc/1OxuUbl1NZ63bo12Bpk0Ng7/CZtw7E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r42XXqApup8FBA1ae2EdA7SXtt6Ilu2c8ItXJXd81SPSr9thIwGhALFccdi3/mssGIivrrS7HtHlVYIloSstEiLcsBGfuM4BvWB4M1FYDJOLPA/awA03KKBglX2EHG0/0wt18PTQjAymemkclNMpd5kKheCyEOEjaY4y4ugSWmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCKoecV+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCKoecV+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12881F000FF;
	Wed, 23 Sep 2026 17:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790185566;
	bh=fnebqtGV3Vo1f42njei1T7ki6CI8ofpmcKeGcPIPmDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fCKoecV+Q7kAgnWparCCT67uusHKDJ46XGmpymntsXhIcfbIE0fzdqpOk12YjRSus
	 3cIaylyjmKi+POF0xPYafIsXEbPBkd4Jje/ZQN0+0IRgEAOHKipRjAMBF2E9FpbA39
	 NjskUzgUcWIhzrGKKcKQwEkjK2RO/p47F7SVFWPbLwCW8wOpwsGefowVbEb7of8uPu
	 TpGt0ZhfpQTyvfOEplopmQC53yvrNk/oBvGzpHrC9SfAVsCIyrQg9vGDNbQolUAYzv
	 AIyTNQDSTODgjd8kIeCadz2ok+MG2h14NEFSO2Z2s9b91e3riHwn4YqsSRdvGANk8s
	 4m6O8GvpsUXSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/15] cxl/core, cache: Add Cache ID register probing
 and init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Cheatham" <Benjamin.Cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260923173342.5584-9-Benjamin.Cheatham@amd.com>
References: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
 <20260923173342.5584-9-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 17:46:05 +0000
Message-Id: <20260923174605.F12881F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] build: function redefinition in cache.c when CONFIG_CXL_CACHE=3Dn
--

commit 666bdbfb794604b7884fcb19d8260bded28d941b
Author: Ben Cheatham <Benjamin.Cheatham@amd.com>

cxl/core, cache: Add Cache ID register probing and init

The CXL Cache ID Route Table capability and CXL Cache ID Decoder
capability are optional capabilities required when more than one CXL.cache
device is enabled under a host bridge. This commit probes for these
registers and maps them if found during the cxl_port probe.

> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index f51575abe5af4..33420aaf40db9 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -15,6 +15,7 @@ cxl_core-y +=3D pci.o
>  cxl_core-y +=3D hdm.o
>  cxl_core-y +=3D pmu.o
>  cxl_core-y +=3D cdat.o
> +cxl_core-y +=3D cache.o

[Severity: Low]
Will this cause a build failure when CONFIG_CXL_CACHE is disabled?

Because cache.o is added unconditionally here, drivers/cxl/core/cache.c is
compiled even when CONFIG_CXL_CACHE=3Dn. This causes a function redefinition
error for cxl_port_map_cache_id_rt() and cxl_dport_map_cache_id_dc() since
they are also defined as static inline stubs in drivers/cxl/cxl.h:

#if IS_ENABLED(CONFIG_CXL_CACHE)
int cxl_port_map_cache_id_rt(struct cxl_port *port);
int cxl_dport_map_cache_id_dc(struct cxl_dport *dport);
#else
static inline int cxl_port_map_cache_id_rt(struct cxl_port *port)
{ return -ENXIO; }
static inline int cxl_dport_map_cache_id_dc(struct cxl_dport *dport)
{ return -ENXIO; }
#endif

Should cache.o be added to cxl_core-$(CONFIG_CXL_CACHE) instead of
cxl_core-y?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923173342.5584=
-1-Benjamin.Cheatham@amd.com?part=3D8
