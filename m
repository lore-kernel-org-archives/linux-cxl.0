Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3EF39E183
	for <linux-cxl@vger.kernel.org>; Thu, 14 May 2026 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778750821; cv=none; b=FYgkdfFyhaEr7MehuNFB1U8IiN104o/4Nm1qP34EBAnKngKe2qDj2OkQUNA/o+p0Wp8WstyxPib8p3XSISVBZpTFQ8c3+Pp8WEii5GW/PAyyG51fs+3Re2+ZGElw20JYn6VFq/V/3hCdR1HjPei+u6VbAVrPXCwfXy52V4/qSCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778750821; c=relaxed/simple;
	bh=Rsj6Y4SIz+yqaGHvVFu8fVJHAe+o0P1xMLGAtrKa2cA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DVyfXw4oybTh67czI8GFZjfJAximq+f8ZzG2ej2NG5J2ZWxLZwDxmPhZSH6UpkXapUvz0Iab88AMNjvpddoFsAh3ajxsXAZ7hfFLfAr3t3ZGR5Q2YAG23EQyL5eiEj1sZZmECFDObHeD0k0uM7cFjkVdshnFdh71UmHBaWgIxjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OHyx9JtX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RIfPQnKS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OHyx9JtX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RIfPQnKS"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E56mjr828359
	for <linux-cxl@vger.kernel.org>; Thu, 14 May 2026 09:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ep7Kseu2ALN8qw5peg3urlwX74UCeAOq10m
	htSWm5ic=; b=OHyx9JtXT5NXVd4H2Ucvhx0qRtiQgRXRlbWMQINkSuQOBYzIvR1
	3mQIEnrb3bAwWPkq9MzwGh07GHFhxclLAuz5L55AwjOMqrKnHYpygSTy/nJDRyvV
	Hgph+CsqmSmxaTUnPuLYn2+8+OMbkWHYq7di59WALCdRDUT8IKj6Irli4BbcYnG6
	AWgSLRlWEZe16jiGWnjkdpvdlOsL1uNKa7k4HDY+FSvyYdSFCtmdWiSJlU8lj+lA
	/KFkQhANfTiNyPDpNH6kiJabKB2U9j/l7ZCZiL++qEsJSjiD8hUugKx3c4ae9DHD
	DW7Up2Adq5UVGGAfrgmgn17Wo5Ca77N5auA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e57y7gwmk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Thu, 14 May 2026 09:26:59 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2f2d983d109so13652485eec.0
        for <linux-cxl@vger.kernel.org>; Thu, 14 May 2026 02:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778750819; x=1779355619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ep7Kseu2ALN8qw5peg3urlwX74UCeAOq10mhtSWm5ic=;
        b=RIfPQnKSTBy+uX7xvMzTcn5bo9tsUXtf7TthLWfSMrnTktdHb5bwGj/S2MCEQjyWK/
         LxNqj1nrmcZqIUijkUcx0T4Lx9sHIfLX8PqnPrA6Gbd2QxkhnkXECplosO2t8YZpuM+X
         ol3xCDI9uyITzJK5miQuRY10mYRdzd9BC0oKaLGElXbMlRgDoODGo37nvFUF92wnVjLn
         rO5wK7B9bzZBNbF8/lWnEoaXeK1uTIYyQ3hOROuef/K2TOdmfC8JWrmQkbIJa7BXEquv
         eIE6BfLmHRNlsk48TbIii8hM/qo/+DRN3HKv3FSfEWRWVTComP8aUEByKBcO2enCIAaS
         wBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778750819; x=1779355619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ep7Kseu2ALN8qw5peg3urlwX74UCeAOq10mhtSWm5ic=;
        b=Ohng2Y7o1AsHFP6cJ8Uj3SSEGK0GVtuGyxKQL4DMnZ8I7fGKrphsqAO7j9q1N42vjF
         quODk1F9/x+4IzBOJnfbZo29GxCs0CcqjSfH4gmC+sqexwIWqdc8vqk+344KnLo8BVIT
         Fv4YYBVjtXj2W7Mf+KqKfJlXlXpcfOHzqtg8Ypl+Bs5HaNpFCZ8PvO30E5Qowdswzm5+
         jc9ssXP0ZlA6Xzp1rAGzbp7LHEe1f9MN3tyBGBKMwov36GdcAdqhcb/3JzzgV/I7wjdi
         GRXSpI3WK33/9+T0cy+lWtRsV0qbF1yzfS5G6pg7Z38IlBJTwOccGCYLtkrgxRGFdztU
         qeJA==
X-Forwarded-Encrypted: i=1; AFNElJ/u0UF2WILS8BIFIaifvKpeDxD8CyLVNhttPM1EQcHMxZE8CY81DOY/zS4KYFeEw6VEwwSRXxE+ApU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRPANaHw0oaRgMAexC6F2Vs9sxgz02bsE7X+cVxd10t3lJO5h
	4urQD0z/wzltt3NmYJvGqA9EGWuZns5oYEfAHIbAc/yNhUSRVXBZO4y2EKuPN1uIZ49tUeGtxTq
	UDju17d5S4Oak4+qefvF2YgD5B/JVKF0nLVQa8hzv2HGparrH9WP9uG4VVGN0uZ0=
X-Gm-Gg: Acq92OGCaMRUtJO1Mb8w6oWS8j38s7gzAGNTB0iBML50ATQgaZaLHS8laAxfehoHn1g
	SbjhI5NtJ8ojW5Wf8aOHe89++cfseiQsQpoC46TULTkfBHQuEF4O+I5jOKzS280KzMbR12uJrAR
	qOpjJiIFBe0ydM8YBIH7kynqbd5CxcxVQQASTZQVY/uPqr+2Ix4WQWLO22CH1SK1yL9TMDJb62u
	R8lwIQF3phLnnSyZ+qNjYhQZprgxSPKcSXmmP/H28Iy/TPwuTHFKI44syU9YugQELRKEiWtxOXR
	TOZ52EgQ8LbOZiVJXgYPccsgC1KDSxxjM43az6kqkazGO+pAuNhPfrgh9IzwEum61Xm1y/qVuFi
	VrRYriemUMfG0Wz1XUi/rWpVEyyVSUqt8Eop57P8UCNbBQyh0X1/O4Q3hfqaHuL24qAWTISuezZ
	lAEQ==
X-Received: by 2002:a05:7301:1f01:b0:2ef:9961:27fa with SMTP id 5a478bee46e88-30118ea0193mr4235476eec.18.1778750819137;
        Thu, 14 May 2026 02:26:59 -0700 (PDT)
X-Received: by 2002:a05:7301:1f01:b0:2ef:9961:27fa with SMTP id 5a478bee46e88-30118ea0193mr4235461eec.18.1778750818588;
        Thu, 14 May 2026 02:26:58 -0700 (PDT)
Received: from hu-c-gdjako-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302944ffdf0sm2329385eec.8.2026.05.14.02.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 02:26:58 -0700 (PDT)
From: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
To: akpm@linux-foundation.org, david@kernel.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, osalvador@suse.de,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        georgi.djakov@oss.qualcomm.com, djakov@kernel.org
Subject: [PATCH v2] drivers/base/memory: set mem->altmap after successful device registration
Date: Thu, 14 May 2026 02:26:57 -0700
Message-Id: <20260514092657.3057141-1-georgi.djakov@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ws3bPjp23b1S0sbEmEjiupLGmv8pROrB
X-Authority-Analysis: v=2.4 cv=UY9hjqSN c=1 sm=1 tr=0 ts=6a059563 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=YGLr7xQM868z39zpSbcA:9
 a=PxkB5W3o20Ba91AHUih5:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: ws3bPjp23b1S0sbEmEjiupLGmv8pROrB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA5MiBTYWx0ZWRfXznQG26R61qu6
 11H0eYvHxub73uF4AXSelgr9CUgmeRuyGTkUCxr/LMqtBuhs9bgSYkcp5AB1Y3+joBFb+jw76k+
 AkrxptgFysEwaJho6qWEAl5Ib4/z8KgH7IRb+MD5OQX8olsTYtQpuaKm8/AqyTv36dwrmZ7TkBS
 9TrncOSg/jNRIO3ngXIB776oQhUehiEZ1LxZEiSeJp/xRl2hmMr2AJnU+i9b8Yh14naEBX0b+Tg
 /rFouZEqS5NYw/wD4pZ9CoVEdtzg3X2csGwiv5FwoGwRM/GJ8iqNYFowHwwvFsyWT8oBG7Nqc/w
 R9oEVNRVF7WJw//b2bBA37PmbhFFK0bng/Mx0ZsXh8jb8ZYOSXdzbDZyW8LaNISoeIWXzqHmYER
 pPBqupYFmIxvddXdlKr2qFzzgCxcInDxAs20mZJvkZc/ouwA5d8lGSVOtDTlfgch1A1owNm5cwB
 1rIxyWhL9r3jbYBoSNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140092

If __add_memory_block() fails at xa_store() (under memory pressure
for example), device_unregister() is called, which eventually
triggers memory_block_release() with mem->altmap still set, causing
a WARN_ON(mem->altmap). This was triggered by modifying virtio-mem
driver.

Fix this by delaying the assignment of mem->altmap until after
__add_memory_block() has succeeded.

Fixes: 1a8c64e11043 ("mm/memory_hotplug: embed vmem_altmap details in memory block")
Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
---

v1: https://patch.msgid.link/20260513130900.2204499-1-georgi.djakov@oss.qualcomm.com

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
