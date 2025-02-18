Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F51F2862B7
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 22:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919293; cv=pass; b=YbXidjRT1RxIi0BMDpZIH1jNVT1jSuFND+4tvubrULsgBFuvJLvdLqs2HOHnTdfbSoucvGXRLTNb8cLgGgbKqkjybCBW5YN/Kclii3looO2iO51amoYiV55+2KxhnEaiGiNY9gfE2sA0BCRmgvkaVsJN282j7yGJCu1RpXejQgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919293; c=relaxed/simple;
	bh=vsqB8zBcueJSyxYsu5MYuSX5H9iAnkTb0aGKGrnSUlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dGZXne3rpIVL+9K9mNXpFlmtfSVCZ9Z/3GzLDUHTXy2bBDrJ+XYMPzzP6Ns0VVZCTQ7/CVkfGKCl7ntaRtSjsHgAhDPbh21efspq/mOcK6kWJtCw2FkkXoSt/NXqWsAQR2FE+lXpeFZOmHKULZWBemHS1GQPXfDnKqDASDZkC5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=fuHc348I; arc=pass smtp.client-ip=23.83.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="fuHc348I"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4943A8415E;
	Tue, 18 Feb 2025 22:49:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a303.dreamhost.com (trex-8.trex.outbound.svc.cluster.local [100.101.191.136])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E932C840C8;
	Tue, 18 Feb 2025 22:49:34 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739918975; a=rsa-sha256;
	cv=none;
	b=l2V397FuigjlLv4zqYypTt+hYZs4QPiDC9jCDIwtAjhfzIN094zPIwCgfdai6npQJUBMhD
	3YmxTuK9C0LYdNphSYh/z3p4grJBuA6KNYnLNLPnhFY0yP+Ccji/dEvrqsz9ZGTIw+XaC7
	J5cEa7HMN96W9UhvDpMLaOxObqztnmllD3gyC4dQC/AqGqr5dV3j7Lc9RUypZ1ReEsIV+c
	xaGYeQtjMdCda8pGG/A8FxP1DoCovYH470X0l8PykM9w9DeW+3iNoaAZl/2EdNb5U7tsO3
	jE3TEFf8mFW5YVqSMHC7ACPQCYuInwsOstW3VPjgPafZz+d8qVoGjOEqugb/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739918975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=pR9LFH2Ed7oqWr1ZTHIJA0T/v52hho/lyHEaJ3y1pjk=;
	b=vF98ywEDKQYPz76cbkB8xmnIyYFhe7rNyEtPzMmZzs4tupaBqBNXzAzWDHo5g7oG6UvPMZ
	4p3LOo8/nkkQFIr4NRzjKf33zN4vIeF6CXufORh1rvZeZXgrhy1nKZhjoUpWV3fejDhUph
	76NHZVjbN3mMWNVD+AzU18pEyStLvUcpvZTQUFFNNMZysEUcnA8kszhRAi3HyEISf0aS4j
	4/eZ6c3LchmmYrZ00NImSaWzngCWyqzoVdWU9Mp2/be803tCDqUlAbxahoQTBk3h2NrSgm
	wehey9qcLHdxa8qNX8I0sorKZeh3Xuec5wCjYhtFnzCxR1ouhCsB7M0lRzE81g==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-bt28w;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Minister-Society: 51f238df70712818_1739918975192_3006900656
X-MC-Loop-Signature: 1739918975192:3009615032
X-MC-Ingress-Time: 1739918975192
Received: from pdx1-sub0-mail-a303.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.191.136 (trex/7.0.2);
	Tue, 18 Feb 2025 22:49:35 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a303.dreamhost.com (Postfix) with ESMTPSA id 4YyF8G2J9yzWY;
	Tue, 18 Feb 2025 14:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1739918974;
	bh=pR9LFH2Ed7oqWr1ZTHIJA0T/v52hho/lyHEaJ3y1pjk=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=fuHc348IPN1skCodl/0g9HqA6f1/AoQElE49+gGirV1jwek2sPeAX6kamP2NIRH5i
	 Y8r338pmPvaJspGfJ/T13f0YfolpUfWhsGH0Cxx/Wf5EiYNXspqp9FYslLCYVnfBc1
	 9g89b1W9eBHLdJF440cRdn4+kVa/z/MskoLL/+KD5Gb8s6e/M+nScAvg2HJLj4Gjvg
	 cbtAcQlt+K2trYdOAvQFfrPJFroVJy+qptdffteJz/pv8hOvMPervq775zGqVLF7BA
	 qAUK7DWTAq9mBI1CPf4xO/uan6MoXrn6v167M5kzOdvSkw85auSpZxAMj5X69JhyNi
	 ysRzKyjOBiYAQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 1/2] cxl: Plug typos in ABI doc
Date: Tue, 18 Feb 2025 14:48:52 -0800
Message-Id: <20250218224853.67457-2-dave@stgolabs.net>
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

Trivially update where necessary.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

