Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56303E024F
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494060; cv=none; b=gJ65kGzvWKsnUQB9vLQ4XmffthKMOiVyLEsqt6JskdeqX7VBBAESkUFku25+B+drFlzFJXoSiTzYOS3vS+8xwTO5LE/MaMLW+I/KeWQWklm+vwQYVc473/BGj5E/F7hSnVbrshYUpXQGSQxsq4/hDXYHZ6B8Rd4jemE4M7w7x0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494060; c=relaxed/simple;
	bh=aE00pakjWf8tN9pZX6bvXiRrHhvO1bfyEskaE+iRK4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eww3DJkThxIkXNHaUl+Lc/sv/s18TjnDPEGap5aecDVddxLALUEI5sS1rkRl8iLtxr3AxH7l1MVNgyXhG4UJz5sSi9rc/p2FxruEQv0UplIhCYJC6nXhtX0Lw2I5mH3+vTacvBG8VnbFqPTi5vcfuAwl/tkXBEoeuja1rhWkO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXmDMPcP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXmDMPcP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9071F000FF;
	Tue, 15 Sep 2026 17:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789494058;
	bh=BWiGRzKycO1RLpLU0xZUnZv/IK3wipnLxthVoAjJyc8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cXmDMPcPUTLqpONzqxVxsVlbOPgTA7/Ihmb8naMspjtjbaLjkvPehhyDAmW5Ev6Pf
	 13TzEcouUv1MuwU+KaXOYjwaXfjvQUkK5FLeBauG9ovJTWapLKVPI052BXTUpDM1Vz
	 R+h3UTsUKEdRUmQW1v38suH5FSPKS3leL4nPkvUFbATkpMt31pIOw3bxUx3GX8SxPi
	 Jvzc6+AqYYNUXFy7qm59Lp2TkequncjKnHB5BEbA3J50WPIb1LNRopPGlatqOzIUg4
	 QEj5h75WTz7VNJEdD7AEiNxZMBpJZf5vcmktUbFdLYwLWuAS1dpQD2rfje6jmgtWPh
	 JdRp9ebkMpL4A==
Date: Tue, 15 Sep 2026 18:40:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Junjie Cao <junjie.cao@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com,
 jonathan.cameron@oss.qualcomm.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add Junjie Cao as CXL reviewer
Message-ID: <20260915184056.44f30b8e@jic23-hlaptop>
In-Reply-To: <20260908042310.493882-1-junjie.cao@intel.com>
References: <20260908042310.493882-1-junjie.cao@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Sep 2026 12:23:10 +0800
Junjie Cao <junjie.cao@intel.com> wrote:

> I have been reviewing, testing and contributing to hw/cxl for the past
> few months, and would like to be Cc'd on incoming CXL changes to help
> with review.
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>

Apologies for slow reply but for the record.
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Thanks for helping out!

I'm jumping through hoops to get a CXL staging tree up under new employer's
github.

Just waiting on what I think is final step so maybe have that done today.

Jonathan

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7183babd6a..bbabcf8cca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3328,6 +3328,7 @@ F: docs/devel/migration/CPR.rst
>  
>  Compute Express Link
>  M: Jonathan Cameron <jic23@kernel.org>
> +R: Junjie Cao <junjie.cao@intel.com>
>  L: linux-cxl@vger.kernel.org
>  S: Supported
>  F: hw/cxl/

