Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9E935E1A9
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jul 2026 02:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783910736; cv=pass; b=Ew6jhCCzGXwSNtIRdfKHwvfi4FUd5uNUAAkLfLBKfq5M+pe3dKchNQyzsDhTVEK17oeQ4mBFM09/RfE58Xpeb59SiED7Gw1XtNiQtwQ4KV2i3AyQ58VeckX48idpEeu8EgzXmJlQYUXtvF4ElvgblLjzlgOJCeXgD0efp/u+klc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783910736; c=relaxed/simple;
	bh=/+UiPZ3D8/RcxWgRiLW7N6uzlEKCFoHZGr40nsUwpxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RAkKQkwHcuGkukbK70oJFti/qv4X760XNEf45N0zRIjYh5cyrtDAeuU9uEx8O3TK+BpTR0dNQy24FkjdhFLNl20WnqpzLlpkjQDYOfuZItykxogZpJtcJllAXoMDkNKHB0WRAAEAukJG517oN1Xg/5x01FGDYsXpbFO4ZMslzcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=O+sY0+p9; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="O+sY0+p9"
ARC-Seal: i=1; a=rsa-sha256; t=1783910727; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jXKGiSf/w5gqgl3gCHEeekkIWwDRxu/ehVaLy4ycF/VHMxORHOIovGc82l7slMdMrpTnOWsPe8kKwLreY2u0qRHKgYnvoGAspQ8cOlKEyEZLwMUzx2ca0t8oHrjWWowZx29R1UdPEDIXIqHLJuWH72VdzOWgC16ZOfxf433CxTw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783910727; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OeVmBxNOp7AW2ooRwnzMoDdvAEwkbd5dUAuZ45GG7cc=; 
	b=GPs0N3vSjpeh+vN0Swu8uHg9fT0u4Q4qskinfAKCA0rHq8Wtrj5bD+StAaaXkQT4hoVzSr9PeWkKjK5yoKgz+E+zBhiefR3l2EA2qmMlAa5IEAgJpABjZijUdTDQh//d719ctmrwUP4LKRtuq0ZzCF9kRp2yQxojY/neSomaWNc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783910727;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=OeVmBxNOp7AW2ooRwnzMoDdvAEwkbd5dUAuZ45GG7cc=;
	b=O+sY0+p9snBR5Ss73HZPQy0H7OY0wVrlumI7pLB7ZQKYBNPTswr9pKws5s9ESED/
	ZvkywRLKgCABHALj1QrrAuhj0ZQ8anZHnTUiVBBc5KlgfKvJJgDxiW1lSGXs9DQbB7G
	uL7schGABVngodo3AI2O1C6O5u3f0e2H0kx7QgPE=
Received: by mx.zohomail.com with SMTPS id 1783910725137498.9366201239218;
	Sun, 12 Jul 2026 19:45:25 -0700 (PDT)
Message-ID: <a0d6ec53-7186-46dd-a3c3-6bd380a23f9b@zohomail.com>
Date: Mon, 13 Jul 2026 10:45:17 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/port: Restart port enumeration when a sibling adds
 the dport first
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Dan Williams <djbw@kernel.org>
References: <20260712012843.1792090-1-alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260712012843.1792090-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: zu08011227f8695467b5b996b9fabeb2a30000d82ef0c9476389d6ea05ae144b3a9dd973404e63bbcd6b93a4:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 7/12/2026 9:28 AM, Alison Schofield wrote:
> Endpoint probes can race while enumerating a shared switch. If a
> sibling probe adds the dport first, the losing probe treats the
> existing dport as an error and fails to enumerate the endpoint.
>
> Treat this race the same as the existing port-created case by
> restarting the port walk, allowing it to find the existing dport
> and continue enumeration.
>
> This race was discovered while testing a cxl_test mixed-granularity
> topology, where twelve endpoints behind shared switches are probed in
> parallel during module load.

Hi Alison,

Per commit log, I think the root cause is probe_dport() called in devm_cxl_create_port() twice, and the second time failed because the dport has been added.

But devm_cxl_create_port() is protected by its parent port's device lock, probe_dport() is called only when a new port is created in devm_cxl_create_port(). If a port can be found, will return -EAGAIN directly in devm_cxl_create_port().

So If probe_dport() was called twice, is it something wrong in find_cxl_port_by_uport()? Or I miss some details?


Ming

> Fixes: 4f06d81e7c6a ("cxl: Defer dport allocation for switch ports")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/port.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1215ee4f4035..65f2d2f1eb00 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1749,8 +1749,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  					     parent_dport, uport_dev,
>  					     dport_dev);
>  		if (IS_ERR(dport)) {
> -			/* Port already exists, restart iteration */
> -			if (PTR_ERR(dport) == -EAGAIN)
> +			/* Port or dport already exists, restart iteration */
> +			if (PTR_ERR(dport) == -EAGAIN || PTR_ERR(dport) == -EBUSY)
>  				return 0;
>  			return PTR_ERR(dport);
>  		}


