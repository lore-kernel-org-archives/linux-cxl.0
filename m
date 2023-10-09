Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A51200AC
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="kELWIusD"
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3BF92
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 13:48:35 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EA69E801CA8;
	Mon,  9 Oct 2023 20:48:34 +0000 (UTC)
Received: from pdx1-sub0-mail-a290.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 82F208012AA;
	Mon,  9 Oct 2023 20:48:34 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696884514; a=rsa-sha256;
	cv=none;
	b=xRQiGL1xlcnBvBIMfKJxxj64ikBKYN7Zyf1sDcj5Y6hS+ApYGAi/MWVQWtaNJpyMOgEPDQ
	uzAM5uXHiaLgoLV7DOD0w/gwpyYiW/DUkr7BuhuPUyXr8q9e9iAlbqF83gx3+waE/RxS9h
	Yl76t/JP9wY3qKoPZ80hKxzkUv948hv5s1FNWX/59Fb/Y0GnFQnHkXUAdhr6bz3KOC6OUq
	FJVBebcvvdN3txhBoKCFQarVld6XhuRnQ9CpcX3NitNk2pZ4V4TgDJSlSnOvKKSswK/fij
	f+V2x0i44B1JfT+sgTMyisrXDScA9GDJ1qvCIlHk/wDnIjOve49MRO493VY8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1696884514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=mgppq76jWPeViiYHITbO1mesVJEVPSawd9gcbrhagvQ=;
	b=YwOK8hFRqxS1I5jxoK7LKZIQIYQJXM0zSHiwvTEWiTifVgKv4TxnhZCJ12SppWsj4rbJao
	UafUQmtAEufFdXxI2OR+XfTrX7mE06MTf+0Pu7Um4py6UQa+cKwFfnRRQRMIk78cEogURW
	bXPrFDCYk2wlktrcDkeUh4WPvmLji3N1y9pjk8uQGVABojcL6x+oaS13Fa6Pg6PX/oc1vO
	E5OL+v0iqLIODiyHOIUGFsWTbut//j8UZvkKIc/ZlHbhEvknWxEc/nqhYWyQssExCRjhx9
	8Erszrsn7nXKRmpwgkITp1YKj9uihQEHrm1WiF4RHa2fraPy815v/xqgJud2vw==
ARC-Authentication-Results: i=1;
	rspamd-7c449d4847-z9tmm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Relation-Turn: 167b1d156d6977c7_1696884514795_1546538541
X-MC-Loop-Signature: 1696884514795:3904043542
X-MC-Ingress-Time: 1696884514794
Received: from pdx1-sub0-mail-a290.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.66.73 (trex/6.9.1);
	Mon, 09 Oct 2023 20:48:34 +0000
Received: from offworld (unknown [172.56.177.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a290.dreamhost.com (Postfix) with ESMTPSA id 4S4B2T6Tlhz6G;
	Mon,  9 Oct 2023 13:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1696884514;
	bh=mgppq76jWPeViiYHITbO1mesVJEVPSawd9gcbrhagvQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=kELWIusDWaRTnmNnUiD8597DMgyjbzYLV4fU3UZveG54Awaw15OF2opOu1SMQw2iU
	 xzsTTzrwxZQjcUBzTI5B/ZhG9DdpT6U703O0WnnqLNfYRf8XIpGGFBu2vI/Rvd6ove
	 4NRGI/wd7qq4UZ2jMWIfVISgnlS8mRv+bqf9osPiIK01FRaxFuMZtvI56BjO6Y78RX
	 K70/2PajP0ff18BG6Mv+J2Avlhg6YpMHy6j5N50KfUVw0XLnhm5X4E13+7xidUeADj
	 5odF9f6uXRPCdCob7DKaA1IRcYb+Dug0ORo7AKJyrUsIwSNJIo7dmHigCs1bgHfDvE
	 +YGbAzc24uxaw==
Date: Mon, 9 Oct 2023 13:48:29 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 02/10] cxl/pci: Cleanup 'sanitize' to always poll
Message-ID: <qtpwbofev67y27ttehmu4frfojmiujllibtqifo2bix5vbb77q@ihhuaspo5p5p>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657717034.1491153.300696666588880104.stgit@dwillia2-xfh.jf.intel.com>
 <afq4tt4xhgecfhhi2k3hllxn3lj4j6j5tl6seknxp7i4xurjb5@vxgvams6smni>
 <652448ed101af_ae7e72943f@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <652448ed101af_ae7e72943f@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 09 Oct 2023, Dan Williams wrote:

>Davidlohr Bueso wrote:
>> On Fri, 06 Oct 2023, Dan Williams wrote:
>>
>> >In preparation for fixing the init/teardown of the 'sanitize' workqueue
>> >and sysfs notification mechanism, arrange for cxl_mbox_sanitize_work()
>> >to be the single location where the sysfs attribute is notified. With
>> >that change there is no distinction between polled mode and interrupt
>> >mode. All the interrupt does is accelerate the polling interval.
>> >
>> >The change to check for "mds->security.sanitize_node" under the lock is
>> >there to ensure that the interrupt, the work routine and the
>> >setup/teardown code can all have a consistent view of the registered
>> >notifier and the workqueue state. I.e. the expectation is that the
>> >interrupt is live past the point that the sanitize sysfs attribute is
>> >published, and it may race teardown, so it must be consulted under a
>> >lock. Given that new locking requirement, cxl_pci_mbox_irq() is moved
>> >from hard to thread irq context.
>> >
>> >Lastly, some opportunistic replacements of
>> >"queue_delayed_work(system_wq, ...)", which is just open coded
>> >schedule_delayed_work(), are included.
>>
>> So the current order of this patch will cause bisection issues -
>> the next patch which moves the irq handler to a threaded context
>> should come before this one. Otherwise:
>
>
>This patch does switch the order:

Yes, you are right.

>...did I miss anything?

Nope.

Thanks,
Davidlohr
