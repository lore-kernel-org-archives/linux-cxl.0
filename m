Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9523644A4
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562139; cv=pass; b=YORnbD5+E6WuVZ/WKsWVuLbsr+wl2T8Fbe3x2SCwsBMvMST9eCzwXSC9VCmqDGim6b4n2rOs2y7OuzTCQiW99yAzUm4aufrTLWzUYFiBzQ5MZYw6lBxGeLb1mYkiYQT5YwQG8uuoqvPz4G+lKlpjKgc1wI2iwtrHs6AGiwbVQ20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562139; c=relaxed/simple;
	bh=DxRmwu5RmIuj24FLntDF1Q0HuDOjwAgaAKyPiBxutpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYkrENZx+x8W4hc64iHt5GXt+CZltqJRCaA6ZDLixd1ZN971Gafk7bV8H7JP9UQ3Rkjyiw5n1HPr+j8JaiEUnj2gfH+uZIlSZ/4cSVUN38YE4nEn2zPlWvn8hbFeGwUmpIOiwXa450T2iyJif0HZphnewyYeNr74iacGrLzM8ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=BoGGaODd; arc=pass smtp.client-ip=165.173.180.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="BoGGaODd"
ARC-Seal: i=1; a=rsa-sha256; t=1789562128; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bz8wmMy8gbcoZabw85SSQOP96jrW7f1Ijt1FHX+Qh5AFb1ber9MtHtP8PFtdHV2TjMwQpAOCnWwcJmq3jJZeHIPaifQ6ZCvZiGEBUb6CVl5Unl59FUcYt71Ob5TGaHKWmu91LGh7BtkxKiBAhlkrFI+y/Ez/rgVbu+uPnd62Pms=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789562128; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dR6Gj1EOdj2p2PtEbDRGOtKh6e5OI+ee9X0HvlTunZ0=; 
	b=nr0ZdCL5dXilCVxQWfcPNK2wSxJTbmDAxoVrrSdUQEyWBTLLr5M8TYlAWjkCU2t3woZ9EYH5/ruAV5NIrO826F7mfn5dItpObVeonCI7dakcepS0TWWYC1EttxGhWREx1R/lwwFP/6MJsiq06ZNAhaJ+AZqJ0OJxohLIkAGGf8I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789562128;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=dR6Gj1EOdj2p2PtEbDRGOtKh6e5OI+ee9X0HvlTunZ0=;
	b=BoGGaODd95z0UH9nxStDcdT/UFUXs7cAv+PnxwLqsm5cS8tKVnkpHfx1i3LYN3Ru
	N1XP6gH+f/lZ2jptQzSjv/r0yhZpezlXmkWCN7+A8i4jIQRzKihloeodm7dR1s/snnn
	56NyqoQf4TuuwI90SDvxgKFn0RPQffGMz6g85ZUY=
Received: by smtp.zohomail.com with SMTPS id 1789562127810983.7620596622855;
	Wed, 16 Sep 2026 05:35:27 -0700 (PDT)
Message-ID: <3ee67324-a11d-4538-88c9-13d102255bed@zohomail.com>
Date: Wed, 16 Sep 2026 20:35:24 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/core: Skip einj_inject creation when
 devm_add_action_or_reset() fails
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>
Cc: linux-cxl@vger.kernel.org
References: <20260915060138.2007974-1-kanie@linux.alibaba.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260915060138.2007974-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: zu0801122706dd8b87bd40953161ca9e100000a89e3fc25dbee197f777364b466ac53b4a661d2c746982645d:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 9/15/2026 2:01 PM, Guixin Liu wrote:
> cxl_debugfs_create_dport_dir() ignores the devm_add_action_or_reset()
> result and creates the einj_inject file below @dir unconditionally.
>
> When the devres allocation fails, remove_debugfs() has already run
> before devm_add_action_or_reset() returns, i.e. debugfs_remove() has
> released @dir. The subsequent debugfs_create_file() would then use
> that dentry as its parent although its final reference was dropped in
> the removal and its memory is subject to call_rcu() delayed freeing.
>
> Skip the file creation in that case, consistent with how the rest of
> the helper tolerates debugfs failures.
>
> Fixes: 9185b1a3043c ("cxl/core: Fix dport use-after-free via the einj_inject debugfs file")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/port.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8d715739995b..95c0be57ed53 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -837,7 +837,8 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>  
>  	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
>  
> -	devm_add_action_or_reset(dport_to_host(dport), remove_debugfs, dir);
> +	if (devm_add_action_or_reset(dport_to_host(dport), remove_debugfs, dir))
> +		return;
>  
>  	debugfs_create_file("einj_inject", 0200, dir, dport,
>  			    &cxl_einj_inject_fops);


