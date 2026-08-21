Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC0D3DDB03
	for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 22:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351132; cv=none; b=MU5QMK87mpZFCxckWAwKxZxkT+fuEY7ZjFyJvl6CSaBXvlJdErWoekAs7lG6S6vlHlwIbiR38oSDzrJGnJExpn1ux4+T5N0S4CJWD3Kn0QG2vNJIvnMREBlFmElMGUoinSNSM61YPDRiP9+sK7NEPwT3x2vCf9OztEt8uj+GRiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351132; c=relaxed/simple;
	bh=vdCB8xGfwwzyw0wgolx5VFNTwR9IIILKyntejxe0m54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k0h4DC+OGOrEX5GwuavZkVTLPLeR9tRfZu0WZQAmh3lHkfIzr1mAMWuRZYZ6SjbDzpnrGVnli8/7eJIuRG6aze61qCh00/YPXQ/7pSsVRxQ2Fg+c1qeDJ1UUOX/yBAIydP5oXTF0j7kZY2ocVjhrw9GHh9W5wgz2M96wV7+8fF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUzDK71n; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUzDK71n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351130; x=1818887130;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vdCB8xGfwwzyw0wgolx5VFNTwR9IIILKyntejxe0m54=;
  b=kUzDK71n1iDXvNKRju3elWPLWgVZZ7jaspmVrTd5jDLCt0IXpdjYAvT9
   z3DZdTW5toHb65ww9V639sJWSQrr69sw1P0ncC0jHGPAxwZ65vsKYL+Lr
   yqJ1kSlM6GkGQ+FFIRBepRhkYn81LqUuG7FnP1VH8r+fhvymGI4p7FzY0
   FFFOAix7E13u/LcyccwxiJMMi1QwQppSAaFXF8SGkG5BDCmkJcvmX6O7n
   xCYNR3UpzWoZ/wTv2dPLAHfnVQMTCKC8eZhpXDaUg24l85XRteccGvGs/
   gKf8YfZu/gpgdoCJd8tnCigymz6xsHfuRv71Y2Lb7P73DLh1Pc63L1luu
   w==;
X-CSE-ConnectionGUID: zuQNISm1SK26MPWP453aIQ==
X-CSE-MsgGUID: iRQJKsqeRXa6LCItbfxshQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032178"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032178"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:25:30 -0700
X-CSE-ConnectionGUID: mtTUOh0IQ/WoaDW0to2Arw==
X-CSE-MsgGUID: 6DIfjQlGR12s2aXYQO3TXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679176"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.211])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:25:29 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH] cxl/region: Guard against a missing peer mapping
Date: Fri, 21 Aug 2026 15:25:14 -0700
Message-ID: <20260821222515.2675707-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When two endpoints share a dport, both must be mapped by the port.

sashiko-bot reports that a missing peer mapping could result in a NULL
pointer dereference during region creation.

No caller can reach this today. Guard it anyway so a future violation
of the mapping requirement fails region creation rather than causing
an oops.

Reported-by: sashiko-bot@kernel.org
Link: https://sashiko.dev/#/patchset/cover.1787255388.git.alison.schofield%40intel.com?part=3
Assisted-by: Claude:claude-opus-5
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 27e63e6dab7c..75b8092e6dc2 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1367,7 +1367,8 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
 	/*
 	 * If this position wants to share a dport with the last endpoint mapped
 	 * then that endpoint, at index 'position - distance', must also be
-	 * mapped by this dport.
+	 * mapped by this dport. An endpoint that this port does not map at all
+	 * fails that requirement.
 	 */
 	if (pos < distance) {
 		dev_dbg(&cxlr->dev, "%s:%s: cannot host %s:%s at %d\n",
@@ -1378,7 +1379,7 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
 	cxled_peer = p->targets[pos - distance];
 	cxlmd_peer = cxled_to_memdev(cxled_peer);
 	ep_peer = cxl_ep_load(port, cxlmd_peer);
-	if (ep->dport != ep_peer->dport) {
+	if (!ep_peer || ep->dport != ep_peer->dport) {
 		dev_dbg(&cxlr->dev,
 			"%s:%s: %s:%s pos %d mismatched peer %s:%s\n",
 			dev_name(port->uport_dev), dev_name(&port->dev),

base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
-- 
2.37.3

