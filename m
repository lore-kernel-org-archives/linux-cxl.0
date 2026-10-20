Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792463622;
	b=4xDiXVyhKUFK+yQiiLcFkHs9AXV9g4yMJ10nHhpoWzEMsBIbzjNDaQ4cBQsDBuKzY5ke
	 K3phxvP6yvRSFarUKNhfu3Gl/wMEGhYsSHoJ36nj96z3g2sCduqKXBfKEJy/0bV2GQToQ
	 IxRQ6ek0WA2oXI3t6Tk5WRg8x2Ax2P3OKT+iOgY8f2j9vJmefl7a6bHAD4edvqVmhR74/
	 6VBpf6lRAq8TLCgMWyhlx7XqvxGbtRRoY0nvDTux8u2X7sK1Qiyk/r6SRghequ7jsgT9L
	 xlbEUUruvs7sIwPCCCRBn2U8HSbdPtD3fik1oRneBrriwNe4H2QV1ZDcohDh+J3kWmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792463622;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=MZkVxH5PoQkw/VeTyTnWuYKCx4Mn7OQYLdwxoiN1HFI=;
	b=KQmz1k6cD579WprPUmFGpDBcRjVTzSp959Ca137oNSb0wIqNXFuPpgjHPpj9UTaemdwe
	 jJD4xBjTFXCM9HK5Q9f7NudQnNjxEH7fARyVdVZNv+AbLyPJwlxRZZfU1V/kkcrczqWYu
	 JdcN+JrfYgS2N2iKBGZpPuIKSgPoM64YAbAcNpa3BHWx4yXt94/ux37Yp63Sic+3wEc64
	 zpevk36t/i8D5vDqHzfT3j9oj9pRM8ptfx/h6GyEhqlt1i43v7DZXn/ZY7GmMXv+ySeIu
	 43J466HXPl3ILCiHvWY5roP1Iq02mZuKIfDeaOj0iT5YqPVlcUSceVwUCnjx30KW3Cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=FbOaSioi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA597606A31A
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 02:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA597606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=FbOaSioi
ARC-Seal: i=1; a=rsa-sha256; t=1792463612; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oCzUVdex1euwnn4yNUMld69jkhAGChFuoaAKBSIbaMdbclQLmuSJakgBpTSOyw2xlwcxXAW+069ig5PVSVMz9Tv8Xunm2brjG4g66RJgZVAk7Fi8Vcqs6M6+7LS/MzuU6IVGQxzUuDhIx+0auWY8RDHIWTZ06q2eIGyCbGwIP7U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792463612; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MZkVxH5PoQkw/VeTyTnWuYKCx4Mn7OQYLdwxoiN1HFI=; 
	b=il4rX4YjAzIuNUwmwS27EuXAdSs5Gi8znA0MfLC4lsp2XquR+qZbR0+TigFcn0KA6G04KHArO3ZgvCjfnmXDgyzoTZdvn7Xn4oi7Op/LDNuXBuBLliYeusPmmzh307KryKyeKZP3n/ODO/xatlzv8hyBzJXTBsRiVplZh446CFM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792463612;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=MZkVxH5PoQkw/VeTyTnWuYKCx4Mn7OQYLdwxoiN1HFI=;
	b=FbOaSioiH1P0vjps/CwTDiEiZvaqBDdjz/5/QNIxtgJq/1aCRTm04Vs52ivDOLPh
	IQUof/m6QU5VJo8GUpVTBkfwIs1PKn3uX8IxebbeUa5krYTplNC69275XmaPRtChkPe
	IYxFKJGjIhvFF4XiaQS9RGEKPHrawsDme511jxzk=
Received: by smtp.zohomail.com with SMTPS id 1792463610752681.4978932634922;
	Mon, 19 Oct 2026 19:33:30 -0700 (PDT)
Message-ID: <7128116f-aa75-42d9-b71a-2999a26a702c@zohomail.com>
Date: Tue, 20 Oct 2026 10:33:27 +0800
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
Subject: Re: [PATCH v4 8/9] cxl/region: Simplify switch port target setup
 control flow
To: Alison Schofield <alison.schofield@intel.com>, dave@stgolabs.net,
 jic23@kernel.org, dave.jiang@intel.com, vishal.l.verma@intel.com,
 iweiny@kernel.org, icheng@nvidia.com
Cc: linux-cxl@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <cover.1792263750.git.alison.schofield@intel.com>
 <4a6a854c35234131279dbcdf1cf8c2cece709200.1792263750.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <4a6a854c35234131279dbcdf1cf8c2cece709200.1792263750.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu0801122773c28454c403e0ad76918fcb0000002237e3d30998711981583c0734795cb57d8f3152c15172ac:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/18 03:28, Alison Schofield 写道:
> cxl_switch_port_setup_targets() searches the decoder's existing targets
> for the endpoint's downstream port. On a match it checks the peer position
> and jumps to an out_target_set label to log the target. Otherwise it jumps
> to an add_target label, skipping the interleave calculation and decoder
> setup that only the first endpoint to reach a port needs.
>
> Return the peer check result directly when the downstream port is already
> a target, and make the first endpoint's decoder setup the else branch of
> the target search. Both labels go away.
>
> Returning directly after peer validation also removes a misleading debug
> message that reported a reused target as a new assignment, with a bad
> index.
>
> Suggested-by: Li Ming <ming.li@zohomail.com>
> Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

> ---
>   drivers/cxl/core/region.c | 34 +++++++++++++++-------------------
>   1 file changed, 15 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 025cf21adfa9..2a64ecf656b7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1635,27 +1635,23 @@ static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
>   	}
>   
>   	if (cxl_rr->nr_targets_set) {
> -		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> -			if (ep->dport == cxlsd->target[i]) {
> -				int distance = cxl_port_peer_distance(port, cxlr);
> +		for (int i = 0; i < cxl_rr->nr_targets_set; i++) {
> +			if (ep->dport != cxlsd->target[i])
> +				continue;
>   
> -				rc = check_last_peer(cxled, ep, cxl_rr,
> -						     distance);
> -				if (rc)
> -					return rc;
> -				goto out_target_set;
> -			}
> -		goto add_target;
> +			return check_last_peer(cxled, ep, cxl_rr,
> +					       cxl_port_peer_distance(port, cxlr));
> +		}
> +	} else {
> +		rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
> +		if (rc)
> +			return rc;
> +
> +		rc = cxl_port_setup_decoder(port, cxlr, cxld, iw, ig);
> +		if (rc)
> +			return rc;
>   	}
>   
> -	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &iw, &ig);
> -	if (rc)
> -		return rc;
> -
> -	rc = cxl_port_setup_decoder(port, cxlr, cxld, iw, ig);
> -	if (rc)
> -		return rc;
> -add_target:
>   	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
>   		dev_dbg(&cxlr->dev,
>   			"%s:%s: targets full trying to add %s:%s at %d\n",
> @@ -1677,7 +1673,7 @@ static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
>   		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
>   	}
>   	cxl_rr->nr_targets_set++;
> -out_target_set:
> +
>   	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
>   		dev_name(port->uport_dev), dev_name(&port->dev),
>   		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dport_dev),
