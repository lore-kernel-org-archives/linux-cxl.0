Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19602862B7
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918978; cv=pass; b=ht4txco+KC64E3acro91B4bbFS+H9Bti6YS/2bY+4tifQK+kXCBT9H1koLKFtK9BSxJgpQiDw4G/jbstAH/AdgGJ0q4YcADz0xqBj53cyOr2s+PYykH73CPjaa+Kwm7FZ+0aFWisAgungDAyaWJleN2cpnrFuDMJMaQJclMkCQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918978; c=relaxed/simple;
	bh=UrhZgu7uHXwX0nrR+admySz33U8kmBCtuCdWsnd7gwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rlvNs9Ly7j5ieA7Q4crldV3IoawtNKvozOa78xGMjX9PeFgo7aiIXIVZCR5VOHDkOf9xvBIM4dz2v8RLTl9ebt9JsBh8YabGroqi/eYt3aDkgc2i/8bahYMSqwpqTcog4NyPhCubVEqhTZkOFf2JJpJ+svfBHP1qnLg0wMl3LvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=jDPDWQs0; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="jDPDWQs0"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C481C90239A;
	Tue, 18 Feb 2025 22:49:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a303.dreamhost.com (trex-0.trex.outbound.svc.cluster.local [100.125.216.205])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6E0149023B9;
	Tue, 18 Feb 2025 22:49:35 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739918975; a=rsa-sha256;
	cv=none;
	b=mchZ0xJnwPvkuZHahnGlFYGXP8+HtzYA3ojpUzn8LSoNVZH1eT+1fGdUpei6gj6VHfK7Ja
	JW+VWTKnoYVweb3p5vnSWZrsIMxegqwLrjBB9b7GY0st57oZQ3Hkq9qP8YQUdPCb+YXz/0
	5rBAj97fEOXo7F5ihY3h3HIUkncNvwRht6ssBM7dUEAPYo4Z2+b1jo7hRE+SGzFaXzChVv
	sbBxGVkwGtYTrdutkxrO67ahlryiKlpOzP4QVgkXhgkFufohTpl+DG9NSDHGneWr+lJJr2
	+zPvrJuXbgr8c2n7W3C3Z4/CiNgvzUn0nL4n58YLU3GWFBNYy+Qk5ZvC56j+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739918975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=XSfpRAOReVa/gTBWIeP2i0oFf2kJ1w90ygEKuqm3tJo=;
	b=bgkIwRaUMJ6VHkYJjKkbyvvaejtB3o5KbbSTADz9U1rqcSz/AHYA0hzHV9D6KdV7U+uAbV
	trDfLhp7ttPrk7OTa/Ab5jYmy8jWmWYu+o546a+oZvAsRK1wqg/cxNEmaQVipALChIobPj
	NvuSplh5ZhH4idyFCvovlRY5f+VwUc85rfPcfzkYrhwmmehDd+hXGqRWFd2wPXlz4nnj82
	ObJbWyvJ9a5LLMqHRL4KQJFX9tqkNw9sYXIhrDuQ0umeXgAjmzGqFnMx38dOzIGS2t+bxS
	aIX33TdCEJrmAbb+i0cIPWX3DiIb52SGifMi2f8FPqqLlO8q8EoQyF/fsvlW1g==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-tw94k;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Continue-Industry: 157619d03b5efa75_1739918975700_379832279
X-MC-Loop-Signature: 1739918975700:2438856009
X-MC-Ingress-Time: 1739918975700
Received: from pdx1-sub0-mail-a303.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.125.216.205 (trex/7.0.2);
	Tue, 18 Feb 2025 22:49:35 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a303.dreamhost.com (Postfix) with ESMTPSA id 4YyF8G6LV9zbr;
	Tue, 18 Feb 2025 14:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1739918975;
	bh=XSfpRAOReVa/gTBWIeP2i0oFf2kJ1w90ygEKuqm3tJo=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=jDPDWQs09zxzakP/zN9+q6HtMc7OiOBqOAOOFmzfeZX06CfJgQ/gqtqSqilA8XjPc
	 XF2jagrOMCiOz/ZE/4Mqkpk7VoikPHO+mGMyLumlZA0mhue5vHgcdJi5Kd8FfjCUV+
	 Ao0ozBwId4k7JFkA2YapcY4PVw+15j+LvhzrrWUL1X5t3EutlarRH9W/P4d9M4eKCM
	 1Ye3soPmYv4rkpYK/IwaiO/1tZF351wHvqfhhisHAXWl8MnbQvs9mAC4v0J2AyLxkm
	 qNnrecn21+R/PxioUaD2fCuPJBRrCpP88tSymxbgVx/7uZ+t1m03EELmsMtuYr+YhK
	 Q1xcaT4jMZ99Q==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 2/2] cxl: Document missing sysfs files
Date: Tue, 18 Feb 2025 14:48:53 -0800
Message-Id: <20250218224853.67457-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218224853.67457-1-dave@stgolabs.net>
References: <20250218224853.67457-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add to the ABI documentation the payload_max and label_storage_size
read-only files, which have been there since the early days.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 7bdf0eb79d7c..04a880bd1dde 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -18,6 +18,24 @@ Description:
 		specification.
 
 
+What:		/sys/bus/cxl/devices/memX/payload_max
+Date:		December, 2020
+KernelVersion:	v5.12
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Maximum size (in bytes) of the mailbox command payload
+		registers. Linux caps this at 1MB if the device reports a
+		larger size.
+
+
+What:		/sys/bus/cxl/devices/memX/label_storage_size
+Date:		May, 2021
+KernelVersion:	v5.13
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Size (in bytes) of the Label Storage Area (LSA).
+
+
 What:		/sys/bus/cxl/devices/memX/ram/size
 Date:		December, 2020
 KernelVersion:	v5.12
-- 
2.39.5

