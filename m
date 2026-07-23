Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B573DAADF
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 23:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784847996; cv=none; b=OhxsvZ6adUXFWHpejvTn9IufBXe7fi2wj+Ok0e1Xb07z/l86RGUxWeSR9LmOhXserlKkSSzahCyXd0Z2Um+MAvcuPHyVm7RqVrnx1pf6oVR/4xbAODvrOSi27qS3JcPmUTFRcY+5pQuVzHHonlSb2tapiK7spiAfg+Y+mHSpUZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784847996; c=relaxed/simple;
	bh=S1vECeO/e5ywF/TEdO71GsrR+/GWwjIESP7TyU9mGyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hztFhUm+Xa/E42mH9HtQZnmc4P0D0+SKN4cy2Yzn7x1z1w3L1HOGSc8vYvNHgttFQZP2AFjjoyuytAypiayaCu4iFdHrkj0v8qIZWhTd3K5kpu2sigHwIUMKNPGnSbvVvS89ajPFNrN0a4mtk5mdmXNbwxmQbwa+jO7nfjKhDPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ViX7FuFG; arc=none smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ViX7FuFG"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 151C27E1DD3;
	Thu, 23 Jul 2026 23:06:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.103.100.118])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7F9057E1B34;
	Thu, 23 Jul 2026 23:06:32 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lonely-Desert: 164b88845676b91c_1784847992949_3801057878
X-MC-Loop-Signature: 1784847992949:2247451416
X-MC-Ingress-Time: 1784847992949
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.100.118 (trex/8.0.2);
	Thu, 23 Jul 2026 23:06:32 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4h5mvq5yJ7z2c;
	Thu, 23 Jul 2026 16:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1784847992;
	bh=20TituhC01/lcmaA/WpTaowNk3KKSQ6tO9kJU3VQqIw=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ViX7FuFGOd8S9ZBecOMwmb2dypfDNxS+NsSI+UGyyNZgJRbSuW++bwicNo6buni77
	 4lB9+f816qn5Kufj7e6293YPYjLwCHAdBZVIt4QB8QvNiH/UadHUwTCrHruflLRb8O
	 fNwSYXs2NTdGXsc4mb7OVwrtMRbsObRrB7zOiWTyClzEK1qRIOQjJhegFpnXTdR+dI
	 xQ7Del9z0OQauf7ICDLtOSPn3mcZBH3kzlVD8BmY5QR2HrgsOG7r8l/DfgRzZfMJCL
	 jZqnxyzPKsBBwcshmdup4vXQD6buamA5J9gxpYDj0FzHHtkPGlXU3Mq99r1PazYwvv
	 sln7oewYjw4Ig==
Date: Thu, 23 Jul 2026 16:06:29 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave.jiang@intel.com, djbw@kernel.org, jic23@kernel.org,
	benjamin.cheatham@amd.com, alucerop@amd.com,
	alison.schofield@intel.com, gourry@gourry.net,
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 4/5] cxl: Add HDM-DB region creation
Message-ID: <20260723230629.yklwrj3nr6dbblgp@offworld>
References: <20260615145529.13848-1-dave@stgolabs.net>
 <20260615145529.13848-5-dave@stgolabs.net>
 <ajpEy-oubtV4E0lY@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ajpEy-oubtV4E0lY@MWDK4CY14F>
User-Agent: NeoMutt/20220429

On Tue, 23 Jun 2026, Richard Cheng wrote:

>On Mon, Jun 15, 2026 at 07:55:28AM +0800, Davidlohr Bueso wrote:
>> @@ -2772,6 +2796,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
>>  				   size_t len, enum cxl_partition_mode mode)
>>  {
>>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
>> +	enum cxl_decoder_type target_type;
>>  	struct cxl_region *cxlr;
>>  	int rc, id;
>>
>> @@ -2779,7 +2804,14 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
>>  	if (rc != 1)
>>  		return -EINVAL;
>>
>> -	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
>> +	/*
>> +	 * The CFMWS dictates endpoint coherency: a BI-restricted Window
>> +	 * produces an HDM-DB region; otherwise HDM-H.
>> +	 */
>> +	target_type = cxl_root_decoder_is_bi(cxlrd) ?
>> +		CXL_DECODER_DEVMEM : CXL_DECODER_HOSTONLYMEM;
>> +
>> +	cxlr = __create_region(cxlrd, mode, id, target_type);
>
>Hi Davidlohr,
>
>I have a question about this part, I do not understand FW so please correct me
>if I'm raising some stupid questions.
>
>It derives the region type from the root decoder's BI flag, but on auto-discovery
>path, it still and it needs to take target_type from the endpoint decoder's HW-read
>type, 2 different sources that can disagree.
>An auto-discovered DEVMEM region could hit the "DEVMEM && root bit && !cxlds->bi" check
>and reject in cxl_region_attach() before cxl_bi_setup() has executed.
>
>But path 3's init_hdm_decoder() -ENXIO on a committed BI bit means such a decoder will
>never reach construct_region(), so this scenario might never happen.
>If so, maybe a changelog or comment noting that HDM-DB auto-discovery is out of scope would
>help?

Yes, currently auto-discovered regions are unsupported, but this is certainly documented
throughout the series (and I have also discussed this with Ben).

However, v6 comes with a proposal for supporting this, as an incremental patch. The main
requirements are 1) move cxl_bi_setup() from cxl_mem_probe() into cxl_endpoint_port_probe()
and 2) decoupling the read-only topology check from cxl_bi_setup(). As such:

cxl_endpoint_port_probe()
	cxl_bi_probe_capable(port); // read-only topology check
	devm_cxl_endpoint_decoders_setup(port);  // decoder enumeration relies on the above
	cxl_bi_setup(port); // perform the actual topology-wide BI enablement
	discover_region() // auto-assemble regions

With some qemu hacks I was able to succesfully assemble a region:

[    0.709507] cxl_core:init_hdm_decoder:1136: cxl_port endpoint2: decoder2.0: range: 0x190000000-0x19fffffff iw: 1 ig: 256
[    0.717141] cxl_core:__cxl_bi_ctrl_endpoint:1210: cxl_pci 0000:0d:00.0: adopting firmware-enabled BI
[    0.720518] cxl_core:__construct_region:3806: cxl_pci 0000:0d:00.0: mem0:decoder2.0: __construct_region region0 res: [mem 0x190000000-0x19fffffff flags 0x200] iw: 1 ig: 256
[    0.723118] cxl_core:cxl_region_sort_targets:2079: cxl region0: region sort successful
[    0.728158] cxl_core:devm_cxl_add_dax_region:101: cxl_region region0: region0: register dax_region0
[    0.728952] cxl_core:cxl_bus_probe:2298: cxl_region region0: probe: 0
# cat /sys/bus/cxl/devices/region0/commit
1
# cat /sys/bus/cxl/devices/decoder2.0/bi
1

Of course, the platform has to be sane and support it, otherwise:

[    0.775144] cxl_core:__cxl_bi_ctrl_endpoint:1210: cxl_pci 0000:0d:00.0: adopting firmware-enabled BI
[    0.775963] cxl_pci 0000:0d:00.0: mem0:decoder2.0 BI decoder in a non-BI window
[    0.776652] cxl_port:discover_region:55: cxl decoder2.0: failed to add to region: 0x190000000-0x19fffffff

Anyway, fyi.

Thanks,
Davidlohr
