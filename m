Received: from crimson.yew.relay.mailchannels.net (crimson.yew.relay.mailchannels.net [23.83.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC80CA94A
	for <linux-cxl@vger.kernel.org>; Fri, 21 Feb 2025 01:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101319; cv=pass; b=HLymByelZUYsJ3/bA5rbXmLpu+6MLEWbMe0LXMN/FKFYiPnlt5oPpe8HSVPVqeinkulB68iA2fG+SRUz7cP3uWAF8/69ShA+TEaWaWQPo+JXDSm3ItpWgJd+t5epRlmU/JTu38y6NvAluH//uk72LjLzkXNDm++R3isD0Vk0wjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101319; c=relaxed/simple;
	bh=0oU9nGLRctraxB/S/SeupYsQh4DMcej1ca5Zw+kel1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lBD9hSNzcDU0/WSmkTW+RSKGWptnQ+cmI85maAJS6yqoHTcQVa4HeikKswyQOTNFIdOKS18dIfix7Hm0vYb+NnnXBjbNcz5ml6aX7V9SBtPlKZcyraFDsUT5rPLg+7C0qREp+NvtnKC9oH4KArF8lxvUUNe+EeEVNM4YHoBFZMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Ml4Sdwx1; arc=pass smtp.client-ip=23.83.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Ml4Sdwx1"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0FFFF322E00;
	Thu, 20 Feb 2025 22:02:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a229.dreamhost.com (100-97-28-76.trex-nlb.outbound.svc.cluster.local [100.97.28.76])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5508D322F18;
	Thu, 20 Feb 2025 22:02:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740088961; a=rsa-sha256;
	cv=none;
	b=5BmYYP3A7Tko5IoUzJtYvDFY5rQvbjAOJZXWy9yDDVQFM425ORm5DTjzb7163LzWeyzGEw
	ZUT6dAexziWoQfXpRDhnIjh77rFO8c1Eoe+xt/24BO9qFWawczEDXvlx1swn55sc175oyz
	QmBDPmLpAZWXwDDdfRejSgLOaD1Cw6nZA0D0c0vC8anBjrceLtThwmSkpA47cejCeIpBcu
	MHTWUF35swWCVx1nuHo98KrqlaW0ojbDB9LGfklhAA1N2sz46pDmXcIBhRwlpccc+tqxBq
	6Spl4pC0ti8apXgXuesUxWXws0MJbNe2JzdmFwx00TuHEsWrZnpimngfcJp/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740088961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=an6uVolBgKwPu5v0qfdukWY/y+90pz+FF04pCiJ6z74=;
	b=fIUvSvhRUps4czHkQCGGh8zLKGtCGllk5XeMOIiIhnBQxP7phvZcAt7QCWYtHUB07WW59+
	pbgqia/1xPOGqsoC4aWlI00CDOKGrS1jro8lPlvK+UqR6VbElhx85gIAKR0JJHo1qyJs0u
	wEOQZ9PUpj4DqoAOcJHa2ALsk8xGpHU1T3GiAeZAnX5LOqbr5vMubi93MFoTCoW5vofFjt
	Jr3uoS6BCNGa6QPMvg05yfchdkZaxlTJErrOQCMmzlub77fCJ69U4a1xlQOF76kKeQrKm6
	g7LUIeOLUfGd3/fWyz0dwHM4NSjUQoLteOOI4fLxPjy24f1cPxakrukuCweiDg==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-fvkg7;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Relation-Society: 0028685e37ec1c5f_1740088961810_399080677
X-MC-Loop-Signature: 1740088961810:802406110
X-MC-Ingress-Time: 1740088961810
Received: from pdx1-sub0-mail-a229.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.28.76 (trex/7.0.2);
	Thu, 20 Feb 2025 22:02:41 +0000
Received: from localhost.localdomain (unknown [104.36.25.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a229.dreamhost.com (Postfix) with ESMTPSA id 4YzS1D2t1vz7L;
	Thu, 20 Feb 2025 14:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1740088961;
	bh=an6uVolBgKwPu5v0qfdukWY/y+90pz+FF04pCiJ6z74=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=Ml4Sdwx1p9OHU8QLkCuyc59WfHliMjf/1eCGv5lNzCyy6yNnEvSdEhSEGEByzS+eN
	 UyM0PjxN+KmASTVFIwzISPU/NwEL2vBf3HwXn+x6uWsFKUt9Zd8t9woM6OO/9ZzE1F
	 VvrTLsoKaos8KmOlBFZM+TUX78ZQehfa/k3QrcWUZJaCIKuC1pT+fpNXeLjkV8oEZ3
	 OlmWqLpOJ2IF8ala5Tqz1c5ma1TBK4mL9xOu69x63EGrfMPLroR4PNbv4yP/ihh3Bj
	 9ZS5WDFkjldVE2n0OO/faBB0AwrBn6zFtslaykPCgfIDIZXnDyZbQTmmjtdm/OCrJY
	 6NObUjUWwSaWQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	seven.yi.lee@gmail.com,
	ming.li@zohomail.com,
	a.manzanares@samsung.com,
	fan.ni@samsung.com,
	anisa.su@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v5 0/4] cxl: Dirty shutdown followups
Date: Thu, 20 Feb 2025 14:02:31 -0800
Message-Id: <20250220220235.276831-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v4:
  - use %llu on the correct sysfs file in patch 3 (Jonathan)
  - s/cxl_nvdimm_setup_dirty_tracking()/cxl_nvdimm_arm_dirty_shutdown_tracking()
    in patch 3 which was feedback from v1.

Hi,

Some followup patches to the GPF work. First two patches are from feedback
provided by DaveJ. The third patch adds a $platform/dirty_shutdown sysfs
attribute to expose the count to userspace. Fourth patch adds support
emulating the set shutdown state command for the mock device.

Applies against the -next branch of cxl.git.

Thanks!

Davidlohr Bueso (4):
  cxl/pci: Introduce cxl_gpf_get_dvsec()
  cxl/pmem: Rename cxl_dirty_shutdown_state()
  cxl/pmem: Export dirty shutdown count via sysfs
  tools/testing/cxl: Set Shutdown State support

 Documentation/ABI/testing/sysfs-bus-cxl       | 12 +++
 Documentation/driver-api/cxl/maturity-map.rst |  2 +-
 drivers/cxl/core/mbox.c                       | 25 +++++-
 drivers/cxl/core/pci.c                        | 30 +++++---
 drivers/cxl/cxl.h                             |  3 +
 drivers/cxl/cxlmem.h                          | 15 +++-
 drivers/cxl/pmem.c                            | 77 +++++++++++++++++--
 tools/testing/cxl/test/mem.c                  | 23 ++++++
 8 files changed, 165 insertions(+), 22 deletions(-)

-- 
2.39.5

