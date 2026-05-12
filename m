Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7007C2030A
	for <linux-cxl@vger.kernel.org>; Wed, 13 May 2026 00:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778630946; cv=pass; b=NWZE45IPeD9HKdaX77lxxcZKFwZft+l2De1GTIvA1wHzCmyO1D4hb3LPV1xb6z3dg2izhKvEXbxLmDbo3VRk/hvmauF37l3bSaHF6Vstj5zPzY1/mJdisSTh9Z2J/4OKmmoPWecZA7+rvCka3Bt66++8MrX4U3hywX4s4JIATRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778630946; c=relaxed/simple;
	bh=11VxdpX/3wSQMjdVgVweGTPHVYVvVR5W8oNGM7NYmcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRcg6PTyuzJq34Or32JnFJIIVk2fQVDK8NnYPgIz2sR7cHxnzbVPeGjvwDg1oDyspipYiEPJJh0Vf9jZC8BHh+bsdI2oog/o+v50R2JLQy1NCBnEyC8UTDCDksNUsuLpWc02AJwwyA756w3na/fr2MS8MLiUv5jZfZ7s2aroyz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=rUjMpnAM; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="rUjMpnAM"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2CA754C050A;
	Tue, 12 May 2026 23:59:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (100-106-191-157.trex-nlb.outbound.svc.cluster.local [100.106.191.157])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B1C974C0DBB;
	Tue, 12 May 2026 23:59:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1778630361;
	b=TK9qcoiR1jnud3E5vJ2w1djRWOwYxzkBPb0JDLFuD5TCzYx6azQCbaq0NlYl0Gw4tXrMFV
	8EHXW6lEY+v3IRw7LCmOxd2df7WbTAtLsCDUZIceYWdQvRGBa7baq8JYiu6P3L7XcJni0+
	g82Uzoedz4n/PHCcGU8GhB2YpsYsD16n1vRMHVEpyUiL6dtF12sLkMzLmST/0INTaeRlTb
	Y9qjg9ieQEfLokNz9LHQshTmPB2vjC5ccAyzpYSglwfyrenb7pPAVBzevtOVfDxMuyFU0u
	Y6nahQgSbjwQgeXIdOXgAjQWVu628g73BTRQmf3KZ0aWQrybjT+5ZlIgwiqtTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1778630361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rzcEoaWotebEH++3I3bsqPyF1H9k8EPpBhDAr4WDSqc=;
	b=EfZpygz2DTvboswJa40KAABiT5S7c2P0kys7Gk2OiHJMcO7wxOuQPuXvjd3Bxf5rOLf+Uu
	NOtaK5YQsApCGw7jLbv+NfBEuv3PsAZtlJkQkHSm7oMzeLf6dkjhh58NvFPHUlabPRvVm9
	9dsfxV2mMn2oCqKpsM8DzEec2Fjfz7MWrIMJFZ70dRctVjLQat6e86GJwjGPx/yLFpBLr1
	4E5xqvgArgddJlmqS9T43OUL9klURzV0zQUx8b6P8VQU/wRlYxA1gOF3CM3+EUDGjfmaaw
	kzQTxlZIhUADFe3HqBhgDVNK7s0V05I5NiGfKsFNraeWt1VmRbL7ZozKb/nbVw==
ARC-Authentication-Results: i=1;
	rspamd-79cfc4d687-sjdhw;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wipe-Inform: 04a9c677109dfd63_1778630362004_1917903092
X-MC-Loop-Signature: 1778630362004:1568215119
X-MC-Ingress-Time: 1778630362004
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.191.157 (trex/7.1.5);
	Tue, 12 May 2026 23:59:22 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4gFYV10L8Pz3K;
	Tue, 12 May 2026 16:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1778630361;
	bh=rzcEoaWotebEH++3I3bsqPyF1H9k8EPpBhDAr4WDSqc=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=rUjMpnAMHDKTL5Oh+sBPQmfjm/lPf9xibr+TuN/5ZoQBhgwqC5gPi92yyiNNQ9rS3
	 FftjewRQOjmOZkmOixN8LJgqZXMsU6ScLZYPEueNxqWu0vrFXAkP5bb9acDgwKOhHv
	 0P45pvLyDq5guk3n6xVJdfCKkwzJkSAmAVJao+I2zGXjtPWCaGl7CCCIKvlwn/LEMt
	 A1FJW0vxigXsL9fowTdqx1s7CHjMUwOHk28/MN7Ozb7AV0L3UR7VnZr8r73LOYTx+y
	 VU6UunrWZ5F+wxaHEGWvqu1s5cUkcFHPgfu0Beaj0t/G4oge2N094TOqtM9ew9Ra5o
	 D+QfV0KTZMFcw==
Date: Tue, 12 May 2026 16:59:18 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: dave.jiang@intel.com, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	ira.weiny@intel.com, gourry@gourry.net, dongjoo.seo1@samsung.com,
	anisa.su@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 4/6] cxl: Wire BI setup and dealloc into device lifecycle
Message-ID: <20260512235918.c4rygelqdliqyp73@offworld>
References: <20260315202741.3264295-1-dave@stgolabs.net>
 <20260315202741.3264295-5-dave@stgolabs.net>
 <a8843959-a000-4dd8-8560-699346772dd9@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a8843959-a000-4dd8-8560-699346772dd9@amd.com>
User-Agent: NeoMutt/20220429

On Fri, 20 Mar 2026, Cheatham, Benjamin wrote:

>On 3/15/2026 3:27 PM, Davidlohr Bueso wrote:
>>  static int cxl_mem_probe(struct device *dev)
>>  {
>>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>> @@ -150,6 +155,21 @@ static int cxl_mem_probe(struct device *dev)
>>  	if (rc)
>>  		dev_dbg(dev, "CXL memdev EDAC registration failed rc=%d\n", rc);
>>
>> +	rc = cxl_bi_setup(cxlds);
>> +	if (rc)
>> +		dev_dbg(dev, "BI setup failed rc=%d\n", rc);
>> +
>> +	/*
>> +	 * Register BI dealloc after setup so devm ordering ensures
>> +	 * it runs before the endpoint is removed by delete_endpoint().
>> +	 */
>> +	if (cxlds->bi) {
>> +		rc = devm_add_action_or_reset(dev, devm_cxl_bi_dealloc,
>> +					      cxlds);
>> +		if (rc)
>> +			return rc;
>
>Can I ask why this isn't at the end of cxl_bi_setup()? It would alleviate ordering
>concerns and make more sense imo. The only reason I can see is that you're worried
>deallocation would fail and don't want the device to be usable in a half-on/half-off
>state. I'm not sure that's a concern since it looks like disabling BI on the endpoint
>can't fail, at which point the hardware above would fall back to HDM-H requests?

Yes, I agree that doing it in cxl_bi_setup() is cleaner, and have done so for v2.

Thanks,
Davidlohr
