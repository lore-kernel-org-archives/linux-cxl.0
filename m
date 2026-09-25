Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8C24052D9;
	Fri, 25 Sep 2026 23:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790378313; cv=none; b=mMhCteV/iMrSt7JmGPLYf7lqTx2Whw69vHexe/VZ4ZXIuSatqni1neXyZGDRQE+ruve1nFLP86Pv2I4vTv2LkTYL/Fe+xAsEYReXqJlQ8D3/mRT4cu5WonP+NNOIkdI7G3SRv2EF4zQMCdCwnn398/l39IB8YPYS24347b+76M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790378313; c=relaxed/simple;
	bh=+3/8lX22F8PExynknXLQgXUcUCdEmWnbvVgPswsZ+yE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7pXVuSoP06Ch47+I1K1dtmnbcCVKqB3kK3T6LkCWaR24XsxIIO4iGQ3pKq3IK1trdWLBJiSlwTLcWt9dHtYxvMu0/frT9qd+LqGDlQroDbQO/4VCmq8s1iqU2S5cGf+P51Kkaj2/gFi0QYefQCt42x02wGN/AL8lzgctFAE7qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGafbZ9b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGafbZ9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAC71F000FF;
	Fri, 25 Sep 2026 23:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790378311;
	bh=wownGkDODVsUoCmEkDtdm7U0WfmFdaCjKWMc+dHNJ4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LGafbZ9b9JjmYF4nez8XfoAr1NkeNj0ppu4DGnvgs/h+g+pgThKL+rFMMNo8ciuQL
	 xzLjfwSNC88Qrx2vSro2fKxWdLDg747Llgu99ThJBIf5I1uCEUMzSQr3lghFvxugqK
	 EW/C7AukAbHQx5LXNb2fFt8pgu9NsiGBtPUgTo4Lqzy8fpU5y8+IGj5nXz8OSaRpqY
	 EcNtDh57t2gYVnRpQjlyB9qxple8q4vaAXSA7y4E7qsrALlw0ScBhQV4ldQS8dedDu
	 5mL+EU5sFi9vgn67T09zejvoCGTB05yE/mknpmaHzBPI9EC2PRrdKdSvT2j4oGr1jZ
	 jbyOIUZc2H8cg==
Date: Sat, 26 Sep 2026 00:18:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, iweiny@kernel.org, ming.li@zohomail.com,
 kaihengf@nvidia.com, kobak@nvidia.com, newtonl@nvidia.com,
 kristinc@nvidia.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/4] cxl/region: Don't leak tolerated RAM -EFAULT
 from unmapped poison scan
Message-ID: <20260926001829.4dbd173b@jic23-hlaptop>
In-Reply-To: <20260922101129.52794-3-icheng@nvidia.com>
References: <20260922101129.52794-1-icheng@nvidia.com>
	<20260922101129.52794-3-icheng@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 18:11:27 +0800
Richard Cheng <icheng@nvidia.com> wrote:

> CXL 3.0 section 8.2.9.8.4.1 requires Get Poison List to return Invalid
> Physical Address for a volatile range when the device does not support
> volatile poison lists.
> 
> For example, consider a memdev with a single RAM partition and a
> committed decoder covering only part of it:
> 
>   RAM partition: [ committed decoder ][ unmapped tail ]
> 
> On a device without volatile poison-list support, querying this tail
> returns Invalid Physical Address, which cxl_internal_send_cmd() maps
> to -EFAULT. The driver tolerates this response for RAM because volatile
> poison-list support is optional.
> 
> When cxl_get_poison_unmapped() was converted to iterate over partitions,
> the RAM-specific error handling became a continue without clearing rc.
> If no subsequent query overwrites rc, the function returns the tolerated
> -EFAULT and incorrectly reports the enumeration as failed.
> 
> Clear rc before continuing, restoring the previous handling of this
> expected response for RAM partitions.
> 
> Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
