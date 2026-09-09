Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AE159E35A
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989241; cv=none; b=tz3JKWD1m7wt1xksSmWi8B/KPnAuFj8W9pSSMvSR2/EuB50Lap5hU1tFKV0bN6mvnWz1ZNpGmYn84z+KOyt2FMcv6ER6d/0dszWFUxuVIUn7RoA6Sc+EO3/lIqXHp2h0lCwOSgTkpbrOE5yhPB+ykjqKZZTp1x2PTpOAl5Xcw9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989241; c=relaxed/simple;
	bh=1R3q5zt/VtlV5xb9dPAsfUN80TJBUVjlcjuuKS0sUdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8JVYgdzNzL8aCtcrovIE55SrfzNpwToysl04UxzoQlTufzjKUkxwSg0vgdd/NQDshO7JrMuDT/qycuVnvFSy8ovJfmB9qYKIo1abrXnCP1FxcVppGEPHrUWsAaQvxmAGKZ1KVzjvsknwvZ4jgpQFKU001fTyKuaUdwSOBRmOFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nqic2kkI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nqic2kkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677691F000FF;
	Wed,  9 Sep 2026 21:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788989228;
	bh=sahnuKPaqFsan30sP98ToOHnKC7gT1KgQ9zwZU7Mo5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Nqic2kkIu3tMyOjD6Je7W5lSxjHrrHO49bajSo/zS45fwIEekQc/YjlBCuH4jLHO5
	 5GfxaTyRcTwFs+S9fl7TWSxs9Uw5Mde24pGWxRw72RqLEx9JPJU5qNfWP5YqRTpzTa
	 dkRgDkl7d+BRfqC5RFejcvFqc0XJpcjMlJHOAKQo3oH6d9jTyjk31I66PGPBSxD92/
	 5PLrorsGbjAb939pmngiNb8xRxaAXqUGd03oD88p9DvLzuuloTCQoXn7io5ZD7ZxoY
	 3tH0+W1GAZCYGZpysZJKjZ4dLGntr+u+82WX3qzdi/qRTS275Mr08+aiHVNhxKnKg8
	 Zk4trQprEumGg==
Date: Wed, 9 Sep 2026 22:27:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, alison.schofield@intel.com, icheng@nvidia.com,
 ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v8 03/10] cxl/hdm: Add BI coherency support for endpoint
 decoders
Message-ID: <20260909222703.4387706a@jic23-hlaptop>
In-Reply-To: <20260909170302.1550680-4-dave@stgolabs.net>
References: <20260909170302.1550680-1-dave@stgolabs.net>
	<20260909170302.1550680-4-dave@stgolabs.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 10:02:55 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Cache the HDM decoder's Supported Coherency Models on struct cxl_hdm.
> A later patch has region attach consult it to verify the HDM supports
> the region's coherency type.
> 
> For uncommitted endpoint decoders, init_hdm_decoder() defaults
> target_type from supported_coherency: Type 3 devices default to
> HDM-DB when the HDM is device-coherent-only, HDM-H otherwise.
> 
> Pre-committed decoders with the BI bit set are not supported because
> endpoint and port enumerations are independent -- at decoder
> enumeration cxlds->bi is not yet known, so the topology cannot be
> verified.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
