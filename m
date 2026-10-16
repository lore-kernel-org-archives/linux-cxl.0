Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D98237F315
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792180903; cv=none; b=KABqrYjkr11o+1GR4DBIc0KaQkxOQjIQuQqEjDBvEe0SBP6Q2xZJcxY1jvNdgGqK0Ic6NlyUX9fbnFRfdypkLpdz4PEwvplvhUS+SAuGmRm/pH2nTznMze2Qoq81Oxzg7VLKLij2V1eVkw25YXSdRuYzuS4Qc5POEHx45wfEifs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792180903; c=relaxed/simple;
	bh=gsjghLTdfLX9utjt46Q/ov9Dz+EG9gZFDfmvO7JfYQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpS/tC0cwRtLR/2dS0ZMAicTO8lfyQnUKoJSA8RMT6AG8QEXFWwdMyizhQOoxEcSpUMPnUM+mYH07XNr8gpTXePgu8cHfthPxxfk9eSOfa+U/y39dkU3WeF6QOlDPtn12a9Qs1xbiJJ3bvJhEYCFK3NAr7Bk7BTySyXQolLMUyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lntB8rix; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lntB8rix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56FB1F000C4;
	Fri, 16 Oct 2026 20:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792180902;
	bh=o4BIRu8utbRUwCD8rw4sYYZQAWvheQpCWmCGbnvLzRw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lntB8rixNV0F014Tsa583P3t4pkii8eLR1Zn5EbaLedh/P6tkM01b0ArEGEQwNN1t
	 fe/pyDaq2tGel/ZcHV/PqTWtKXLsH3E+gib9Vr0CgOIQO09+9IC+ggCPwL241Fi1/n
	 Lrgvoo/9Uh8D/5joJl5wSUCAHA9Uqkj8OA9hYP/RnvrqUNBlc2Maj+EwD4wJkae1x4
	 F2+QF2lsYKBhimphu7oKR6oWyxdcgAW6sj5Anae0ap1NpSDfzzx2JK4CRnszAkpG7X
	 F8xcppNXOm6UF4ocfrL4wJQUUJjdD3hXpXVn0R7cyFr6WgagQA1nOO4j0zecXwnwCW
	 YbhoiuCNDVfdw==
Date: Fri, 16 Oct 2026 21:01:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/4] cxl: Add KUnit tests for HDM decoder encoding
 helpers
Message-ID: <20261016210137.64db4a14@jic23-hlaptop>
In-Reply-To: <73af16d29561eec944e128af116783e20b990dae.1791949910.git.alison.schofield@intel.com>
References: <cover.1791949910.git.alison.schofield@intel.com>
	<73af16d29561eec944e128af116783e20b990dae.1791949910.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 21:17:53 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> The CXL subsystem has no KUnit infrastructure for testing self-contained
> logic.
> 
> Introduce CONFIG_CXL_KUNIT_TEST and drivers/cxl/.kunitconfig, along with
> an initial suite for the HDM decoder interleave encoding helpers. The
> suite checks valid and invalid encodings and round-trip conversions.
> 
> Use a single Kconfig option for all CXL KUnit suites, with each suite
> built as a separate module. This allows new suites to be added without
> requiring additional configuration options.
> 
> The HDM decoder helpers provide a starting point for establishing the
> location, naming, and configuration conventions for future CXL KUnit tests.
> 
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Just one thing inline for the only case where the test is exhaustive.
Either way on that
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> diff --git a/drivers/cxl/tests/hdm_encoding_kunit.c b/drivers/cxl/tests/hdm_encoding_kunit.c
> new file mode 100644
> index 000000000000..54a7cb078a06
> --- /dev/null
> +++ b/drivers/cxl/tests/hdm_encoding_kunit.c

> +
> +/* Decoder Count field of the CXL HDM Decoder Capability Register */
> +static void hdm_decoder_count(struct kunit *test)
> +{
> +	static const int expect[16] = {
> +		1, 2, 4, 6, 8, 10, 12, 14, 16, 20, 24, 28, 32,
> +		-ENXIO, -ENXIO, -ENXIO,

Can we make the mapping of bit to value more explicit?
		[0x0] = 1,
		[0x1] = 2, [0x2] = 4, [0x3] = 6, [0x4] = 8,
		[0x5] = 10, [0x6] = 12, [0x7] = 14, [0x8] = 16,
		[0x9] = 20, [0xA] = 24, [0xB] = 28, [0xC] = 32,
		-ENXIO, -ENXIO, -ENXIO,
//hex is to match spec that just lists these one by one by hex value.
> +	};
> +
> +	for (u32 val = 0; val < ARRAY_SIZE(expect); val++) {
> +		u32 cap = FIELD_PREP(CXL_HDM_DECODER_COUNT_MASK, val);
> +
> +		KUNIT_EXPECT_EQ_MSG(test, cxl_hdm_decoder_count(cap),
> +				    expect[val], "count field=%u", val);
> +	}
> +
> +	/* Bits outside the count field are ignored */
> +	KUNIT_EXPECT_EQ(test,
> +			cxl_hdm_decoder_count((u32)~CXL_HDM_DECODER_COUNT_MASK),
> +			1);
> +}


