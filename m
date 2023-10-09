Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94340134BE
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="h1Wzj6wv"
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A1AB9
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 10:19:30 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5A6201421CB;
	Mon,  9 Oct 2023 17:19:29 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id CFEA31419DB;
	Mon,  9 Oct 2023 17:19:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696871969; a=rsa-sha256;
	cv=none;
	b=VI2qYft+L/sbjIVe1AA6uk3o/BVoIgCNlRGhoC14PBIDBhaGMhZZYiWPPHNghd2bNvBl65
	9AvJm+RnxnRSpUgQE98Miz9VkqwfIbESq4MqkOlDxHDHMjghZEVgShT+Yf69Pvn9q8WzSw
	4+jyHmhRbF4Up7dn22XX2hgyieKYPgeaCXhX3Ko6EJKoEYenCvLhly0/u2VNrO5j81thfK
	QZpQvstD8PtjSKGfQV2/6TVd32bjiC9V+9mog3kiPtJ6+2UZcagsdsFRyfi2j4eUmi6HOs
	y+HFGrYZY4qAq8j7nypDakM05iShifTa2QsV4veZ0WhOvx4OCkuq3lfvw5jtNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1696871969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8hITGJVEhvJZuN8NwPQTLlAYoMz8crxMP0ek/rS/2vI=;
	b=iNJz6Rwz5ICYL4wcEF+RLe+Cc6CO9/AKog0h9p9epGGS9lx2nOLMqv6CXP7um9SwjhG+yK
	dxINaOCnT6bvq5QLJso6+QTL7+MXcR7PexzHwkd7y7lMjZI4h4Nv3CbRtVpLfs5qjdQCFu
	BAjYr7y2bpM5BZqgCMzz4y62PXTgxZdqTn2i45DiZlldS1qNJEHDTcXe0IM3dk8/EHDQdT
	GbZmYyBtql2RBRVvOSksuwskoyUm3EPpzjkKQ+eOgeCUFXKkJRn0dhNAG6TRtaN8Eele6M
	WZ0hFBf3udqDE0WwJAUwZfILOQm9DvGotmqWHJOq3o79/2xOby025qX/ym9aYg==
ARC-Authentication-Results: i=1;
	rspamd-7c449d4847-zgl4f;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Callous-Supply: 67bf2969074189cb_1696871969196_420326583
X-MC-Loop-Signature: 1696871969196:1662526628
X-MC-Ingress-Time: 1696871969196
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.108.167 (trex/6.9.1);
	Mon, 09 Oct 2023 17:19:29 +0000
Received: from offworld (unknown [172.56.176.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4S45PD0VC6z6g;
	Mon,  9 Oct 2023 10:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1696871968;
	bh=8hITGJVEhvJZuN8NwPQTLlAYoMz8crxMP0ek/rS/2vI=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=h1Wzj6wvjSmEh9tUPu896pG4hyXGJpBRTzzb13wvrGEkNI5GFI+UBAtqb1vpz4+e8
	 nSshqx6rDv4TagbxmhKqCox9rgwTHahuLPEq47D04kObKL1dOHP9PmX4yZnkRmsFPc
	 yz4GUqmlgDuW7NGfxoU7idZc2U8RLM4dBk5scDcmpsAvNiXbGRjL5QMrliHmNjqC4M
	 EBRLv44Rxwxe3h31qVFg7DIgP6N0QpYz6HX6oeDQBUdN8CZ4DLVxk5MoxTCMnjI9k9
	 32MVQoP1/JiaHCy+eDvp7GrrZw1IL3JSGrbIemOC2E/RJA0+meTUnmtnG3Zffd1d1A
	 67qzKhaENFWhg==
Date: Mon, 9 Oct 2023 10:19:24 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 02/10] cxl/pci: Cleanup 'sanitize' to always poll
Message-ID: <afq4tt4xhgecfhhi2k3hllxn3lj4j6j5tl6seknxp7i4xurjb5@vxgvams6smni>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657717034.1491153.300696666588880104.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <169657717034.1491153.300696666588880104.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 06 Oct 2023, Dan Williams wrote:

>In preparation for fixing the init/teardown of the 'sanitize' workqueue
>and sysfs notification mechanism, arrange for cxl_mbox_sanitize_work()
>to be the single location where the sysfs attribute is notified. With
>that change there is no distinction between polled mode and interrupt
>mode. All the interrupt does is accelerate the polling interval.
>
>The change to check for "mds->security.sanitize_node" under the lock is
>there to ensure that the interrupt, the work routine and the
>setup/teardown code can all have a consistent view of the registered
>notifier and the workqueue state. I.e. the expectation is that the
>interrupt is live past the point that the sanitize sysfs attribute is
>published, and it may race teardown, so it must be consulted under a
>lock. Given that new locking requirement, cxl_pci_mbox_irq() is moved
>from hard to thread irq context.
>
>Lastly, some opportunistic replacements of
>"queue_delayed_work(system_wq, ...)", which is just open coded
>schedule_delayed_work(), are included.

So the current order of this patch will cause bisection issues -
the next patch which moves the irq handler to a threaded context
should come before this one. Otherwise:

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
