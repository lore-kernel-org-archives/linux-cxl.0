Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610654;
	b=rCoN0+Uhp0vRQD4t3xrOGASz35BzXLH4DCpggYXbsNDvhVSX93Rtq/iLBf1+r7oTdTlh
	 oKmISxvgLXv6vngWX+PIIAPUa0P55VkWP3CeQih/yOSN8TmNNrD5iwdZu8aKDgnMsJYkc
	 d4fwC5e45XjZjE300fjTqbw6OaCUxqNLgmVAwLlhie2YLBaP/e/18VLX6GajS3DFcbBBi
	 bpA6eZlDYTQbjFsh3Rz0E0cUudV8NtA7gg4rLiymzcCHjYMg1rvKQcRUZxOSoKjsEZFpt
	 uqiLEq6shSA5HMcG3ZFsPMVP8/kwxKxYarMA5BlutEpxmMBSoBo49Wzp6YZxWOEAUrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pLmImULofT3+FSttUaKv878lyoAkirgsHgMwhWxjRWg=;
	b=PdrxpPInI0rgdTVk1hwUnruW+AgnqVOvFx+1GKLPU19FI7WbatEoi0v+r49moYkhLsle
	 YHYMnOjRQtwZKuqZdRGOzA0E+S9ArMaGwUgsdOTnIRJ9F87mWJlK5kxIMyTpvWlLLn5js
	 Wlp7fYiiCdpDA3r4bVW+Yv1SUXmetGI4cPFM5GasQKPTL7ZABc3OwtbrFwbainZx/CnwQ
	 GciWzmNv3j86XSxBGKPHYVOJ/cB+SH33eQNeoVyX6RR9kXbKtw3/u/bOX7PrfgbT1BwWX
	 vUAVk3PmJiznFKproiq03Z7lDp808NbOPgeHymQr7FJ9rZ03b+HEKQdl+kAuL9A1B/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DKiul7a8;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962DC606A321
	for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 12:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 962DC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DKiul7a8
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38431138772so7366577eec.1
        for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 04:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795610653; x=1796215453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pLmImULofT3+FSttUaKv878lyoAkirgsHgMwhWxjRWg=;
        b=DKiul7a8vW4My+7zvqtSI8EBbg8PDLcHwhxM5Mze6ID4i/gDliyVU7Pl6zTR9wpViI
         nDidtpzShU5EHLcGK5uw0mr4HZrc8IWHKCJi65tIMtVxRSmJ4D6DCMJ65AnXOy6nvkCy
         gEObSZR4AZVcJbDGuD6DPEJ2L+QQJy7ZejC5pSufKRWEKN4J3tIMNLKFQjw0W6e7vADM
         BRCHRU2vumw4S71ybtOoF8U6f/LqudjdqE9HwBOQS1iEjcDZHAFOuH0Dy+iRibWMbRq1
         PILvvCwDIVgc3+o7MDP4Q9hpWslJMuZy/xjIvrFBcOCR0OC1DsraEy2nUyy8nEgiSv1Q
         vzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795610653; x=1796215453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pLmImULofT3+FSttUaKv878lyoAkirgsHgMwhWxjRWg=;
        b=v9ekIcKbd8C7JzZ0+rCcchHu5THh02REVQK8/Cen0PZGpHngS8spSjZxBicbrVE/kf
         5Y5YdwMeAjL3qJBrgyFAijVn/JBWyKXOXgPVG6aiCRecUufWLbv4VLvw9j721bIqJ4sP
         FWvBFMEpji1t/ipEths/uaXKaMZ8DHgXKmbMosBpJ0yyoAbtK0qY5ozU59GM/kCwzPND
         UkmE0tmKBlU0GsFG5KWIFkfJJeRY5MBYzPs5I/JrWhH3ITrb4Q2l4QP3krmNA9aa5T7O
         t12TpESUS9gI/biZOgnhiJiD40gkKxhJTnzLTp5nKnO+H35Y8xZDV9KcGi8oSphRnxzS
         Ldug==
X-Gm-Message-State: APuU4Z9TsB5LdXwDNzk78vQKIZ+BVAiAaNHHW3kUqFxYyKedkA9+CUN7
	MuYqv22LDdaX5YKUAxLnQ8B8d0CVfQuXWy16hTBnxJHmvf0FWXBgX/XWSJXX6Wx6
X-Gm-Gg: AZFdTZfbMf/n/Z374yZh8hGSPIeo/CsmwNz8N1mfAsMoy2pEdWPApunUR8uqoFWosY3
	SeuHvHZ9nXJjAm8l46YSh6la+uBoe5fs+JpxVDRWPFZQIMBEYkzVRb4iHfyg0j7D/avSHA7cHSR
	mg0t8/8zuehQeyrtNsETK7J90jF7whtugvi4A0CoPg7qiabyt8O1yCRiU5gqhBaWXEHE4umD8Q0
	RCH7FBggeOq0sfzRQUH0culbe4N//2qX17me8ICMq0llAhJxTJPAqpXr6QhmgW5/IHydVJosX/W
	GPdxUnqZCuJzvp9C/CvBwhRezBx8WaRDfbcipUl1c72+grQ8iLa0c6DTRncbt+uatW2Py7RASkU
	bAA5+esG2AviW1wsyaDgbzbp+CL3SljdvSFSl+VSLLEm99A8Og/Yu+td4t4SQKORqgHwEh5AnvT
	2G/AHlPcvqgUt186KNtIg7685vy3mcpNiOCXTn3OZJELbpbSW0245w295+Rl5rZjPy56z2eLySr
	AaVDGSg49xGRFic2G+kt7Uquj43DrIP47NA3PvGaHk+VUSBA5yYFuSUge8QURrzKD1nSHGCRHYH
	3Q+Yjf0YxptJKN48i8NdqVKVedc2fOHMg2rU5zbztxU=
X-Received: by 2002:a05:693c:414b:10b0:386:9e32:a65b with SMTP id 5a478bee46e88-3869e32aac6mr15238550eec.1.1795610652666;
        Wed, 25 Nov 2026 04:44:12 -0800 (PST)
Received: from localhost.localdomain ([121.134.184.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm55841836eec.6.2026.11.25.04.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:44:12 -0800 (PST)
From: Unsung Lee <unsung0317@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	John Groves <jgroves@micron.com>
Subject: [RFC PATCH 4/4] tools/testing/cxl: Add a knob to advertise online FW activation
Date: Wed, 25 Nov 2026 21:43:58 +0900
Message-Id: <20261125124358.3583223-5-unsung0317@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125124358.3583223-1-unsung0317@gmail.com>
References: <20261125124358.3583223-1-unsung0317@gmail.com>
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

cxl_test memdevs report no online activation support, so the new
firmware_activate attribute can only be tested for the EOPNOTSUPP case.
Add a fw_online_activation module parameter that sets bit 0 of FW
Activation Capabilities in Get FW Info. The default keeps the current
behaviour.

Signed-off-by: Unsung Lee <unsung0317@gmail.com>
---
 tools/testing/cxl/test/mem.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index c740372bda..7fefc91921 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -23,6 +23,11 @@
 #define MOCK_INJECT_DEV_MAX 8
 #define MOCK_INJECT_TEST_MAX 128
 
+static bool fw_online_activation;
+module_param(fw_online_activation, bool, 0444);
+MODULE_PARM_DESC(fw_online_activation,
+		 "Advertise online FW activation in Get FW Info");
+
 static unsigned int poison_inject_dev_max = MOCK_INJECT_DEV_MAX;
 
 enum cxl_command_effects {
@@ -1327,7 +1332,8 @@ static int mock_fw_info(struct cxl_mockmem_data *mdata,
 		.num_slots = FW_SLOTS,
 		.slot_info = (mdata->fw_slot & 0x7) |
 			     ((mdata->fw_staged & 0x7) << 3),
-		.activation_cap = 0,
+		.activation_cap = fw_online_activation ?
+			CXL_FW_INFO_ACTIVATION_CAP_HAS_LIVE_ACTIVATE : 0,
 	};
 
 	strcpy(fw_info.slot_1_revision, "cxl_test_fw_001");
-- 
2.34.1

