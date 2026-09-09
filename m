Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55B3566C53
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990349; cv=none; b=C8R5pkqj+dAu0qjg4M866NU/5gDBiFpxvBqR74Bs4+F9rrGMem34prLXQ6M7qKy61tqkmYwqHE6v2BzgzclUppoKr3OcBjVLBxU+tsMDGftxaQQc7JPuZbQ8WScAGzOuHrjlLFZoqxhhWSBrruYw201QqqDW8dkZb51ET3L9ebU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990349; c=relaxed/simple;
	bh=2H3Xg2AxDMC7D/VGJZ4w8FHBR7/qrZ5e96LKCZiSLqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiC9a4KkbjbRli9I5kpz7Vkx0DkfctW4sRve7RQ3eY4RzUi8jvfnX/HCsFdSiHOpl4BMSeTlvGVXQ8nsLKn+7SvLe1e5Ftx9NHy7ZIJ22L3cpOdqmZ61Ze8l5rBgEKQ5Q7oMB2rvOR61UUE8sxEEBqRx68+OR5nHvbzDuKnSOA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=bjJCdMg+; arc=none smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="bjJCdMg+"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 507BE723072;
	Wed, 09 Sep 2026 21:45:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (100-99-183-67.trex-nlb.outbound.svc.cluster.local [100.99.183.67])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 11835723066;
	Wed, 09 Sep 2026 21:45:41 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stop-Bored: 4992978855a5065a_1788990341163_1217299894
X-MC-Loop-Signature: 1788990341163:123952504
X-MC-Ingress-Time: 1788990341163
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.183.67 (trex/8.0.2);
	Wed, 09 Sep 2026 21:45:41 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4hgDrN30W1zPK;
	Wed,  9 Sep 2026 14:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788990340;
	bh=vLaYww7qARjgFi9XN7iJuSL6hBGDjkDh3ToyImU8gAU=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=bjJCdMg+en3Dn+bx8riWzQxovWFEt6jzmvPbwrj0vEQdqrQVPPNWfXeSEYFLadhKW
	 RrL0fkinFhtrieUdwtIy3jfHAti8eVRJvlwchuB1G6sibweC8+ro0Grj6VQRWjupeA
	 xl8lB/Lh7tBEVLlg3JoRD1Cv6gu7fPgH6VWHTaQ4V3CsgVSIGONwZiB1eKs5qNGs06
	 J7ptjnJw5aHEa5BHflObeMm2mtRPeQ10zneYZXYyKWSMCBdi1Q9B4Kg2xMndQ5E7NW
	 Yn0p+swP+oV0fQeQqurvCnBfinsTOidtfcQGIhoNan815SiYu+jlxWICctLVdI3ic4
	 TmxWr2Y1mXrTQ==
Date: Wed, 9 Sep 2026 14:45:37 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: dave.jiang@intel.com, alison.schofield@intel.com, icheng@nvidia.com,
	ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v8 07/10] cxl/pci: Split BI capability probe from setup
Message-ID: <20260909214537.7xt6ixzztbes4wkn@offworld>
References: <20260909170302.1550680-1-dave@stgolabs.net>
 <20260909170302.1550680-8-dave@stgolabs.net>
 <20260909224037.7bd984d5@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260909224037.7bd984d5@jic23-hlaptop>
User-Agent: NeoMutt/20220429

On Wed, 09 Sep 2026, Jonathan Cameron wrote:

>> +void cxl_bi_reset_detected(struct cxl_port *endpoint)
>> +{
>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	void __iomem *bi = endpoint->regs.bi_decoder;
>> +
>> +	if (!cxlds->bi)
>> +		return;
>> +
>> +	if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE,
>> +		      readl(bi + CXL_BI_DECODER_CTRL_OFFSET)))
>> +		return;
>> +
>> +	dev_dbg(cxlds->dev, "BI disabled by reset\n");
>> +	cxlds->bi = false;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_bi_reset_detected, "CXL");
>
>Why did this need to move?  Just to have a nicer code arrangement?
>Maybe not worth it given it makes it look like this changed
>and it didn't.  I'd leave it where diff thinks it was originally.

Oh silly me, yes I will be dropped for v9. Sorry for the noise.

Thanks,
Davidlohr
