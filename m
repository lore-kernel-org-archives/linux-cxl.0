Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794880461;
	b=bG5fp2adNBvclX5v8RMs5jIZKjuaxWhCyQcDn3Kkxkhtt0dDWdxgmIUxIJbjJrJwsvor
	 2oTKkDh8OZPnXDUscSd+L/5LXkMMSe78kwpbWKZ5WPLnNvt0f1AqeizRfG7kdX1fj4Bvl
	 FCV0zUgx+Qm0XmQK2TCr3xmRZkSh0sa0uQVwb1QI3uOepA2/8PbiLYHyIsyo4qtwSQKLm
	 0/2Ay8hUIxgORtzGLh4GYAUIqP4Y1upo5kFMnAX7wENj8SpeTciEgbNnERZ8K9gJxIjvl
	 rzoF4e1traCvLP/yCOfdQ5AIr6Fan5KYn4OJDWhsIAgx7zFTSpiVpnIUctc22T/FR7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794880461;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YP9hmHr4UROfwM30mGTQEiI0eCaDdcyOYl2V4M8vCzQ=;
	b=waGhIwKeRQ5gJTL3aaRbxZkQhgXZM+Px0q13eIeF55DTwphlIG2MfVbij2lsXIA2lYGM
	 riDilmgfeG5of44i4YZXCT0FvfQTNrqgl1ZCurWrnkZ0RLvShRWp272ylY17mnUwaJyhf
	 BvxVZ5Nq7RK+O1BfHZxwtyoIfiaYVKiM78tMfI6DYEHl/YtpyWbr8jc6D/Vs74Lahhi7j
	 rOh32S4VJWVxwwWc8JfqhL1DP+IRfmJAXOe87d1ZXWwRaoYl2w3MM3De9DOIqWZbtX4bZ
	 XL0HML5Puc6mMCtGTxM7Z7qiXmmeQy34gG+JEgPLF8q2nyzy+EcZ6anJABkLEVCmVYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CukadoL5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD8A606A323
	for <linux-cxl@vger.kernel.org>; Tue, 17 Nov 2026 01:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CukadoL5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9EE1F000C5;
	Tue, 17 Nov 2026 01:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794880461;
	bh=YP9hmHr4UROfwM30mGTQEiI0eCaDdcyOYl2V4M8vCzQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CukadoL5E74Q42rajxrLQ6IQ+MZm/KrSPeS/6FLU8+Sx7dWDqUr/rxilYSOxVHIMN
	 a9kcbeTIjXhRcTDC2r+E3lm5RuW/vhGM1LVDoUOA/UpHwHN7//RzN5Bsejc75eVL2L
	 wOrPmxgSW4An3fAi3MWk4DO/rMm0aWeq2A/GoZbfrE69MWWWjRVtBKf2qaELM2tarn
	 7jTHPYRzNPkW0vPuZCUOHsWhT79MI1Ut7AkO8cQEulqkCM4oqv3e7gOEn7cNnjgsVt
	 +kiWIUy90SpKMD96Y1bFJUlodXMcS9yZOT/EEosMz5tYeL3NB+5jAQ4y0TTnSgSdlX
	 k/SxEzBWprNGA==
Date: Tue, 17 Nov 2026 01:54:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>, Ben
 Cheatham <benjamin.cheatham@amd.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/3] cxl/test: Add a 2-way 16K root decoder for
 passthrough testing
Message-ID: <20261117015412.40d895b4@jic23-hlaptop>
In-Reply-To: <13bdd65ad28c8e7f834fa01f7df1b0134416ab3f.1794010889.git.alison.schofield@intel.com>
References: <cover.1794010889.git.alison.schofield@intel.com>
	<13bdd65ad28c8e7f834fa01f7df1b0134416ab3f.1794010889.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Nov 2026 16:35:01 -0800
Alison Schofield <alison.schofield@intel.com> wrote:

> Add a 2-way root decoder at the maximum hardware granularity of 16K.
> Selecting one endpoint under each host bridge makes the intermediate
> decoders passthrough, allowing a unit test to check that they carry the
> 16K interleave without exceeding the hardware granularity limit.
> 
> Place the window in the XOR topology set to leave the default modulo
> topology unchanged.
> 
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
