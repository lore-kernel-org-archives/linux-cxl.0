Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F0D1EB1AA
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792190267; cv=none; b=Yb29sMHziIPoTd0A3QtUioMUxLLL4w1qzineLNpVFnm/nMiRrcfbMKEqC4IHnDOM0vewBhBwuEwloX/17jl1ig26mJLk8+d+I5UBUO2mdlZNyPGfl3Rch4m3ahXB9ssUlMQpOE6hhduo9+aLRyvlrCdNNjwlecBEMh+We3yz7+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792190267; c=relaxed/simple;
	bh=qQMmiIH4VmdKSm//z99ZgNl0pBLYYDS7rPdpu5vj+OM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=im2pvc+vt77t58SBP1ibjrzt4yW/vfVpyiPl9cx4cux81SkxlDClWhqUo3NKPMR+HbfLVDtxjLwHwDOhI8m6+3lhFmp5jOUQa9FUYTw0+OBGxUgk09hjkpqeNXHNPiaJTAE/RSUffserwxH3ksXRhmLz8WdqFA2s+wQ+oocredc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W78Uzt0Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W78Uzt0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA741F000C4;
	Fri, 16 Oct 2026 22:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792190266;
	bh=Z5xdCuM3eNL/g/vbxTan5KEpsbq4JXepoLB8ReMQ22Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=W78Uzt0YXPpJoGD8xh1De7p0YF8WLTSVvH1U8TrdZJxbHh8ySUKznbg6HZ1hA2RSp
	 Zx93OCvcIGsBLCJItTUYkGcCtQOnd6LNGrA2mchf93b6dMD4tRXINg6MPuTa6KPfgm
	 Vbl4aVhilRyNj4wfeilRb5QJVzCmQZqQw6YRAQm5CTnCUBxNEsoa52VAzafNx8guIA
	 1hu9OsKf7VUfbcwlhCKKq4vLRHOeF6x7Y1bCqPkk06vhsJl9+ryML5VLLWxJl9wjL1
	 gru2JE1eyhXJ2yeIfe/f5UTtRdcO4G1X7cj3S5E0b/CZqtyNtzbs180Fq3zpj27P0Y
	 rU1uBSm7tIq8A==
Date: Fri, 16 Oct 2026 23:37:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Richard Cheng
 <icheng@nvidia.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 3/3] tools/testing/cxl: Add CFMWS windows for region
 selection tests
Message-ID: <20261016233740.02d7af65@jic23-hlaptop>
In-Reply-To: <af1c9e18-4563-4c3a-abcd-219ec57da7f4@intel.com>
References: <cover.1791582353.git.alison.schofield@intel.com>
	<74ce1a0d09b6bab2f93d905a49dca681ac3b4648.1791582353.git.alison.schofield@intel.com>
	<af1c9e18-4563-4c3a-abcd-219ec57da7f4@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Oct 2026 16:03:25 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 10/9/26 3:11 PM, Alison Schofield wrote:
> > Region selection needs topologies where multiple root decoders can
> > satisfy a request and where a decoder supports both RAM and PMEM. The
> > mock topology provides neither.
> > 
> > Add two x1 windows, one PMEM only and one supporting both RAM and PMEM,
> > while preserving the existing modulo decoder identities.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>  
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


