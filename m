Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4CB1171C
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888607; cv=none; b=Y5HevlL9Du2ic6OEpNUNyHVc5Xap18q4+qi3BPxkyUc13VO9gKivIaKsoRoGMONfzi1pum3FbNWXgMFX7HzYOFRc7XnEzuzgigKRGRDT/gb65kx3PewS6E5xx8WQ3qEJ0U1/6a4ck7CKU9eCiOjq5ayuFLlYJYhh5Fp6TUfgHyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888607; c=relaxed/simple;
	bh=sij8mQmLBr227Upb/cKfVJr0KFapMnwQJyZ+mJYzfsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ua5crsKrAGcECqxDMIRO1FExufaHYKsgmMASdq8nUNdeuQNOJ3wlhO0iCF/WD1dPuPAYyXcId5I1B4S/u4QaPs0bVW3uv+fWJS3IKq1kra4kSuWqcEIdHCgH2n8wqBXIyzTV4Z0yGv6CI0LoiiTH8mWbWzSvl0LoPcIvKNAwFLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Ks7r83ZO; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Ks7r83ZO"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1728888604; x=1760424604;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sij8mQmLBr227Upb/cKfVJr0KFapMnwQJyZ+mJYzfsQ=;
  b=Ks7r83ZOsPUD+tvRg4cH/SSEEYlaelGOV3LIo/YH3bRV5rf+Mblf3H6r
   +jdb9eSjnzFRyABhwTDUaeYhoO+j5et/SzvNZbmiYx3zvtM/nsv8YGvq7
   o5DG7SyPRoO+q9PFbUT6rp1YdM9jpO522BpbDcncV/FzmN/HwSPOEyp5P
   IGQodZQVTfd1XN4Qfg/kzHUXnkGG1ivSjRFOw1yhrpAjAXx1pULbxJsAE
   MRrNVO8sjUzgyIn9kEVApn4Gko1r1Rnxwf9TFXKePe6SONsXy88I4Esfb
   OE+XiwnBBHQHPgb+rO0Zmxi3oYBxIx/1jpJrpVXA7hM15GMguoCfRW/la
   Q==;
X-CSE-ConnectionGUID: qoyq6zLjT2e/E4xuKjJyQg==
X-CSE-MsgGUID: hccnRVb2R8KN9fjVN+uHTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="155571174"
X-IronPort-AV: E=Sophos;i="6.11,202,1725289200"; 
   d="scan'208";a="155571174"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 15:49:55 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id EC45CD29E1
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 15:49:53 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 25FC5D4C24
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 15:49:53 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id B52016B4D8
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 15:49:52 +0900 (JST)
Received: from iaas-rpma.10.12.255.254 (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 3193A1A000A;
	Mon, 14 Oct 2024 14:49:52 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [ndctl PATCH] test/security.sh: add missing jq requirement check
Date: Mon, 14 Oct 2024 14:49:51 +0800
Message-Id: <20241014064951.1221095-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28730.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28730.005
X-TMASE-Result: 10--2.745000-10.000000
X-TMASE-MatchedRID: Dkfyeyxtv0ZSuJfEWZSQfEhwlOfYeSqxa9qiaDSLgo3+Aw16GgqpO0kS
	zx2E9sLTvqbgr4tKCQvmn3xyPJAJoh2P280ZiGmRkbMiEOIxZet9LQinZ4QefCP/VFuTOXUT1Ao
	zErC5dcfkwjHXXC/4I8ZW5ai5WKlyIh+d+sRjCR9JxhRR49StWCeUEZGUktVBjH6eSSzP4B6OPu
	dWtbuMtKqZCD3DtnP8INHmxzMyXoowJcB3GTi/L3/0r3TUIHw+EWW0bEJOTAVAdUD6vW8Z1mZAM
	QMIyK6zB8/x9JIi8hKhgLRzA45JPQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Add jd requirement check explicitly like others so that the test can
be skipped when no jd is installed.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 test/security.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/security.sh b/test/security.sh
index f954aec3e25a..d3a840c23276 100755
--- a/test/security.sh
+++ b/test/security.sh
@@ -220,6 +220,7 @@ else
 fi
 
 check_prereq "keyctl"
+check_prereq "jq"
 
 uid="$(keyctl show | grep -Eo "_uid.[0-9]+" | head -1 | cut -d. -f2-)"
 if [ "$uid" -ne 0 ]; then
-- 
2.29.2

