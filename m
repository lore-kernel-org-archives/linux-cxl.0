Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5CE25A650
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 04:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738728537; cv=pass; b=f9ANYUz5ePxlV8s4MEBdkZVzuKDiKU3wEtRecNtd+71UK40RE68MORCixiuyU+AxbLQWKWPEXDJDNeT9H6h6fwt27ab5ZkyjzrWied0uzOofz+NJ8OFJX/lCDiXg9LEL/i8kJ1YJCzVS+8exAJG0d0nyjD54JA1Y2n05i0b7R5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738728537; c=relaxed/simple;
	bh=8BDbf1KMpueUHChsBQvcnkH36tTFK6Hsn/jdZQXfySs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K6xU5oiRPMTtjI+bqyjwtdmTEfvjyEXnWyfeo1ncspNrpxTyoatTUP5nNjGqmddVv/5HHozEPkaI+84kvLiOFcWd+k8otLN3oLjbrALk1uuCw1KAAD9S0qrhQKxYDk5dIet9Zo3BL785x3dwfGH21YkQgzTwhe0xmsGTpVvpST8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=EVcIv889; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="EVcIv889"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F0BBE781F83;
	Wed,  5 Feb 2025 04:08:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a274.dreamhost.com (100-119-246-122.trex-nlb.outbound.svc.cluster.local [100.119.246.122])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 73AFA782D5B;
	Wed,  5 Feb 2025 04:08:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1738728527; a=rsa-sha256;
	cv=none;
	b=jtTEuAXUi/AWjHFekwXv2U0dZlx/IAKFDPVmMnm2SsQzfUPFZaMLc9d1DMdu+xdEqjB4TW
	QBqWE1bxNioh5zFOu+oNmuXIZj9Z2j+F3dMsJCzW1vGrdjLRa1XbApriqe2eD0wYsW0Hr6
	rwSnmoMmzYJwuH3ZVXNg0kXuPkbXaLozVZxHTpCyC5iwPJPgEBV0tiNNgQl0IAD8u31npJ
	6XKNSPuqnoKGnIOV4vEvW4DX5y5E6Y1lONNDKB/qgnFtXV3UkIG0VIkBbyipSGU4sVItdo
	iaCFBYYcFLa4JNHlQlAGVgR3BTM6OJSqDN5k60skT3zqXj0pHRCesZzEEjxszg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1738728527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=vwWzpDvjMuLt9gCiFXgDDHgvpaK8kfO4FmN1QrVPgKU=;
	b=vmJOwTJ4N9Kheu8Wo195Iccu1GsPOw3SvrsWEFGtokxUHMzU+cx0lDZ+eRAr4NecYMz7i3
	h2+aW0wLTkiZLa1jaJh85NXc8LPONHx+yYdoFXMtg5Skky3cSpIsxJiFiPGFEnCBJEkP9Z
	0iCAaoxhHKp7KYkVlhqFSe1uWGCTFbvu9/79LzJJORhFXfL73Dx2zi8+WcPSvxKQFc+Mgn
	wkgMZhADtLx7xug4mxOIWTwbdt3uiAGq/iBv1CX1v7CNzITT8F9AE4L9MWEQZqWbKQROSs
	GaFgvkiuT1suFV9Ch44kolLOqgD6DAOXuSVISauMFxOk8hcLK9kmT12XLWuVBA==
ARC-Authentication-Results: i=1;
	rspamd-854f7f575d-l97bm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Blushing-Cold: 6dc00f7178883cdf_1738728527776_688707327
X-MC-Loop-Signature: 1738728527776:580489688
X-MC-Ingress-Time: 1738728527776
Received: from pdx1-sub0-mail-a274.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.119.246.122 (trex/7.0.2);
	Wed, 05 Feb 2025 04:08:47 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a274.dreamhost.com (Postfix) with ESMTPSA id 4Ynmv24y9LzDT;
	Tue,  4 Feb 2025 20:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1738728527;
	bh=vwWzpDvjMuLt9gCiFXgDDHgvpaK8kfO4FmN1QrVPgKU=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=EVcIv889XUuS8aSz0HzXR0vuM4Ydor7Khn0AsGMYZcWnCvEsQMsn3BBFmj45mVBrV
	 Y/Bv+YS7DZ8vA/f4b2l1QurRkHsG/7nTuIqhtwM/ypsa0QdYWYWxPrsfU9nB+t4zpl
	 OXLZx+AFW18rHuUzhAu86NYFFNurC4RhOH6hu65ZjgATm64rkYuXGp5GJSO0FY0IFU
	 wBiezCtlEFX/I9glqFmya7ZxrUEGQcnTdCGftM0be2/LbUtD1vL/kBNJtTbhdX4iUX
	 TPevWq7Xo4T205O2VV/gAtDVK2fgRUtlpskbhkCmVL1Zcil4gbyBzyaEP9D+O08xbn
	 y7RUmyiRGmgAw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	seven.yi.lee@gmail.com,
	a.manzanares@samsung.com,
	fan.ni@samsung.com,
	anisa.su@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 0/2] cxl: Dirty shutdown followups
Date: Tue,  4 Feb 2025 20:08:40 -0800
Message-Id: <20250205040842.1253616-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Two followup patches to the GPF work. The first adds a
$platform/dirty_shutdown sysfs attribute - my only doubt
here is where this should be documented, and for now I just
left it in the regular ABI doc for cxl bus. The second
patch adds support emulating the set shutdown state command
for the mock device.

Patch 1 has been tested with qemu, and patch 2 is only compile
tested. Applies against the -next branch.

Thanks!

Davidlohr Bueso (2):
  cxl/pmem: Export dirty shutdown count via sysfs
  tools/testing/cxl: Set Shutdown State support

 Documentation/ABI/testing/sysfs-bus-cxl       | 12 ++++
 Documentation/driver-api/cxl/maturity-map.rst |  2 +-
 drivers/cxl/core/mbox.c                       | 21 ++++++
 drivers/cxl/core/pci.c                        | 23 +++++++
 drivers/cxl/cxl.h                             |  1 +
 drivers/cxl/cxlmem.h                          | 15 ++++
 drivers/cxl/pmem.c                            | 69 ++++++++++++++++---
 tools/testing/cxl/test/mem.c                  | 23 +++++++
 8 files changed, 157 insertions(+), 9 deletions(-)

-- 
2.39.5

