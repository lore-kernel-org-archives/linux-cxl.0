Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD1C2C11DE
	for <linux-cxl@vger.kernel.org>; Mon,  9 Feb 2026 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770667695; cv=pass; b=ezW6i3aA1UFt0Qv4kfMI6lMmRIFf4Cp4ZI40BpCEoxl3RI+Boa1xGdqAkGbiXRMc2IdTfrTuh2W0hDpwC7iqJV5u8HGRSApLvK2cpozp0CZBSY6iC8wlFLj4KHlGmcipQkihWEiM7DKJgE9jinrqi5DXGvOp3xa5lf0N6ljEqcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770667695; c=relaxed/simple;
	bh=3AWzzr2v24B0eLAjLCw2oKoD3gmjk5nr8lx6h9DwyMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kl1xQQ2R5QEM9pk/AqAC8qdlXM2gCkXCDfdy6VPcbyxfPU8pqc1lGEGN8lvURUKyL5i+exFnNTQntsnJWsLquoe4oI1EPASBlE/SwAwsOA/JNFQcu8GLG8JKUV/iuTvksCddVvxdhd937Vn0q6DPwdAqlv1ZB1Q3QxkeN18Vxk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Z2MaoMjd; arc=pass smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Z2MaoMjd"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2F7BD4C3997;
	Mon, 09 Feb 2026 19:52:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com (100-96-84-203.trex-nlb.outbound.svc.cluster.local [100.96.84.203])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9F57E4C2A23;
	Mon, 09 Feb 2026 19:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1770666778;
	b=n2Ek0vn1uyiaMQsDr6l36ZHC6BCG0STW3Be1gUd8iKK4HpVmCrsBV+G8XCx8oXoJo5scJm
	T6hWPHAdndTfHU5v/zBC5hnlMvdEXRCnI1GkGLdcEjvqr/ukiK7NeK+TnF9SHB9IXDuFM0
	8cJsMZpHsxeIbfBG8KHFSPXG4AuRP1Oiawg/o+jEHsz8RhgMqS9svxHT3J2jd5LSHnqH9R
	CFeVbZi76y3ggIMfF/tQ/QEMTrnk9ANXbFQTSQBdiFFvYbVxiAIwhSpx+zwr/Wej1QVQkM
	DdqVQqwL1YOO2CkPEWAGhv+SkAYPluZaI5lOXIVf0qOmeu0S9G4UvbKFpWWq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1770666778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=GqXRs232yRyj29Sd9+WFnvTB5YBihracBzNciScQdgo=;
	b=Wub6a6cQ9WoxhlYNFHzrX1g6gjP27LEnwHHU8bHSpNizQPtrs/Ui2/4rhgHaA0Rr2fU+BH
	QYbzN9Vr+YCyFb+TxNEelCDaHJe3Jnbb87o/dZuC3AimNLQCiDehlJY4wELOSP4NlDVCcD
	e+lvlqv+FQ/cgTJEL4IUfI6aOyguX8r/NIkn1H+pY4LLIlUlSyuAEdbIklxxi8YOxFLVD+
	KgZnsltx4lkbgu00072HAOOJm6ljOAv/jvkjN7odn2GF9+PzuYgpiFvzfObuwl6JxAbwSz
	ooBR+W2qVYugWnT9TGUJDXlzS4oDXV0uMtZm3h3U0FFRNZNPP5GYKLFKubzvUw==
ARC-Authentication-Results: i=1;
	rspamd-845545c4df-thxvx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Chemical-Sponge: 5ac71d2d2a550e66_1770666778999_2551100784
X-MC-Loop-Signature: 1770666778999:3580148392
X-MC-Ingress-Time: 1770666778999
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.84.203 (trex/7.1.3);
	Mon, 09 Feb 2026 19:52:58 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4f8wNB0g8lzS6;
	Mon,  9 Feb 2026 11:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1770666778;
	bh=GqXRs232yRyj29Sd9+WFnvTB5YBihracBzNciScQdgo=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Z2MaoMjd6oSSb+O+eHV0Yf9ECQhq27aTi3MwzYjH5VFYAVm5LMhMcxlN78ib8YLuy
	 P4MzZYA2iXdnVL7pt2WebMt3GOzgBPopIph7/Rujo5HArIPyzVb0Pf0Svk0ttR263C
	 X3097AWdN0pW2MzHrtMC7PedtS68Awu4ve1JxNq6om1S1CEbWgvJI2zKXsiizsIum7
	 G+Shc8088nOcCF5Tysb2ziO5MQ2uIF8pdenDhiutN//VMYVPWZ3UuIFVSC2jo14hHC
	 W3ujk3dgWzhKxLQPb8F4/xv7DMcBuOR5nW2pXFKGTzFHqh9dqdegt4/h9m2WbdxXY1
	 cT+WsbdWJwfuw==
Date: Mon, 9 Feb 2026 11:52:55 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: dave.jiang@intel.com, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Fix leakage in __construct_region()
Message-ID: <20260209195255.24egy2aywdfrt4in@offworld>
References: <20260202191330.245608-1-dave@stgolabs.net>
 <698a380971da0_c11ee1006a@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <698a380971da0_c11ee1006a@iweiny-mobl.notmuch>
User-Agent: NeoMutt/20220429

On Mon, 09 Feb 2026, Ira Weiny wrote:

>Davidlohr Bueso wrote:
>> Failing the first sysfs_update_group() needs to explicitly
>> kfree the resource as it is too early for cxl_region_iomem_release()
>> to do so.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> ---
>>  drivers/cxl/core/region.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 96888d87a8df..28d70497283d 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3795,8 +3795,10 @@ static int __construct_region(struct cxl_region *cxlr,
>>	}
>>
>>	rc = sysfs_update_group(&cxlr->dev.kobj, &cxl_region_group);
>> -	if (rc)
>> +	if (rc) {
>> +		kfree(res);
>>		return rc;
>> +	}
>>
>>	rc = insert_resource(cxlrd->res, res);
>>	if (rc) {
>
>There is another call to sysfs_update_group() with potential failure after
>the insert_resource().  Does that need to be handled?  Or is the resource
>turned over to the root decoder at that point?
>
>Assuming it is ok.

Yes, the second call failure is after the region param p->res = res
so taken care of in cxl_region_iomem_release().

>Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Thanks!
