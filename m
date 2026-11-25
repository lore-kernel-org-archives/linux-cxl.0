Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610649;
	b=Lxs6D97qXeqia/dY8m59ObXEcO1mbcug+lGqlTRJ4CkCTQk6wNN7OSP3bvp6J9ZkGJgZ
	 pZ8+jX9w/sGEcorTnrfake7O4vUGHyUKUMbE5DnytkR+rNnAzsZKnOEqw7ztL24qjcSUU
	 4wYPbX9balGCHg+RayXnAcm94ISWToTeM3I+bCvCuWUxRS6S0ee26HNwo473n6CY+9sR3
	 b+MOp3ByaJK76Km/kUCLGCbzqDgEk8nUBkIJEYH/6UELaxdJ1AC+b1O4tcJIlGhAIWblf
	 W7V7wLwL0wyL7MdUbFJ07QtcK/F4neUSpLwgoCuyRGxduCPPwpGRVxrnL0g8/lNBqjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Scu0RT4wwOzmqvi2oDtwqTdu8bZ2ODzVh2EewvDP+98=;
	b=0NbncFg+oYBEDHO7efe/iiDW+It+AIan+TLyIvckazTa0Oen/Blx9AF5pL64PyzvfwyO
	 hy4yQXs4pVIWyS600RPmbjESOlnez2N1qz/DIXso7Ld8Lso13GXB4K7uv2noKhQNOQa0a
	 ERnyDyc6NHc6w+xF/jw/JRkZMx2aCF+AQUyymYziGpkg5WHaKHbrTk2t1XDbc0U591SUA
	 LepuYV7sxr4l6IofL3xwzbUkZUxj4or5ZdpzMkjTggsqdpPcyq0zFyIS7lm0AA6JYYK1w
	 mUYt6mL7mJLNrpoMr/8zyvvVT0rdKD33eP38BvIjXg5q9MkDovtnraFx+IE98Uj8ydw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DOE3EmRp;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61031606A31E
	for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 12:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61031606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DOE3EmRp
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-38644aedba1so8685837eec.0
        for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 04:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795610648; x=1796215448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Scu0RT4wwOzmqvi2oDtwqTdu8bZ2ODzVh2EewvDP+98=;
        b=DOE3EmRp3zpOGyXLEgVT/MHhRb+Dj4ylff6gZgyt3E6lFhH1eo6SMzVvrK0nV2U1gu
         rqwySSD2FI1VSgBiPvBRx5kKTVqh2tkRAFfWvSQtgO8JJhXTA/n35GplaQwdMCxPCXAq
         CGDj787lswY6Pcuqn6rRLRYj1yxxq+OSBoW3cnfBEm6HV/2nqrf0LCquDj1Dvbgz1pUN
         oGOujoxvmn1GBio6BsgmkhHP5qmkoL9JgQWGag6wO9Tz/p3QPffMeq+hMEp/Fj7/+APs
         fgE1LwoGUQ++YFzC+5WF9VUAvjsVHCNGbEcKAGY8RxMqt4dl9dVJjprxMWpyDNUYJi4k
         ySaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795610648; x=1796215448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Scu0RT4wwOzmqvi2oDtwqTdu8bZ2ODzVh2EewvDP+98=;
        b=P6afQ78m8HffbTpWqf/LiwZJcxIDeIyra6QrZIdMaxn7ewZ/r5l/YVVbYarZlb3t8a
         /l7jVT9a4uj0KuA/0Jqe3LxZ/kkM3EODw48O/p56puQXbMYJaSWqrCepGQulf01f36JS
         J9FU8V/1sozKsf/+V8jnU7vbEP9DOf03V0O+t0h6l9DoqtCLgvi9POmycOzykthTmcg8
         aHsJoHue4aXi2GGKvFKylloQEmH3SGxLfkQLwS+lZVJ6fa0E0GscK6zQFNezqNu8XS6a
         jitUNxm9TqjmS39b7O9ARSIVdc5ebpCV7S46HnnGH7myW8DemY0ikGvK0QsGUJ4P0dvK
         OVuA==
X-Gm-Message-State: APuU4Z8lIuVLTQEXPNcyNYgPbnwSEX3ONPaM4UtALW/QFmtfu79UhJ62
	Jb9n31acXjGCOyEe+e2yAAangbYA+qnayxdDcatM18pjKP6IwN7y5RDmaYj5a6Aw
X-Gm-Gg: AZFdTZfNIVZgTDeBpNpck9eFGdkKqXYEsJz20Me7rXHZTp2e2i70eW5FtJny/plE0Mg
	xWiZFov6oDO1qiHNM+W9RKswL5l4lQJRummwBzmqnOY4Kxc68qI3eNy1ObIitQq58ejvGrHOLKh
	lraAWRtY4Cx39yyHvdnE21Yg7+EJVpKQBODL+yMd6sFLiNE24x4EJ6GMFJ/VhYOOXvv7r+ElF9S
	VRvjNCEMN4Psp/61FGkDQxSX3TRr7zflg+yIGaS1ejxxep6tk6Dp83tUiVhKjrmSj1UPeXuFFtT
	NLvptchaza+B5I9rpzmVv4BfNSBeagKi1ZDsElf7ORQDIUDat/kUe3kTQv0yjDK1SsKx5L53NKG
	3jtRXLX4vMOVnEqu9u3iPqbXS7IzFJuH0ahIZDxZ79JSW6ms4ctkghtE8be7ymg+AK4O/k7AU3j
	uIqYdv82TGvkmhzFS0v8jO2G5K0GOZRD7kPdJmPOl5qUdMR6N/OZwpHyhXzWDO6994LKy58QoM6
	YuqU8wnpUpUYqctiCMz5lIx7TTFny49+V8nqtVG+mWEJrmhEaULy9mw6PbxFwlNBPjw1UXvlLYZ
	T2P9c8CFP7TD27U3T04EnPya6kUPqnj6Rib9ZD2Ary4=
X-Received: by 2002:a05:7301:4718:b0:369:1401:c5c2 with SMTP id 5a478bee46e88-3857025806bmr18124957eec.26.1795610648133;
        Wed, 25 Nov 2026 04:44:08 -0800 (PST)
Received: from localhost.localdomain ([121.134.184.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm55841836eec.6.2026.11.25.04.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:44:07 -0800 (PST)
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
Subject: [RFC PATCH 2/4] cxl/memdev: Keep pending slot and activation capabilities from Get FW Info
Date: Wed, 25 Nov 2026 21:43:56 +0900
Message-Id: <20261125124358.3583223-3-unsung0317@gmail.com>
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

cxl_mem_get_fw_info() keeps only the number of slots and the active
slot. Also keep the slot that will be activated on the next cold reset
and the FW Activation Capabilities, for use by online activation in a
following patch.

No functional change.

Signed-off-by: Unsung Lee <unsung0317@gmail.com>
---
 drivers/cxl/core/memdev.c | 3 +++
 drivers/cxl/cxlmem.h      | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 67f467c267..cdbebd1225 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -925,6 +925,9 @@ static int cxl_mem_get_fw_info(struct cxl_memdev_state *mds)
 	mds->fw.num_slots = info.num_slots;
 	mds->fw.cur_slot = FIELD_GET(CXL_FW_INFO_SLOT_INFO_CUR_MASK,
 				       info.slot_info);
+	mds->fw.pending_slot = FIELD_GET(CXL_FW_INFO_SLOT_INFO_NEXT_MASK,
+					 info.slot_info);
+	mds->fw.activation_cap = info.activation_cap;
 
 	return 0;
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 4cf8a0f6cf..a67e451a62 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -388,6 +388,8 @@ struct cxl_mbox_activate_fw {
  * @num_slots: Number of FW slots available
  * @cur_slot: Slot number currently active
  * @next_slot: Slot number for the new firmware
+ * @pending_slot: Slot to be activated on the next cold reset, 0 if none
+ * @activation_cap: FW Activation Capabilities from Get FW Info
  */
 struct cxl_fw_state {
 	DECLARE_BITMAP(state, CXL_FW_STATE_BITS);
@@ -395,6 +397,8 @@ struct cxl_fw_state {
 	int num_slots;
 	int cur_slot;
 	int next_slot;
+	int pending_slot;
+	u8 activation_cap;
 };
 
 /**
-- 
2.34.1

