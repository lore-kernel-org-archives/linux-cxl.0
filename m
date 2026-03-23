Received: from caracal.birch.relay.mailchannels.net (caracal.birch.relay.mailchannels.net [23.83.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2503E51FF
	for <linux-cxl@vger.kernel.org>; Mon, 23 Mar 2026 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774298985; cv=pass; b=oMF50pnnldmS+N0738CHtQLtI3MGJtogDE5DCqE0wowEs63ymNKNVTNssjxiYF3bYz0Vkaz+J45/bypUofZfA8us3hOqhlJFl2v8IU/VFUEPFLUKCfO+Wofk5G+BDTFbRG4qr+xXPWR+noi9+p0rz9yuEx7Iyx2iNO81DLwZOAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774298985; c=relaxed/simple;
	bh=FVnYnHsbHciGfQV6cFJsU7MwMMGsVV1CPM7CMSThMaA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qfoT+Z+6zFcA5om2FO1rzDzzuOmB4dR9UNpXhaQWa0kfQNE/uP56MzJaKdzZSHKwIB7MlUYcQSLbYzYeKzidkqr8D23s0MfVgouImU3uVA51fBWQtHJ5Vi4vuyF60j1HT8cu29oQfLiq+njlkyGxJ0pA3VtZOnJDjpYXAmuysCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=k0aJS5w2; arc=pass smtp.client-ip=23.83.209.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="k0aJS5w2"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 453BB82238E;
	Mon, 23 Mar 2026 20:40:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a255.dreamhost.com (100-115-97-34.trex-nlb.outbound.svc.cluster.local [100.115.97.34])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id CFE8E8223DB;
	Mon, 23 Mar 2026 20:40:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1774298426;
	b=OcbUV2kOOfNoOZWRgOPUp94Qoq1h1rQeQNEdR5sUh6JulvyVm54oNSAOb/XvwpVKReFvDP
	14RZ9mGpS07O0soN4ZcSKnoak/aVfPORIBUwFsaKqds0Uh8b797KphxgwY59e/lLzYAon4
	ZG0Psn8hCeaQiu/AzD9S2sNOtOb5buPky4Pd5sjRjasQnSCzHf1sou1tplcra4aTc+s+Bd
	KyI9LJeoE0p8/boXq0JnodDoxniWdeBQBWqRHWyWnDqhWGQTc8hqBICnI8dGUZeDidFDGw
	XScjAsCdXu/3MM41I+Zn3qlQ859QurkLFeGDGZkAAyhQvlJadbnyvso92nd4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1774298426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=SdQ1vnqmHtLWgxiSlKynd+zQIVdOXzvOfmfuTmnIUsE=;
	b=VjBvh9s2+mVVdVihVl3hJHIfMlhr0r0Edlfj+amTZbisQZWp+SFLrFfwMhcvlV7r5feJ/C
	TrD+TnV9QYWFApkWwcDuCQ3TNbIALsoR8VeBWeNDVLKbO7pkQGE5bxWk0t4SrQ+C1lGesK
	cF89/GzT3R/GSXEUNxgVNYGtyMCzyG9SyyuwWttheLk4oINX5kryPRk1b3URc7nyZRTMwO
	NR5Y1bVfCAKcAo/MC2F681KxZ0X7OXv5/XIA4HaQGCt9B1AaDGBL6YsD/smedNgPBYu/jd
	DEqTYbcUlOpHsNFsBDtXJvgH17KtFXt7VMNmEG4SIdgiglHq/BC218fW/Wd/Tw==
ARC-Authentication-Results: i=1;
	rspamd-7f98bb5847-nf8pj;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Illegal-Drop: 10bb59cf60cb508f_1774298427112_2791202610
X-MC-Loop-Signature: 1774298427112:2665710441
X-MC-Ingress-Time: 1774298427112
Received: from pdx1-sub0-mail-a255.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.115.97.34 (trex/7.1.5);
	Mon, 23 Mar 2026 20:40:27 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a255.dreamhost.com (Postfix) with ESMTPSA id 4fflRZ0mF8z104g;
	Mon, 23 Mar 2026 13:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1774298426;
	bh=SdQ1vnqmHtLWgxiSlKynd+zQIVdOXzvOfmfuTmnIUsE=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=k0aJS5w2pzU8fwLehr772iIngXrETiYQNLJnaH3SVlux611HVuSYjTNcDgB9+A3Ol
	 ajGg+KH3+U/p0X5etyDxokG8aaHcORq77yYpwx1j/IwmpXDH08V/nz31Oi4gf0lpLd
	 FtDjoPUSLw6pnzK1orrvlNel2eqFRaRA10rvTJrkCFDeVlejszG34yOh4FI4W2bdsb
	 5bzaPc2fkAEX9Q/n9dXlQWY4Qm57we9PeWQqa6JQRSoYtm5RLk8x2iyIS0iXROPoBT
	 TY1MM3NVqVd9MxGqS1clHVeuyydDRlK/NGAfvhNcvNQMP3UFdaLvwzbfce4BnFHjPY
	 GWyt3EIX7qTyw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	dongjoo.seo1@samsung.com,
	anisa.su@samsung.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [RFC PATCH 0/1] cxl: Media Operations
Date: Mon, 23 Mar 2026 13:40:12 -0700
Message-Id: <20260323204013.4010634-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This implements support for Media Operation cmd. It is marked RFC because of these
noteworthy points:

 (i) Sysfs interfaces. These changes implement 'security/zero' and multiplex
     'security/sanitize' to allow dpa, len pairs for the range (no impact for
     current usage as whole-device). This breaks the 1 value per file "rule",
     and would be a first for drivers/cxl/*, so am I open to suggestions.     
  
 (ii) Background cmd handling semantics. Media operations are synchronous,
      which for raged zeroing operations makes sense and for range sanitize
      differs from the current async handling for whole-device, so user response
      differs significantly, something I am not crazy about. Another downside
      of this is that it exposes lock hold times to be user-controllable, but is
      no different than what we do for fw. Fundamentally, users have the
      responsibility to break up the work into sane ranges. Further, this is
      without considering abortable bg cmds[0], which, per-spec, are unsupported
      today for media operations.

Tested with qemu + fixlets (https://lore.kernel.org/all/20260319184256.3762391-1-dave@stgolabs.net/)

Applies against latest 'next' from cxl.git.

[0] https://lore.kernel.org/all/20250617193611.564668-1-dave@stgolabs.net/

Thanks!

Davidlohr Bueso (1):
  cxl/mbox: Support Media Operation

 Documentation/ABI/testing/sysfs-bus-cxl |  31 +++-
 drivers/cxl/core/mbox.c                 | 235 ++++++++++++++++++++++++
 drivers/cxl/core/memdev.c               |  45 ++++-
 drivers/cxl/cxlmem.h                    |  59 ++++++
 drivers/cxl/pci.c                       |   4 +
 5 files changed, 369 insertions(+), 5 deletions(-)

--
2.39.5

