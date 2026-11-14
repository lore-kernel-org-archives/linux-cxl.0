Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640240;
	b=hdChotIcfkYXw6X6B+WosMySieWq0X6PZeK9jufY1Lc2y960r9rGX3MwUaceBgmmBnIv
	 zw8qOdvJFJcuhIsH0CeqqOrGOdi8BnJw85MF5RaRaJMxsSaJD+m6ghglcHmCl6AfSYazB
	 4VPi/Hs6id3HUYpT/wo/Zwe0FK8UpnuTLAgExie/GG1tschDaxRzPJ5lvPU3uBIIhd6jA
	 jSKjmvg/HmZpPvZnQiTx+jQ5rQHltU4ClJZ3oqhHSlaEhQe+A+7El8GnP1yBJGB13quPX
	 TWzHTY3P8CBZc/ODku8p7JSPm+tSLDUXLxM31jxCNlNjOQASpqWwsduoC476ZlrFauw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TW0pg36vCDijleVRTyqZR6UjU0iehYYk3FdVNC+q6Cw=;
	b=aNbE9kRF+PghXjRXGIk1VagVpSal+YVKng3e0PQJM3pV1HqfnM4DmPS3fJKrJ6MrPBpA
	 gI1Otis0s90egtmCsdPT4gtLUq3y4fEsZtNVTP6t8TdBKrx6+t2UEdE+ECecgkUOQBjU6
	 8LJJPYCryi7QipK32g26GNO+6Ch9LQUJ75PrNCj3FAW3Wf35KFusAFFG9ZCapqDQkRu7Z
	 fTQgyoDBm+zDvXkxwqxTOYmUoNvIs71XzG9eZj/SswWkQKLetKo9tpBaATxwAiTz7sXj/
	 J44kX6iJ9l6fBNQLDbDGLX7cUzrIEIcUleHfdQESqDQ21f+vVhf35G1CsDuQe2gmrTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Q3DA2nko;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94FA60A2614
	for <linux-cxl@vger.kernel.org>; Sat, 14 Nov 2026 07:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B94FA60A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Q3DA2nko
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91f332a4b2eso5815676d6.0
        for <linux-cxl@vger.kernel.org>; Fri, 13 Nov 2026 23:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640239; x=1795245039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TW0pg36vCDijleVRTyqZR6UjU0iehYYk3FdVNC+q6Cw=;
        b=Q3DA2nkof5TccLKEKOkpoD4tlAOwkqtDIAn0I7af3oHWDqV3MDanG1m+HE/Hze03RB
         qgl3c5vxWVmkXsR09wn3vLHdDsQxs6n5d5kmh2vSTwdxhuPGurTHI/rf19CMjpalpwLk
         Bat76O/tF4T0TriwTFkD4rF4Myqr5UPy8AlQL4K/O+nVeq1syIpOIfYk8TaDUdAHd5w3
         QDiVsq+WKJug4sgJGFgXNDsZz1FuysrzHgEgwFF25lm8FzKJWbtQrAoKggIMdZvxF0BJ
         30S+RNohN7c+/TVaM/HNeDtJjy04gi9aW1TsyxUlWnJ0PK27ITnaJvWinVawe5+Yuzex
         YAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640239; x=1795245039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TW0pg36vCDijleVRTyqZR6UjU0iehYYk3FdVNC+q6Cw=;
        b=TxjfwFPR5XEp8ysdNZe3RPdE0uh9So1O3iChFDF5px5Yz7kw+GUctwVYPFOPrAjzjt
         6zkLMEZjRGWVi+2AQj0/4wTJqVyu//YNIfIYFQOCRKPmWtQpzeRGZ8NhFsHICizjEhL7
         TkfdLyHTds26SLJJU0S4+mM0YJWBNBCni/UG+o/A0ufmocOB+ko8If6bqIye301Wzwf9
         LBe0ebY0nYtDsgpCBmnVjivZt6Q32rwgimhh1HFfjtKPM4DAEINQiOot+DV2A4sWKUM9
         slTn1MiNuplDFydi8Wbj2mFWvwKEVRUxfJvtJPx7AieUH/FxVtATQdkGLGpshzaYHPZQ
         UG4g==
X-Forwarded-Encrypted: i=1; AL+hErFwglyn81WkVdOk+nIYJoNf2qwCA80x1dLzkMw+7IGDStuF9ytuwzY3sV4DOfL5IS4CjT91AfWOsKg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NLh69BH2klztQgb8ApYDNmktVvSPBoaudSIOYx2EzlNn8Wgpv
	P0T1ycuvCXh1ekxvzazq/SkpHj7nvExCKPzVN2rh9oTBwKdD8XBSl1gpV6ANrmZo8YM=
X-Gm-Gg: AYBFou3449fGO0gqKXCPliDDRlDrXR0dTe7vhPBIr0/qe1FJsXOe/K296doIfc7O9nj
	Jkm0OqWaqeiIjmNvnqQHO231fpbPGn1AKafBRTUi56aTzv5hoIHM8VeGsiuvZAxBnVSZDfRVxX8
	FTSImy5zl7ekQ/QkDtYsOtzI+wtb1K0cUtxT0xLRdmQwDnjZIE+kpZNQ4yO1EHerkBp9NFxPi2D
	GCR8mDZEpFmNE/hA6vSRmxYoWq6uPecogu5e653euCw5YCY9GuGTzEz1AiZzYWrl9PPGh2+Wi2X
	w39X6SOmpATMjbbSTVNPO2Z2Dwkd06z2xOVAXEZeDqUGD4wNI9Z46ovf2WfI0J66Xe1E9Ne21lM
	e4BYcy7R9Lp/N5NGLxzgg1qhN675m6M7p9w9mk6ohZGOZk8vZBxDXBaCpb3OG+A2A2jtTjytv2q
	3dkPHVcLbLTQykw/sjOZX5KKGQjdlb6QquWJMeowt+00e9Joi9MR3Sr8XfqEBPPJjGvG4lUsZ8M
	OcDDvENNxD2Qqq3nHM05S3klSoA+PaaCsA/KJXoxBR4ZmdNHefHGCuZgN/Uw3Jj+FhMmY2eMkN9
	M2+U1/WbgRJo6eFdheWmd+WFgWYymugkmNMkJ2W8dkw43L0FTS7aJ1McE9v17E0P2zbm4CFrxTA
	RgUL+DGclC0+0lgx1RMsw09HJ1IlTPu3SiiQW
X-Received: by 2002:a05:6214:1311:b0:91f:2208:b683 with SMTP id 6a1803df08f44-91f2428c6aemr76715686d6.55.1794640238785;
        Fri, 13 Nov 2026 23:10:38 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:38 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	johan@kernel.org,
	jirislaby@kernel.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	pavel@kernel.org,
	lenb@kernel.org,
	hannes@cmpxchg.org,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	sj@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	apopple@nvidia.com,
	rientjes@google.com
Subject: [PATCH 16/22] tty/sysrq: use common memory for the manual OOM zonelist
Date: Sat, 14 Nov 2026 02:09:53 -0500
Message-ID: <20261114070959.3490008-17-gourry@gourry.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114070959.3490008-1-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
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

SysRq-f constructs an OOM request with GFP_KERNEL and supplies a
zonelist for allocation-constraint checks. The request represents an
ordinary allocation, whose fallback domain contains common memory rather
than every node that happens to have memory.

Select the zonelist from the first common-memory node instead of the
first memory node. All memory nodes are common at this point, so
behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 drivers/tty/sysrq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index f4571d05b4962..824f5836b47d7 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -386,7 +386,8 @@ static void moom_callback(struct work_struct *ignored)
 {
 	const gfp_t gfp_mask = GFP_KERNEL;
 	struct oom_control oc = {
-		.zonelist = node_zonelist(first_memory_node, gfp_mask),
+		.zonelist = node_zonelist(first_node_state(N_MEMORY_COMMON),
+					  gfp_mask),
 		.nodemask = NULL,
 		.memcg = NULL,
 		.gfp_mask = gfp_mask,
-- 
2.53.1-Meta

