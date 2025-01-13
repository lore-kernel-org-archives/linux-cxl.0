Received: from cornsilk.maple.relay.mailchannels.net (cornsilk.maple.relay.mailchannels.net [23.83.214.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883E055896
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jan 2025 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736736784; cv=pass; b=eQTVlRxnBKk1IY6sDqDhbh6+V8V33TsIQCXkHO1Jau/zszXwP0J+oKcMIS6tFNq5aKHsWFCdMqwCwvOBCTiXPoRMPMX3JrAGn1IC/SHPCQocfn8nyonWKBHtztncoCGMt25YAzUZPpazipuubfv8EU94HV8JkyCmpbGXoHDWq9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736736784; c=relaxed/simple;
	bh=mABGkqb6qNeIOfyJl6Wd97kgi/Pa4FQYpDbLF0qrdrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LPQDcfZc1k/R+T1pUVmNnEoR6JY2w7eCUMjpCM6vFWjeDUEtvdYxv181EIaCdU+d6lii1156pF3T6lfWvjPntQ7VUOfAUmQPq9o/wTRgsHrCzcVQVyvQFDSTzqMnouzOsdau5/Y8mqZZ0FfJ4FmAG1kWxijhcFR1/m71hfxRS1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=cMVVrT10; arc=pass smtp.client-ip=23.83.214.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="cMVVrT10"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 21F5D183728;
	Mon, 13 Jan 2025 02:52:56 +0000 (UTC)
Received: from pdx1-sub0-mail-a293.dreamhost.com (100-110-82-187.trex-nlb.outbound.svc.cluster.local [100.110.82.187])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B72EB1836FF;
	Mon, 13 Jan 2025 02:52:55 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1736736775; a=rsa-sha256;
	cv=none;
	b=G7eHSEWu+etsP912NXZ/FWO5njb+j9wmE+ZlivvY9HUJNAKjGuHZONHkwIxW1J2lPXphj+
	gdBSKKxMTRCHEDYGZzP1JCbJOTI+vwxWm+8vUURckAHnepE1ZIBBwvhwXHnwXEJJ2RPI2F
	e2WaG8Fp0kpbhc9g+E6YSHl6OCXwvM0xjP+TbVLsP3WICj7uMwK8oRcJUrPHjMiRYq9Sqw
	qF2VOlYUn/wv57H1aYNQGyqNQ28b5OKR9XJ65djuf5FT0bKShJ4O4/ehOaGUJrJwJXWxqk
	i42gg9qB6Intz/Rd8Z98kBjHV40pqyrc+FRwbK0H6s+KNX4pk39UsWkldapv8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1736736775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=EWxpJu5BhF4C2PqO/kotMRvyIwzPtyR2Rflw4V1zAy4=;
	b=eOPJxeK1zIUx86q/CYoFOdGhLWpo0qpE5+SUHAueLf+Ui6kTaMEUnU6HOIqm1URos0TMPI
	DnnjjTTHTnOCZ1Gfp6bPaNF5B6n2GoUnwYLbVFJRO3W7oJUZfxgo6FppyIIoLwaCXcZYgM
	hFw42dJAjKmmMCvbwZtv+uhFIQCBAnXIDhfHetCaA6uMQzgQhsNpEKrtLczco9mPtkO9fe
	YztEfmWNftv27LwiCBnqt/tvctVgG8KOc7iF3He5ewhfZH6oFLgGkdOZXhVElZI9YpESWy
	9JDL/HLe6QLXjLnJrszmuCqsiCmBzF5zhIp99POLQ5BSR/6IfyyW9U9ZDhl70w==
ARC-Authentication-Results: i=1;
	rspamd-7df4dcbd86-6r7gt;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eyes-Interest: 3b361eb84106b412_1736736776008_725781545
X-MC-Loop-Signature: 1736736776008:2988447105
X-MC-Ingress-Time: 1736736776008
Received: from pdx1-sub0-mail-a293.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.82.187 (trex/7.0.2);
	Mon, 13 Jan 2025 02:52:56 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a293.dreamhost.com (Postfix) with ESMTPSA id 4YWcJ712r9z6w;
	Sun, 12 Jan 2025 18:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1736736775;
	bh=EWxpJu5BhF4C2PqO/kotMRvyIwzPtyR2Rflw4V1zAy4=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=cMVVrT10Ca4xK34CV+p8rlQlprpk8Qs9D7o/RpzXpgE7JRdpZeNx6WtEFvRmUJJeq
	 1E7/wIyqwHZqOPYjiZGlSMLtCWJqMd6lhctYbgYI/x3h+gJQJZuqgGNhb5I7uHGOpD
	 6rNs48pw9kLJnSk9jIR/aYdEFk3Hti6NtM9Xtk1PP8X49cvbl1Cyn6kk5gAmIR4bXY
	 X0TrfW293MwzVVQodUwVz00xyipVXXPshkz71C00CgvFjxDX1IFsZraw2pO6BO+AW9
	 ImDh3pEZBH/AZMKNSa2DYDI4g1+pCtTMHuhoaa+CUJl7HA/hRFdOKhTBAScIam34nK
	 2b1FN/L3WPvQQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 2/2] cxl: Document missing sysfs files
Date: Sun, 12 Jan 2025 18:52:40 -0800
Message-Id: <20250113025240.327124-3-dave@stgolabs.net>
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

Add to the ABI documentation the payload_max and label_storage_size
read-only files, which have been there since the early days.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 7bdf0eb79d7c..96c7fffa5442 100644
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
+		registers. Linux caps this at 1Mb if the device reports a
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

