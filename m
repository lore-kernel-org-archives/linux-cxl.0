Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502AA3AF646
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990645; cv=none; b=PQabR0TZVa/+o+kJzekCoXgyOcDJeMn51Kcq32O2s/YBwSLOjEN7DdNZrSadBmV0iVJyQp+DieA3/jLbSSPnVJU57rbxlO9sOdXAQBceKDcvIkEvOOozFkSvGq4DoRcDg41pTMr3XEgzWqFgxeiXir69kDPTDhMO0vRle5ifzIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990645; c=relaxed/simple;
	bh=/gisGpF2PnFGkmmRNfwENMrxYm52IolisdWrXBpERwM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWdNWgsQbK3z9jJLaI0WbEhdIvCtox4PEebM37s84B9wu3BCQ0ajMqYnGYrSvlP4nVGFCJZcbSMAXXl19es/coilCD+gAW3nNFvrg4E9ZJgXMX5tUYR7HjL53BRLITIeRA221qH8viOFrkP4DPilNBLMrRQTa+eLWqKuRjha5uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrEka3FZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrEka3FZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAD51F000FF;
	Wed,  9 Sep 2026 21:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788990640;
	bh=HHeIklYNUUhPK8Bbd0zwNvYYC84L326KSsL8FEPxcE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mrEka3FZT82iiz1wqL185ApPvolDc+XD88NBA8OibG+3aV7U4B2Rhc2rq7zMbuwQ/
	 s/wkbojlmDarbh+v1mn6syzQSR7n0LJ8zpi+qOtJq+/lYtILtohWLuy3hCkaprz5ps
	 JM6HcRgSd7rD6AMAsUuNDdZPhL9hQ1CQH/qJ7Go4sPyBPzBEd3afgxQ53beKjv0+CF
	 LlQ6Cc21FSH9xximGtIiDKTa3CHbOWF135kRTnG1OTa5fGneDIglNRaZr0NVw/wdeN
	 G+GWRnKtg9x/lCrjIUHj8zE6UpuMaMs/RYfe4aGxhfWz5EnX0z9MIZtcSMKnsL9OCY
	 WbijnhrsA5QuA==
Date: Wed, 9 Sep 2026 22:50:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, alison.schofield@intel.com, icheng@nvidia.com,
 ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v8 10/10] cxl/doc: Update maturity map with BI support
Message-ID: <20260909225035.21fd8ce0@jic23-hlaptop>
In-Reply-To: <20260909170302.1550680-11-dave@stgolabs.net>
References: <20260909170302.1550680-1-dave@stgolabs.net>
	<20260909170302.1550680-11-dave@stgolabs.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 10:03:02 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Add the respective Back-Invalidate info to the maturity map document.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
