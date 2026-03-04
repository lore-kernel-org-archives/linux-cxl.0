Received: from cornsilk.ash.relay.mailchannels.net (cornsilk.ash.relay.mailchannels.net [23.83.222.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B6A37880D
	for <linux-cxl@vger.kernel.org>; Wed,  4 Mar 2026 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772664627; cv=pass; b=YfQ0EojW/RYHc6fiygGyhwkSeIbRjBy8GJBhc8m8ZJMR555xO04FUoPvL/s1eg3zoC3P7aXojLCEwsIOS+GSo1JoRky7mjWE30y8t3oRzd8OyHS+Nm2ccKFmDCNhJFxxt8T6MvFPisQyDA6xmQnxZRiyVZxfdFjnl7uci5Kl1Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772664627; c=relaxed/simple;
	bh=ciBchx0QtMqj1D+B98EW1mot3L68QcEhumIMfp9bNoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARh90BaZ3KZCTLCvMDxA0kk6xz9WJ4+tGSDMW+Dq8Kem/CCOAkIgLodK2YIG5kMYCry+wPcjcCEOuBNpFQ1DR3gjV0d0sDDC84wPs56Rg1SPtitUB0GROwT/5mSsrEvtmR+CYv+khVhKQsaEqQXDRg5YvE9rCLb72HYmTZ7x1+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=OwwO/koH; arc=pass smtp.client-ip=23.83.222.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="OwwO/koH"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D6D95783D50;
	Wed, 04 Mar 2026 17:14:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (trex-green-5.trex.outbound.svc.cluster.local [100.106.44.163])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3374B783B2C;
	Wed, 04 Mar 2026 17:14:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1772644487;
	b=nlFo0VV8ZgwdPXrNe+hu8AilDsh/MydwwlJsHGsTOD9fBQxzTWNjFAYGnQ2DL1xY8C8b/5
	NwJmTWfos9CEVEQsiLVtrFE+vBQUsIvePICU02Tc/ZA8oZf9GhEflQcHxYh4zYCXOI4Lhy
	M6LJ74PHaaegUxwcVS3IKa6gCaePEpL8YP95dJLCUv8bBm44ajpJ5PbYCW7CZK4LsBkOoB
	5+WwTzSY2sSh1cQRyXBjaKDptXFszuiDckTzSvNfuTvzjDVETCPN03yUkIagR3+96TyrJA
	bThSvV+zXZ7sz88H6QYLyQfnWYsDu6n6bVC2J/t3tWmx5yVD4Wld019fBcyzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1772644487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=n1nc98wxZH9AYQDSngUN/HtP6sFUA5A+qlUBOUMovV0=;
	b=OAF3kjKAWd6uMdA5aXGSKm/VomFnvnOQUxssc/74aSgBNZPiQLhfL7GMFQxaS/3W50lSwD
	sf+QpqZ+mzYI/6jxRgRUrUD8da4P3YfChQ8omllQ0Bm/XuNoL8qrz2QFQSrhpYSyhHp8ab
	RjUwMIqejE5GSvo4dndXL4YnNLYSHdp4toaEgP8DGmw0H/BujwB4Id77F1a+CFCf7tKOC7
	0COWwWvUkkruhG4W90XKa7D8MkyWtP0YTUr3BQgEomgCNqlzk6PGHZCZEWvm7SHmL9HqSF
	h0r9/5ziJpSklXFpSlrgyS6LtJlI7b4JgFbaD633HyuFNhWKkej2KRz8Ny98ZA==
ARC-Authentication-Results: i=1;
	rspamd-7f65b64645-t4xtl;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-White-Suffer: 4248394e13e3fa86_1772644487469_4237990486
X-MC-Loop-Signature: 1772644487469:1401202760
X-MC-Ingress-Time: 1772644487469
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.44.163 (trex/7.1.3);
	Wed, 04 Mar 2026 17:14:47 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4fQzn24rPmzdb;
	Wed,  4 Mar 2026 09:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1772644487;
	bh=n1nc98wxZH9AYQDSngUN/HtP6sFUA5A+qlUBOUMovV0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=OwwO/koH6N0u1Zihm70xkbGSi5JL78HoQ1ZUwC8uoXdJQECAdvke340r+gWFvqHhO
	 kqYXAoUcDiFFmXY55F4i3zMySbr3Thwq9hYHVfU/gSSBvV/VTRdgiW/qV9qBWebC/+
	 pDxrLIDM8a4CmEsnFz29Juk+BI69TeqnH7rGeqMlVF8QbcDRMMAkgS+Szn0x5mTF/J
	 8hVgFM1OJtZvUHGEXHI4Y9GdKkSwVkexDREwNarcBaQ2WIX8UDtFukYWvGVbeUriIa
	 xUJTkV/in2hMpIqJtSqArEIqjQ+FbxPDmTPbUK8zkMA6eL/T8naVxh7fgsfRR8lbqZ
	 dBnNEpC3f5v3g==
Date: Wed, 4 Mar 2026 09:14:44 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Fix leakage in __construct_region()
Message-ID: <20260304171444.dpgaiaknv5dq5uns@offworld>
References: <20260202191330.245608-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260202191330.245608-1-dave@stgolabs.net>
User-Agent: NeoMutt/20220429

ping? Dave, can this be picked up for the next round you send to Linus?

Thanks,
Davidlohr

On Mon, 02 Feb 2026, Davidlohr Bueso wrote:

>Failing the first sysfs_update_group() needs to explicitly
>kfree the resource as it is too early for cxl_region_iomem_release()
>to do so.
>
>Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>---
> drivers/cxl/core/region.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>index 96888d87a8df..28d70497283d 100644
>--- a/drivers/cxl/core/region.c
>+++ b/drivers/cxl/core/region.c
>@@ -3795,8 +3795,10 @@ static int __construct_region(struct cxl_region *cxlr,
>	}
>
>	rc = sysfs_update_group(&cxlr->dev.kobj, &cxl_region_group);
>-	if (rc)
>+	if (rc) {
>+		kfree(res);
>		return rc;
>+	}
>
>	rc = insert_resource(cxlrd->res, res);
>	if (rc) {
>--
>2.39.5
>
