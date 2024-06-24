Received: from antelope.elm.relay.mailchannels.net (antelope.elm.relay.mailchannels.net [23.83.212.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B162136995;
	Mon, 24 Jun 2024 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246327; cv=pass; b=QKcaNrXpRUyx92WgCINpmnPcWnN0G+gpY/Qq3lmSVud86cMQW+cIQrUhr8QmPjTm760XlI032+BadrkhRgnbJ2vQ3Cp36ceev6TKmNTbWxCBRqYG/B4Dq1iDfOQeONjfrK8w+6QIa6I4H7OIeWNtKOaU3wJ7gvaEvG2NBAPLOAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246327; c=relaxed/simple;
	bh=s/X7e9ND1LcgFkfYWET+NkfJ4rO2vGCLphX+LfaDXAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AECTnAGHD+YYiAQV3eJ0ki0nmwkGf6pp0aq4Sp69a3f5C3/7fuJ5CBbSw4iLIoyoJGsMf9BASrT58uhSv0osJDteKeqh+dKVIaZ5h7/7rVqZ55urXqJbzcWK+OfwUHYtLdOfE0F74fgEsXVUSAXzjWRTUDKj5KCAN5utY6QUskA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=cvjfmSv/; arc=pass smtp.client-ip=23.83.212.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="cvjfmSv/"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E9C371021BD;
	Mon, 24 Jun 2024 16:18:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 643D0102800;
	Mon, 24 Jun 2024 16:18:46 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1719245926; a=rsa-sha256;
	cv=none;
	b=RxFOHkYAs8kHhM0JFi++tXHrqC2wFE3mGXUMYR9fALURWsGiHJNpw+cO69H/BEzikNvESp
	B5TKPYoMLfZ0YICR/D90VlJ545haN5W65AByHNWI/D4aRoxbcDA4CmVeurTlcSbhWnZlUW
	V87iD7iaXZZKCY+MFWV3G3hpYzV2zRfOUCmxkTAeTeDTZseEGovTxnXXOSTy3SEHLL9Ryw
	41TJvNnW6ZW8QCdVKQTanCq/P5YA+nZudb/mjyRiLFI+T8uylza4YRi64Bl8bibK7vhIsH
	D4e+/ZDpjv3KilokkrTlBs3Uy1PPYl13r0r39fcMGrzvjZtRQA5NiygU1z0lbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1719245926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=s/X7e9ND1LcgFkfYWET+NkfJ4rO2vGCLphX+LfaDXAk=;
	b=cIgDMkwcTVVtRiD+kcXnOg1h56H9puTO0bi9dAPXbYFJ6iW3w4/MEvbE3CvZvsDh17eI5s
	6tN4wfAB22kR5mwMro12wtgmxykrsRCTX5jiFV4bq/WHVnXHKo88abyMW2ctYCQmOlA1o0
	7wVGf40UUJO52S1FmTFbn2hboUE8KTZCWhXTdy7J3X9EMZc6gVJWy7Vvx6MysawlCP3Xey
	7mN6a6f+isbxgrnEkNHI0X7cDqX2G67ccee32K9arbzNuR9zJ3Q8ir2ea4dcDxkpLIgOxF
	AVe/rlWQ7z/NN6ssEIeYN5AuccFvrIzDuKENmEmz1CSKvOO/ACg94+zYZQ19pA==
ARC-Authentication-Results: i=1;
	rspamd-7f76976655-7pwfm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lyrical-Supply: 4362dac010c41fcf_1719245926736_502416715
X-MC-Loop-Signature: 1719245926736:1170366257
X-MC-Ingress-Time: 1719245926735
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.207.198 (trex/6.9.2);
	Mon, 24 Jun 2024 16:18:46 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4W7Cnd0KhMz83;
	Mon, 24 Jun 2024 09:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1719245926;
	bh=s/X7e9ND1LcgFkfYWET+NkfJ4rO2vGCLphX+LfaDXAk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=cvjfmSv/xtxNiy1geC1B7ErlaIXuNCp8p579Rdgk7lRi/G9ZhaRI2JLftSKNd5X73
	 dxExRW5C4jruL7j8VO6OFRy2XiBofKi3p2M02os7BN/Ld5kTyENlx6CFkqBJxU5MA2
	 CUXL8qFb0L0N8lCGf9ci5F6wfWwIwgLbYA8NeT3bFzy0is0Q9pFSzPXQM5Hbw7OLdZ
	 zrxuiJ+Uip9vPt0op9wg09W+0iUaE4NRWgpAVE5emse4vWozSRP47/YMrwNGeixqVZ
	 ngGFAgPW1zQP2oVndUKmM/eOP9+rH4H5kG4FoSPiT7EQEWSN9Tx0InsNTRpaH8wi5P
	 CS3V0/Gj6mWDA==
Date: Mon, 24 Jun 2024 09:18:41 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bharata B Rao <bharata@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 1/3] cxl/region: Fix a race condition in memory
 hotplug notifier
Message-ID: <20240624161841.gekjnoksxrb4zd7x@offworld>
References: <20240618084639.1419629-1-ying.huang@intel.com>
 <20240618084639.1419629-2-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240618084639.1419629-2-ying.huang@intel.com>
User-Agent: NeoMutt/20220429

On Tue, 18 Jun 2024, Huang Ying wrote:

>In the memory hotplug notifier function of the CXL region,
>cxl_region_perf_attrs_callback(), the node ID is obtained by checking
>the host address range of the region. However, the address range
>information is not available when the region is registered in
>devm_cxl_add_region(). Additionally, this information may be removed
>or added under the protection of cxl_region_rwsem during runtime. If
>the memory notifier is called for nodes other than that backed by the
>region, a race condition may occur, potentially leading to a NULL
>dereference or an invalid address range.
>
>The race condition is addressed by checking the availability of the
>address range information under the protection of cxl_region_rwsem. To
>enhance code readability and use guard(), the relevant code has been
>moved into a newly added function: cxl_region_nid().

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
