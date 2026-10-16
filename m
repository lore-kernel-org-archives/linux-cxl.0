Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469BF4CF468
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177300; cv=none; b=c6bcFSIjMdg+L9sn7MwMn+1VizDf/FkP2ACc3m5EpUJPGWf3St3l75VrRjQ9LWXmVxm9Ko8104lEYqDWGKXIWLPUoPdLTyRc6KW5k1L67/iYuB8SSc5BcxXta6hUi6mOdV1GZTliMuGo8sDuHLspTyJcHQVEV9E6Cy9s94Xwogo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177300; c=relaxed/simple;
	bh=JPCptI+7cKkChYF3Ztk04f8AEh2gDJ0hMrNcvieb2RA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RckEw9rNg/qHOOlYNCxcki6gJPvrmUEsdOgbU0LKSx/WI5vSdKBNSJO7zeTOW3aa2EYyavuq6eenPzXFv+4wk1ZUx/k089ZHb1PFrMeGwWH3jIGpIndzWTkV1BBsROk4psGJysHLEdwJxo5qOd+sNz6NWCAGKJoP5WGjpJrIdEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRGDa4H1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRGDa4H1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C2C1F000C4;
	Fri, 16 Oct 2026 19:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792177298;
	bh=YlHYdkpflqNhz7ahhbha2/gbxphTDXzF6OKYovMJHu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bRGDa4H1surwzV+IMQ4I7tQNF6hdIypDLtjhLMdgbstF9/bO/5RtptbEKf16OBwSB
	 VhVKFunfqumO78D/AtGT7A/cRnSRKnpqQzPBH7OnpIwqBuINc/5KQYu3Dn9sgqQ6YS
	 TxDzgLL4W3fa+kEvBs+GvNpv/FDzUjlV+U0Bg+8qKB1VPZfnvE6Cyj4YbU/l2NciIw
	 7A44vwKmNzDF+Hiv8ZpwG3oPrN5+cb9rf8zl4dbGI2gjiJco6Yj3G/8O7dlzsx/HHD
	 KlNIZL6UE6f2X6++h8s/emUnd+omvzebjfxLFR2wrHIcstSrJFMfMQ2/Hkrf5r9nBA
	 XHOYBWVvcFD+g==
Date: Fri, 16 Oct 2026 20:01:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/4] Documentation/driver-api/cxl: Add a testing page
Message-ID: <20261016200132.421bc751@jic23-hlaptop>
In-Reply-To: <7af9e1341a24928799d88adaa6144c1ca82091f7.1791949910.git.alison.schofield@intel.com>
References: <cover.1791949910.git.alison.schofield@intel.com>
	<7af9e1341a24928799d88adaa6144c1ca82091f7.1791949910.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 21:17:52 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> The CXL documentation does not describe the subsystem's testing
> infrastructure or provide guidance on choosing between cxl_test
> and KUnit.
> 
> Add a testing page that describes when to use each framework, how
> to run the tests, and how to add a CXL KUnit test.
> 
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

> +- If the code under test depends on another configuration option, such as
> +  CONFIG_CXL_REGION, make the test build conditional on that option in tests/Makefile

Because we all love the trivial.  Line is a tiny bit long and I don't think it would
hurt readability much to keep to 80 chars in here.

> +  and enable it in drivers/cxl/.kunitconfig.
> +
> +- Use exported interfaces where possible, importing the CXL symbol namespace as needed.

As above. Few chars long.  Check the rest.

> +
> +When to add a test
> +==================
> +
> +New or modified self-contained logic should be accompanied by KUnit coverage where
> +practical. Extend an existing suite when possible, or introduce a new one for
> +functionality that is not yet covered.
> +
> +Bug fixes should include regression coverage that reproduces the problem without
> +the fix.
> +
> +Changes to topology-dependent behavior should be covered by cxl_test tests in ndctl.
> +KUnit coverage complements, but does not replace, cxl_test.

