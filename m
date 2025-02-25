Received: from cheetah.ash.relay.mailchannels.net (cheetah.ash.relay.mailchannels.net [23.83.222.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DDE21D5A7
	for <linux-cxl@vger.kernel.org>; Tue, 25 Feb 2025 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.222.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523121; cv=fail; b=T9+S+HqbLLa/LLXUF3C4Ca3TfNZnS0C3f1PtORy+YZ7aP9Vvri0nXduWGPtySmZ4dXKexMYkpmAeAt1ZcnW+hSs0md3pINCabvHFyiGT8xriwtpG1Onp9bz6n1PStckezi3oG0+pW0oTqIu5sEoHI0lrokIEgACABd3c1x0REAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523121; c=relaxed/simple;
	bh=5qvuQ+WJN28ykfOZqke1yc49nlbd43LiZ/tncv2Y8Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVTyXs4afGLApVU5r+Lv7yC3kWENgtsKVpnldbGpULyjlEr0aDigOiBA0bjHqpI8gA77Kni8Q+cFJeQLgXBaeM43b5N9pbXb50wyDO8cMNseIL1J6hIqMDp40e2cvZjeR2BicqOzC48u/TSqFU6VST+JTVn/K5dhik35yCp43Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=EwDxBxud; arc=fail smtp.client-ip=23.83.222.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="EwDxBxud"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A99CC8A4356;
	Tue, 25 Feb 2025 21:01:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a218.dreamhost.com (trex-7.trex.outbound.svc.cluster.local [100.107.32.231])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3BFF98A3F01;
	Tue, 25 Feb 2025 21:01:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740517274; a=rsa-sha256;
	cv=none;
	b=83T6mEdwI94/HP4RNZxL5XQapwPOMFgC83fnycBRIHcAPKWiBZdJv6Gml7Gi24sZ5jPcEr
	sTIfdaaqyP/HC4Fo+E5a9L5CqcgEy5DF1KpqWB2dojKA4kWDvKsSVMnUB98Z9TJOqTNFdZ
	yYMk/GvdoL097gdiwOeJ+FRY76wcK841dpAmjjfc2lyW6cgkoX+/b9N/R7BvT6aGWMclSb
	cDelNwysH91G1QnWes2oqtSZsud9u7fBY2rnZPq+sRExRbPEc5T+/ZI5aAPYn4HO/Ud+w8
	F6v4vrSyglHFL2nHeyT7Y8wOLnnqonjznwdChuU4qGpHx6T6sQvQTQprx2SU4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740517274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vlsA5W4dt+ngqFpCtTsf+jSVDy6+8JfJJxKJlvjhqBc=;
	b=4AuMedaL3bh6xbLwo/lttFf630LUGHKCdXX/7/pENWcuYjgnvDNMkHOelDhR5SHfmZ9YxV
	djSpC1kiceSe0pwL5OvaKBObw24SctbhEBGIJz/5LZpiqYM0wxWeGlJBbEiirMcRYeBpcf
	hRrZC6M4AgRFbzR0aFGo5vGPzmNvFe+qMnfcyKkkMIRrkESanI5C1DoNEd5enuFWPibUJq
	VCyJAUctemkPOK76ekHnxdxQlEzwrjrufp/kV8SasmJ2UgubzGm6PM5CuemHwherKY3iss
	EGcH5nn9IaxR8eOc+NbgLa7kQbJGNqgATyEU0T2m2xYLpqd1SBjufw5ZUOE6Iw==
ARC-Authentication-Results: i=1;
	rspamd-78ddd997cc-bjxq5;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Soft-Whistle: 1803bb1a36e59f99_1740517274529_2536723096
X-MC-Loop-Signature: 1740517274529:1234087980
X-MC-Ingress-Time: 1740517274529
Received: from pdx1-sub0-mail-a218.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.32.231 (trex/7.0.2);
	Tue, 25 Feb 2025 21:01:14 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a218.dreamhost.com (Postfix) with ESMTPSA id 4Z2VQ13gTnz5H;
	Tue, 25 Feb 2025 13:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1740517274;
	bh=q47YZMZJXaXCB6KksHo93dYYbFkcRasLcUp6/gS7yG8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=EwDxBxudymqG/QUm/yJVyvn9UKr7NtFXBRMsF9VtIPYdXK57xJyLWOLbFjDyyGjC6
	 7XVXUp7/TJN1hYnYPO3MeyBuL0JieONPCGCT+Stdk5I2EVuKIZibq3UcsYpk5J3+EX
	 3JIQo7ZhHFVIPx3s/wZ7Y9LCHv9cMcwudIOfhGRxfVm2kY/iyEjmtCbxlMLL1BGczF
	 hB9L96LsXflPIsxxpem5vfdmdiVKs15cJ5TaQgq9C5YNdyfl1ogrmVbf+BBcp/GESW
	 oYScCMgKFNFZVt4BDCqYdviWcL6hL2vWqesXhcTISj8F/sQZ1ha8fjVpsdN0OvQDf6
	 EFqhvqLy+RBGg==
Date: Tue, 25 Feb 2025 13:01:10 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	jgg@nvidia.com, shiju.jose@huawei.com,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v7 02/14] cxl: Add Get Supported Features command for
 kernel usage
Message-ID: <20250225210016.vdci7r7pwseytsyr@offworld>
References: <20250220194438.2281088-1-dave.jiang@intel.com>
 <20250220194438.2281088-3-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250220194438.2281088-3-dave.jiang@intel.com>
User-Agent: NeoMutt/20220429

On Thu, 20 Feb 2025, Dave Jiang wrote:

>CXL spec r3.2 8.2.9.6.1 Get Supported Features (Opcode 0500h)
>The command retrieve the list of supported device-specific features
>(identified by UUID) and general information about each Feature.
>
>The driver will retrieve the Feature entries in order to make checks and
>provide information for the Get Feature and Set Feature command. One of
>the main piece of information retrieved are the effects a Set Feature
>command would have for a particular feature. The retrieved Feature
>entries are stored in the cxl_mailbox context.
>
>The setup of Features is initiated via devm_cxl_setup_features() during the
>pci probe function before the cxl_memdev is enumerated.
>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>Reviewed-by: Li Ming <ming.li@zohomail.com>
>Tested-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

... with a comment below.

>+config CXL_FEATURES
>+	bool "CXL: Features"
>+	depends on CXL_PCI
>+	help
>+	  Enable support for CXL Features. A CXL device that includes a mailbox
>+	  supports commands that allows listing, getting, and setting of
>+	  optionally defined features such as memory sparing or post package
>+	  sparing. Vendors may define custom features for the device.
>+
>+	  If unsure say 'n'

When would a user want to disable this (admittedly this might become clearer further
into the series)? But it seems this should not be tucked behind a kconfig, much less
default to off.

Thanks,
Davidlohr
