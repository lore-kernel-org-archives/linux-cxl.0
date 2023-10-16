Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A015B5
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 01:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RbLMme0s"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E574B95
	for <linux-cxl@vger.kernel.org>; Sun, 15 Oct 2023 18:55:27 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231016015525epoutp0168c88193f02a523c1264fabed983d281~Oc7PVmXEK0657006570epoutp01t
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 01:55:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231016015525epoutp0168c88193f02a523c1264fabed983d281~Oc7PVmXEK0657006570epoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697421325;
	bh=O+M4MAv/rLJNMYmmKBctGaZccwGtFE3jknhP/Sm8daA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=RbLMme0sw45gjLlqNnYZOLbqrHCRiyW94GEoY4RYsN73ImbrOH7xwBhO3f2DuXpgj
	 fro2guUMmuk+Bf5jDheSUQrTO8SpG0hfLdE8Q58lEAMqcr9kh4rSvx5aJLbADEL+Ko
	 LRgX5KupDTDzR4/PsznpcoukwcMJIATNx+jUWfE8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20231016015525epcas2p1bc8cf5267fa2978459596e6c62873152~Oc7O3NX8v1484214842epcas2p1u;
	Mon, 16 Oct 2023 01:55:25 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.88]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4S80Ym6ghlz4x9Q5; Mon, 16 Oct
	2023 01:55:24 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A6.E5.18994.C089C256; Mon, 16 Oct 2023 10:55:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20231016015524epcas2p331375a467212eaa09d6e29d18c215e94~Oc7OERKeq1255412554epcas2p3B;
	Mon, 16 Oct 2023 01:55:24 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231016015524epsmtrp2d88415d5def0a11d7a9c11a346dbd4ea~Oc7N9fPOk2028620286epsmtrp2z;
	Mon, 16 Oct 2023 01:55:24 +0000 (GMT)
X-AuditID: b6c32a4d-743ff70000004a32-8d-652c980c8c9a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9C.BC.08817.C089C256; Mon, 16 Oct 2023 10:55:24 +0900 (KST)
Received: from hojin-Precision-7920-Tower.dsn.sec.samsung.com (unknown
	[10.229.83.132]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231016015523epsmtip123bfcb45ae0f58c3359b9e9c353349c3~Oc7NpIseq3111631116epsmtip1e;
	Mon, 16 Oct 2023 01:55:23 +0000 (GMT)
From: Hojin Nam <hj96.nam@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ben
	Widawsky <bwidawsk@kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr
	Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
	=?UTF-8?q?=C2=A0Kyungsan=20Kim?= <ks0204.kim@samsung.com>, Wonjae Lee
	<wj28.lee@samsung.com>, Hojin Nam <hj96.nam@samsung.com>, Junhyeok Im
	<junhyeok.im@samsung.com>, Jehoon Park <jehoon.park@samsung.com>, Seungjun
	Ha <seungjun.ha@samsung.com>, Youngshin Park <yshin0.park@samsung.com>,
	Jeongtae Park <jeongtae.park@gmail.com>
Subject: [PATCH] cxl: Fix flag name in struct cxl_command_info comment
Date: Sun, 15 Oct 2023 22:02:29 -0400
Message-Id: <20231016020229.22584-1-hj96.nam@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdljTTJdnhk6qwdxZphZ3H19gs2ievJjR
	YvrUC4wWJ242slmsvrmG0aJp9V1Wiw9v/rFYHHjdwG5x5uxLVotVC6+xWSw+OoPZ4ugeDovz
	s06xWLzoPM5kcWvCMSaLjfffsVlc+fmI0UHQY+esu+weLUfesnos3vOSyWPTqk42j74tqxg9
	ps6u9/i8SS6APSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUn
	QNctMwfoASWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJ
	laGBgZEpUGFCdsbjY1fZCmaxVSydcpm1gfEHSxcjJ4eEgIlE77yNbF2MXBxCAnsYJaacfgLl
	fGKU+Nj2jQnC+cYo8ensdkaYlouXZ0NV7WWUON2+nBXC6WGSWHlxJVgVm4CaxML7l5hBbBEB
	WYnmdQ/ARjELTGOVuPr4GFARB4ewgJvEnQleIDUsAqoSnw59BevlFbCUWL5xCRPENnmJ1RsO
	MIP0Sgh0cki8e/uHHaRXQsBF4uzDUIgaYYlXx7ewQ9hSEp/f7WWDKMmX+LQT6s8CiVk9a6FG
	Gku8u/mcFaSEWUBTYv0ufYhqZYkjt8CqmQX4JDoO/4XawyvR0SYE0agksb+jlRnClpC4c+Iy
	NEQ8JDb83A9mCwnESpz99JF9AqPsLIT5CxgZVzFKpRYU56anJhsVGOrmpZbDoyk5P3cTIzhV
	avnuYHy9/q/eIUYmDsZDjBIczEoivOnBOqlCvCmJlVWpRfnxRaU5qcWHGE2BATaRWUo0OR+Y
	rPNK4g1NLA1MzMwMzY1MDcyVxHnvtc5NERJITyxJzU5NLUgtgulj4uCUamDqK5pg/j6Xr+2z
	SY3mn4xL9RPW3ZU7vigq4+g3FbVY9tka7y6tqXL/c3XaY6ftGyMal27K4tJ7dkNBpU930b81
	tsE5209+X8DjlbNziehi5pwjAsf+hfDIepeI/FHa/rBtbUGMI+cNzyi2k+zHT75XLovu9Fzj
	+WvHoas77PrW6kgZz/r4I9H4QfmplA+3s7LuXL5dvLeocPmao3lqfKq6Evk3klf/9rnnYFe6
	t6wuUmOf+s4LZmI5h2/Pe5oqs6By3qvcOwsEl8f9+r76Hvvrd9bSUY/dtxRfyj3Rd6jM8vKT
	aRrTnM4eC95Ulc5+uDz/yfOX+38u7a3s8tu/2V3DlL1l1YGZyccqfmuHCF2uVGIpzkg01GIu
	Kk4EADRrPqEeBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSnC7PDJ1Ug2PzOC3uPr7AZtE8eTGj
	xfSpFxgtTtxsZLNYfXMNo0XT6rusFh/e/GOxOPC6gd3izNmXrBarFl5js1h8dAazxdE9HBbn
	Z51isXjReZzJ4taEY0wWG++/Y7O48vMRo4Ogx85Zd9k9Wo68ZfVYvOclk8emVZ1sHn1bVjF6
	TJ1d7/F5k1wAexSXTUpqTmZZapG+XQJXxuNjV9kKZrFVLJ1ymbWB8QdLFyMnh4SAicTFy7PZ
	uhi5OIQEdjNK9M5vZIZISEgsfryTCcIWlrjfcoQVoqiLSeLe5jNgCTYBNYmF9y+BNYgIyEo0
	r3vABFLELLCIVWLLjqdAKzg4hAXcJO5M8AKpYRFQlfh06CsjiM0rYCmxfOMSqAXyEqs3HGCe
	wMizgJFhFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcOhqae1g3LPqg94hRiYOxkOM
	EhzMSiK86cE6qUK8KYmVValF+fFFpTmpxYcYpTlYlMR5v73uTRESSE8sSc1OTS1ILYLJMnFw
	SjUwTWZd6qTC5qve/vL2+kjd0D0JXqbzn9xy5J5+YOHJ9dlazJsf7Clnkv5RkMW08H3E5Cu/
	HWevZww/EHPi7LEDlh3vZPpeHOXeZP1h2ReVGdkfHkgtN7q+9snW7q9Pn83VWOvPXtRqPruZ
	M/9A0lsul+tWHAybmDXZp+2/EfX6/Ef3q25vGj1eZb7/yLCDqTd4+vUa+bR1V91rNl60uC2z
	78abCTpv9p5L2lX09OWKGufrDy1u6UwucZNe++641dzdQpPOxlm9idDclqVVwW5bcyVk4mf9
	v2e+CU78IblOn6X58toNvmfSF/en6VrtlftjKzjrzZrV9n9Y/kTqtk+1eOcevvhLtv/5XNPc
	/dM8XcuVWIozEg21mIuKEwE+MxfuzAIAAA==
X-CMS-MailID: 20231016015524epcas2p331375a467212eaa09d6e29d18c215e94
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231016015524epcas2p331375a467212eaa09d6e29d18c215e94
References: <CGME20231016015524epcas2p331375a467212eaa09d6e29d18c215e94@epcas2p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

CXL_MEM_COMMAND_FLAG_ENABLED is declared in the code,
not CXL_MEM_COMMAND_FLAG_USER_ENABLED.

Signed-off-by: Hojin Nam <hj96.nam@samsung.com>
---
 include/uapi/linux/cxl_mem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 86bbacf2a315..6a54cff4d8d2 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -74,7 +74,7 @@ static const struct {
  * @id: ID number for the command.
  * @flags: Flags that specify command behavior.
  *
- *         CXL_MEM_COMMAND_FLAG_USER_ENABLED
+ *         CXL_MEM_COMMAND_FLAG_ENABLED
  *
  *         The given command id is supported by the driver and is supported by
  *         a related opcode on the device.
-- 
2.17.1

