Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.222.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795055447;
	b=WcLK864DXfjtViPpmARz7GpAD1qf/2SuIyzEaErdKrQHGz6hNQMBnJwRZUNxcuqujOlE
	 yohdH/RreW9ilm4PILXX7OkVxvO7bOPtD9Ky/wns5et2HB86oE12/vL36XGPJGIZ2jA/0
	 6Me1Jq3CwPt7q4GqEHsPubBsti3DqWoLQD/H7ZBT2ahKCXwiwMsk8Qrv/zzg0/pWZI0Lz
	 kl4CWlxtSSY5s3/2WRXJEifGXcq6y5tYsyykmlstMcH1DBpcGHc/aBJFi+UjHKYOhdQAa
	 eKngXl6wiIP0uIiz4xr414+UVRtfYcP+R4ST+eVzNVfeWLRK5Xg7qHhNJ+3Sn972muQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795055447;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Suffer-Scare:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ukDBnjfJSRpRpa12Maw8rvKvWcb0syTVp17HY0zplFQ=;
	b=WctOhZw/CBM0UNzhn0OIwB/wIivBMd1qYkrLqWXMzwtzYSj/Gq6UzogCjUUwtmHBV0TU
	 00RNMX+XC9WHxnzoCb9P+qD28rRqzwnT5AJ1mTJNVZT3z3NnUj0z5ezokxUZEq/vsk8Tz
	 Ww7aNmDz1sGu9CObOATOLinz0GBfawWX93lpaMjoZ+xEadC5jfIZALIJVmplpMR6AzSIN
	 7sX+9atPrfFWwKvMPzfGv6X6TXOzj7v1oeIqcM597nIjcFE1o4RyjoMHpgtvlkFUPOipu
	 2Ks152lp2ETe0hFLdd9VD9cwbi6LyCAeK76bg9Z/JgTBhYJMFRtycQlqt017Kfocrpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b="khj/7ijb";
	arc=none smtp.remote-ip=23.83.222.35
Received: from chocolate.ash.relay.mailchannels.net (chocolate.ash.relay.mailchannels.net [23.83.222.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A4D606A31C
	for <linux-cxl@vger.kernel.org>; Thu, 19 Nov 2026 02:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21A4D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=khj/7ijb
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 940C441904;
	Thu, 19 Nov 2026 02:30:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (trex-green-5.trex.outbound.svc.cluster.local [100.103.220.8])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 357A3406F9;
	Thu, 19 Nov 2026 02:30:36 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Suffer-Scare: 0154a09e360a68e4_1795055440432_3552641768
X-MC-Loop-Signature: 1795055440432:2355324203
X-MC-Ingress-Time: 1795055440432
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.220.8 (trex/8.0.2);
	Thu, 19 Nov 2026 02:30:40 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4jVMrq4nR1zPN;
	Wed, 18 Nov 2026 18:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1795055435;
	bh=ukDBnjfJSRpRpa12Maw8rvKvWcb0syTVp17HY0zplFQ=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=khj/7ijbPHBPrGC/KGUd4cfCBymYEYiNlufc9HV1pkqrOATyGugh96TeN4AZ5d2PG
	 hyCJzh+rU0TZvahxWlsUpn7uhUpcpx1LNBNHsllrxNR1SlC+0KcNCN+Z8HFVZdpaWN
	 al3x9t2M7z+bUHoV+i1enMC0Mmf39QQunM6XGIpSOAopIOnDAGewQz08kFGEUAAFS/
	 n34PEqhsB5GuhGQoV2XFS+sAIDmdOBaXhWAwhTOINxjo2r4MtoK6CYaRouyRXNdZBC
	 UAZfL7NXHbeLPuY+2lkt1pgdban0fUqO98gDnPEBR8L+RhbW83JH3gfYoc1/RAA1D0
	 nEF3qSFSHBroA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: alison.schofield@intel.com
Cc: dave.jiang@intel.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH -ndctl 0/2] ndctl: Back-Invalidate support
Date: Wed, 18 Nov 2026 18:30:26 -0800
Message-Id: <cover.1795050773.git.dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The kernel's Back-Invalidate series, now in cxl/next [1], adds two sysfs
attributes: cap_back_invalidate on a root decoder, set for a CFMWS
window carrying the BI restriction, and back_invalidate on an endpoint
decoder, set while it decodes an HDM-DB region. It also gives cxl_test
a BI window with BI-capable endpoints below it.

Patch 1 adds a cxl_test unit test: a region created on the BI root
decoder comes up device-coherent with back_invalidate set, and a
cxl_acpi rebind replays it with the model intact. It skips on kernels
without a BI window.

Patch 2 has libcxl read both attributes, reported by cxl list as
back_invalidate_capable on a root decoder and back_invalidate on an
endpoint decoder.

Tested with meson test --suite cxl against cxl/next d337784de533, 17/17
with this test included.

[1] https://lore.kernel.org/all/cover.1794172701.git.dave@stgolabs.net/

Thanks!

Davidlohr Bueso (2):
  test/cxl-back-invalidate.sh: add a Back-Invalidate region test
  libcxl: report Back-Invalidate decoder state

 Documentation/cxl/lib/libcxl.txt |   2 +
 cxl/json.c                       |  16 +++++
 cxl/lib/libcxl.c                 |  15 +++++
 cxl/lib/libcxl.sym               |   6 ++
 cxl/lib/private.h                |   2 +
 cxl/libcxl.h                     |   2 +
 test/cxl-back-invalidate.sh      | 111 +++++++++++++++++++++++++++++++
 test/meson.build                 |   2 +
 8 files changed, 156 insertions(+)
 create mode 100755 test/cxl-back-invalidate.sh

-- 
2.39.5

