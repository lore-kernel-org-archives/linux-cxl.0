Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D9E4BEE2C
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789163606; cv=none; b=Z76noMlgg/wd2u5wpRfnnpkBI2CGNMsLAkW2Aty9XA7B2Hv4QI8rb3aQvDuxjmlcF/ttlOonNLg7/nSnPfUEsftZ9kmMkte6hFEi62Lpc9oe1M8ejv6oBC55SMcHBvLYRnbP0nPxI6j5hMnRGTBAZaPMTX8tqENxZCWLN0/y/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789163606; c=relaxed/simple;
	bh=QTAAvVo+D7Wnc9KGN3ZO+mOdZs3GkHWnL/npgBHGXy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aZevChjaue5VvicuV7oCIpI3SMIcRVGIszNfItIFLfy2BRoHymap1VGw1amrRja8QGSknhM5rUAmIXbGTszr3YmoGafEiaEEs0KFtWz6SjgwlmXaAojS5MX5a7046IIL4hB5hs5nBgB8iHO57HhE/f9/5rtIQKfVoeduhpLwqjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=llWp0jX3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QxIYNrd4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="llWp0jX3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QxIYNrd4"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BHWihV3621968
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 21:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=B7ceDK0YYL2iC58PsLjwpIR2KHifRP2AdMv
	tXE1Mcqk=; b=llWp0jX3cIf3nmN3w040iOOyH2DoQUiIVWUMGPHD7xvNgEBWz6r
	8aBOFWXOIq60JMJ2+yUX/8tix8JIxcdVj/WdmWA3inMyc2MnYicr1a5bvnPr3kwg
	LmN5ra7vLGRHwLw3GGW6JBFusqyQOHn2nyztRMDDGdKTI3NGSOaHcMuuXpwU5Ap/
	ZJHjYftaYKaw9P6rOoQCUvTkuMuyZFjgYp8Xi8nC73ZIYwfDGqxRtLpBAZBSzuac
	bY2k4aFcVFSH2Pt28JBNgjgqu6EvXNOqQtlbkPJ2GJVrQXVCmg3cT68e92fYdZkJ
	xsWZ+UNNdO3RmaH6aG/RAKwUHkph1aavltg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmmubs88b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 21:53:24 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so2521726a91.0
        for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789163604; x=1789768404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B7ceDK0YYL2iC58PsLjwpIR2KHifRP2AdMvtXE1Mcqk=;
        b=QxIYNrd4DB/3cu3wJhqBG3UuVMFjN89TwxlHTKLO5tRNfPvRhAK4AAVuyRQTbBhtcu
         rQoyqutUPY69RGL7cWyodWiCVkAYBLab+No8JLzmILwnHr7CiSOot7kOqvv+CFyvaIrU
         FPL4t71SsKWlU3VNOANtgp4adLqrwnwbyMumG7PF9S2m4QQjSThKp2FPxoPXbIuqLxOF
         uptthC7ScYZ3Q65EYZVaKeNQFB0tzGzkX49y3DxuIbpRuPfNpTwQNYS20hZWs9JtngGn
         BTZdFezoZ/X0eRb+OO+S7GpB70ujHxhZ0QIGFu11z+J/cLuLILPvKaBwQPbiQg7fzU7o
         CgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789163604; x=1789768404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B7ceDK0YYL2iC58PsLjwpIR2KHifRP2AdMvtXE1Mcqk=;
        b=dz7jFbjxjH0M+8RZF7xCUS5MOz0RPZ2m/GHMlEK4wHWwexiy/5bO/Cuy2A+aqTa0ZO
         KN6fqMv64xeNPI7NILF3aebOhNe6/k0XXFEYdzxf4HnqxuF5eTRSO7rxfz3+L/EoYpVk
         9Ciy3Cbkmsgi1yTIYSmpcWWNMnSu2UGAPulJ0eWRZ7xo0vFpySfdMlpz+EuOZTZkPw07
         6zKs1PqdhQpX1sOeuXdC7sTFvpVyQCPgwE1YZz9eJrCemZlYB7BC9ErySZykN8O48pAq
         4REVYRWs69i0m1ofuFoKEdUfCkTGm57Uz/Fkd4U421fsBh1cACd0UWUJI9RApmoDoycb
         AKdg==
X-Gm-Message-State: AFuF++mN63yvrj7EVd+mHeMkBniYRXlmGB78IA6EkNwRAmtZbFOlE4sc
	2BFvgtxj/Ezm3ThhVI2mX7Mc4UMA2OpyjO8SsnshRyZpkgEVbGwg307N5AsUyUrD7+43XPQxZGo
	6FpNzvehQupq8CDneRJH/F2TGrOJUvmcSlvm/gKnI4ZeuC9i86sNGl2TAKgSJoSE=
X-Gm-Gg: AYBFou2MtB3hWSSCbIf6KR4gNpJrxOw6B2PaOBFgeFGeJHy4MN4UTN6NKjot62t6mnn
	v3Cx7wX2X/BC++Yp2pAoEIWCAzdTiByJiE5pMRGBDjh/fI3+mwzuXpyGurLnnUo3efpJSGevVn8
	qd/E9C8PQLJYrvETU1Q8Q+wp5bAEUzna0C7tYjSdGzn5dz9RRmEFdmh/2kvf1aIdq7J38JiGZNn
	i7ILUhsvqV/WNOXt0pnnXy9sjBKdIjp7Cf0ALFhVCcGe18+Ror1u0Mvd5fjjd0dhJBUcw4jIVn2
	h7S5XRlnNM9hOHlZAAxRojk7Cw8lOybVuWUgEGkOVNZ7+ZtjQGBEcVbWe1IKRYt9dBuHDjkRPXn
	XOqagovUXk3qYp0zKPJRURTyPbMZgZzgI8oisuzv17616MSGdmA==
X-Received: by 2002:a17:90b:3850:b0:398:9be8:ea69 with SMTP id 98e67ed59e1d1-39d9c36187amr9706304a91.22.1789163603688;
        Fri, 11 Sep 2026 14:53:23 -0700 (PDT)
X-Received: by 2002:a17:90b:3850:b0:398:9be8:ea69 with SMTP id 98e67ed59e1d1-39d9c36187amr9706262a91.22.1789163603274;
        Fri, 11 Sep 2026 14:53:23 -0700 (PDT)
Received: from hu-ashoraj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f739b5sm9100610eec.25.2026.09.11.14.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:53:22 -0700 (PDT)
From: Ashok Raj <ashok.raj@oss.qualcomm.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
        Li Ming <ming.li@zohomail.com>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Ashok Raj <ashok.raj@oss.qualcomm.com>
Subject: [RESEND PATCH] cxl/features: Ensure that count is set before access to end[] __counted_by()
Date: Fri, 11 Sep 2026 14:53:04 -0700
Message-ID: <20260911215304.1816467-1-ashok.raj@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Es4Co3d9YAz2lrdJS_sGZ0hfp4nYlQCZ
X-Proofpoint-ORIG-GUID: Es4Co3d9YAz2lrdJS_sGZ0hfp4nYlQCZ
X-Authority-Analysis: v=2.4 cv=dakVTnXe c=1 sm=1 tr=0 ts=6aa47854 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=hVXjItmcbegfcmPrdh8A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDMxMCBTYWx0ZWRfX9Dx1kwogSfAs
 PiizvcFXVRWwk9N8oy3KfIRzb1R287Pu/zNJlXzHmNJ4e8ivr/4uBO1rfRPxlRDotnYjBEQEuP/
 5PCqiK+WD0TCuMZjeB2jXBdYwOSY36VGglxSov4M2oM1HAXxCe+jrMIWGplfB4h8sXV6MHnLS5K
 4OXq3kgbqtPAGGBqAoXdWLs/X/qy7nyYrYoUQvuhXDRYSTdcB7hY7C6poa1DJJyKmiasuOXaYk3
 8FLNEi1fUwK9VVmSRcVZUtD3NHcmrK8IekuyNPWa+PPVQlh5SvTZCQMLLqwtj3LidQzAWC9OTi/
 twQPo3k0z7qzVIrPNjaUBfJ3QU0AVps3x6coRBHy9SSOMAXS/v92eNGGdK5wL0WQw26l2/Yi7NS
 2ZxXBC9oy1QnYQMMJ+5ayXuqjpKaBc/lbQ2OekekAPwstIcTi3Fx1OKUkhPsXirkOruzMbyOA2W
 vfb41zjPCZ3+kVxy3eg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDMxMCBTYWx0ZWRfX0DrWSdJpmc8H
 u07UKWOneQSmDDwK6QtX/YbwQMFNfax1HwWpBM8uMclHDIdQMwpE3TPpd9CKD+5ags5N2WOysOV
 7qt+zlmS1jCSkj8xHqdaS5lZJpVES9Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110310

get_supported_features() assigns entries->num_features only after the
memcpy() loop that fills entries->ent[] has already run. Since ent[]
is __counted_by(num_features), the compiler's bounds instrumentation
sees a 0-length array during that loop and FORTIFY_SOURCE trips on
the memcpy. Set @num_features right after allocation, before any
write into ent[], so the bound is correct for the whole lifetime of
the array.

This was found via a fortify panic:

 memcpy: detected buffer overflow: 384 byte write of buffer size 0
 WARNING: lib/string_helpers.c:1035 at __fortify_report+0x54/0xa0
 kernel BUG at lib/string_helpers.c:1043!
 Call trace:
  __fortify_panic+0x10/0x18
  get_supported_features.isra.0+0x4a0/0x4d0 [cxl_core]
  devm_cxl_setup_features+0x84/0x120 [cxl_core]
  cxl_pci_probe+0x254/0x5e0 [cxl_pci]

Same class of bug, same fix shape as commit 6c9d2e87df40
("cxl/fwctl: Fix __fortify_panic"), which fixed the analogous issue
in cxlctl_get_supported_features() but missed this one.

Fixes: f0e6a2329bf9 ("cxl: Add Get Supported Features command for kernel usage")
Signed-off-by: Ashok Raj <ashok.raj@oss.qualcomm.com>
---
RESEND: Dropped the mailing lists (linux-cxl, linux-kernel) from Cc
by mistake on the first send. Resending with proper Cc.

 drivers/cxl/core/features.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index ba6d2a5acb74..754fe5eb4b76 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -97,6 +97,7 @@ get_supported_features(struct cxl_features_state *cxlfs)
 		kvmalloc_flex(*entries, ent, count);
 	if (!entries)
 		return NULL;
+	entries->num_features = count;
 
 	struct cxl_mbox_get_sup_feats_out *mbox_out __free(kvfree) =
 		kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
@@ -174,7 +175,6 @@ get_supported_features(struct cxl_features_state *cxlfs)
 		start += num_entries;
 	} while (remain_feats);
 
-	entries->num_features = count;
 	entries->num_user_features = user_feats;
 
 	return no_free_ptr(entries);
-- 
2.43.0

