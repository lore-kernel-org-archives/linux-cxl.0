Received: from quail.birch.relay.mailchannels.net (quail.birch.relay.mailchannels.net [23.83.209.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA74921D5BC
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 19:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.151
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770059829; cv=pass; b=mWX+4V6q7XhDgx5XD3GJa3sB5vwKIOGtaU8LsIrrpPzI6weDptVXWPiNiiuGfoTVSP7qiaXuuZqmk4m9f/RIRXsU32+VM+N5b1yep17iguSeqHEABZRc1l/km3L14r+Bixnv3mnyxzW4JDEii0cqIbaIXhZKCFYy4POGn0k4RrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770059829; c=relaxed/simple;
	bh=lfg0YvH4Pqw1bWO+M24RcXwafAYwB8/hI/w2hpKmz9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltYdzcywjVUwFRc4uTyWEjWfgQ0jni4D72KEJ9CsvjbSmSCt8EpoHxHbiqLhLf7cbobk84JUKy1YNBwXlOnOUmL1NkcC5hRbmLotx5/x4+G5saibPtoH4JtDzqo/jIEH2i+LzyA71GiabQYwUmXiBGzZjGus2ZdyPcVQFanTe9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=KeX4fP23; arc=pass smtp.client-ip=23.83.209.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="KeX4fP23"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 211B944174C;
	Mon, 02 Feb 2026 19:17:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a252.dreamhost.com (100-122-8-2.trex-nlb.outbound.svc.cluster.local [100.122.8.2])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A79924424AE;
	Mon, 02 Feb 2026 19:17:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1770059820;
	b=XUsEp55eWbCSrhyG8LfF8mcV3jDsp+Msfm+npL9FGn3Cpxb+W0aopYqj7nh4KV+tRokNKy
	vmCQwfyO38cyKpDGrH9/hWk9yNGbX5VMNVtia3mQN3Uff0Fc9A2v0+vnHq+0KGIiqERGYQ
	nnM26gd9iGbG6eLGgTbmdBpnuOTA71AlDfw8iclp17kwInAuRimcR0Zf4Zm2F9PLdHr+KM
	t/8xg59OEJFaqfGK+OrCn+oUIRJAYyfcD5NNq3EeNKEosba1VPz51Qp8LBzbQFAznvFujs
	nHZCWtv/tqN83Toc6hlPGxGxZNXMZ99CqlhgqauO/tMsb3jgjdJU7pGGbQuCbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1770059820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dUNPF7wqc36qBdAIjyFvl6BaZHqkAFDsj29fQacl8SA=;
	b=HZB4nl8OFhoWmLySB6ppxtqcUjc3tHJ5F6ZVYnQb3/eKu9RYrhpUubVpJlbxO4TvGnTLa/
	j1Y3j/pvPDJ2wVNF5lLGzlGDLQ7ulDlKFtvSYCdptwQHtX0WDo5oLYUhFDCWfSaGASQ1iE
	N2/0eS2kyuBklrpqkb3752rC5AWM11bOGklYntZmGtVXIOc8UdjCPP50d1eq66632ebrea
	/YSDQb0wh6BBa4Ai0RSTX6489AcP4wX6GpIwPs+JVNQJ1/V6ZnsNyk+jzc6pap+WaMLo2L
	QhPhgU21dK7NSsIRLFVKMNbqb3sf0/WNi3d01TxLKx1S8EWW7u0MWUSqNJYXHA==
ARC-Authentication-Results: i=1;
	rspamd-5b979ccf89-bd98r;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wide-Eyed-Abortive: 68dd21f85c64a455_1770059820942_228613891
X-MC-Loop-Signature: 1770059820942:4278327489
X-MC-Ingress-Time: 1770059820942
Received: from pdx1-sub0-mail-a252.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.122.8.2 (trex/7.1.3);
	Mon, 02 Feb 2026 19:17:00 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a252.dreamhost.com (Postfix) with ESMTPSA id 4f4bvw15VPzyrC;
	Mon,  2 Feb 2026 11:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1770059820;
	bh=dUNPF7wqc36qBdAIjyFvl6BaZHqkAFDsj29fQacl8SA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=KeX4fP2339ypseDzfGZwRm/t4LXsDEtmNwDWrAxUHECHuU/KK7fNwgJdd0gpK+3bg
	 mLk6ZjZmYfHHBwIitDyu7oKEVBxlIEMi2whyiP4sZJ7Hrx0sHVrUgAeBdBhPvNpvf+
	 YwznsJOge32qHgFxNOie47vfYlJnFtVsNhzmy2vqo2+hlQuBOf3giEsQ/O5jLURux6
	 744vzYb+vj5f29Xc/nxsjHgytQY3sUbwKyvR99TxFD608zK7qEHCZQzFhW/qamO4we
	 avm2EK8Vs+jeEmHpbTVA0dVuuWxcHBnhlLiSEdIFuZ/dvfnIQnbbFPYcec7tUs6TO1
	 lzquSnfBC5tEg==
Date: Mon, 2 Feb 2026 11:16:57 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Fix leakage in __construct_region()
Message-ID: <20260202191657.a5xksgklaw6o6iib@offworld>
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

On Mon, 02 Feb 2026, Davidlohr Bueso wrote:

>Failing the first sysfs_update_group() needs to explicitly
>kfree the resource as it is too early for cxl_region_iomem_release()
>to do so.
>

Fixes: d6602e25819d (cxl/region: Add support to indicate region has extended linear cache)

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
> 	}
>
> 	rc = sysfs_update_group(&cxlr->dev.kobj, &cxl_region_group);
>-	if (rc)
>+	if (rc) {
>+		kfree(res);
> 		return rc;
>+	}
>
> 	rc = insert_resource(cxlrd->res, res);
> 	if (rc) {
>-- 
>2.39.5
>
