Received: from seashell.cherry.relay.mailchannels.net (seashell.cherry.relay.mailchannels.net [23.83.223.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CB312CD96
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jan 2025 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736736783; cv=pass; b=sd0RJOSnaOtCMXRCOuHNYwno3JiIdCNGV5I5VOUP25xD2oYiRv1hSPZCnzTNpKx8dnVsdjWQEPu7wDl0npBvkMAKwauPykOFLnt3AomAuZQg1PQUiHeCeZ0Ndgz3vD5qhEA3MZNMHJ7nxMjT+9RN5UiN4xU524i+Vi0a89RlA9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736736783; c=relaxed/simple;
	bh=W5NOwQ5CwChC2bhQhEQ0k0ihUlcnX5sxRURmHEKIpgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S1xQy3x3I6CIz3tnR8ggNgR0QAjSGJzzdzuHoIDsMQICcyJ0lQbIiQ9hWyZqt52NTQy5kS/1p9IjN+b7DnUAmAbu5HG03a8sDvNr1sMAh2rdrWnAOaDOFQs8EpfbKrrFGuvAbwJ6fZaJ5VmBOlSI1m8IwjkS10p5LYu6sGf5tVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Fts43AjS; arc=pass smtp.client-ip=23.83.223.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Fts43AjS"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 94C518A4A65;
	Mon, 13 Jan 2025 02:52:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a293.dreamhost.com (trex-6.trex.outbound.svc.cluster.local [100.109.45.164])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 27E458A4A94;
	Mon, 13 Jan 2025 02:52:55 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1736736775; a=rsa-sha256;
	cv=none;
	b=4d6hllBt5LJyPtofATWDAs8pXtxhn2M53S/yEzIlue121DjbfsOPyrOlQ7o+VbUpX7raPT
	l7tsBJnWzKcM5/X/amd/pttHxMTkrMW4pbQMZPZD2T9kU1vXuxQ+j4UYaUQezoq0OkQQdU
	SNfqK1gVwlTxkUANyS+tIKT6TwyLEJS1eqR/zsG+ljHVApxoXEorhiHA4E9CfTV5FNPVrG
	Ge3TZheCMJVwzPFffQ4qfbgCgHSMz3XP7NIC3BwcMm1Zc7v8GnwYUv631O1KNNyYwQlE3Y
	nOTcUWpOMSq/7J7zTfPb0j3p7yk22tTPuH7l6RSqHES86B94Z8dXJvmBsS5aFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1736736775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=GC/GkDJr86Yge9cTKUc0eRwcyVg2Yt9O9veVcL9920k=;
	b=F4rlkT8rGwgRGzzY4lC8jPB3+HqJkx0WlyBoE8aElsmPkqZw5KvwNvLHlD2+YEW+LYA4WN
	BTbb5sEoGoIOVidhKwzIvCFoolxQ3PEyjM0raKhn68VdLAs51xoHMYj2+RtIfbR4iHbbNs
	CHcRuTJkd384/8HyVbkV4nBVKWHiK+8VrNpfHbWEL9SOBO7OcVdzHbMCnPhaO1lxBfR0jL
	1P0GRD+lA2E4Pb4Qr+Oq79ussectKdfNGLg6YWr4snM9S1qarYmMSAev0H3oprRILcHE9H
	YgKWmfKaaOs9jMOA6iLm/ZYDb5xcvA34gGpwUxh/Xepa3WWr3Osu20+iQ7QAwg==
ARC-Authentication-Results: i=1;
	rspamd-b5645c5d4-tr9xt;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Grain-Scare: 31eb9c9c295cf6c7_1736736775439_3269952311
X-MC-Loop-Signature: 1736736775438:4262248360
X-MC-Ingress-Time: 1736736775438
Received: from pdx1-sub0-mail-a293.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.45.164 (trex/7.0.2);
	Mon, 13 Jan 2025 02:52:55 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a293.dreamhost.com (Postfix) with ESMTPSA id 4YWcJ647lPzd0;
	Sun, 12 Jan 2025 18:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1736736775;
	bh=GC/GkDJr86Yge9cTKUc0eRwcyVg2Yt9O9veVcL9920k=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=Fts43AjS4v4kziACtGWxUVOyD+BGJUFHCq6YuJijxfS/rTBjvJQ5oWEsMCf/ZYH7V
	 0cr534Y1cZfFeOULSPIJG1fAL3j1SbkRnKc6wXbKfr+p6xkXPBdIceNCWjVsePzBVQ
	 qDJzVmNp7wzksVz+prOAutJa16Ms4PchNRv9DQLk7/QJ98tuvIx61Fu1a174cPDIHZ
	 CePS+fSDR7N+aE9mpBO4jAEbgQwAm3mJIKIK0ZVKEXG2bV+JBBbMYlCPKeikahhjiV
	 GjRrLB3K8xuyv1MIZ2j56NWC+ffXy8s2FyvhXJRJ5NYbFtujJxWCAS/9QETF9qiw+G
	 URHL/74KrUEoA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 1/2] cxl: Plug typos in ABI doc
Date: Sun, 12 Jan 2025 18:52:39 -0800
Message-Id: <20250113025240.327124-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113025240.327124-1-dave@stgolabs.net>
References: <20250113025240.327124-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trivially update where necessary.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 3f5627a1210a..7bdf0eb79d7c 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -1,5 +1,5 @@
 What:		/sys/bus/cxl/flush
-Date:		Januarry, 2022
+Date:		January, 2022
 KernelVersion:	v5.18
 Contact:	linux-cxl@vger.kernel.org
 Description:
@@ -33,7 +33,7 @@ Date:		May, 2023
 KernelVersion:	v6.8
 Contact:	linux-cxl@vger.kernel.org
 Description:
-		(RO) For CXL host platforms that support "QoS Telemmetry"
+		(RO) For CXL host platforms that support "QoS Telemetry"
 		this attribute conveys a comma delimited list of platform
 		specific cookies that identifies a QoS performance class
 		for the volatile partition of the CXL mem device. These
@@ -60,7 +60,7 @@ Date:		May, 2023
 KernelVersion:	v6.8
 Contact:	linux-cxl@vger.kernel.org
 Description:
-		(RO) For CXL host platforms that support "QoS Telemmetry"
+		(RO) For CXL host platforms that support "QoS Telemetry"
 		this attribute conveys a comma delimited list of platform
 		specific cookies that identifies a QoS performance class
 		for the persistent partition of the CXL mem device. These
@@ -423,7 +423,7 @@ Date:		May, 2023
 KernelVersion:	v6.5
 Contact:	linux-cxl@vger.kernel.org
 Description:
-		(RO) For CXL host platforms that support "QoS Telemmetry" this
+		(RO) For CXL host platforms that support "QoS Telemetry" this
 		root-decoder-only attribute conveys a platform specific cookie
 		that identifies a QoS performance class for the CXL Window.
 		This class-id can be compared against a similar "qos_class"
-- 
2.39.5

