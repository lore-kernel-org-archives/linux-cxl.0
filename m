Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1333A2F872
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jun 2026 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780878815; cv=none; b=Od0qZmil41Jhf4Ji5XdyHiKcM59P584bGzgE6mUAwQ9Kyi6hTddfvvuvfS9GPnI+JWbSFALsWeMXTnnyccOoYeqtGadKadXBI+D7Cou7hCws1Fiiw9AalTv4r3xfLI42I/QsewkIf+teSu3V1voagFZOzdBU4tNaM+o3pnz/Yp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780878815; c=relaxed/simple;
	bh=yXMg9NNRaAzwiz5SkATg+Ly+ZP1dU3Vw/Zg3xpTDwY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z53SY9pfl9xBqftqK6LbDu01y1eZ+bJZwphz+4GIa2/uLZO8JA+UFU3IHam3Z3AJ1usUHVU6PzkKD/YfD2s8Inwydpxl73oQg3tTwmF8UyLgQtZmur0ttYY7yIOxPfwupqcgjGSrk2z0tP5j2r6ryGaXADs/QA6lc1gIhyDvoB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=oi95RGO3; arc=none smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="oi95RGO3"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6A008941747;
	Mon, 08 Jun 2026 00:33:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a252.dreamhost.com (trex-green-4.trex.outbound.svc.cluster.local [100.116.171.68])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0DD8C9416D9;
	Mon, 08 Jun 2026 00:33:31 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Quick-Power: 304673fb7ee62df2_1780878811278_3752733523
X-MC-Loop-Signature: 1780878811278:3653208989
X-MC-Ingress-Time: 1780878811277
Received: from pdx1-sub0-mail-a252.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.116.171.68 (trex/7.1.5);
	Mon, 08 Jun 2026 00:33:31 +0000
Received: from offworld (186-79-212-212.fo.baf.movistar.cl [186.79.212.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a252.dreamhost.com (Postfix) with ESMTPSA id 4gYY1P3J7SzyrG;
	Sun,  7 Jun 2026 17:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780878810;
	bh=teJnluGo6zFTpPmNlw8CFvduNjORzm806J372k0Jg0w=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=oi95RGO3tt3wXw5Jg8MX2o3SBmNylaN0pEwSuOevSSDOAC/FCtouZ6EVvVWELx8wz
	 mdlCwN/DqDeAy/X8qOFvu8odf97BjT745aWLDfZJFIO9HS3EfM9AM2LzBy9cvFCUZT
	 EDIN/ZMBak8yl7WngoD5gvaKqXuttGf9o8wZxOvTVtmz7vBopI4laRBAgEAtJW6Y0z
	 eqnPBkgYor50cMBWEZVuPa2QmoLg7C1EgP1bu3P1fy3vwHdKBO9ZipsOWMK9FuZhuz
	 GVE3wScxHeGgvpSSM7IwpRfwH/jSrrb/dKLMgE8LEgNr3/c9agfqBbwJYzbx86kMYj
	 9qslV6GKE3lcQ==
Date: Sun, 7 Jun 2026 17:33:23 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: sashiko-reviews@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/5] cxl: Add BI register probing and port initialization
Message-ID: <20260608003323.lsja233dvqltwjqm@offworld>
References: <20260605003329.2584012-2-dave@stgolabs.net>
 <20260605013307.DA9421F00898@smtp.kernel.org>
 <aiItL9wmNPDafyFG@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aiItL9wmNPDafyFG@MWDK4CY14F>
User-Agent: NeoMutt/20220429

On Fri, 05 Jun 2026, Richard Cheng wrote:

>On Fri, Jun 05, 2026 at 01:33:07AM +0800, sashiko-bot@kernel.org wrote:
>Hi Davidlohr,
>
>cxl_port_map_bi() is called here before any dport exists.
>Component register discovery happends later in cxl_port_add_dport() and then
>cxl_port_setup_regs() on the first dport.
>
>So for switch USP, bi_rt.valid is false at probe time, mapping is skipped
>and never retried. I saw from your cover letter's dmesg
>
>"""
>cxl_port port2: BI RT registers not found   ??? probe-time map_bi
>...
>cxl_port port2: found BI RT capability      ??? later, on first dport
>"""
>
>Endpoints and RP/DSP paths are fine, but switch BI RT mapping might
>be the gap.
>
>Let me know what you think, please correct me if I'm wrong, thanks

Bleh, indeed, thanks! I moved this from an earlier version.
The below fixes this, and we now get:

[    0.760688] cxl_core:cxl_probe_component_regs:102: cxl_pci 0000:0f:00.0: found BI Decoder capability (0xab4)
[    0.872325] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0c:00.0: found BI Decoder capability (0xab4)
[    0.888387] cxl_core:cxl_probe_component_regs:96: cxl_port port2: found BI RT capability (0xaa8)
[    0.924125] cxl_core:cxl_probe_component_regs:102: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
[    1.087716] cxl_core:__cxl_bi_wait_commit:995: pcieport 0000:0e:00.0: BI-ID commit wait took 114533us
[    1.288190] cxl_core:__cxl_bi_wait_commit:995: cxl_port port2: BI-ID commit wait took 200377us
[    1.292282] cxl_core:__cxl_bi_ctrl_endpoint:1164: cxl_pci 0000:0f:00.0: BI requests enabled


diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 2dd712c5d312..ca8d8c14b787 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -122,8 +122,6 @@ static int cxl_switch_port_probe(struct cxl_port *port)
         /* Cache the data early to ensure is_visible() works */
         read_cdat_data(port);
  
-       cxl_port_map_bi(port);
-
         return 0;
  }
  
@@ -312,6 +310,8 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
                  * on failure, or the device does not implement RAS registers.
                  */
                 devm_cxl_port_ras_setup(port);
+
+               cxl_port_map_bi(port);
         }
  
         dport = devm_cxl_add_dport_by_dev(port, dport_dev);

