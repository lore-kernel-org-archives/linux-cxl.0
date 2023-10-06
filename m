Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924D0450C8
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 22:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="mnroMriT"
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF24C2
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 15:06:05 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 14F6F9011C8;
	Fri,  6 Oct 2023 22:06:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a290.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A471390091E;
	Fri,  6 Oct 2023 22:06:04 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696629964; a=rsa-sha256;
	cv=none;
	b=rnmfGszTni3FTn5Q+7DkfXxf0BvejjqDPfUVnC9GfQsNsZR8GLbU0cqos3vQNx1TR657KT
	WyWXAOmhvAH7D06tZrX7Y7XJSOg7TjH34mdwPsz31PB1lhNy08nY/Xr2WDxhGRMtqbo5ku
	K8SW9EzWQN3GIqYWea7n8e13OJ03gOif/CQchive3zi+DrNQoDoVo0YTel7whqP8h7QBBu
	yQojWPIgTUki1CutbJckZfJeeZQ0Quv8heuNPJ2QlcTfzuSpD5EUSdiPss8e+VURKuDw08
	1eaMWHyLj8yJH+d23sb44ko2vVwQ38fgvyUk28IL/tMihKEf17WmA4jG4I9M0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1696629964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JItpN06Wh25TwKPvBlAbv/AwfAuy+Nb5vduoX+Igngk=;
	b=XIfF0RlisMJDt7NXuupiGyksWwzENqfDpl8zG6N8u9m8xKIRHaSDvOzj53xfSlVJsk0rvu
	rBOsWj5rrekeYZx0WujINTK7dhHX+uacXafPyrO889gYyL5Hj5uz/pnFvBSZW8408dsniE
	sfW8pYyqOhB2JfXzsF8NIOcojHX9ORrHAy4OcFtmwcVotcUb4Vqh0qqFD6aqOLuEkeE9oT
	6i1yttc24Bae0JXflRZW1iBm17AWX/O+Ki0ow5jHuZQrkH3WlIU7o3YK46SG0Mvm/CQADQ
	L/O6agKS7CKRkCYGAWbZY8X9kz+BGMgLz653noGUYugEQRwRFVzYiE25ePag9Q==
ARC-Authentication-Results: i=1;
	rspamd-7d5dc8fd68-4jf74;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Reaction-Abortive: 5f82616511c6647c_1696629964895_135213354
X-MC-Loop-Signature: 1696629964895:3802750041
X-MC-Ingress-Time: 1696629964895
Received: from pdx1-sub0-mail-a290.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.112.206 (trex/6.9.1);
	Fri, 06 Oct 2023 22:06:04 +0000
Received: from offworld (47-158-7-114.lsan.ca.frontiernet.net [47.158.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a290.dreamhost.com (Postfix) with ESMTPSA id 4S2MvJ2Mf8z2J;
	Fri,  6 Oct 2023 15:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1696629964;
	bh=JItpN06Wh25TwKPvBlAbv/AwfAuy+Nb5vduoX+Igngk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=mnroMriTTghZ4+vFDgGDPdf8zNtw4p/k3lIpvsdctkd0ADM4LcPLSUjmxDNt196Cg
	 zWVhTVWLaJUo6WJVZu0sjfeTyar/FRMFDyrp/4LGZ+TLJatbFHmqU9tl6wW7CPPmIp
	 HTb6nQvfckkuLm0he8dk/UtBNCKbHjp2ihk12TXkW9mJnBtMEgGJ9+5sSgTuv0nhne
	 cMpQ2u3EyBe4pEsyZutU2J1tnR3oE0Dv0ykYhwX9h3YdUfwIuJrj0hx2lXwu+tDtFT
	 T8tujWMRMoKJ7Y1eJ96WIfLwNSWZgm1yDxTyrKjEn8pRu0xgnLSLuQtD3482XBomCx
	 Bt0g2jm+oVeDA==
Date: Fri, 6 Oct 2023 15:06:00 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 03/10] cxl/pci: Remove hardirq handler for
 cxl_request_irq()
Message-ID: <lde3jgrejg2twocwtql5m75wbfbuhanvbbv2cajj5p25k6lhkr@g3hwdeqwmm5o>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657717635.1491153.10040969889268437662.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <169657717635.1491153.10040969889268437662.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 06 Oct 2023, Dan Williams wrote:

>Now that all callers of cxl_request_irq() are using threaded irqs, drop
>the hardirq handler option.
>
>Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
