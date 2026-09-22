Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C5D36B07C;
	Tue, 22 Sep 2026 01:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039698; cv=none; b=E1z6wUOQkEtFxbwaXTaMOUCYr4qJQX0AfQMf/dmu93PXhzE8s+emvO91wgGjN8VOHXTrPhlJaXa9O3p+m2FDUFXIm2JuV+Mmww1zUA/6+/2VR0ipan22BVtHBZf4WQ+QPcijbE5EQu5I2aRKDr6Jz45tsTRQHNE07Xf0REAvm8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039698; c=relaxed/simple;
	bh=QmsyhsrZC53GV25P+gxbZ6GrRQChNpT0EbgSKxXxCUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vu8vYTaPYt/74OIPgx43uHDYws664o8McU/R4c4TiGeISVMvIJ5RHNHfHFhMi0VSLO7FefZqM1hI8k1yTpLjuFTSm1EfG4v1Gc9fDFtUTbepG4AhUbETZeu+lqExUrjJOYoREn9/AwKgcT9x8KBXKH45qxPJm6MH/My07BNs7Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iufBKHSZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iufBKHSZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D521F000FF;
	Tue, 22 Sep 2026 01:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790039696;
	bh=Qzy7JZ0LF+2Yc7cFgOUqKNIv0ecUyoz4OAPss4nIxhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iufBKHSZGPNEP1uqviNuuvFmBxwD28wAfdHMoRCRlVDbuwaCUIwJVRwBkE8vb3dYZ
	 2wNNgw0t8mAhFVehPUDuHy50lFjs9hD6/nszXc4USGmokBCapoYrUuS8goq1To2Yo6
	 FUCYrCf1hqH1mkoAaMd4R1JMWSFYFfNYMrNYa1ErmX7GqrY8O7pfGI+8GsOm+muLHX
	 Fi17VtMT2IVm4sBOnAC7m+l+WY/WyeeKTI+1wfZaTVfEYoEZvuO/QAJOTl4SU7K2mY
	 STPWXfzEXcM3Z7LnuIJkSstx1AbnVbo53fsm8b/yuzr3vbarHoq5oYweUsPmzNxNxu
	 iZD3sg1GRuZ7Q==
Date: Tue, 22 Sep 2026 02:14:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, vishal.l.verma@intel.com,
 djbw@kernel.org, danwilliams@nvidia.com, alison.schofield@intel.com,
 iweiny@kernel.org, ming.li@zohomail.com, kaihengf@nvidia.com,
 kobak@nvidia.com, vaslot@nvidia.com, mochs@nvidia.com, newtonl@nvidia.com,
 kristinc@nvidia.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v9 1/3] cxl/region: Simplify poison_by_decoder() error
 handling
Message-ID: <20260922021449.6a94f3e4@jic23-hlaptop>
In-Reply-To: <20260805055524.22311-2-icheng@nvidia.com>
References: <20260805055524.22311-1-icheng@nvidia.com>
	<20260805055524.22311-2-icheng@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 13:55:22 +0800
Richard Cheng <icheng@nvidia.com> wrote:

> "rc" carries both an error code and the loop control
> signal for device_for_each_child(), so returning it bare is misleading,
> the early guards mean "keep walking", not "no error". Zeroing "rc" to
> forgive an -EFAULT on a RAM partition adds to that by discarding what
> the device actually returned.
> 
> Return a literal 0 where the walk should continue, and test the
> forgiven case directly instead of rewriting "rc". Give that test a
> name, poison_efault_forgiven(), so cxl_get_poison_unmapped() and
> poison_by_decoder() spell the same rule the same way. No functional
> change.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


