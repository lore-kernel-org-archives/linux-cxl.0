Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6646E32470E
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 02:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789527291; cv=none; b=lZemLBAXJdvwkbGbt3kNLCZ6HN8NwjtHv4WqfUPioD2jFbf1u/ghVsrDHem2o0dQkrxc+IlhZud1isVtiP2Cc6Dkwzc1p/4ImmU92CzCgRaIMm9VaVgwzcESaP0JAD2lUpz2iyq7ZIuEP68NPbE2UQb9NeJ0DUijLIsY8YEj5o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789527291; c=relaxed/simple;
	bh=o32XbTNmaWhb4S/3nBbCwFEP3M2ST8j3UbGXca+PPi0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMCKb2mnsIC8A/QgEPodoDR2qCVkPFLTknMNa9vUs6Rt1muN/mk0hhYY/+KgFTEmD+Yj1PCBvPY57xHgqG/aLUs1ucNL0z+1ICEKGGEOzuD0aqKb31WsoysNa7WpXAdDq/F02XwIlEZHUuW7KbGkpzjk03/O6HHNQy6t7EYRhNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPJIAqQm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPJIAqQm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8921F000FF;
	Wed, 16 Sep 2026 02:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789527289;
	bh=c2mHanBhFEhMODwSGAnmCdAkH9gL3/SYw7zGHBzQERU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MPJIAqQmEmaNWy2M0E6V7mPKjfqwhah3OIPmQbfJ/WO73jGVdo7GVwr4/uTc+8s5H
	 e7bRUVU8DoTDag9uFsyIRBHAaQSXlrGLaL6bC1wCu5mzIM63NhUnloI0OHe8aZi7L2
	 Pevm/Bv83CY0gkcAtdFqZAcLTMvfhpARpABg+Udd0cv6U0//iMiy5jZCSDsJWO+hPg
	 HSrt2Sfj+i2G7HddT6+MW70/Ne2OMrk75uDS5PeQiIWp8B55ffsLOLH5lGyTXuWe9q
	 VdDfS7W9QKHkDdz092zRuLu+wnnwh1jhMDzLCgjnxmTAzNWXXGOhaSKIZgO7Xa6g2p
	 6R1/mA+vkQIJQ==
Date: Wed, 16 Sep 2026 03:54:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Anisa Su <anisa.su887@gmail.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, mst@redhat.com,
 junjie.cao@intel.com, dave@stgolabs.net, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH] MAINTAINERS: Add Anisa Su as a reviewer for CXL
Message-ID: <20260916035447.1ac74817@jic23-hlaptop>
In-Reply-To: <20260916002143.777233-1-anisa.su@samsung.com>
References: <20260916002143.777233-1-anisa.su@samsung.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 09:21:28 +0900
Anisa Su <anisa.su887@gmail.com> wrote:

> I contributed the FMAPI DCD mailbox command support in hw/cxl and also
> work on the Linux driver side, which is developed and tested against QEMU's
> CXL emulation, so I would like to be Cc'd on incoming CXL changes to help
> with review.
> 
> Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>

Welcome on board Anisa!

Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Having been more or less absent for too long I'm very happy to
go back to having more people sharing the work on this.

Particularly as if things go according to plan we have a bunch
of hardening work and missing feature support to add to get
this to a state where it can be the basis of emulation needed
for passing DCD supplied memory into VMs.

Let me take this opportunity to thank Junjie Cao and Michael
Tsrikin for moving things forward recently.

Jonathan



> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5bf895732c..14412a6b4c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3334,6 +3334,7 @@ F: docs/devel/migration/CPR.rst
>  Compute Express Link
>  M: Jonathan Cameron <jic23@kernel.org>
>  R: Junjie Cao <junjie.cao@intel.com>
> +R: Anisa Su <anisa.su@samsung.com>
>  L: linux-cxl@vger.kernel.org
>  S: Supported
>  F: hw/cxl/
> 
> base-commit: 302c2f2df4d8b2eec81c38ee5d5b04e8e6e40d31

