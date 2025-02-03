Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8183171E43
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 05:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738647089; cv=none; b=R9mGpA11jK/zjBNHvBH9wkiaH5h8E8ZM0OnezelGZOCtUXg+l8RsgKcx3hF/SZB8msmR7yDSJkMua+cOjyx+t8Qjkb9Gz0O5NfQiy9idS2WttpHh2qpYLxPCGpZTEPybstvb+uJOBDLeGKYXimpCH8r7ZrwyeeWpK7CXhHdFCRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738647089; c=relaxed/simple;
	bh=8d6lO2Xo5mIaQufu+kDsSZTXopoc1hCCNL0cx4YuQkA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=ENnUIJhMGYKLWJWuZiN+7mMCooT8cv1cmZB256dsKhe2G6nbQiJU3lX5wt907VFCWncWxQQ8KBv6Y/5She4d36HOCQVLgbMuB8Q7iZFHsVB3c9aDfn5W8AxG6K1LvIlvGqnhtwDZ/XWgAApM1rKGGn+pgNxmvcQunxRzi8un6r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Sy/ZRSpX; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Sy/ZRSpX"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250204053119epoutp02c9fd6d2d23290e77717e5f1c422d7df0~g6k6pkSLF1049110491epoutp02O
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 05:31:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250204053119epoutp02c9fd6d2d23290e77717e5f1c422d7df0~g6k6pkSLF1049110491epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738647079;
	bh=+biVHaGMB5F+GKA60sB0OWj5DAFTwShqFHKuX7hiXTk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Sy/ZRSpXpkKBaDA58WxaXyJyqVGBPMR+z3qP7Q2rjkTguvcVOVMGnbs8eE9yHg0y8
	 QGAICku9VTSw7wnyNuBubLaURfhOkigOhbQO0wlJtxl7Td15nYqwcVMAok8TW1Mqru
	 p2na+7FzKo9NUgXRtJWokcC8KaFR7hV6X7ymAUjQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250204053119epcas5p226e689dfdde761e792dfede18f4fe982~g6k6FoFCs0611106111epcas5p2V;
	Tue,  4 Feb 2025 05:31:19 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YnBmj66njz4x9QH; Tue,  4 Feb
	2025 05:31:17 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D7.F4.19956.526A1A76; Tue,  4 Feb 2025 14:31:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250203114457epcas5p1569ad2154f5ca08145e74c44efee1e1e~gsB236msg2272322723epcas5p1F;
	Mon,  3 Feb 2025 11:44:57 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250203114457epsmtrp17b40f4f710c3ee1653bd90f3e12c9a53~gsB23ONb03189931899epsmtrp1R;
	Mon,  3 Feb 2025 11:44:57 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-28-67a1a6259ed6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	FE.C9.33707.93CA0A76; Mon,  3 Feb 2025 20:44:57 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250203114456epsmtip2229ff867f5871829eac42db13a18fef2~gsB1dE91b1414714147epsmtip2L;
	Mon,  3 Feb 2025 11:44:56 +0000 (GMT)
From: Sweta Kumari <s5.kumari@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, Sweta Kumari
	<s5.kumari@samsung.com>
Subject: [PATCH 0/1] CXL CCI Health Information & Alerts Commands
 implementation
Date: Mon,  3 Feb 2025 17:14:44 +0530
Message-Id: <20250203114445.64088-1-s5.kumari@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmuq7qsoXpBr/36llMP6xo8eX0HjaL
	1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBZrzn1mAYrNYXfg8tg56y67x5Nrm5k8
	+rasYvSYOrve4/MmuQDWqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTc
	VFslF58AXbfMHKCblBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV5
	6Xp5qSVWhgYGRqZAhQnZGZv3z2Uv+MFacWT9MvYGxn8sXYycHBICJhLnZu1j62Lk4hAS2M0o
	0da9mQnC+cQosePoVlY4Z+/853AtC1quMEMkdjJKHLg1gwXCaWCS6D/5kRGkik1AS+LH5wfM
	ILaIgKTE767TYB3MAq8YJTZuaAXayMEhLBAk8eJ3PUgNi4CqxNsbL9hBbF4BK4nL+xexQWyT
	l9h/8CwzRFxQ4uTMJ2BXMAPFm7fOBpspIXCNXeLMkeeMEA0uEi1rtzND2MISr45vYYewpSRe
	9rdB2dkSd7d2Qi0okfhwezcThG0v0XqqnxnkNmYBTYn1u/QhwrISU0+tY4LYyyfR+/sJVDmv
	xI55MLayxJZ/y1khbEmJFZ+XQNkeEnOfHABbJSQQKzHt8gu2CYzys5C8MwvJO7MQNi9gZF7F
	KJlaUJybnlpsWmCcl1oOj9nk/NxNjOC0qeW9g/HRgw96hxiZOBgPMUpwMCuJ8J7eviBdiDcl
	sbIqtSg/vqg0J7X4EKMpMIwnMkuJJucDE3deSbyhiaWBiZmZmYmlsZmhkjhv886WdCGB9MSS
	1OzU1ILUIpg+Jg5OqQamlSuWFKxiuurycvWks5rJz0JUrMpundv9cuXBO8rhUzsWrPkguLtD
	co2koJVak+LHjeseNrS55lwpt3E5OP3JVoPMVX1HDXXn/Tk0adOBGasnVtjdCG04b8/5tTnD
	0yb679q6zaemFYQv/C++7twJkRdXp8+fu9j3fJbc7/uFzU9OeJWaHgxQWRlfGZKxK7RZq8t+
	q07DodSeRKtrUu9sPO310v2PW7RV6Bl0M7F+LNz/YmPq+QQFtmVTZUR+GC+Z01R4Y2rbimJ+
	sXVHfz/N1f1x16PrsmRjR8G7bn4mlw9Ohydv19B01WFcHMCjHP70ztGbF9azVgu9iZENWlkz
	Y+eqlOMRFWa7kzh+XfTdrsRSnJFoqMVcVJwIAKry/S8kBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSvK7lmgXpBocWGlhMP6xo8eX0HjaL
	1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBZrzn1mAYrNYXfg8tg56y67x5Nrm5k8
	+rasYvSYOrve4/MmuQDWKC6blNSczLLUIn27BK6Mzfvnshf8YK04sn4ZewPjP5YuRk4OCQET
	iQUtV5i7GLk4hAS2M0o0f17DDpGQlHh75hIjhC0ssfLfc3aIon+MEn+2HQYrYhPQkvjx+QEz
	iC0C1PC76zTYJGaBL4wSUxq+MoEkhAUCJK5v+g22jkVAVeLtjRdgzbwCVhKX9y9ig9ggL7H/
	4FlmiLigxMmZT8DqmYHizVtnM09g5JuFJDULSWoBI9MqRtHUguLc9NzkAkO94sTc4tK8dL3k
	/NxNjODQ1Qrawbhs/V+9Q4xMHIyHGCU4mJVEeDkOz0kX4k1JrKxKLcqPLyrNSS0+xCjNwaIk
	zquc05kiJJCeWJKanZpakFoEk2Xi4JRqYJI+d32JxMw19Ycj5xje0/2cypAVOl2g3L/Q2COp
	/PD1bWdlPx758f7DzpkTRXqUlxYculnIsbaub8v3bQfyTwdVSCxNuuj+9zjDk/0Vl6rTk7l6
	VxR9ddw1N5LhR1JYj3DsWc7Wi7uMZDhmedfHp+nZrODvqWNt6mc3TmmV/HhPZ8qLAIZPcV2v
	Pjr3LLl8Vt41Xrp+sarUBNGJ8TOL50Z5cs69KVDqk5Wwgcl+x3r3mWbPTuQHTyl2+C1xLTqz
	Q7h8isXG4AtCb/y/RT5M1/a336q0JH3hJJZIzt7WH3veS7dan7t7a6Pw9z/LWZaWKcT2/1p4
	89Pum0tlujvjNOYEdcgs+qC6zlpxelPRfyWW4oxEQy3mouJEAONLO6bMAgAA
X-CMS-MailID: 20250203114457epcas5p1569ad2154f5ca08145e74c44efee1e1e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250203114457epcas5p1569ad2154f5ca08145e74c44efee1e1e
References: <CGME20250203114457epcas5p1569ad2154f5ca08145e74c44efee1e1e@epcas5p1.samsung.com>

CXL CCI get/set alert config commands implmented as per CXL Specification 3.1  8.2.9.9.3
1)get alert configuration(Opcode 4201h)
2)set alert configuration(Opcode 4202h) 

The patches are generated against the Johnathan's tree
https://gitlab.com/jic23/qemu.git and branch cxl-2024-11-27.

Signed-off-by: Sweta Kumari <s5.kumari@samsung.com>
Reviewed-by: Alok Rathore <alok.rathore@samsung.com>
Reviewed-by: Krishna Kanth Reddy <krish.reddy@samsung.com>

Sweta Kumari (1):
  Added support for get/set alert configuration commands

 hw/cxl/cxl-mailbox-utils.c  | 91 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          | 20 ++++++++
 include/hw/cxl/cxl_device.h | 24 ++++++++++
 3 files changed, 135 insertions(+)

-- 
2.34.1

