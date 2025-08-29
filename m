Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6271D61BB;
	Fri, 29 Aug 2025 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756506907; cv=none; b=Ns67yRwBhSAw6zhL++mwdg8moA6DE5Ixmxq2qWDW21a5sp4pH/NBBJ5Uvbw1tX+hlej4C/N2gMTtzcOujeHDADyObvuH4FaRTRmaN7n6l7BeWPXQCMHLZq4Qcvi8cv2QZm7vXwI1zWfy46t4pOUXVypDk+Dj877DfngOCIpoHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756506907; c=relaxed/simple;
	bh=psyHVBHH52umKGRyqGiz9/R/Wx8nDG3Lb6AieVV9h70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PSrbC0G73onUoRVY+He4zmZZQcTG7lHhyY9nIGbNRBATnREpklnJhlAOKxtbXqShRzH2vjCB1Fnjv0m5O1tkT/IagopE4tFFgb2Mb0Xok4Gau0MsxIJbFYGB7uV2fNBJNd6YjMhoQ1ws02qitnjeJAiJPpFytpIqjosXdJuIWq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Yrlg3tWg; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Yrlg3tWg"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D761140AF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756506905; bh=j9pdz4fvOvXD/nnfTD03LeIxAJWY+Bl75kULpm1YGrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Yrlg3tWgGl+KR0gvLKPpwxh/ccK70xseariZ3utKekozcfBwJyhS3rBOMTxJP23ir
	 EMxROTR6jAetE6gtkCsaYhqyrB/fzoj5GgUxE8XtdLRMjz/Flaw5kO1GwyGR80pmkL
	 p6yVSUxyBTwDqV9qFOPZPEoAotmDso1RsFWlLiTx5js7McFuKWHfW+kds4t+5bQR2b
	 p0og0yI6Zy73JQ0sbsgW5+XVacq3x6R+tpmfpo5o7uR+Mt33qSImbGkV7VM+M0grkd
	 BH561WzYV19gFCpjoidA/Elib3ZaveH0HOyUV2hJ3CVoTe8Y4Zx6bLMfqbDl+FZBLv
	 dU5mFv0bZeLZA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D761140AF5;
	Fri, 29 Aug 2025 22:35:04 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Moktar SELLAMI <smokthar925@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, Dave Jiang
 <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Gregory Price
 <gourry@gourry.net>, Moktar SELLAMI <smokthar925@gmail.com>, Alok Tiwari
 <alok.a.tiwari@oracle.com>,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] Documentation/driver-api: Fix typo error in cxl
In-Reply-To: <20250819084116.13108-1-smokthar925@gmail.com>
References: <20250819084116.13108-1-smokthar925@gmail.com>
Date: Fri, 29 Aug 2025 16:35:04 -0600
Message-ID: <87iki53gfb.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Moktar SELLAMI <smokthar925@gmail.com> writes:

> Fixed Typo in the driver-api/cxl/devices/devices.rst
>
> functionalty -> functionality
>
> Signed-off-by: Moktar SELLAMI <smokthar925@gmail.com>
> ---
>  Documentation/driver-api/cxl/devices/device-types.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/driver-api/cxl/devices/device-types.rst b/Documentation/driver-api/cxl/devices/device-types.rst
> index 923f5d89bc04..7f69dfa4509b 100644
> --- a/Documentation/driver-api/cxl/devices/device-types.rst
> +++ b/Documentation/driver-api/cxl/devices/device-types.rst
> @@ -22,7 +22,7 @@ The basic interaction protocol, similar to PCIe configuration mechanisms.
>  Typically used for initialization, configuration, and I/O access for anything
>  other than memory (CXL.mem) or cache (CXL.cache) operations.
>  
> -The Linux CXL driver exposes access to .io functionalty via the various sysfs
> +The Linux CXL driver exposes access to .io functionality via the various sysfs
>  interfaces and /dev/cxl/ devices (which exposes direct access to device
>  mailboxes).

This one was fixed a while back, so this patch is not needed.  It is
always a good idea to check linux-next when considering changes of this
type.

Thanks,

jon
