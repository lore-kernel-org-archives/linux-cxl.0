Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793149791;
	b=caFWyGo4v7X53mwxnogJybQPfV31EVtXm6YGJbQogGIj51haW/ahcMNtl1D1RwEfKn5g
	 Ul6TxuChh5fvzmZ9w95jNNEqxvGNxrk9YFVQre3NzmNn+jtJ3ftTrCDExTxtE2TYTidLx
	 z7Rpcr5aZ1y++aSLnJmtNppHTqXfV08Qa9UdTwukrSzucdqZ77WXXfSUAMUqpQEgYZGYK
	 Euv9k7W9WPgxl1ivTQbz8k0gTgJE4PwthBI3JgIgpu1w6A9++NxjrBxbPt1TvdoQEtLuq
	 SXvePg5Z63265z6BhnCYa2OgkcL+MeYBN6SvzdYLC336bBlK2MbNMyRPQtlBHLvjCoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149791;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=M85UBsLA4R+YZabkZpqbK6f/pRq8oyJfaWdc+EXipXs=;
	b=erNk1gKxxZeh+KUy2Fws/Za2/TWXFO9JVoeh1RBu984Nde6gRL07iMOzli5ivcPXcmh9
	 FRdNEVD4KiLUxXk5QNQpMHm9a2Rwqac/8B9egYdS3xdkadHRluhEu5xebTxfuNIHNo3lb
	 xWHPV3OVLG1T8pp0oolZ4x8OqfbcKJZVFhvadPNf88ou3SooQ26N1O1Da1+2fnm9x6Ze9
	 dxeLJQ4lIlh2G2iC1arKCR88ivnL0FfoE9HBJmNsm4B2Q7plomm86jO/UFl3n/60oPt5L
	 zYh/kFZNDPU4JynVMBx+upFyK6vA8xyVwu0g5wajNFcCQuUk8zx52AvGf5QagGWLB7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iA88Bvx8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4D606A31A
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 01:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iA88Bvx8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8361F01825;
	Wed, 28 Oct 2026 01:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793149791;
	bh=M85UBsLA4R+YZabkZpqbK6f/pRq8oyJfaWdc+EXipXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iA88Bvx8ORnnUk3j9CnqUlUB7BBq6XgNA5oEWk6icwiUfmEZWmF7+8Kl0T3Yudy7j
	 HqnFfVWT0GqJO/e9G0WLneKn7Umm92gR1dHElt6oQaUqOBkmhHs3MAZgrgvuJ8nNdF
	 NQxXEbuCQaB2wVxd5Dnn2IyAIaLD7AiUvengY/Sr5Qj5zsPeliX/j0uZX5zi7d6f3v
	 0wk2X2wofdkfAoK9u/C1OxfsLcXNhuppkk3gawddBK9QsVX7U02R5ucBW8Rpg/+l8F
	 tnJoMJpF7QkBApjY9yiDtoOsVsfhuVtfHdi55aTAFgZ7c6G1NdZE7kpkugbLVSWeoi
	 Tt37VsjHC+XGQ==
Date: Wed, 28 Oct 2026 01:09:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cxl/Documentation: Describe clearing a region
 targetN position
Message-ID: <20261028010943.0d63849f@jic23-hlaptop>
In-Reply-To: <efa1a098550077dc3571796ba0102ddabe1e9b0d.1792989098.git.alison.schofield@intel.com>
References: <920d80735a449f93a1f17a8bca4c25e4b302cb42.1792989098.git.alison.schofield@intel.com>
	<efa1a098550077dc3571796ba0102ddabe1e9b0d.1792989098.git.alison.schofield@intel.com>
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

On Mon, 26 Oct 2026 09:16:50 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> The region targetN ABI documents that writing to an occupied position
> returns EBUSY, but does not describe how to clear the position. Clearing
> a position is supported but undocumented, leaving no documented recovery
> path after writing the wrong endpoint decoder.
> 
> Document how to clear a position by writing an empty string, how clearing a
> position decommits a committed region, and how the region can be committed
> again after all positions are filled. Also clarify that writing the same
> decoder to a position in a partially populated region succeeds without
> changing the region.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

