Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC882485946
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989601; cv=none; b=FmLHnIJs/BoPNfM5yd+CsYsk23tiWMtVDANz9ojF8BIIvM1Z12HLoFdDA54c4NJmge9JITSs/ZeVScPGi87G3ewgRxTueR7zaZo0wPe/S598nBdWohPrYfa2IhtdWdNN3ijNQzf+2/UGVPHTw1jSNxCs9zXMJHVVktO55cFT99s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989601; c=relaxed/simple;
	bh=CPngRwGH2qh+PpW2ebfo6TCYXqS4kZAGQMULmWkl+2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTaWXG/fvITGjuzEpm0NQgaziyABQ587CQaFl9F0Jbs/2wYvzPuFnoCriiaBmoXJvxR2BS3slViHNh85HU3Uy5IemG0WdU0vZ9UcmTpQXEtcXVefAZUlD2eqwliWSF+LFgQRsnDPWX+3H2HV+ef+1Tkg2miOowoqlBi/LSANowI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxATnJGZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxATnJGZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B1E1F000FF;
	Wed,  9 Sep 2026 21:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788989577;
	bh=3XWm8BGPKscNNLEUsqhuD1ABEsU/SqwKDc7CT2xqRfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KxATnJGZ/FDJ/cAwoTlRI6mKPiBeYHxYCWAJOVf7nOpHGszouv7//owtb3z10fEzE
	 9gPRpuY5c58mBJHE7ZBssBVlUYYgJGvdjLjCbbYIiC+CzOaluVpTGOYvc4dZfURw+5
	 2fg1TgU1nacVOk0+Ateq4raMUV2NplWswmDNH0U+e5OOFtiiZz5W71isjYqgob0qFp
	 3dx0KYbZU5QgR8uciYD8jE2+Xt8WEP60a+yCjMt6Re9b0/LbS/I4sW/DgQDSHRfVQc
	 HZRnPRXRvbLhCcQRmqH3WEvVOPQ7J7r6n9+Wg0SdXj6RpP5wRvqy3iJTnfcy4R22TO
	 MIb3LbpC7mE2Q==
Date: Wed, 9 Sep 2026 22:32:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, alison.schofield@intel.com, icheng@nvidia.com,
 ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v8 06/10] cxl/region: Log the coherency model at region
 creation
Message-ID: <20260909223252.738b8922@jic23-hlaptop>
In-Reply-To: <20260909170302.1550680-7-dave@stgolabs.net>
References: <20260909170302.1550680-1-dave@stgolabs.net>
	<20260909170302.1550680-7-dave@stgolabs.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 10:02:58 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Region assembly emits plenty of debug information - resources,
> interleave geometry, target placement - but not the coherency model
> the region operates in.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
