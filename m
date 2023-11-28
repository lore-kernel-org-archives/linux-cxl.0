Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="g865j1E5"
Received: from snail.cherry.relay.mailchannels.net (snail.cherry.relay.mailchannels.net [23.83.223.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6C11B8
	for <linux-cxl@vger.kernel.org>; Mon, 27 Nov 2023 16:58:43 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B98ED803832;
	Tue, 28 Nov 2023 00:58:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a293.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 49DD6801079;
	Tue, 28 Nov 2023 00:58:42 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1701133122; a=rsa-sha256;
	cv=none;
	b=hWnUTgAzR7NBuJr0AeGkrXG2Gm10fJ4MgS6dpEOH9r9H2w/FB0iaLCZZZH8/n4eJ7BdBiF
	SvFqnap8sPbUTEhUPOiQHgmNKRm4cOV7sVrNRXrID8QreYGVuTaq+9TT3qEQFSop9BMmFg
	kNag1MsyDT55WlzBqE8vH9fBXu6GO1dndTndAfHjhsB5RsH0DtC38TWjX3s62ipe376v3w
	xHcdfbO1wQZsuZXeKYteUWRzhQ7d+Y2IzED28Xquu468wgy1jUMc3LYL1gz2iH1ZM42hBX
	fvbpwYL8KTZJV7Xp2B/ZS3Oe+3Ma6cKFN/oZVblQRv1Md+a8A5IwuXay84Ut+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1701133122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2XUP3QpS7H8873FUeTF1Ik2sX9PdiMq3x2TpV75CeqU=;
	b=tSHGD5dyKWDnxM7851ejv+tMI/O7JrXXUeGDyktsI5ROtOVAO0oH7FfSg2jT7KGWKDyR0U
	cnxAfGYDzWhCahBpn9XsB8CHpNF5pEt7oC7dDGvXyA2VsgLE7p17d8noAH04c34b2WR59K
	KX34HqhGP/KhjVG9W0tum1I4MxFqt0KPzkNa1q41O/lu10zd2lTNKM/YsRSyqIzg/HcFjF
	xkRGB5vO/7PR6qF4z3kQJ8Qhgzbo4f9lkqXn9/bPT4g7PoUVwlpds9h2MRetArikhqO7U3
	VJaiAVSmf4FBD6cHomNiBDYq+5HWSHplYnvqaFaiONnZtCPPhpet/ktuASEMuw==
ARC-Authentication-Results: i=1;
	rspamd-d88d8bd54-fm8lm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Relation-Blushing: 06ee0cc0598f637d_1701133122454_1965049341
X-MC-Loop-Signature: 1701133122454:3952728191
X-MC-Ingress-Time: 1701133122453
Received: from pdx1-sub0-mail-a293.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.120.2.6 (trex/6.9.2);
	Tue, 28 Nov 2023 00:58:42 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a293.dreamhost.com (Postfix) with ESMTPSA id 4SfPGP0KFvzDY;
	Mon, 27 Nov 2023 16:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1701133117;
	bh=2XUP3QpS7H8873FUeTF1Ik2sX9PdiMq3x2TpV75CeqU=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=g865j1E5ktbRAzSo6cV+LwIl26y+dmGSeCpsgJe3bzHFRZYX2anZyrsZUlOei0Z5C
	 vhqtnmeDxTuO9snGItoqYp5b8xhmkP7r6Hv1ZKPZdPa1PuWPYPepmX0QpKWZ2rNGmg
	 3mk8bs5G7zhAnO6mRrjTXzzoQbe3czy5PblO2PprQUbaSGBwtRQ3yRaO/VgqKyndzG
	 Vp9bNxCqFFS1kFJdL5diGQRRzmnEB1JMTzFQRiXUCky/W4IG2l2aZkWFEVyL/X+Zgd
	 Oluffa9Jvew5C1yi/49M5iOageEL+mIStIJpBBw1yV3M56g0e//BaNbNvKi78XNAis
	 jrEvCiOC40grg==
Date: Mon, 27 Nov 2023 16:58:33 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: alison.schofield@intel.com
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/2] cxl/memdev: Hold region_rwsem during inject and
 clear poison ops
Message-ID: <20231128005833.jbmpvpvgwbroslqp@offworld>
References: <cover.1701041440.git.alison.schofield@intel.com>
 <08721dc1df0a51e4e38fecd02425c3475912dfd5.1701041440.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <08721dc1df0a51e4e38fecd02425c3475912dfd5.1701041440.git.alison.schofield@intel.com>
User-Agent: NeoMutt/20220429

On Sun, 26 Nov 2023, alison.schofield@intel.com wrote:

>From: Alison Schofield <alison.schofield@intel.com>
>
>Poison inject and clear are supported via debugfs where a privileged
>user can inject and clear poison to a device physical address.
>
>Commit 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper")
>added a lockdep assert that highlighted a gap in poison inject and
>clear functions where holding the dpa_rwsem does not assure that a
>a DPA is not added to a region.
>
>The impact for inject and clear is that if the DPA address being
>injected or cleared has been attached to a region, but not yet
>committed, the dev_dbg() message intended to alert the debug user
>that they are acting on a mapped address is not emitted. Also, the
>cxl_poison trace event that serves as a log of the inject and clear
>activity will not include region info.
>
>Close this gap by snapshotting an unchangeable region state during
>poison inject and clear operations. That means holding both the
>region_rwsem and the dpa_rwsem during the inject and clear ops.
>
>Fixes: d2fbc4865802 ("cxl/memdev: Add support for the Inject Poison mailbox command")
>Fixes: 9690b07748d1 ("cxl/memdev: Add support for the Clear Poison mailbox command")
>Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
