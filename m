Received: from aye.elm.relay.mailchannels.net (aye.elm.relay.mailchannels.net [23.83.212.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEEF311946
	for <linux-cxl@vger.kernel.org>; Wed, 18 Mar 2026 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861085; cv=pass; b=Ykc1GgLh92WNBpVewAPdTwaTiXvo0urITjJPLQO19z/tZnkxF/2GtacUjYb9zOt2dabNpkuTJ52+eMf+Z2ONdJ3HmEf3QHHDWEwzqhpO/xvNpBB1eKYUzHYXQli31filvCCRzKrrAJxR826vzl1oX9qMTudreLEinTPydF7uxPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861085; c=relaxed/simple;
	bh=40svH7ULHSjjMizof4BtDqM9ajgN1EmZ8e64/Ab8m9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YTK2t9QQYkgMFQAgXPJ97fqALBsxbSDBIdqZtcs0IK+4KTHOjMPKPC1zL3oynMtLo8QcRU7wDen+oXx6By/LY9/s0CsFsZLzRs/oNzvZdE22wc37cidxmAGFsB3QrFTaAEYNlLQwobMgrD1d78o2kPOttLvbINrAhne5yHQwng4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=mOMXz4nu; arc=pass smtp.client-ip=23.83.212.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="mOMXz4nu"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E08874C3637;
	Wed, 18 Mar 2026 18:55:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (100-117-57-254.trex-nlb.outbound.svc.cluster.local [100.117.57.254])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 905094C3868;
	Wed, 18 Mar 2026 18:55:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1773860123;
	b=12qW9zgpXzBm40hjxFvVZQ8BJVHR7KfcMvdmX2gEIyBm6KTleb1c/KCQL4mfoQijIEzILv
	q9xKD9JWAq1IyOqGLqj8aaNIlb6ve1ySCbkTYfX9+wdULXpZfu6kf4ED91cI25vgr/8pNE
	RPNiQM2dE/d5sNsu7ENP/JyJ2HmaMhhp+PyHuph4rn5KO5hEcKmGgYGfj9tKXko5ghkc1O
	1iNjJSKX+vZ8Jknmedla4x7WhRq6Qi/743nFv1wkuDHLviW+ClcKB2Lp0VgEEESxAbWah5
	D0RXqfY8H9+9Ml6z/xmhBdgxQfjsrhVecXB97J9RHj2a1nZ/srUk9iMmEkU8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1773860123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=FxF3AC/kTZqacub0KGcZN70llm2LI5A4Np3en7HHhW8=;
	b=W89UEYzwNYtxaT3Mp2smGBHMi62DpwHLLGq+/6nARG1ykoId2dh5Q/+k3PV15yRoFCrW+0
	mkhntW502Swt5JyKwwLa0FFD4t0XccVJARuIkcpRswBxh0XaFfVkmSTdNTZKNoAswXXCN9
	mbe0wYEoXZYnXukNUoWNlty8Vc9w5wZfLGjIv96jivqBmuhpeIn7BJCTrw8wlOsno+DSgg
	C21y81QkaWhEz0xv2MsklF/hIEDTlAtrXvm5hTallmkN+7dH8Erv7e9UsaIyvNWYAbhEif
	obWrHpkus46U1Ud5DRAEKco+zK3Grxacyl3HtAXqPOlM6NSvm2nyXersAyJHfA==
ARC-Authentication-Results: i=1;
	rspamd-6d4cb6745-2x4br;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Army-Ski: 2ef823ea0cff0c2f_1773860123802_2105714562
X-MC-Loop-Signature: 1773860123802:1021080898
X-MC-Ingress-Time: 1773860123802
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.57.254 (trex/7.1.5);
	Wed, 18 Mar 2026 18:55:23 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4fbdLg07nWz1079;
	Wed, 18 Mar 2026 11:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1773860123;
	bh=FxF3AC/kTZqacub0KGcZN70llm2LI5A4Np3en7HHhW8=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=mOMXz4nu7PRuJ452Di2+Ci1foY1W8eI/jhi+L0h8Cu+s/LzR27YyI/YCo8oh32woT
	 wr6wzmk00HqPzM/WXZw3RyaN4I08IVnORLw7RirtTLa5BfyI+pU3cX/pYiaZLEyoZP
	 ZkSlwKOkGGeDlxXGGdmHfHtGvKC80vENqerS8o/7gj47cZ+DBWKaeuLkcdaQo2Foon
	 45msNC/jqKlPArUxCB3MtWOCCyh6o48DrvYj8E29RXFYI0P89pT8is6kmi5LKpC940
	 RaC/r7yOuda616U7uPY6KXzuEorxNQRtSzEfwhwY4L6Tcla3S+pGUJ+uZHXCVVEiJ7
	 D11LuwKe4jQng==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH v2 -qemu 0/2] hw/cxl: Media Operation Discovery fixlets
Date: Wed, 18 Mar 2026 11:55:06 -0700
Message-Id: <20260318185508.3683044-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Changes from v1: cleaned up comments in patch 2.

While working on the driver side of this, I tripped on two qemu issues
around discovery semantics. I think this is the first time these code
paths are exercised.

Applies against 'cxl-2026-01-09-draft'.

Thanks!

Davidlohr Bueso (2):
  hw/cxl: Respect Media Operation max ops discovery semantics
  hw/cxl: Exclude Discovery from Media Operation Discovery output

 hw/cxl/cxl-mailbox-utils.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

--
2.39.5

