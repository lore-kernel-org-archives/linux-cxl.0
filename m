Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A746C347D0
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="GzoGmUt7"
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8E193
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 11:08:08 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 86821541838;
	Mon,  9 Oct 2023 18:08:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 081AC5418FB;
	Mon,  9 Oct 2023 18:08:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696874887; a=rsa-sha256;
	cv=none;
	b=5IiBeicOXseKpLQWH1QGrTn0HDAaXow92hajzi/13kKyKMFSN4t+YsXI3ZxKyqdQzv/8j4
	9fyx6efFt+nugp6NBbGV3tJN+dJUwRH5gAuXGVX6cnqdN9NbUAbpodNcg1SWpo4Lyg9CVY
	SNqljA5DUUk4g31nIcajHurRbBdlJVaVDNG5cs5YTB3VlayeXQ3kj0Nk4RVO5ShVWIyLI9
	xIn12bTl+vvZu3F6b2kWu0RdFhPjZzzwvy2MK7aGROwYkpSrsX4KGuk8m8uwkl1QazPWb1
	W1GBR4ivywzb0pY/JTF5WlUQxcawsMbt84/Wa3xdlF4Tpay+yushezEeh0xaXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1696874887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fKnWL6hfVqVU/YX9m5/AKgzLUo9Tkd8luS5GBEqQXME=;
	b=4CWqVM5EYJJQN5a2tHyhMSzArqFuMoOx6e92c2vIOgqXRn0RGWBO9a8nZxm8b+Q5gek4Bo
	44dv2ud7TYeLQTFm8mwAOYR6F+z6F2iTHdTNpiXem5ghZk28/s2KYMaxhGv4a03xkCgWd9
	8GmCJ4lcAyPwmvdZhlobt3YmpYCfZdvbCBK9/oGkuc6mqfe4hO3IFrqxUkC4vtXDU68Cyl
	8dO2/0NZD7VR9Y38kE9skIABvXsQ0rMq4FIi7y6rj7eGMhex8DCw25ZMZALDa2azEyEbXb
	VcAp53r8+dkWJ4WuPrSA8i4pIB8nFHz/DggWj1623tuoBbeJIetdIfswh9yoQQ==
ARC-Authentication-Results: i=1;
	rspamd-7c449d4847-pb4gd;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whispering-Whispering: 0946ed1051764628_1696874887314_148934865
X-MC-Loop-Signature: 1696874887314:1320291559
X-MC-Ingress-Time: 1696874887314
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.66.73 (trex/6.9.1);
	Mon, 09 Oct 2023 18:08:07 +0000
Received: from offworld (unknown [172.56.177.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4S46TL21vVzP6;
	Mon,  9 Oct 2023 11:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1696874886;
	bh=fKnWL6hfVqVU/YX9m5/AKgzLUo9Tkd8luS5GBEqQXME=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=GzoGmUt73T3erkH3nGCaB/kLBlANh8ntebn6f8mcip9c+hoeCAkHyAU77+EMzRS8r
	 DLe9+xXELu/S0BBKkc1YjQkMD/JdyfPRFsh5RwwPtVVKC5GnpmHoNP8v+e4ZE41u1w
	 w79eYilAwLu7Qha+LEC6IP1yV9RFnNl0RtEiWeQVzosLxC5DCMbkhT6egl1tFDbwe4
	 bpTZoji0Kq7P2AN8zEea7VKDyrOpWLxiBBCKkmKwX9w7oru1GHgX/N9gzQ4buNhrJp
	 0Tl82Vtur79ITOLpxFBKfVONwFD+jNr2Ufv2eA8bZ7iUad7ihRIG3zuEYD0UF28umO
	 riiYYJ9X0bQwA==
Date: Mon, 9 Oct 2023 11:08:02 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 06/10] cxl/pci: Fix sanitize notifier setup
Message-ID: <aytjsewyzog3ixcvvfqaonwcqayv6vtvrf4ljrdefeqsbrhon4@s5lmxji3y7za>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657719381.1491153.1571837747024067070.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <169657719381.1491153.1571837747024067070.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 06 Oct 2023, Dan Williams wrote:

>Fix a race condition between the mailbox-background command interrupt
>firing and the security-state sysfs attribute being removed.
>
>The race is difficult to see due to the awkward placement of the
>sanitize-notifier setup code and the multiple places the teardown calls
>are made, cxl_memdev_security_init() and cxl_memdev_security_shutdown().
>
>Unify setup in one place, cxl_sanitize_setup_notifier(). Arrange for
>the paired cxl_sanitize_teardown_notifier() to safely quiet the notifier
>and let the cxl_memdev + irq be unregistered later in the flow.
>
>Note: The special wrinkle of the sanitize notifier is that it interacts
>with interrupts, which are enabled early in the flow, and it interacts
>with memdev sysfs which is not initialized until late in the flow. Hence
>why this setup routine takes an @cxlmd argument, and not just @mds.
>
>This fix is also needed as a preparation fix for a memdev unregistration
>crash.
>
>Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
>Closes: http://lore.kernel.org/r/20230929100316.00004546@Huawei.com
>Cc: Dave Jiang <dave.jiang@intel.com>
>Cc: Davidlohr Bueso <dave@stgolabs.net>
>Fixes: 0c36b6ad436a ("cxl/mbox: Add sanitization handling machinery")
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
