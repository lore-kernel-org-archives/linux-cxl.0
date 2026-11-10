Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.92
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794315109;
	b=TSk4Wk6f0PvShFXXAXzAtiGAkBvBbibaJlfqYqczD+0XU2PXvc2AFzBpAQ+ppYUSt0LE
	 o3iNReuHucXdogY+zkYZYCccJiFQPEJjBP04qUWBKzbZ7MJSnsdhBvTF0K9zSK8Dyk4Y2
	 iEoTpNuCDzYRBNzkz/sn068AiFLZv7ktWBrQUPG5OSym30wzvHjDK3TSI92gyKihMs0Vj
	 4jyxkXCoiH+/Z8sfNxB3ACroEDkyIQj4K78on18+NpvLDmxQeTkNAnGycyHxKpMijuZ1d
	 xNqv9El3QzA1UAEPDdZ5Z8bD1ILtz0SGWNXVCCoOq76ktdDKS1Ko6/k/DttS/dXmyOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315109;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=Qdgu3j4B51v1KXhMEmtG/5AJM2j0PzflodAV6B9ZcAs=;
	b=UvnM/0SHw1Yrv/lKKc9sFwJNevT1SZhmQsyr0CR25bQ2NsWLTZzcbFpHGLKKCGSklPQR
	 rxxSHW0ln8llE/yL8DsWjn1FGXzMYMqSNCwdlcUqXe3kOvesghSeijq0X/gWn+J6pT8qS
	 J13itz4Oo14gPApWKe0gQiq2I+gzXaYvXzIWJGkPQSOfWMFMIW/4F/4Cl1jlZMz60YDXs
	 +Mgv79QgZ7DEtJTsLvLk+Q1htADkeQdezbh4fXBWPxtxg2svj5iN7mrnL8pGunvHDauLq
	 UWq9HtGu80E0MIXk4M7pAwffkQzg7elInA30WSgfsa+Qsm9N4DQ+5K8eF/fZo+HlKFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=QdKGkylK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.92
Received: from sender5-pp-o92.zoho.com (sender5-pp-o92.zoho.com [165.173.182.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A6460A2607
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 12:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45A6460A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=QdKGkylK
ARC-Seal: i=1; a=rsa-sha256; t=1794315093; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S0P1yp3iI7ZQjrMniwuwLN4aNyBXSQOQRf9bhP1PezDg/iqWT8jdKfO8veA1UV/yE/jy1h3uL+bZD1R0XwAEiWICMRMfll5Bflh3cnFHwGqk8vNHDUT/2LTQ36Z4b8oGYWNoqVYHV7xQiIL0npDMZCE4FSozRonUtSfJuFqUlFY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794315093; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Qdgu3j4B51v1KXhMEmtG/5AJM2j0PzflodAV6B9ZcAs=; 
	b=LS3CuVX4go9jeV/zfBT5ttIKk8rNVMwHGdtp2pvmNPLdb6lxGmClrqC4G7xMabjZyTendNugiNRh/fYEKKQeVzbeqnrXSCrfe17X+kdI9o7b5FVih8fY+EfM1WEfpIavjoSbwjJLrx+oHoR3JtN5aNVtuvGYp0TM43SEFqT/C7w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=QdKGkylKDTxWwDzs9q55rJhJc0FsD994iUGOzbw3qHRqlp4+otW/0ullQIltkWfWAzCHTAFLz2xQxpp0qZ0+yc3QRQUkFl8WUQb1r63Z2bHpwN+3oEDBWVUHuaPOTR3RU9tnfrY1o5ZAjc9bUjzTt/JPN1qvk2dSG4m5z7St3e0=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=Qdgu3j4B51v1KXhMEmtG/5AJM2j0PzflodAV6B9ZcAs=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794315092422254.90764286647664;
	Tue, 10 Nov 2026 04:51:32 -0800 (PST)
Message-ID: <2a05a957-4353-4b66-8de0-c2b6769fd516@zohomail.com>
Date: Tue, 10 Nov 2026 20:51:26 +0800
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
Subject: Re: [PATCH v2] cxl/region: Restore a target's position from its slot
 after sorting
To: Davidlohr Bueso <dave@stgolabs.net>, dave.jiang@intel.com
Cc: jic23@kernel.org, alison.schofield@intel.com, icheng@nvidia.com,
 benjamin.cheatham@amd.com, linux-cxl@vger.kernel.org
References: <20261106233711.2654827-1-dave@stgolabs.net>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20261106233711.2654827-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112273173a4e9766150f2773bade8000040b9fe62f280a1b17c80c2f5ab248d3953c5bf6a4f32643ada:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/11/7 07:37, Davidlohr Bueso 写道:
> Region auto-discovery records each arriving endpoint decoder in the
> first free @targets slot and sets cxled->pos to that slot. Once every
> member has arrived, cxl_region_sort_targets() calculates each one's
> interleave position and sorts the array by it. The original version of
> that function then restored cxled->pos from the member's slot in the
> sorted array, so that follow-on code could rely on
> p->targets[cxled->pos] naming the member, failed sort or not.
>
> Commit 0cf36a85c140 ("cxl/region: Use cxl_calc_interleave_pos() for
> auto-discovery") dropped that restore. cxled->pos now keeps whatever
> cxl_calc_interleave_pos() returned, which on failure is a negative
> errno. A member that could not be placed is left in a region it cannot
> be detached from by position: deleting that region runs
> __cxl_decoder_detach(), which finds pos < 0 and triggers:
>
>    cxl region0: expected mem0:decoder3.0 at position -6
>    WARNING: drivers/cxl/core/region.c:2314 at __cxl_decoder_detach+0x483/0x910
>
> A decoder committed by firmware behind a switch whose own decoders
> were not committed for the range is enough to get there
>
> The same stale position is what commit cbda6a2c2bec ("cxl/region: Fix
> out-of-bounds access in cxl_cancel_auto_attach()") had to work around
> by walking the array instead of indexing it.
>
> Restore cxled->pos from the member's slot after the sort.
>
> Fixes: 0cf36a85c140 ("cxl/region: Use cxl_calc_interleave_pos() for auto-discovery")
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Li Ming <ming.li@zohomail.com>

> ---
> Found while battle testing BI changes.
>
> Changes in v2:
>   - fix the hunk header
>
>   drivers/cxl/core/region.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a048bd5c06cb..d344bc4b5aab 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2045,6 +2045,14 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>   	sort(p->targets, p->nr_targets, sizeof(p->targets[0]),
>   	     cmp_interleave_pos, NULL);
>   
> +	/*
> +	 * Restore cxled->pos from its ->targets[] slot so that follow-on
> +	 * code paths can reliably do p->targets[cxled->pos] to
> +	 * self-reference their entry, whether or not the sort succeeded.
> +	 */
> +	for (i = 0; i < p->nr_targets; i++)
> +		p->targets[i]->pos = i;
> +
>   	dev_dbg(&cxlr->dev, "region sort %s\n", rc ? "failed" : "successful");
>   	return rc;
>   }
