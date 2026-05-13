Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B754282F34
	for <linux-cxl@vger.kernel.org>; Wed, 13 May 2026 13:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677744; cv=none; b=Lrm3KYbjajlaXz2DdRB51X3LRQGt36F0SGffIXBOFe209vxdjBA2ing7Z3X/8vHl0LePR47s8nq3EM0AaXJH1kKVrJeHsmFolRawzBKET/V61wVPgldrpQv7V/tBf5DahEfx8BaltKI9mpvQ9sAWp1LWiyX5ex/BRojXOwf9jSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677744; c=relaxed/simple;
	bh=vWOE6osmL0+rVOc13QGeOgsjejKjx6iSDzXnEgTjB6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YzzoPczb3Ygm/BANYYDE2p74jzMwZL4kq62DIC57STtuCvh6uqo+ikx8f2pWd8xgghzePSM9oMCDSeDRGVIihsJ8XKkke2UhM+97dUsPto5h3bKVnuW91SxBuUYOb8uVb/TRb+D2YEiQa8v13pbHx12zOGW0PtqX4aLc6uSy4rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AA9XbeEY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SdsLOfgg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AA9XbeEY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SdsLOfgg"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D8woYv4159625
	for <linux-cxl@vger.kernel.org>; Wed, 13 May 2026 13:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=uTfe/tIGhNeQUIR+fCUbh9LouIthlTdyb6t
	nrf/6/uM=; b=AA9XbeEYswKEb+EXZXwsLhUjZnS61idbfu0Z55OfSafAM8B/RBN
	eNETlFP+uZSjY9zloxIZJuQwpbaUSQJPlmsagxP15tZy0ktOh1SADcfvtMxpm4HH
	nq0tAhcFBIobzPX3sD+/rLyX4VTmju6wBxzb2md1XG63lDpimJxSPYYe1tZlBdME
	9EkgOg3G8Pchp84prvhh1UAJE2dtjfimiEsxxUYcOFlAiosZSFPB667EIcAR9coY
	p6WH3c1lcReTgCy8fTU91/LWyHYRhyqYUGFrYDzXHULarSjaVMnagMiHFAJTR1pf
	/2kS1olfrZdYoZ9gSC7mR1jnBKiqhkAQhwQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p91rvwu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Wed, 13 May 2026 13:09:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2f485961555so17019418eec.1
        for <linux-cxl@vger.kernel.org>; Wed, 13 May 2026 06:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778677742; x=1779282542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uTfe/tIGhNeQUIR+fCUbh9LouIthlTdyb6tnrf/6/uM=;
        b=SdsLOfggew6u5i6SrnnEz8JUF6PnJI+jiitir/cZdrLTMZ5A1xfuGqr7GYvYgv2SjV
         9euYsE07jOyeS0vADBsocVdGxZ+Dovjqaov43ByCq/Sppq7VNFeWwTEKrSCaVb5G2i1N
         s6t9aZu/w/VbERsZgY99LFJ+Gc3Y2GaG7dAx3pxtl7EP60U0PtvfEpCv+jmFXVeh7Vp5
         CHKwQLtZYF4qobI0v4POJ/KEInBftryZehD17xZTY/foFoA9jfgXw0IyGq7eVlAXDXdO
         3oskj57bSpI/F0P1IYa/fUughUh2j9Ydm+N1PHuxBbB8iSdvBy34381ygSFLcnRE0rSq
         b0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778677742; x=1779282542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTfe/tIGhNeQUIR+fCUbh9LouIthlTdyb6tnrf/6/uM=;
        b=NPPAobQSL7DDY/D5s1mk1FfZbKL4IsYYCaMk3MTZJ0Nkh+mge2FCyAzh/xsmCgIIjq
         7pTKDKm3/rEZK4XDc1a4kIoOO5ygVSHnYKZOxy0sQzJAZf+jL0cAoh+cXtGvAAdZZHVz
         YiRu+N63UL+0+u1huz7obcmYF+AZokG73RPuVVzZGA5DqATbxpQL3JkXPfHMiNuw4PSf
         Ab8IG1HTxVdVScsjtMhjsr/32ckki8roUcGjfOlly9y+s5pgQgbTlV0N0HSWxevOJeVR
         WsWfSm3xz26HPeiXab0xdhf9Mo6R3R9Y10TRUOeMh+c2it4ZbDbN+Z9CPQUmh8XWPbCW
         G1Ig==
X-Forwarded-Encrypted: i=1; AFNElJ+yKtpSZ1JoQVEECyIYJclYl+xeRzSaMQ9yxYh6spAfULmNPE75A3a0PlvUh3GoPtMpK80QTZHMkUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyk4oHcThYaonzbN4LdYN+u9sTWH3rRsyV8d9KoEWAMbmAxYgY
	tjcfvfj6OnKM56aeS6HPQVgUgKhZPi8fZi6pf9pEqWuAFh+3lZPKmFPgJkpOzQ67EU3q3gT7xsk
	cNhu+ORNYHrYU2SDFY/roK2c8i0S8rt1SqZkoEjkns7IRjY6FoK2pyVDbBLT63MA=
X-Gm-Gg: Acq92OGKHPNLm/CdylXSEDlq16+fycQLWtfVvMTscatCBJdNp+TN6E/Lfa4dA3eDIo4
	ZXphe5afqLe5LKI3FGtOh95QvjyncfG54PA8AK7ODJ4lIJMXqz6ZYY20AdBJSV9iyzE6vhnCfbt
	DM85Rk9jRVVB/dya7r8FaixZ21GNpEQriGpiVdTPOGmBSIuBXkigYkqFURfZbLL9fQpsb1Osgmh
	U28VNJbXN343zrJK7NKIdnEUGtZ8d3vpRmWNKf/Nnsv2q/FJuDulb5XImsPAtRyl+fi5QaYa+Se
	MdCe4w19vn8GaTrAKO8orDWThOmnWCLonZNtV0NA9X341rIf/fVFlQXm69+cHyqs2oMBlKZqpX0
	TuT7O0UWvHMGjqwTHffbOjcr8HSardvWrCXpN9RwjDw/G/fqOJNYBEtlALiNGOCnwexbkEduD2h
	OFWQ==
X-Received: by 2002:a05:7301:1011:b0:2fc:9ae6:e5a8 with SMTP id 5a478bee46e88-3011a16e093mr1953616eec.20.1778677741963;
        Wed, 13 May 2026 06:09:01 -0700 (PDT)
X-Received: by 2002:a05:7301:1011:b0:2fc:9ae6:e5a8 with SMTP id 5a478bee46e88-3011a16e093mr1953584eec.20.1778677741266;
        Wed, 13 May 2026 06:09:01 -0700 (PDT)
Received: from hu-c-gdjako-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafacsm21895067eec.1.2026.05.13.06.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:09:00 -0700 (PDT)
From: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, david@kernel.org,
        osalvador@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
        georgi.djakov@oss.qualcomm.com, djakov@kernel.org
Subject: [PATCH] drivers/base/memory: set mem->altmap after successful device registration
Date: Wed, 13 May 2026 06:09:00 -0700
Message-Id: <20260513130900.2204499-1-georgi.djakov@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _uDvq2SR8QcUzId3w_UYnuJjNhZ4Cupv
X-Proofpoint-GUID: _uDvq2SR8QcUzId3w_UYnuJjNhZ4Cupv
X-Authority-Analysis: v=2.4 cv=G9Ys1dk5 c=1 sm=1 tr=0 ts=6a0477ee cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=-MbnMxPH0mhGQIwWBDkA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDEzNSBTYWx0ZWRfX7y7BPsqtojBm
 OBpFgjYILkvLKbmRLD4QysOsuJjHSlVDJqBFynS1S2O8ZdVBDg7kK2lWMC+vvVYNdwTjE2+myIO
 /gquAGFw9BhjJteBIMiYEbZGvq3y6e/F5+KTpOIIxCuiyV418j7Hj566lli4vRB3iTkE1lpww70
 ryVwy9N+oljMB7KsSOlj+xqz6ZSbhQmmaOFrWo+bk6FuI1QICAgJgzHCH9pM/r195+qXZY5BNQJ
 f+Z4DTo9gkhy34S/woMj3YwI8i054ekiB6XRh2ax95Ug+y5foT8fUsu1lmpjefrzEMlkrKg1MoZ
 NBMmQHjYBF0uT//LtiPP6rMvmdm1SkEbOH/kjRJJ2maCuc0hYz834eYzlEgex5Q/9G+hphGjiNP
 j+pghLd0jkkhmzuYReV8nq0sZQbEQwXqwvyLqHxQ2PwzS6WD44issR88G2QaB2AYon2BCkc52qE
 saQ2ja3Dhka97g9uKQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130135

If __add_memory_block() fails at xa_store() (under memory pressure
for example), device_unregister() is called, which eventually
triggers memory_block_release() with mem->altmap still set, causing
a WARN_ON(mem->altmap).

WARNING: CPU: 1 PID: 76 at drivers/base/memory.c:96 memory_block_release+0x28/0x30
Call trace:
 memory_block_release+0x28/0x30 (P)
 kobject_put+0xc8/0x1bc
 device_unregister+0x2c/0x68
 add_memory_block+0x1b4/0x214
 create_memory_block_devices+0x9c/0xfc
 create_altmaps_and_memory_blocks+0x130/0x1cc
 add_memory_resource+0x10c/0x21c
 add_memory_driver_managed+0xb8/0xe8
 virtio_mem_add_memory+0xa4/0x194 [virtio_mem]
 virtio_mem_sbm_plug_and_add_mb+0xc8/0x16c [virtio_mem]
 virtio_mem_run_wq+0xea8/0x1088 [virtio_mem]
 process_scheduled_works+0x18c/0x300
 worker_thread+0x1dc/0x2b8
 kthread+0x1ac/0x1f4
 ret_from_fork+0x10/0x20

Fix this by delaying the assignment of mem->altmap until after
__add_memory_block() has succeeded.

Fixes: 1a8c64e11043 ("mm/memory_hotplug: embed vmem_altmap details in memory block")
Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
---
 drivers/base/memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 11d57cfa8d72..78e9600e6d45 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -807,7 +807,6 @@ static int add_memory_block(unsigned long block_id, int nid, unsigned long state
 	mem->start_section_nr = block_id * sections_per_block;
 	mem->state = state;
 	mem->nid = nid;
-	mem->altmap = altmap;
 	INIT_LIST_HEAD(&mem->group_next);
 
 #ifndef CONFIG_NUMA
@@ -825,6 +824,8 @@ static int add_memory_block(unsigned long block_id, int nid, unsigned long state
 	if (ret)
 		return ret;
 
+	mem->altmap = altmap;
+
 	if (group) {
 		mem->group = group;
 		list_add(&mem->group_next, &group->memory_blocks);
