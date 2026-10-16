Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B9445EF28
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175417; cv=none; b=fd3izobRH2hCHjF+1yBh6sA6pnsTdvKA/yysusAznYOucB9RwayAhgBBrSA3FG99qRItF48Z95+aRcc7pIix8wbOeb32k8CwfbNRGtHjn73gTPdu1Q3bJwEwSusmpfHAZ2fSLnGcNQ2JfzLtQVcHPsnTeyByfxxdc4koV50jfIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175417; c=relaxed/simple;
	bh=UWJgY9gmskYNSOYXTIxKjBT40JZ83JRFCjCPOjsca0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7RidABxtwr72VWnyyiXhnSDJg/fR93Au/IZNuBpyg/i5O69PeYA/aRf8yB90c2Z83T/dorYagFV12owHXZRAApfjLj2USaIlrVrx1RP0Dh8EDfrTJqLhSyXYmbj7Fd6dcUBHYGuF6whtnHzVPaJBYZoN3hcaqajuTBfMkfKSBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxVZ4EfN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxVZ4EfN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C96C1F000C4;
	Fri, 16 Oct 2026 18:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792175415;
	bh=ipuBl/mlGaSKzvUQjNmaB17hT9RQ3o6KPLyyd3QrAiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HxVZ4EfN+LF7JzGOFA80dvvS642tT8jeosGfxVSDSUq90mGYXGbDDfemkFhhAZ57n
	 t5ctoiqQKKBNsFo8PbP7Th41OsDv7QcJCB4DJDDg+OV2sHEExTlfwtEtpqScSveZpv
	 zF0kA1ikVkiHn4dtpN7XMgzpDxk8j7OZegd8GBsdOUZrZQ/ZIkOxPncJdCj+jmdbBj
	 ik2hU0+3PS3wMS4MdUmVmRzP3FaRy/7kDXSmOPQSyaL5rwhNe0U0GONhegTB7b/gld
	 Tk6nDpgGnI7ShuIzrKlTuy2pmU6Ynq+FM6uB2Aj/0og+XUPOGyvxtfEbVo9076xFa8
	 d4CSbmq1xFhZg==
Date: Fri, 16 Oct 2026 19:30:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 4/7] cxl/region: Factor out
 cxl_port_parent_interleave()
Message-ID: <20261016193008.4f01c97b@jic23-hlaptop>
In-Reply-To: <85eeb8ae3272c57cb5f1a5ea8b4e0b635b71b188.1791860305.git.alison.schofield@intel.com>
References: <cover.1791860305.git.alison.schofield@intel.com>
	<85eeb8ae3272c57cb5f1a5ea8b4e0b635b71b188.1791860305.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 21:26:00 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> cxl_switch_port_setup_targets() derives a decoder's interleave from the
> interleave of the decoder above it. That parent interleave comes from
> either the root decoder or a switch decoder, and each case is open coded
> along with the parent validity checks.
> 
> Move the parent interleave lookup and validation to a new helper,
> cxl_port_parent_interleave().
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
The thing Richard's patch touches moves in here I think - so follow
through on that.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
