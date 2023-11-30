Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="GTEkLI08"
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1A6E0
	for <linux-cxl@vger.kernel.org>; Thu, 30 Nov 2023 08:15:25 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B1AB58029B6;
	Thu, 30 Nov 2023 16:15:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 190CF80350C;
	Thu, 30 Nov 2023 16:15:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1701360924; a=rsa-sha256;
	cv=none;
	b=4JK2aBbOlJtetlV6KJRDY3D7mMAj6Ec3radneuS110qmzAKuhIeWvI7XgybTCmGCveuRGD
	0hPwc6AzsnJQ4rZWwUqWbWrQGzw4BA2r+Dar2FcFoC723d+mldwfdXs529iJZosGor1vMA
	Iv9/8Y99q7/rSgeV14q5Ds8CfWZiluTtC3c83T1+spq86XTN2iN8S67kxUuVN+8imkwk0O
	rXkPbkltXbbhZ3zpMQ3mLSo2Lh3mTElkT5tYnwnYxhtyjoF0edw0qTsuWYc6BgIDQ4kOea
	rWMsTydL2gtbLl1eMc8QgloLIOCIupaT+99vB5jXZqqBCUp4j2PXyGbvHUoPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1701360924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=462pi9mvU2ASj4pvtPHecouWr71OeWLOZxsOU80R2VU=;
	b=008iP3v9GuRu2nPgmZMZHxXXjAyX0NO/f4drYvzUTtkTbiw07TA/TWlXM3pg9N1/XDpA2N
	jaBEn3m2W8FR+NVYqWkxCjpZr8LX1f0dzyP9t8n/hCgwagMDZVmAjUwMJMhjNoa/W7myUb
	Ywfs9cSMUMIey8rFnSspFWQevpGaJN8ko4ILu9fZTFsIIy6/dIyCDS7aSA0Tr5bd9MwXmN
	d34fJrbYUCueMNudgQE4d/v9GK6+zUFyGTPh09ONR5UtqBmYbZjCjDMHMB5Of9COqHiL5j
	ABdD1GQzN1JsM/ig2ezGoMfzPetEAciK5FBvz7F0GQIdyBi+EEbSznkZRCVBAA==
ARC-Authentication-Results: i=1;
	rspamd-d88d8bd54-nbdm7;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lettuce-Harmony: 59e506f11a8f7ac6_1701360924452_422134102
X-MC-Loop-Signature: 1701360924452:27409017
X-MC-Ingress-Time: 1701360924451
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.248.75 (trex/6.9.2);
	Thu, 30 Nov 2023 16:15:24 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4Sh1WH39yxz4f;
	Thu, 30 Nov 2023 08:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1701360923;
	bh=462pi9mvU2ASj4pvtPHecouWr71OeWLOZxsOU80R2VU=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=GTEkLI08Pj+YSvabp1Ylk2m6dqCNtYVpTF+8/0LZt7zjsDkKVrXUo9N+AaYgcoFRL
	 mnlXwRh/b7H6ibJSMNFPk1/HTAKzZnVDXvEaIcPZGVbguKU59QX22CNWEYKLMfC401
	 s/z143DIT2fZU9Y+QAX8SiX712laHbgFFt5yXUyEZgmxC7EfVssHfGeds9Mvk0wfYk
	 NysVV+1AOd1Cl5enQrwICosferCXKn1J8BbqA8IaGpXFGwr6p+qJuj0Cj+2MQhyEb6
	 +xXX5dxD2CkMC6nsCClaxKY8klF+alq8mDc/djSxBhdiEH1YN+c+SgOTLq7ZmM5rM0
	 Wte1uwxf1Irmg==
Date: Thu, 30 Nov 2023 08:15:20 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	peterz@infradead.org
Subject: Re: [PATCH v3] cxl: Add cxl_region_rwsem around commit_end write
 during decoder enumeration
Message-ID: <20231130161520.qccw5npmfw7jvguj@offworld>
References: <170025232811.2147250.16376901801315194121.stgit@djiang5-mobl3>
 <jhsumngltwjkwpa2o2ktxwjujmuzdzrza2m4fyd44ieva3l2ca@trrhklq6evtg>
 <655e75e929fc0_b2e829478@dwillia2-xfh.jf.intel.com.notmuch>
 <655ea49a7ce96_b2e8294c7@dwillia2-xfh.jf.intel.com.notmuch>
 <20231127173936.jyinrw7a4dtw7los@offworld>
 <6567dee739164_c3ae2941c@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6567dee739164_c3ae2941c@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20220429

On Wed, 29 Nov 2023, Dan Williams wrote:

>Converted this ^^^ into an "Acked-by: Davidlohr Bueso
><dave@stgolabs.net>" if that's alright.

Sure.

