Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459662;
	b=ygAg9vdquAW3aAyuVR/RrnBZ3Of0BtAlWYMFCBDdkWoPoDqLp2YTUnhMS8sCoAYHXVo5
	 dkmzhkN1VRz+v2NyyVsMvy9kdO4uWkJpCmzzRbjIV882U5KdaRmtVA3I8NnwqdWiUvRZZ
	 EpHb4Mtti3HBq9FYK0D0mpm9d3Zi1SSaxAUvumZqoOC66yryrWieti/2Rg49K06JJBCUz
	 J8MvmN/4KGjgrcnKplRYi5IMSx+O7Kh0tosWNZ2ZzhkbeBMOS7Gj/x9BwiyKiByFA/Ttx
	 IrR4Yn+o54fY0VTNilar0+d041IkSELN5NMswNqUchGWw7gn9zdRd39uoWbtwjPGjoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459662;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GECsNe/JhWxg3zcbBjesmpGh1AOHM+z1AGK5ujtNd1Y=;
	b=OFROMcelYOdRzV6aRleXPchFvdhwsVWpNzqSyPIuC3Sxo5LjlmNsaz/ci6sRQNkysKof
	 V57A0qMvZ+qMU/Ys9eem+VhHbSE8SboEcryMXEg9hgJvswzDgcDx+fsVok8C3C2a8w0Eh
	 CKswjGtDC8/mua6FjHlsJk9xj6EaY6G6Bh3vgnbTlVsmMef79EE7K+tmSyXDBPnH4gyhN
	 fNR5I1+/vSXHEtjpZrkjl/yL/P3eu90JLSUwmUXGCeo6eMW3Ak96ovXZuW9guunn/QlcN
	 Ed0qsWZk+GiXmp/oi79vjQ9K366XXhJ2DxIhQcfmxF5pj3ord/O2hXKS+IVGT36BwTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mC8CUmnX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77EC606A319
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 01:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mC8CUmnX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEE21F000C5;
	Tue, 20 Oct 2026 01:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792459661;
	bh=GECsNe/JhWxg3zcbBjesmpGh1AOHM+z1AGK5ujtNd1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mC8CUmnX6stgQ4oMunPyVvTh65H+VWQxJkn0W0929ko1FuCTNDsiBlrW4/0pD6l6l
	 kFaka+Pe2FiidgDkbJ/cWApwfYoNSpDvWmxd6GjN5XJwjI7KTZVxPb0EAxGiP6RS2s
	 d5B45cyYG5Lxlz7bjWOselRC/eWnQaNsYwhQyIaWixxsffhKJj7EDYw7nCzilJKAZk
	 VrqkwO9zCy0ySPVI34yOJmPOLEDkgJtKpqy51HdqWzBAiz1wLMu1Boavc7W1GiwuTH
	 YauxH2g1cd/rLEnj3hNHGUQstAJBJRFcoU3xfWF/6PMXficB2lSQqu85LMckR4kiQ9
	 yB2VMKIgwAFmw==
Date: Tue, 20 Oct 2026 02:27:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, vishal.l.verma@intel.com,
 iweiny@kernel.org, ming.li@zohomail.com, icheng@nvidia.com,
 linux-cxl@vger.kernel.org, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v4 8/9] cxl/region: Simplify switch port target setup
 control flow
Message-ID: <20261020022733.4392a7c6@jic23-hlaptop>
In-Reply-To: <4a6a854c35234131279dbcdf1cf8c2cece709200.1792263750.git.alison.schofield@intel.com>
References: <cover.1792263750.git.alison.schofield@intel.com>
	<4a6a854c35234131279dbcdf1cf8c2cece709200.1792263750.git.alison.schofield@intel.com>
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

On Sat, 17 Oct 2026 12:28:54 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> cxl_switch_port_setup_targets() searches the decoder's existing targets
> for the endpoint's downstream port. On a match it checks the peer position
> and jumps to an out_target_set label to log the target. Otherwise it jumps
> to an add_target label, skipping the interleave calculation and decoder
> setup that only the first endpoint to reach a port needs.
> 
> Return the peer check result directly when the downstream port is already
> a target, and make the first endpoint's decoder setup the else branch of
> the target search. Both labels go away.
> 
> Returning directly after peer validation also removes a misleading debug
> message that reported a reused target as a new assignment, with a bad
> index.
> 
> Suggested-by: Li Ming <ming.li@zohomail.com>
> Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
