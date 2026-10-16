Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33A34CF467
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177353; cv=none; b=sQpRUvg6spGzC30rqrVozui91MKlFgT4DEBgMYwcnE1bXyB8pKxOOE53VCo8PdpUViTkR5VO/DzRqCORnmpsBK8dD08YD7fwqSChNx7x1srbLV5fjdehPG/bfLn46bNG25MhSDOdwdzdPSOaAT0D/RAb3B0F+3w7wkPrkouWxvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177353; c=relaxed/simple;
	bh=4skfEkRPbs3flLko5AC203vgD95PUaLjGKMMQ1ikNgg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQQhMZk6eef72NneX++0oNuQITNiNw78rk7064mk5ExUW0E0AzCvPJQoXBmxmSFgdHmLEs/Q6LlPxybSNeOlzWz4cx7SfoBgMqYgLHRLTtijnVFOWVyYBMIa1QiRjJHlu6EmoEJVNx0mGZG2UjRc9G6meokILHNY45yGrTe0E60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkwI78hR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkwI78hR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CF51F000C4;
	Fri, 16 Oct 2026 19:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792177352;
	bh=IHuQ3oKx4PYK2+6xp9gOY680GPVepDQmQX0SqN7PRTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lkwI78hR6woa62EfY5fExZ8yxXK9jo8p8xZ+I8X7poE4pZ32Txbv8x8p0GZqVpo9E
	 DROY2wYFzuKjDHtn6IxG2odOri9oRgQpm2Bc6IAqXB+LM0PJH78L97Zv+hLQjtALaS
	 spIghwBS8GKCLihHFKvIzrIKs+lXgD7BO7JskW2XRABP1oYAZZD0k8p69A8N0QraMB
	 CknlUpFMTyClhIgB/jdhqhHrCT40h0M+QGCxbzI/Qs3L1BlSzoBH7nkWxkIH67EKKv
	 aUYcGt2Uo9QYbxSf4zZvj2/09N7wJM8TlC0cMWa4DjjtWt4JwY6or+fRWVnLMYDPjx
	 bRQAZDUSbaT1Q==
Date: Fri, 16 Oct 2026 20:02:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/4] Documentation/driver-api/cxl: Add a testing page
Message-ID: <20261016200227.2dac18dd@jic23-hlaptop>
In-Reply-To: <as_1dGrwsPYTlZrp@aschofie-mobl2.lan>
References: <cover.1791949910.git.alison.schofield@intel.com>
	<7af9e1341a24928799d88adaa6144c1ca82091f7.1791949910.git.alison.schofield@intel.com>
	<as_1dGrwsPYTlZrp@aschofie-mobl2.lan>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Oct 2026 14:34:44 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Tue, Oct 13, 2026 at 09:17:52PM -0700, Alison Schofield wrote:
> > The CXL documentation does not describe the subsystem's testing
> > infrastructure or provide guidance on choosing between cxl_test
> > and KUnit.
> > 
> > Add a testing page that describes when to use each framework, how
> > to run the tests, and how to add a CXL KUnit test.  
> 
> Gaobin's question about updating the CMD_CMD_RC_TABLE w the new 4.0
> definitions made me realize this doc could use some words around
> maintaining the kunit tests, ie keeping them running.
> 
> see snippet below...
> 
> 
> > +
> > +KUnit
> > +=====
> > +
> > +KUnit tests run self-contained logic in the kernel without any CXL topology.
> > +KUnit is suited to logic that can be exercised with controlled test inputs,
> > +including encode/decode helpers, address translation and interleave calculations,
> > +parsers of device- or firmware-supplied data, and mailbox command handling
> > +through a stub transport.
> > +
> > +To run all of the CXL KUnit tests, from the top of the kernel tree::
> > +
> > +  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/cxl
> > +
> > +This builds a test kernel in .kunit/ using drivers/cxl/.kunitconfig and runs it
> > +under User Mode Linux (UML). The running kernel is not modified, and no
> > +installation is required. The test kernel runs the tests, reports the results,
> > +and exits.
> > +
> > +Add --arch=x86_64 to run the tests under QEMU instead.
> > +
> > +Running during development
> > +--------------------------
> > +
> > +kunit.py builds in .kunit/, but kbuild does not allow an out-of-tree build when
> > +the source tree already contains an in-tree build. If you build the kernel
> > +in-tree, use a separate worktree for KUnit. The worktree contains the committed
> > +sources at the selected revision::
> > +
> > +  git worktree add ../linux-kunit HEAD
> > +  cd ../linux-kunit
> > +  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/cxl
> > +
> > +To run a single suite, name it::
> > +
> > +  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/cxl cxl_core_mbox
> > +
> > +Enable KASAN when testing memory safety error paths. It can detect an out-of-bounds
> > +access even when the resulting value does not cause a test assertion to fail::
> > +
> > +  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/cxl \
> > +      --arch=x86_64 --kconfig_add CONFIG_KASAN=y
> > +  
> 
> Here's what I think (so far) folks need to know about maintenance-
> 
> Maintaining KUnit tests
> =======================
> 
> Use loop bounds and table sizes from the code under test, such as
> ARRAY_SIZE() of a lookup table, so tests adapt as the code evolves.
> Derive expected results from the specification, not the implementation,
> so tests can detect unintended behavior changes.
> 
> When a patch changes behavior covered by a test, update the test in the
> same patch. For example, add newly supported encodings to a valid-value
> table or adjust the expected errno for a new return code.
> 
> A failing test may indicate a regression or a test that needs updating.
> Run the CXL KUnit tests throughout development, not just before posting,
> to catch either case while making changes.
> 

Makes sense to me. With that added
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

