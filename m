Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.92
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793239925;
	b=ixIO4V2Z+ojej8zm2ndjMQ2L6nISsKqbkwLxUW744rnzTNRVVRblTS9V7BynK4jmhPzp
	 10wMyue+AcgjARQlcrm8ea0ytN9m2yRqGTl/ajN3bQH+xB83XxG8u56mn65paAtm4HNFb
	 jDWFYfmMl05Fglj55nTZfztTu0/IU7DN/H4WtdRRLXBe87X2sbSuirRmdDyFBfGAQZlLs
	 M8GzqKZao1zlzCbUZrcnjnKPukNQstsNI+a8DaUfsPQoX63BMNbFM+cjMX/2BhbPimaSf
	 c+awxdXltDR7gWJJDx1qAM3kmOYsrOqyHbzMh7D5RVeqtnqTyEt1rS0l/a8fRb0+T1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793239925;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=upbKjrmUcLKM7VJXdAken43IHjuQ9dosr7as3F0EJMs=;
	b=COfV6ykIPrj1agUnciBjbeQS4XYOtfVFL4xisESvfedO6fML9L9M+n7btalgOb9elpGn
	 cW4N1w6VvVi6IYGjB4JtWh8+c1Ayh8BFJbR8suEFNHPwvU2nhm0oMugXNIElZq1QLKtnS
	 sKUyHZzNUrgkcG5w3xY1s9uFoDi2KptMDAGIDNzcjqGVLKqijKvJ8ahFkF4qkVp73hLOQ
	 ShadLIb43fZCszPmEYexu5RUuWGB/MlFlvEgUgL97tYvVAji3DThtDHVNPET06oi7qXaw
	 xGq9xfXINk/9Q8AsDX5bbQD/If7fSyNvkL1z0Du1v8gT+EK3tItfYBi83yyT1R4/NGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=CAzps2lC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.92
Received: from sender5-pp-o92.zoho.com (sender5-pp-o92.zoho.com [165.173.182.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E31606A31A
	for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 02:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3E31606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=CAzps2lC
ARC-Seal: i=1; a=rsa-sha256; t=1793239917; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cAT+ezGzmPmaUZmmeh4wBhNKMHJBXWDPwlfG89HvQoQtHl6yRHLjx9A+ZqBuTb4qY8k3B5TMdHPQ1VlPpqi6wp8af5NFDN3ASmen2sZcTpsH3dMnE7K7zmPPATLtZU+TrpthV0wHBInmGdKbnL+3jniNWt7IMLyXQCrZMdsuGwE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793239917; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=upbKjrmUcLKM7VJXdAken43IHjuQ9dosr7as3F0EJMs=; 
	b=LrVUR2tm0LTwDZLUgpDzjALZX2snxoQAgoX6wR6JUxwdqtUtzVxGaFEfvSiRlO8COfFNPiwxKh1bTVQRrH83RW3eHb98PRGqI1rDGXiPL2fRnkhrMtOdc8rFclmq3jL6yMhIPe9OoHoWqC6T8yh7qxbQbqLzF1yQB4n5rAkbpZk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=CAzps2lCPrL5TfuPoFD3BzqlAUZWvB8ij65PtRecKcCCqxlUJilaSRU30ceBTK9kTqpPCXoJzFX6ivYj8V4ijn2AFgzZXIVdjmX9YQ6NVJxNRfIkHeo2yWN+KtalxBB3mKjqhMJ9D3rLMNTUwNxk216HV3LzAf5JRa5xFWn0kCY=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=upbKjrmUcLKM7VJXdAken43IHjuQ9dosr7as3F0EJMs=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793239916273590.5723306792166;
	Wed, 28 Oct 2026 19:11:56 -0700 (PDT)
Message-ID: <5eda91a9-9f44-4b3b-a154-f60227a90bfd@zohomail.com>
Date: Thu, 29 Oct 2026 10:11:52 +0800
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: Account for a firmware-armed Lock On Commit
To: Davidlohr Bueso <dave@stgolabs.net>, dave.jiang@intel.com
Cc: jic23@kernel.org, alison.schofield@intel.com, icheng@nvidia.com,
 linux-cxl@vger.kernel.org
References: <20261028211836.939648-1-dave@stgolabs.net>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20261028211836.939648-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227ccc0c061c5e8a975830a469f0000904387a5a26543dbcf818c57b7450d0c4cdd992a9cbbc80fd1:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/29 05:18, Davidlohr Bueso 写道:
> A corner case (yet valid) where firmware sets the the locked bit
> without committing the decoder. setup_hw_decoder() carries the bit
> through.
>
> A later region teardown then writes a reset the hardware ignores and
> clears CXL_DECODER_F_ENABLE anyway, so the flags claim a decoder is
> free that still decodes: cxl_dpa_free() releases its DPA, and a new
> region committed on it appears to succeed, cxld_await_commit()
> returning as soon as Committed reads 1, while the old mapping stays
> in effect.
>
> Read the control register back after the commit so the decoder is
> treated like one found locked at probe.
>
> Tested on qemu modified to enforce locked semantics, setting the bit
> behind the driver on an uncommitted endpoint decoder, committing and
> deleting a 256M region on it, then creating a 512M one. Before, the
> decoder sysfs reads locked=0, its DPA is freed and the second region
> reports committed while the hardware still decodes the first; after,
> locked=1, the DPA release fails with -EBUSY and the second region
> cannot allocate DPA.

Hi Davidlohr,

My first feeling is that we should read this decoder locked state during 
init_hdm_decoder()(currently, init_hdm_decoder() already does it for 
committed decoders), so that driver and user have change to know the 
locked bit of the decoder has been set at the beginning.

Besides, I am not sure if ndctl can expose decoder locked state for an 
uncommitted decoder, but I think let user know that is neccessary.

Does it make more sense?


Ming

>
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> Found while battle-testing BI locked decoders.
>
>   drivers/cxl/core/hdm.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index fdcef20e01ba..d23076aabb89 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -856,6 +856,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>   	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>   	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>   	int id = cxld->id, rc;
> +	u32 ctrl;
>   
>   	if (cxld->flags & CXL_DECODER_F_ENABLE)
>   		return 0;
> @@ -899,6 +900,14 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>   	port->commit_end++;
>   	cxld->flags |= CXL_DECODER_F_ENABLE;
>   
> +	/*
> +	 * Lock On Commit armed by firmware engages on this commit and
> +	 * makes the decoder read-only, like one found locked at probe.
> +	 */
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> +		cxld->flags |= CXL_DECODER_F_LOCK;
> +
>   	return 0;
>   }
>   
